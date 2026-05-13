# woot — Git 仓库枚举（Agent 经 Tailscale SSH）

> **生成方式**：从 **epix** 执行 `ssh -o BatchMode=yes woot@woot` + `find`/`git`（见 [94](../94-multi-node-agent-inventory-raci-and-config-matrix.md) §5.6）。**扫描根**：`~/Dev`、`~/agent-work`（最大深度 5）。

**生成日期**：2026-05-13

## 仓库表

| 路径 | 分支 | `origin` | `user.name`（摘要） |
|------|------|----------|---------------------|
| `/Users/woot/Dev/ccdev/everything-claude-code` | main | `https://github.com/affaan-m/everything-claude-code.git` | `~/.gitconfig-fragment-cursor` → **`woot-cursor`** |

## 备注

- 当前扫描范围内仅发现 **1** 个含 `.git` 的仓库根；若 `~/Dev` 下还有其它克隆，可提高 `find` 深度或扩大根路径后重跑 §5.6。

## 修订记录

- 2026-05-13：首版枚举（epix → `woot@woot` SSH）。
