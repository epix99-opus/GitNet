# woot — Git 仓库枚举（Agent 经 Tailscale SSH）

> **生成方式**：从 **epix** 执行 `ssh -o BatchMode=yes woot@woot` + `find`/`git`（见 [94](../94-multi-node-agent-inventory-raci-and-config-matrix.md) §5.6）。**扫描根**：`~/Dev`、`~/agent-work`（最大深度 5）。

**生成日期**：2026-05-13

## 编程 Agent 工具（实机探测）

> **探测日期**：2026-05-12；从 **epix** 执行 `ssh -o BatchMode=yes woot@woot`。OpenSSH 非登录会话 **PATH 不含** `~/.local/bin`，故以绝对路径与目录列举为准。

| 工具 | 结论 | 证据（可复跑） |
|------|------|----------------|
| **Cursor** | 已安装 | `/Applications/Cursor.app` 存在 |
| **Codex CLI** | **未**在常见路径发现 | `/usr/local/bin/codex` 不存在；`command -v codex` 在默认 SSH PATH 下为空 |
| **Claude Code** | 已安装 | `/Users/woot/.local/bin/claude` → `~/.local/share/claude/versions/2.1.81`；`/Users/woot/.local/bin/claude --version` 输出 `2.1.81 (Claude Code)` |
| **cursor-agent** | 已安装 | `/Users/woot/.local/bin/cursor-agent`、`agent` 符号链至 `~/.local/share/cursor-agent/versions/2026.04.17-787b533/cursor-agent`；**注意**：同会话跑 `cursor-agent --version` 曾报 **macOS login keychain locked**（凭据/解锁问题，与二进制是否存在无关） |

## 仓库表

| 路径 | 分支 | `origin` | `user.name`（摘要） |
|------|------|----------|---------------------|
| `/Users/woot/Dev/ccdev/everything-claude-code` | main | `https://github.com/affaan-m/everything-claude-code.git` | `~/.gitconfig-fragment-cursor` → **`woot-cursor`** |

## 备注

- 当前扫描范围内仅发现 **1** 个含 `.git` 的仓库根；若 `~/Dev` 下还有其它克隆，可提高 `find` 深度或扩大根路径后重跑 §5.6。

## 修订记录

- 2026-05-12：增补「编程 Agent 工具」实机探测（PATH 约束说明、claude/cursor-agent 路径、Codex 未检出）。
- 2026-05-13：首版枚举（epix → `woot@woot` SSH）。
