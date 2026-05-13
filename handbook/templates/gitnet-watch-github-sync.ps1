#Requires -Version 5.1
# GitNet: poll GitHub (origin) and fast-forward local main when safe.
# Edit $RepoRoot. Schedule via Task Scheduler every 1-5 min. See handbook/92-github-auto-sync-collaboration.md

param()

$ErrorActionPreference = 'Stop'
$RepoRoot = 'E:\DEV\GitNet'
$Branch = 'main'
$LogDir = Join-Path $env:USERPROFILE 'AppData\Local\GitNet\logs'
$LogPath = Join-Path $LogDir 'watch-github.log'
New-Item -ItemType Directory -Force -Path $LogDir | Out-Null

function Write-Log([string]$m) {
  $line = "$(Get-Date -Format o) $m"
  Add-Content -Path $LogPath -Value $line
}

Set-Location $RepoRoot
git fetch origin $Branch 2>&1 | Out-Null
if (-not $?) { Write-Log 'fetch_failed'; exit 0 }

$local = (git rev-parse HEAD).Trim()
$remote = (git rev-parse "refs/remotes/origin/$Branch" 2>$null)
if (-not $remote) { Write-Log 'no_remote_tracking'; exit 0 }
$remote = $remote.Trim()

if ($local -eq $remote) { Write-Log "up_to_date $local"; exit 0 }

$anc = git merge-base --is-ancestor $local $remote 2>$null
if ($LASTEXITCODE -eq 0) {
  git merge --ff-only "origin/$Branch" 2>&1 | Out-Null
  if ($?) {
    Write-Log "pulled_ff $local->$remote"
    try {
      New-BurntToastNotification -Text 'GitNet', "Pulled origin/$Branch" -ErrorAction SilentlyContinue
    } catch {}
  } else {
    Write-Log 'ff_merge_failed'
  }
  exit 0
}

Write-Log "diverged local=$local remote=$remote"
try {
  New-BurntToastNotification -Text 'GitNet', 'Diverged — manual merge' -ErrorAction SilentlyContinue
} catch {}
