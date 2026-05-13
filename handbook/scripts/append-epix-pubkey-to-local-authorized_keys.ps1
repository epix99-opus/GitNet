#Requires -Version 5.1
<#
.SYNOPSIS
  在当前 Windows 用户（如 GG）下，将仓库定稿 epix 公钥追加到 %USERPROFILE%\.ssh\authorized_keys（若尚不存在该行）。

.DESCRIPTION
  从 GitNet 仓库 handbook/templates/epix-id_ed25519.pub 读取首条 ssh-ed25519 行，写入本机 authorized_keys。
  不以管理员为前提；若 ACL 异常请先修复 .ssh 权限或运行 setup-glab-openssh-for-epix.ps1。
#>
param(
  [string] $RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..\..')).Path
)

$ErrorActionPreference = 'Stop'
$pub = Join-Path $RepoRoot 'handbook\templates\epix-id_ed25519.pub'
if (-not (Test-Path -LiteralPath $pub)) {
  Write-Error "Missing: $pub"
}

$line = $null
foreach ($raw in Get-Content -LiteralPath $pub) {
  $t = $raw.Trim()
  if (-not $t -or $t.StartsWith('#')) { continue }
  if ($t -match '^\s*ssh-ed25519\s+\S+') {
    $line = $t
    break
  }
}
if (-not $line) {
  Write-Error "No ssh-ed25519 line in $pub"
}

$ssh = Join-Path $env:USERPROFILE '.ssh'
$ak = Join-Path $ssh 'authorized_keys'
New-Item -ItemType Directory -Force -Path $ssh | Out-Null

$exists = $false
if (Test-Path -LiteralPath $ak) {
  foreach ($x in Get-Content -LiteralPath $ak -ErrorAction SilentlyContinue) {
    if ($x.Trim() -eq $line) { $exists = $true; break }
  }
}

if ($exists) {
  Write-Host "OK: key line already in $ak"
  exit 0
}

Add-Content -LiteralPath $ak -Value $line -Encoding ascii
Write-Host "OK: appended epix pubkey to $ak"
Write-Host "Verify: sshd can read file; test from epix: ssh -o BatchMode=yes glab hostname"
