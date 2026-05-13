# 在 glab（本机 PowerShell）一次性执行：人类兜底 + 三工具片段 + includeIf
# 使用前：已安装 Git for Windows；已与 epix 约定 HOSTNAME=glab；路径按你实际 Dev 盘符修改 $DevRoot。

$ErrorActionPreference = "Stop"
$DevRoot = "E:/Dev"   # 若 GitNet 在 E:\Dev\GitNet，则父级为 E:/Dev；若在 C:\Users\x\Dev 则改为该路径（正斜杠）

$homeUnix = $env:USERPROFILE.Replace('\', '/')
$fragCursor = "$homeUnix/.gitconfig-fragment-cursor"
$fragCodex = "$homeUnix/.gitconfig-fragment-codex"
$fragClaude = "$homeUnix/.gitconfig-fragment-claude-code"

New-Item -ItemType Directory -Force -Path "$env:USERPROFILE/agent-work/cursor" | Out-Null
New-Item -ItemType Directory -Force -Path "$env:USERPROFILE/agent-work/codex" | Out-Null
New-Item -ItemType Directory -Force -Path "$env:USERPROFILE/agent-work/claude-code" | Out-Null

@"
[user]
	name = glab-cursor
	email = epix99@icloud.com
"@ | Set-Content -Encoding utf8 $fragCursor

@"
[user]
	name = glab-codex
	email = epix99@icloud.com
"@ | Set-Content -Encoding utf8 $fragCodex

@"
[user]
	name = glab-claude-code
	email = epix99@icloud.com
"@ | Set-Content -Encoding utf8 $fragClaude

$main = @"
[user]
	name = Epix
	email = epix99@icloud.com

[core]
	autocrlf = true
	longpaths = true

[includeIf "gitdir:$DevRoot/"]
	path = $fragCursor
[includeIf "gitdir:$homeUnix/agent-work/cursor/"]
	path = $fragCursor
[includeIf "gitdir:$DevRoot/CodexDev/"]
	path = $fragCodex
[includeIf "gitdir:$homeUnix/agent-work/codex/"]
	path = $fragCodex
[includeIf "gitdir:$homeUnix/agent-work/claude-code/"]
	path = $fragClaude
"@

Copy-Item $env:USERPROFILE\.gitconfig "$env:USERPROFILE\.gitconfig.backup-gitnet-$(Get-Date -Format yyyyMMdd)" -ErrorAction SilentlyContinue
Set-Content -Encoding utf8 $env:USERPROFILE\.gitconfig $main

Write-Host "Done. Verify in a repo under Dev:"
Write-Host "  git config --show-origin user.name"
