#Requires -Version 5.1
#Requires -RunAsAdministrator
<#
.SYNOPSIS
  将定稿 epix 公钥写入 C:\ProgramData\ssh\administrators_authorized_keys（管理员账户 SSH 必需）。

.DESCRIPTION
  Windows OpenSSH：若用户属于 **Administrators**，sshd_config 中 `Match Group administrators` 会覆盖
  AuthorizedKeysFile 为 __PROGRAMDATA__/ssh/administrators_authorized_keys，此时 **%USERPROFILE%\.ssh\authorized_keys 不会用于公钥认证**。
  本脚本幂等追加一行；须「以管理员身份运行」PowerShell。

  公钥来源：GitNet 仓库 handbook/templates/epix-id_ed25519.pub 首条 ssh-ed25519 行。
#>
param(
  [string] $RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..\..')).Path
)

$ErrorActionPreference = 'Stop'

function Test-Administrator {
  $id = [Security.Principal.WindowsIdentity]::GetCurrent()
  $p = New-Object Security.Principal.WindowsPrincipal($id)
  return $p.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}
if (-not (Test-Administrator)) {
  Write-Error "请以管理员身份运行本脚本。"
}

$pub = Join-Path $RepoRoot 'handbook\templates\epix-id_ed25519.pub'
$line = $null
foreach ($raw in Get-Content -LiteralPath $pub) {
  $t = $raw.Trim()
  if (-not $t -or $t.StartsWith('#')) { continue }
  if ($t -match '^\s*ssh-ed25519\s+\S+') { $line = $t; break }
}
if (-not $line) { Write-Error "No ssh-ed25519 line in $pub" }

$targetDir = Join-Path $env:ProgramData 'ssh'
$target = Join-Path $targetDir 'administrators_authorized_keys'
New-Item -ItemType Directory -Force -Path $targetDir | Out-Null

$exists = $false
if (Test-Path -LiteralPath $target) {
  foreach ($x in Get-Content -LiteralPath $target -ErrorAction SilentlyContinue) {
    if ($x.Trim() -eq $line) { $exists = $true; break }
  }
}
if ($exists) {
  Write-Host "OK: line already in $target"
} else {
  Add-Content -LiteralPath $target -Value $line -Encoding ascii
  Write-Host "OK: appended to $target"
}

# 微软建议：仅 SYSTEM 与 Administrators 完全控制
try {
  icacls $target /inheritance:r /grant:r "SYSTEM:(F)" /grant:r "Administrators:(F)" | Out-Null
} catch {
  Write-Warning "icacls: $_"
}

Write-Host "Restart sshd if needed: Restart-Service sshd"
Write-Host "Epix test: ssh -o BatchMode=yes -o PreferredAuthentications=publickey glab hostname"
