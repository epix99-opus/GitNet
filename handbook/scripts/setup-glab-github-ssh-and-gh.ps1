#Requires -Version 5.1
<#
.SYNOPSIS
  On glab (GG): install GitHub CLI (winget), create ~/.ssh/id_ed25519_github, append Host github.com, keyscan, set GitNet origin to SSH.

.DESCRIPTION
  Does NOT add the public key to your GitHub account (needs browser or PAT). After this script:
  1) Run: gh auth login --hostname github.com --git-protocol ssh --web
  2) Then: gh ssh-key add $env:USERPROFILE\.ssh\id_ed25519_github.pub -t "glab-GG-windows"
     OR paste the .pub line at https://github.com/settings/ssh/new
  3) Verify: ssh -T git@github.com ; git ls-remote origin HEAD

.PARAMETER GitNetWorkdirWin
  Path to GitNet clone (default E:\DEV\GitNet).

.PARAMETER SkipWingetGh
  If gh is already installed, set to skip winget.

.EXAMPLE
  .\setup-glab-github-ssh-and-gh.ps1 -GitNetWorkdirWin 'E:\DEV\GitNet'
#>
param(
  [string] $GitNetWorkdirWin = 'E:\DEV\GitNet',
  [switch] $SkipWingetGh
)

$ErrorActionPreference = 'Stop'
$ghExe = 'C:\Program Files\GitHub CLI\gh.exe'

if (-not $SkipWingetGh) {
  if (-not (Test-Path -LiteralPath $ghExe)) {
    winget install --id GitHub.cli -e --source winget --accept-package-agreements --accept-source-agreements
  }
}

$key = Join-Path $env:USERPROFILE '.ssh\id_ed25519_github'
if (-not (Test-Path -LiteralPath $key)) {
  ssh-keygen -t ed25519 -f $key -N '""' -C "GG-glab-GitNet-$(Get-Date -Format yyyyMMdd)"
}

$cfg = Join-Path $env:USERPROFILE '.ssh\config'
$raw = [string]::Empty
if (Test-Path -LiteralPath $cfg) {
  $raw = Get-Content -LiteralPath $cfg -Raw
}
if ($raw -notmatch '(?m)^Host github\.com\s*$') {
  $block = @"

# GitNet: GitHub SSH (dedicated key)
Host github.com
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_ed25519_github
  IdentitiesOnly yes
"@
  Add-Content -LiteralPath $cfg -Value $block -Encoding utf8
}

$kh = Join-Path $env:USERPROFILE '.ssh\known_hosts'
if (-not (Test-Path -LiteralPath $kh)) {
  New-Item -ItemType File -Path $kh -Force | Out-Null
}
if (-not (Select-String -LiteralPath $kh -Pattern 'github\.com' -Quiet -ErrorAction SilentlyContinue)) {
  ssh-keyscan github.com 2>$null | Add-Content -LiteralPath $kh -Encoding ascii
}

$work = [System.IO.Path]::GetFullPath($GitNetWorkdirWin.Trim())
if (Test-Path -LiteralPath (Join-Path $work '.git')) {
  git -C $work remote set-url origin 'git@github.com:epix99-opus/GitNet.git'
}

Write-Host '--- Public key (add to GitHub or use gh ssh-key add after gh auth login) ---' -ForegroundColor Cyan
Get-Content -LiteralPath "$key.pub"
Write-Host '--- Next (human): run in this PowerShell window ---' -ForegroundColor Yellow
Write-Host '  & ''C:\Program Files\GitHub CLI\gh.exe'' auth login --hostname github.com --git-protocol ssh --web'
Write-Host '  & ''C:\Program Files\GitHub CLI\gh.exe'' ssh-key add ''' + $key + '.pub'' -t glab-GG-windows'
Write-Host '  ssh -T git@github.com'
Write-Host '  git -C ''' + $work + ''' ls-remote origin HEAD'
