#Requires -Version 5.1
<#
.SYNOPSIS
  在 glab（Windows）一次性：安装/启动 OpenSSH Server、防火墙放行 TCP 22、写入 epix 公钥到当前用户 authorized_keys、重启 sshd。

.DESCRIPTION
  需「以管理员身份运行」的 PowerShell。**公钥信源**为仓库 `handbook/templates/epix-id_ed25519.pub`（勿从聊天手抄）；epix 本机 `cat ~/.ssh/id_ed25519.pub` 应与该文件中的 `ssh-ed25519` 行**逐字符一致**。
  若未传 `-EpixPublicKeyLine` / `-EpixPublicKeyPath`，则从 `-GitNetWorkdirWin\handbook\templates\epix-id_ed25519.pub` 读取首条 `ssh-ed25519` 行（忽略 `#` 注释行）。

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

$line = $keyLine

$exists = $false
if (Test-Path $authKeys) {
  $content = Get-Content $authKeys -ErrorAction SilentlyContinue
  if ($content | Where-Object { $_.Trim() -eq $line }) { $exists = $true }
}
if (-not $exists) {
  Add-Content -Path $authKeys -Value $line -Encoding ascii
}

# Windows OpenSSH：.ssh 与 authorized_keys ACL（按官方建议）
# icacls 的 /grant 主体与「(OI)(CI)F」须连成合法字符串；用 -f 拼接，避免 "$env:USERNAME:(OI)…" 被 PowerShell 误解析导致「无效参数 (OI)(CI)F」。
try {
  $userGrant = if ($env:USERDOMAIN) {
    ('{0}\{1}:(OI)(CI)F' -f $env:USERDOMAIN, $env:USERNAME)
  } else {
    ('{0}:(OI)(CI)F' -f $env:USERNAME)
  }
  $userRead = if ($env:USERDOMAIN) {
    ('{0}\{1}:R' -f $env:USERDOMAIN, $env:USERNAME)
  } else {
    ('{0}:R' -f $env:USERNAME)
  }
  icacls $sshDir /inheritance:r | Out-Null
  icacls $sshDir /grant:r $userGrant | Out-Null
  if (Test-Path $authKeys) {
    icacls $authKeys /inheritance:r | Out-Null
    icacls $authKeys /grant:r $userRead | Out-Null
    # 公钥认证：sshd 服务账户需能读取 authorized_keys（名称以本机为准；失败则仅依赖用户 R，仍可能可登录）
    icacls $authKeys /grant "NT SERVICE\sshd:R" 2>$null | Out-Null
  }
} catch {
  Write-Warning "icacls 设置失败（可手动按微软文档修正 .ssh 权限）：$_"
}

Restart-Service sshd -Force

Write-Host "OpenSSH configured. On epix run:"
Write-Host "  ssh-keyscan glab.tailbb1446.ts.net >> ~/.ssh/known_hosts"
Write-Host ('  ssh glab "cd /d ' + $GitNetWorkdirWin + ' && git config --show-origin user.name"')
