#!/usr/bin/env bash
# 仅打印 v0.1 周知验收建议命令（只读、不执行 SSH）；见 handbook/97-initial-gitnet-v0.1-deliverable.md §6。
set -euo pipefail
cat <<'EOF'
# === GitNet v0.1 周知 — 建议验收命令（复制后按需改路径）===

# --- epix 本机（GitNet 工作副本）---
# git -C ~/Dev/GitNet fetch github && git -C ~/Dev/GitNet merge --ff-only github/main
# git -C ~/Dev/GitNet log -1 --oneline handbook/97-initial-gitnet-v0.1-deliverable.md
# git -C ~/Dev/GitNet config --show-origin user.name
# git -C ~/Dev/BestGit pull --ff-only 2>/dev/null || true
# git -C ~/Dev/CAMA/CAMA-concept pull --ff-only 2>/dev/null || true
# git -C ~/Dev/CAMA/CAMA-concept config --show-origin user.name

# --- 经 epix SSH 到 woot（BatchMode）---
# ssh -o BatchMode=yes woot@woot 'hostname; git -C ~/Dev/GitNet config --show-origin user.name 2>/dev/null || true'

# --- 经 epix SSH 到 glab（PowerShell 一行；路径按实机）---
# ssh -o BatchMode=yes glab "powershell -NoProfile -Command \"git -C E:/Dev/GitNet config --show-origin user.name\""

# --- 双端 SHA（bare 与 GitHub main 是否一致）---
# gh api repos/epix99-opus/GitNet/commits/main --jq .sha
# git -C ~/git/GitNet.git rev-parse refs/heads/main

# 证据落盘：更新 handbook/published/inventory-*-enumerated-agent.md 备注列，或写 handbook/90-process-log.md。
EOF
