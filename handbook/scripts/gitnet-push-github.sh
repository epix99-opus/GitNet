#!/usr/bin/env bash
# 复制到 epix：~/bin/gitnet-push-github.sh
# 用法：设置环境变量 BARE、可选 LOG，或由 launchd 调用
set -euo pipefail
BARE="${BARE:-/srv/git/GitNet.git}"
LOG="${LOG:-$HOME/Library/Logs/GitNet/push-github.log}"
mkdir -p "$(dirname "$LOG")"
{
  echo "---- $(date '+%Y-%m-%dT%H:%M:%S%z') ----"
  git -C "$BARE" push github --all --prune
  echo "push ok"
} >>"$LOG" 2>&1
