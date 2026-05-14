# woot — Git 仓库枚举（Agent 经 Tailscale SSH）

> **生成方式**：从 **epix** 执行 `ssh -o BatchMode=yes woot@woot` + `find`/`git`（见 [94](../94-multi-node-agent-inventory-raci-and-config-matrix.md) §5.6）。**扫描根**：`~/Dev`、`~/agent-work`（最大深度 5）。

**生成日期**：2026-05-13

## 编程 Agent 工具（实机探测）

> **探测日期**：2026-05-12（首版）；**2026-05-14** 经 **epix** `ssh -o BatchMode=yes woot@woot` **复测**（BestGit 落盘同会话执行）。OpenSSH 非登录会话 **PATH 不含** `~/.local/bin`，故以绝对路径与目录列举为准。

**组织口径（2026-05-14）**：与 epix、glab 一致，**本机具备 Cursor、Codex CLI、Claude Code 三套编程 Agent**。下表「结论」与组织对齐；「证据」含 **Agent 经 BatchMode SSH** 可复现的快照——**Codex CLI** 若仅在交互登录环境或自定义前缀下可见，请在本机执行 `type -P codex`（或等价）后将**绝对路径**补进本表，便于下一轮自动化引用。

| 工具 | 结论 | 证据（可复跑） |
|------|------|----------------|
| **Cursor** | 已安装 | `/Applications/Cursor.app` 存在 |
| **Codex CLI** | **已部署**（与三节点组织口径一致） | **SSH 快照**：`/usr/local/bin/codex` 不存在；默认 SSH 与 `zsh -l -c 'command -v codex'` 当前仍为空（**待维护者补录**本机 `codex` 绝对路径）；自动化盘点应加长 `PATH`、用登录 shell，或调用已登记路径 |
| **Claude Code** | 已安装 | `/Users/woot/.local/bin/claude` → `~/.local/share/claude/versions/2.1.81`；`/Users/woot/.local/bin/claude --version` 输出 `2.1.81 (Claude Code)` |
| **cursor-agent** | 已安装 | `/Users/woot/.local/bin/cursor-agent`、`agent` 符号链至 `~/.local/share/cursor-agent/versions/2026.04.17-787b533/cursor-agent`；**注意**：同会话跑 `cursor-agent --version` 曾报 **macOS login keychain locked**（凭据/解锁问题，与二进制是否存在无关） |

## 仓库表

| 路径 | 分支 | `origin` | `user.name`（摘要） |
|------|------|----------|---------------------|
| `/Users/woot/Dev/ccdev/everything-claude-code` | main | `https://github.com/affaan-m/everything-claude-code.git` | `~/.gitconfig-fragment-cursor` → **`woot-cursor`** |
| `/Users/woot/Dev/BestGit` | main | `https://github.com/epix99-opus/BestGit.git` | `~/.gitconfig-fragment-cursor` → **`woot-cursor`** |

## 备注

- `~/Dev/BestGit` 已按 BestGit `docs/rollout-epix-glab-woot.md` 经 SSH **克隆**（2026-05-14）；若后续扩大 `find` 根路径可能发现更多仓。

## 修订记录

- 2026-05-14：编程 Agent **组织口径**改为三节点均具备 Cursor / Codex CLI / Claude Code；Codex 行保留 **SSH 快照**与「待补绝对路径」说明；登记 **`/Users/woot/Dev/BestGit`**。
- 2026-05-12：增补「编程 Agent 工具」实机探测（PATH 约束说明、claude/cursor-agent 路径）；**2026-05-14** 与组织口径对齐后，Codex 行不再写「未检出」为结论。
- 2026-05-13：首版枚举（epix → `woot@woot` SSH）。
