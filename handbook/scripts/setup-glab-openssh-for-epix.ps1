#Requires -Version 5.1
<#
.SYNOPSIS
  在 glab（Windows）一次性：安装/启动 OpenSSH Server、防火墙放行 TCP 22、写入 epix 公钥到当前用户 authorized_keys、**以及**（若存在 Match）`ProgramData\ssh\administrators_authorized_keys`，重启 sshd。

.DESCRIPTION
  需「以管理员身份运行」的 PowerShell。**公钥信源**为仓库 `handbook/templates/epix-id_ed25519.pub`（勿从聊天手抄）；epix 本机 `cat ~/.ssh/id_ed25519.pub` 应与该文件中的 `ssh-ed25519` 行**逐字符一致**。
  若未传 `-EpixPublicKeyLine` / `-EpixPublicKeyPath`，则从 `-GitNetWorkdirWin\handbook\templates\epix-id_ed25519.pub` 读取首条 `ssh-ed25519` 行（忽略 `#` 注释行）。
  对属于 **Administrators** 的 Windows 用户，默认 `sshd_config` 的 `Match Group administrators` 会使用 **`%ProgramData%\ssh\administrators_authorized_keys`**；本脚本 §5 同步写入，避免仅 `%USERPROFILE%\.ssh\authorized_keys` 时 **BatchMode 公钥失败**。

.PARAMETER EpixPublicKeyLine
  epix 上 `~/.ssh/id_ed25519.pub` 的完整一行（以 `ssh-ed25519` 开头）。与 `-EpixPublicKeyPath` 二选一即可；均省略则读默认模板路径。

.PARAMETER EpixPublicKeyPath
  含 epix 公钥的文件路径（可为 `handbook\templates\epix-id_ed25519.pub`）。读取首条非注释且以 `ssh-ed25519` 开头的行。

.EXAMPLE
  .\setup-glab-openssh-for-epix.ps1 -GitNetWorkdirWin 'E:\DEV\GitNet'

.EXAMPLE
  $k = Get-Content -Raw (Join-Path $PSScriptRoot '..\templates\epix-id_ed25519.pub')
  .\setup-glab-openssh-for-epix.ps1 -EpixPublicKeyLine $k.Trim() -GitNetWorkdirWin 'E:\DEV\GitNet'

.EXAMPLE
  .\setup-glab-openssh-for-epix.ps1 -EpixPublicKeyPath '.\handbook\templates\epix-id_ed25519.pub' -GitNetWorkdirWin 'E:\DEV\GitNet'
#>
param(
  [string] $EpixPublicKeyLine = '',
  [string] $EpixPublicKeyPath = '',
  [string] $GitNetWorkdirWin = 'E:\Dev\GitNet'
)

$ErrorActionPreference = "Stop"

# Test-Path 在 EAP=Stop 且对目标无读取 ACL 时会抛「拒绝访问」；此处用 .NET Exists + try/catch 做存在性判断。
function Test-GitNetFileExists([string] $LiteralPath) {
  try { return [System.IO.File]::Exists($LiteralPath) } catch { return $false }
}

function Read-EpixPubKeyLineFromFile {
  param([Parameter(Mandatory = $true)][string] $FilePath)
  if (-not (Test-Path -LiteralPath $FilePath)) {
    return $null
  }
  foreach ($raw in Get-Content -LiteralPath $FilePath) {
    $t = $raw.Trim()
    if (-not $t) { continue }
    if ($t.StartsWith('#')) { continue }
    if ($t -match '^\s*ssh-ed25519\s+\S+') { return $t }
  }
  return $null
}

function Resolve-EpixPubKeyFilePath {
  param([string] $PathCandidate, [string] $Workdir)
  if ([string]::IsNullOrWhiteSpace($PathCandidate)) {
    return $null
  }
  $p = $PathCandidate.Trim()
  if ([System.IO.Path]::IsPathRooted($p)) {
    return [System.IO.Path]::GetFullPath($p)
  }
  $try = @(
    (Join-Path (Get-Location) $p),
    (Join-Path $Workdir $p)
  )
  foreach ($c in $try) {
    $full = [System.IO.Path]::GetFullPath($c)
    if (Test-Path -LiteralPath $full) {
      return $full
    }
  }
  return $null
}

