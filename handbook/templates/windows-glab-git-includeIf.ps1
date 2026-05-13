# Glab: one-shot human + agent git fragments + includeIf (PowerShell)
# Requires Git for Windows. HOSTNAME for agents is glab. Edit $DevRoot / $GitNetRoot if paths differ.

$ErrorActionPreference = "Stop"

$rd = Resolve-Path 'E:\Dev' -ErrorAction SilentlyContinue
$DevRoot = if ($rd) { $rd.Path.Replace('\', '/') } else { 'E:/Dev' }

$GitNetRoot = $null
try {
  $GitNetRoot = (git -C 'E:\Dev\GitNet' rev-parse --show-toplevel 2>$null).Replace('\', '/')
} catch {}
if (-not $GitNetRoot) {
  $rp = Resolve-Path 'E:\Dev\GitNet' -ErrorAction SilentlyContinue
  $GitNetRoot = if ($rp) { $rp.Path.Replace('\', '/') } else { 'E:/Dev/GitNet' }
}

if (-not (Test-Path $GitNetRoot.Replace('/', '\'))) {
  Write-Warning ('GitNet path not found: ' + $GitNetRoot + ' - edit $GitNetRoot in this script.')
}

$homeUnix = $env:USERPROFILE.Replace('\', '/')
$fragCursor = "$homeUnix/.gitconfig-fragment-cursor"
$fragCodex = "$homeUnix/.gitconfig-fragment-codex"
$fragClaude = "$homeUnix/.gitconfig-fragment-claude-code"

New-Item -ItemType Directory -Force -Path (Join-Path $env:USERPROFILE 'agent-work\cursor') | Out-Null
New-Item -ItemType Directory -Force -Path (Join-Path $env:USERPROFILE 'agent-work\codex') | Out-Null
New-Item -ItemType Directory -Force -Path (Join-Path $env:USERPROFILE 'agent-work\claude-code') | Out-Null

Set-Content -Encoding utf8 -Path $fragCursor -Value @(
  '[user]',
  '	name = glab-cursor',
  '	email = epix99@icloud.com'
)

Set-Content -Encoding utf8 -Path $fragCodex -Value @(
  '[user]',
  '	name = glab-codex',
  '	email = epix99@icloud.com'
)

Set-Content -Encoding utf8 -Path $fragClaude -Value @(
  '[user]',
  '	name = glab-claude-code',
  '	email = epix99@icloud.com'
)

$dq = [char]34

$mainLines = @(
  '[user]',
  '	name = Epix',
  '	email = epix99@icloud.com',
  '',
  '[core]',
  '	autocrlf = true',
  '	longpaths = true',
  '',
  ('[includeIf ' + $dq + 'gitdir:' + $GitNetRoot + '/' + $dq + ']'),
  ('	path = ' + $fragCursor),
  ('[includeIf ' + $dq + 'gitdir:' + $homeUnix + '/agent-work/cursor/' + $dq + ']'),
  ('	path = ' + $fragCursor),
  ('[includeIf ' + $dq + 'gitdir:' + $DevRoot + '/CodexDev/' + $dq + ']'),
  ('	path = ' + $fragCodex),
  ('[includeIf ' + $dq + 'gitdir:' + $homeUnix + '/agent-work/codex/' + $dq + ']'),
  ('	path = ' + $fragCodex),
  ('[includeIf ' + $dq + 'gitdir:' + $homeUnix + '/agent-work/claude-code/' + $dq + ']'),
  ('	path = ' + $fragClaude)
)
$main = ($mainLines -join [Environment]::NewLine) + [Environment]::NewLine

$bak = Join-Path $env:USERPROFILE ('.gitconfig.backup-gitnet-' + (Get-Date -Format 'yyyyMMdd'))
Copy-Item (Join-Path $env:USERPROFILE '.gitconfig') $bak -ErrorAction SilentlyContinue
Set-Content -Encoding utf8 (Join-Path $env:USERPROFILE '.gitconfig') $main

Write-Host 'Done. Verify under GitNet:'
Write-Host '  cd E:\Dev\GitNet'
Write-Host '  git config --show-origin user.name'
