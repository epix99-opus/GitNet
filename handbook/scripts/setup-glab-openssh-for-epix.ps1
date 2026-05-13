#Requires -Version 5.1
<#
.SYNOPSIS
  在 glab（Windows）一次性：安装/启动 OpenSSH Server、防火墙放行 TCP 22、写入 epix 公钥到当前用户 authorized_keys、重启 sshd。

.DESCRIPTION
  需「以管理员身份运行」的 PowerShell。公钥整行以仓库定稿 handbook/templates/epix-id_ed25519.pub 为准传入 -EpixPublicKeyLine（勿手抄）；或从 epix 本机 Get-Content ~/.ssh/id_ed25519.pub 读取后比对一致。

.PARAMETER EpixPublicKeyLine
  epix 上 ~/.ssh/id_ed25519.pub 的完整一行（以 ssh-ed25519 开头）。定稿副本：GitHub 仓库 handbook/templates/epix-id_ed25519.pub（与 glab 对接，勿手抄）。

.EXAMPLE
  $k = Get-Content -Raw "$PSScriptRoot\..\templates\epix-id_ed25519.pub"
  .\setup-glab-openssh-for-epix.ps1 -EpixPublicKeyLine $k.Trim()
#>
param(
  [Parameter(Mandatory = $true)]
  [string] $EpixPublicKeyLine,
  [string] $GitNetWorkdirWin = 'E:\Dev\GitNet'
)

$ErrorActionPreference = "Stop"

function Test-Administrator {
  $id = [Security.Principal.WindowsIdentity]::GetCurrent()
  $p = New-Object Security.Principal.WindowsPrincipal($id)
  return $p.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

if (-not (Test-Administrator)) {
  Write-Error "请以管理员身份打开 PowerShell，再运行本脚本。"
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

$line = $EpixPublicKeyLine.Trim()
if ($line -notmatch '^ssh-ed25519\s') {
  Write-Warning "公钥行不以 ssh-ed25519 开头，请确认是否为 id_ed25519.pub 整行。"
}

$exists = $false
if (Test-Path $authKeys) {
  $content = Get-Content $authKeys -ErrorAction SilentlyContinue
  if ($content | Where-Object { $_.Trim() -eq $line }) { $exists = $true }
}
if (-not $exists) {
  Add-Content -Path $authKeys -Value $line -Encoding ascii
}

# Windows OpenSSH：.ssh 与 authorized_keys ACL（简化版，按官方建议）
try {
  icacls $sshDir /inheritance:r | Out-Null
  icacls $sshDir /grant:r "$env:USERNAME:(OI)(CI)F" | Out-Null
  if (Test-Path $authKeys) {
    icacls $authKeys /inheritance:r | Out-Null
    icacls $authKeys /grant:r "$env:USERNAME:R" | Out-Null
  }
} catch {
  Write-Warning "icacls 设置失败（可手动按微软文档修正 .ssh 权限）：$_"
}

Restart-Service sshd -Force

Write-Host "OpenSSH configured. On epix run:"
Write-Host "  ssh-keyscan glab.tailbb1446.ts.net >> ~/.ssh/known_hosts"
Write-Host ('  ssh glab "cd /d ' + $GitNetWorkdirWin + ' && git config --show-origin user.name"')
