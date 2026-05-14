#!/usr/bin/env bash
# GitNet：GitHub main（合入闸）→ epix bare main，仅 fast-forward。
# 见 handbook/30、handbook/10「GitNet 本仓例外」、handbook/90 迁移决议。
# **Dry-run**：`GITNET_SYNC_DRY_RUN=1` 时只打印将执行的 `git fetch` 行并退出 0（不写日志、不 fetch）。
set -euo pipefail
BARE="${BARE:-$HOME/git/GitNet.git}"
LOG="${LOG:-$HOME/Library/Logs/GitNet/sync-github-to-bare.log}"
if [[ "${GITNET_SYNC_DRY_RUN:-}" == "1" ]]; then
  echo "dry-run: would append log to $LOG"
  echo "dry-run: would run: git -C \"$BARE\" fetch github refs/heads/main:refs/heads/main"
  if ! git -C "$BARE" remote get-url github >/dev/null 2>&1; then
    echo "dry-run: error bare 未配置 remote github" >&2
    exit 2
  fi
  echo "dry-run: bare github remote ok; exit 0 without fetch"
  exit 0
fi
mkdir -p "$(dirname "$LOG")"
{
  echo "---- $(date '+%Y-%m-%dT%H:%M:%S%z') ----"
  if ! git -C "$BARE" remote get-url github >/dev/null 2>&1; then
    echo "error: bare 未配置 remote github" >&2
    exit 2
  fi
  # refspec：仅当可快进时更新 bare 的 main；否则失败并需人工在 90 记录
  git -C "$BARE" fetch github refs/heads/main:refs/heads/main
  echo "sync-ok $(git -C "$BARE" rev-parse --short main)"
} >>"$LOG" 2>&1
