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
Write-Output '--- Get-Service *ssh* / name or displayname contains OpenSSH ---'
Get-Service -ErrorAction SilentlyContinue |
  Where-Object { $_.Name -match 'ssh' -or ($_.DisplayName -and $_.DisplayName -match 'OpenSSH') } |
  Format-Table -AutoSize Name, Status, StartType, DisplayName
Write-Output '--- Get-WindowsCapability OpenSSH.Server* ---'
Get-WindowsCapability -Online -ErrorAction SilentlyContinue |
  Where-Object Name -like 'OpenSSH.Server*' |
  Format-Table -AutoSize Name, State
Write-Output '--- Get-NetTCPConnection LocalPort 22 (first 5; may be empty without admin) ---'
Get-NetTCPConnection -LocalPort 22 -ErrorAction SilentlyContinue |
  Select-Object -First 5 LocalAddress, LocalPort, State, OwningProcess |
  Format-Table -AutoSize
Write-Output '--- git rev-parse --show-toplevel ---'
git -C $top rev-parse --show-toplevel
Write-Output '--- git config --show-origin user.name ---'
git -C $top config --show-origin user.name
Write-Output '--- git config --show-origin user.email ---'
git -C $top config --show-origin user.email
Write-Output ''
Write-Output '--- B (epix optional): not run from glab Agent ---'
Write-Output 'If epix human ran: ssh glab "hostname", paste that line in Issue separately.'
