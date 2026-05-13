#Requires -Version 5.1
# Post body to GitHub Issue #1. Requires fine-grained PAT or classic token with issues:write.
# Usage: $env:GITHUB_TOKEN='ghp_...'; .\post-issue1-github-comment.ps1 [-BodyFile path]
param(
  [string] $BodyFile = (Join-Path (Split-Path $PSScriptRoot -Parent) 'published/issue-1-glab-evidence-comment.md')
)
$ErrorActionPreference = 'Stop'
if (-not $env:GITHUB_TOKEN) {
  Write-Error 'Set environment variable GITHUB_TOKEN (repo scope: issues:write) then re-run.'
}
$raw = Get-Content -LiteralPath $BodyFile -Raw -Encoding utf8
# GitHub API expects JSON body field only
$payload = @{ body = $raw } | ConvertTo-Json
$headers = @{
  Authorization = "Bearer $($env:GITHUB_TOKEN)"
  Accept        = 'application/vnd.github+json'
}
Invoke-RestMethod -Uri 'https://api.github.com/repos/epix99-opus/GitNet/issues/1/comments' `
  -Method Post -Headers $headers -Body $payload -ContentType 'application/json; charset=utf-8'
Write-Host 'Posted comment to Issue #1.'
