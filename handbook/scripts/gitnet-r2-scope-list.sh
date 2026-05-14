#!/usr/bin/env bash
# R2 整仓评审：按路径前缀列出已跟踪文件计数（只读）。见 Issue #16、handbook/98。
set -euo pipefail
ROOT="$(git rev-parse --show-toplevel 2>/dev/null || true)"
if [[ -z "$ROOT" ]]; then
  echo "error: run inside a Git work tree" >&2
  exit 2
fi
cd "$ROOT"
echo "=== gitnet-r2-scope-list ($(date -u '+%Y-%m-%dT%H:%M:%SZ')) repo=$ROOT ==="
prefixes=(
  "handbook/"
  "handbook/published/"
  "handbook/scripts/"
  "handbook/templates/"
  ".cursor/"
  "docs/"
)
for p in "${prefixes[@]}"; do
  n="$(git ls-files "$p" 2>/dev/null | wc -l | tr -d ' ')"
  echo "$n	$p"
done
echo "--- root governance ---"
git ls-files AGENTS.md CONTRIBUTING.md README.md VERSION 2>/dev/null | sed 's/^/ /' || true
echo "=== done ==="