function Test-Administrator {
  $id = [Security.Principal.WindowsIdentity]::GetCurrent()
  $p = New-Object Security.Principal.WindowsPrincipal($id)
  return $p.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

if (-not (Test-Administrator)) {
  Write-Error "请以管理员身份打开 PowerShell，再运行本脚本。"
}

$work = [System.IO.Path]::GetFullPath($GitNetWorkdirWin.Trim())
$defaultTemplate = Join-Path $work 'handbook\templates\epix-id_ed25519.pub'

$keyLine = $null
if (-not [string]::IsNullOrWhiteSpace($EpixPublicKeyPath)) {
  $resolved = Resolve-EpixPubKeyFilePath -PathCandidate $EpixPublicKeyPath -Workdir $work
  if (-not $resolved) {
    Write-Error "找不到公钥文件：$EpixPublicKeyPath（已相对当前目录与 GitNetWorkdirWin 尝试解析）。"
  }
  $keyLine = Read-EpixPubKeyLineFromFile -FilePath $resolved
  if (-not $keyLine) {
    Write-Error "文件内无有效的 ssh-ed25519 公钥行（跳过空行与 # 注释）：$resolved"
  }
} elseif (-not [string]::IsNullOrWhiteSpace($EpixPublicKeyLine)) {
  $keyLine = $EpixPublicKeyLine.Trim()
} else {
  $keyLine = Read-EpixPubKeyLineFromFile -FilePath $defaultTemplate
  if (-not $keyLine) {
    Write-Error @"
未指定公钥且默认模板中无有效 ssh-ed25519 行。
请在 epix 更新仓库内 handbook/templates/epix-id_ed25519.pub（或 Raw URL 同源）后 git pull，再重试；或显式传入 -EpixPublicKeyPath / -EpixPublicKeyLine。
默认读取路径: $defaultTemplate
"@
  }
}

if ($keyLine -notmatch '^\s*ssh-ed25519\s+\S+') {
  Write-Error "公钥行格式无效（须单行、以 ssh-ed25519 开头且含密钥材料）。当前值被拒绝写入 authorized_keys。"
}

# --- 1) OpenSSH Server ---
$cap = Get-WindowsCapability -Online | Where-Object Name -like 'OpenSSH.Server*' | Select-Object -First 1
if (-not $cap) {
  Write-Error "未找到 OpenSSH.Server 可选组件（系统版本可能过旧）。请改用：设置 → 应用 → 可选功能 → OpenSSH 服务器。"
}
if ($cap.State -ne "Installed") {
  Add-WindowsCapability -Online -Name $cap.Name
}

Set-Service -Name sshd -StartupType Automatic
Start-Service sshd

# --- 2) 防火墙放行 22（入站）---
$ruleName = "OpenSSH-Server-In-TCP-GitNet"
if (-not (Get-NetFirewallRule -Name $ruleName -ErrorAction SilentlyContinue)) {
  New-NetFirewallRule -Name $ruleName `
    -DisplayName "OpenSSH Server (sshd) GitNet" `
    -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22 | Out-Null
}

# --- 3) 确保 sshd 启用公钥 ---
$sshdConfig = "$env:ProgramData\ssh\sshd_config"
if (Test-Path $sshdConfig) {
  $bak = "$sshdConfig.bak-gitnet-$(Get-Date -Format yyyyMMddHHmmss)"
  Copy-Item $sshdConfig $bak -Force
  $txt = Get-Content $sshdConfig -Raw
  if ($txt -notmatch '(?m)^\s*PubkeyAuthentication\s+yes') {
    if ($txt -match '(?m)^\s*#\s*PubkeyAuthentication') {
      $txt = $txt -replace '(?m)^\s*#\s*PubkeyAuthentication.*', 'PubkeyAuthentication yes'
    } else {
      $txt += "`nPubkeyAuthentication yes`n"
    }
  }
  Set-Content -Path $sshdConfig -Value $txt -Encoding ascii
}

# --- 4) 当前用户 authorized_keys ---
$sshDir = Join-Path $env:USERPROFILE ".ssh"
$authKeys = Join-Path $sshDir "authorized_keys"
New-Item -ItemType Directory -Force -Path $sshDir | Out-Null

$userDirGrant = if ($env:USERDOMAIN) {
  ('{0}\{1}:(OI)(CI)F' -f $env:USERDOMAIN, $env:USERNAME)
} else {
  ('{0}:(OI)(CI)F' -f $env:USERNAME)
}
$userFileMod = if ($env:USERDOMAIN) {
  ('{0}\{1}:(M)' -f $env:USERDOMAIN, $env:USERNAME)
} else {
  ('{0}:(M)' -f $env:USERNAME)
}

# 必须先保证目录/文件可写，再 Add-Content；否则在 ACL 已损坏时会在本步失败。
# 最终仍须允许本用户对 authorized_keys 具备 (M)，否则仅 :R 时日后无法再次追加公钥。
try {
  icacls $sshDir /inheritance:r /grant:r $userDirGrant /grant:r "SYSTEM:(OI)(CI)F" | Out-Null
} catch {
  Write-Warning "icacls .ssh 目录失败：$_"
}

if (Test-GitNetFileExists $authKeys) {
  $takeown = Join-Path $env:SystemRoot 'System32\takeown.exe'
  if (Test-Path -LiteralPath $takeown) {
    try {
      & $takeown /F $authKeys 2>$null | Out-Null
    } catch { }
  }
  try {
    icacls $authKeys /inheritance:r /grant:r $userFileMod /grant:r "SYSTEM:(M)" | Out-Null
  } catch {
    Write-Warning "icacls authorized_keys 预修复失败：$_"
  }
}

$line = $keyLine

$exists = $false
if (Test-GitNetFileExists $authKeys) {
  try {
    $content = Get-Content -LiteralPath $authKeys -ErrorAction Stop
    if ($content | Where-Object { $_.Trim() -eq $line }) { $exists = $true }
  } catch {
    $exists = $false
  }
}
if (-not $exists) {
  try {
    Add-Content -LiteralPath $authKeys -Value $line -Encoding ascii -ErrorAction Stop
  } catch {
    Write-Error "无法写入 $authKeys（仍拒绝访问）。请以管理员 CMD 执行: takeown /F `"$authKeys`" 然后 icacls 授予 $($env:USERNAME) 修改权，再重跑本脚本。详情: $_"
  }
}

# Windows OpenSSH：收紧 authorized_keys（用户保留 M 以便维护；sshd 只读）
try {
  if (Test-GitNetFileExists $authKeys) {
    icacls $authKeys /inheritance:r /grant:r $userFileMod /grant:r "SYSTEM:R" | Out-Null
    icacls $authKeys /grant "NT SERVICE\sshd:R" 2>$null | Out-Null
  }
} catch {
  Write-Warning "icacls authorized_keys 最终收紧失败：$_"
}

# --- 5) 属于 Administrators 的 Windows 用户：必须写入 ProgramData\ssh\administrators_authorized_keys
# sshd 默认 Match Group administrators → AuthorizedKeysFile 指向此路径，%USERPROFILE%\.ssh\authorized_keys 对管理员登录不生效。
$adminAk = Join-Path $env:ProgramData 'ssh\administrators_authorized_keys'
New-Item -ItemType Directory -Force -Path (Split-Path $adminAk) | Out-Null
$admDup = $false
if (Test-Path -LiteralPath $adminAk) {
  foreach ($x in Get-Content -LiteralPath $adminAk -ErrorAction SilentlyContinue) {
    if ($x.Trim() -eq $line) { $admDup = $true; break }
  }
}
if (-not $admDup) {
  try {
    Add-Content -LiteralPath $adminAk -Value $line -Encoding ascii -ErrorAction Stop
    Write-Host "Also appended pubkey to $adminAk (Administrators Match in sshd_config)."
  } catch {
    Write-Warning "Could not write $adminAk : $_"
  }
}
try {
  if (Test-Path -LiteralPath $adminAk) {
    icacls $adminAk /inheritance:r /grant:r "SYSTEM:(F)" /grant:r "Administrators:(F)" | Out-Null
  }
} catch {
  Write-Warning "icacls administrators_authorized_keys: $_"
}

Restart-Service sshd -Force

Write-Host "OpenSSH configured. On epix run:"
Write-Host "  ssh-keyscan glab.tailbb1446.ts.net >> ~/.ssh/known_hosts"
Write-Host ('  ssh glab "cd /d ' + $GitNetWorkdirWin + ' && git config --show-origin user.name"')
