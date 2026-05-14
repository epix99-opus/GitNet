#!/usr/bin/env bash
# 多节点多 Agent 复盘前检：Tailscale L3 + epix→woot/glab BatchMode SSH（只读探测）。
# 见 GitHub Issue #11、handbook/46 §1.0、handbook/94 §5。
set -euo pipefail
echo "=== gitnet-multi-agent-retro-preflight ($(date -u '+%Y-%m-%dT%H:%M:%SZ')) ==="
echo "--- tailscale ping (1) ---"
tailscale ping -c 1 woot
tailscale ping -c 1 glab
echo "--- tailscale ip -4 ---"
echo "woot $(tailscale ip -4 woot)"
echo "glab $(tailscale ip -4 glab)"
echo "--- ssh BatchMode ---"
ssh -o BatchMode=yes -o ConnectTimeout=15 woot@woot "hostname -s; git -C /Users/woot/Dev/GitNet rev-parse --short HEAD 2>/dev/null || echo 'no_gitnet'"
ssh -o BatchMode=yes -o ConnectTimeout=15 glab "powershell -NoProfile -Command \"if (Test-Path E:/Dev/GitNet) { git -C E:/Dev/GitNet rev-parse --short HEAD } else { 'no_gitnet' }\""
echo "=== preflight ok ==="
