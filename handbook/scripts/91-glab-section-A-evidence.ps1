# handbook/91 section A - evidence capture (no secrets)
$ErrorActionPreference = 'Continue'
$ErrorView = 'NormalView'
$top = $null
foreach ($c in @('E:/DEV/GitNet', 'E:/Dev/GitNet')) {
  if (Test-Path $c) {
    $top = git -C $c rev-parse --show-toplevel 2>$null
    if ($top) { break }
  }
}
if (-not $top) { throw 'Could not resolve Git toplevel from E:/DEV/GitNet or E:/Dev/GitNet' }

Write-Output '=== A: glab PowerShell evidence (GitNet handoff) ==='
Write-Output ('Machine: ' + $env:COMPUTERNAME)
Write-Output ('User:    ' + $env:USERNAME)
Write-Output ('Toplevel:' + $top)
Write-Output ''
Write-Output '--- Get-Service sshd ---'
$s = Get-Service sshd -ErrorAction SilentlyContinue
if ($s) {
  $s | Format-List Status, StartType | Out-String
} else {
  Write-Output '(sshd service not found - OpenSSH Server may not be installed)'
}
Write-Output '--- git rev-parse --show-toplevel ---'
git -C $top rev-parse --show-toplevel
Write-Output '--- git config --show-origin user.name ---'
git -C $top config --show-origin user.name
Write-Output '--- git config --show-origin user.email ---'
git -C $top config --show-origin user.email
Write-Output ''
Write-Output '--- B (epix optional): not run from glab Agent ---'
Write-Output 'If epix human ran: ssh glab "hostname", paste that line in Issue separately.'
