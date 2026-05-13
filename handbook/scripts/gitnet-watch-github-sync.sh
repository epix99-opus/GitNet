#!/usr/bin/env bash
# GitNet: poll GitHub (origin) and fast-forward local main when safe.
# Copy to ~/bin/ and set GITNET_REPO. See handbook/92-github-auto-sync-collaboration.md

set -euo pipefail

GITNET_REPO="${GITNET_REPO:-$HOME/Dev/GitNet}"
BRANCH="${GITNET_BRANCH:-main}"
LOG="${GITNET_SYNC_LOG:-$HOME/Library/Logs/GitNet/watch-github.log}"
INTERVAL_TAG="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"

mkdir -p "$(dirname "$LOG")"

cd "$GITNET_REPO"

git fetch origin "$BRANCH" 2>>"$LOG" || { echo "$INTERVAL_TAG fetch_failed" >>"$LOG"; exit 0; }

LOCAL="$(git rev-parse HEAD)"
REMOTE="$(git rev-parse "refs/remotes/origin/$BRANCH" 2>/dev/null || true)"

if [[ -z "$REMOTE" ]]; then
  echo "$INTERVAL_TAG no_remote_tracking" >>"$LOG"
  exit 0
fi

if [[ "$LOCAL" == "$REMOTE" ]]; then
  echo "$INTERVAL_TAG up_to_date $LOCAL" >>"$LOG"
  exit 0
fi

# behind remote: fast-forward only
if git merge-base --is-ancestor "$LOCAL" "$REMOTE" 2>/dev/null; then
  git merge --ff-only "origin/$BRANCH" >>"$LOG" 2>&1
  echo "$INTERVAL_TAG pulled_ff $LOCAL->$REMOTE" >>"$LOG"
  if command -v osascript >/dev/null 2>&1; then
    osascript -e "display notification \"GitNet pulled origin/$BRANCH\" with title \"GitNet sync\"" 2>/dev/null || true
  fi
  exit 0
fi

echo "$INTERVAL_TAG diverged_local=$LOCAL remote=$REMOTE (no auto merge)" >>"$LOG"
if command -v osascript >/dev/null 2>&1; then
  osascript -e "display notification \"GitNet diverged — manual merge\" with title \"GitNet sync\"" 2>/dev/null || true
fi
exit 0
