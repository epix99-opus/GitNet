# woot — Git 仓库枚举（Agent 经 Tailscale SSH）

> **生成方式**：从 **epix** 执行 `ssh -o BatchMode=yes woot@woot` + `find`/`git`（见 [94](../94-multi-node-agent-inventory-raci-and-config-matrix.md) §5.6）。**扫描根**：`~/Dev`、`~/agent-work`（最大深度 5）。

**生成日期**：2026-05-13

## 编程 Agent 工具（实机探测）

> **探测日期**：2026-05-12（首版）；**2026-05-14** 经 **epix** `ssh -o BatchMode=yes woot@woot` **复测**（BestGit 落盘同会话执行）。OpenSSH 非登录会话 **PATH 不含** `~/.local/bin`，故以绝对路径与目录列举为准。

**组织口径（2026-05-14）**：与 epix、glab 一致，**本机具备 Cursor、Codex CLI、Claude Code 三套编程 Agent**。下表「结论」与组织对齐；「证据」含 **Agent 经 BatchMode SSH** 可复现的快照——**Codex CLI** 若仅在交互登录环境或自定义前缀下可见，请在本机执行 `type -P codex`（或等价）后将**绝对路径**补进本表，便于下一轮自动化引用。

| 工具 | 结论 | 证据（可复跑） |
|------|------|----------------|
| **Cursor** | 已安装 | `/Applications/Cursor.app` 存在 |
| **Codex CLI** | **已部署**（与三节点组织口径一致） | **SSH 快照**：`/usr/local/bin/codex` 不存在；默认 SSH 与 `zsh -l -c 'command -v codex'` 仍无输出（见下节 **原因**）；自动化盘点建议用 **`zsh -lic 'command -v codex'`**（交互+登录，更接近「终端.app」）或 **显式绝对路径** |
| **Claude Code** | 已安装 | `/Users/woot/.local/bin/claude` → `~/.local/share/claude/versions/2.1.81`；`/Users/woot/.local/bin/claude --version` 输出 `2.1.81 (Claude Code)` |
| **cursor-agent** | 已安装 | `/Users/woot/.local/bin/cursor-agent`、`agent` 符号链至 `~/.local/share/cursor-agent/versions/2026.04.17-787b533/cursor-agent`；**注意**：同会话跑 `cursor-agent --version` 曾报 **macOS login keychain locked**（凭据/解锁问题，与二进制是否存在无关） |

### 为何已安装 Codex CLI，`zsh -l -c 'command -v codex'` 仍可能无输出？

1. **zsh 启动文件（根因）**：`zsh -l -c '…'` 是 **登录（`-l`）+ 非交互（`-c`）** shell。按 **zsh** 规则，此种组合会读 **`~/.zshenv`、`~/.zprofile`**（及系统对应文件）等，但 **不会**读 **`~/.zshrc`**（`.zshrc` 仅在 **交互式** shell 时读取）。许多用户把 **Homebrew / npm 全局 bin / nvm** 的 `PATH` 写在 **`~/.zshrc`** 里，因此在 **Terminal.app 里**能跑 `codex`，在 **`zsh -l -c`** 里却 **找不到**——**不是没装，而是探测命令没加载你放 PATH 的那份启动脚本**。
2. **SSH 默认环境**：OpenSSH 非登录远程命令还会带上 **较短的 `PATH`**（此前会话曾见近似 `~/.cargo/bin` + 系统目录），与图形终端登录后的 `PATH` 不一致，进一步放大上述差异。
3. **更贴近本机的探查方式**（任选其一，在 epix 上经 SSH）：`zsh -lic 'command -v codex; codex --version'`（`-i` = 交互，会读 `.zshrc`）；或在 woot 本机终端执行 `type -P codex` 将**绝对路径**记入上表「证据」列。

> **Cursor Agent / 人类（二次核对后）**：在 **本机（epix）** 上应先执行 **`tailscale status`** 与 **`tailscale ping woot`**——**woot 在线且 L3 可达** 时，若 **`ssh woot@woot`（短名）仍超时**，根因常为 **系统 DNS / MagicDNS 与 `tailscale status` 的 100.x 不一致**。**权威 IPv4** 以 **`tailscale ip -4 woot`** 为准；**`ssh woot@<该地址>` 已实机验证可登录**（与短名解析无关）。处置与 **`~/.ssh/config` 的 `HostName`** 见 [46-tailscale-remote-git-identity.md](../46-tailscale-remote-git-identity.md) **§1.0～§1.1**；事实变量见 NetOps **`configs/network_facts.env`** 之 **`TAILSCALE_WOOT_IP`**、脚本 **`scripts/tailscale-peer-ipv4.sh`**。

## 仓库表

| 路径 | 分支 | `origin` | `user.name`（摘要） |
|------|------|----------|---------------------|
| `/Users/woot/Dev/ccdev/everything-claude-code` | main | `https://github.com/affaan-m/everything-claude-code.git` | `~/.gitconfig-fragment-cursor` → **`woot-cursor`** |
| `/Users/woot/Dev/BestGit` | main | `https://github.com/epix99-opus/BestGit.git` | `~/.gitconfig-fragment-cursor` → **`woot-cursor`** |

## 备注

- `~/Dev/BestGit` 已按 BestGit `docs/rollout-epix-glab-woot.md` 经 SSH **克隆**（2026-05-14）；若后续扩大 `find` 根路径可能发现更多仓。

- **GitNet v0.1 周知**：本 inventory **未枚举** `~/Dev/GitNet`；对 GitNet `97` 的全量矩阵 **待 woot 本机或经 SSH 补验**（见 GitNet `97` §6 与 CAMA **`docs/gitnet-v0.1-rollout-verification.zh-CN.md`**）。

## 修订记录

- 2026-05-13：**GitNet v0.1 周知**：woot 侧 GitNet 克隆与矩阵 **待补**（见上节备注）。
- 2026-05-14：inventory **二次核对**：本机 **`tailscale status`/`tailscale ping woot` 正常** 而 **`ssh woot@woot` 超时** 时，根因常为 **DNS 100.x 与 status 表不一致**（见 `46` 新增 **§1.0**）；**更正**此前「Agent 不在 tailnet」之误述；表结构修复见前条。
- 2026-05-14：增补 **「为何 `zsh -l -c` 探不到已安装之 codex」**（zsh 非交互不读 `.zshrc`、SSH PATH）；Codex 证据列改为建议 **`zsh -lic`** 或补绝对路径。
- 2026-05-14：编程 Agent **组织口径**改为三节点均具备 Cursor / Codex CLI / Claude Code；Codex 行保留 **SSH 快照**与「待补绝对路径」说明；登记 **`/Users/woot/Dev/BestGit`**。
- 2026-05-12：增补「编程 Agent 工具」实机探测（PATH 约束说明、claude/cursor-agent 路径）；**2026-05-14** 与组织口径对齐后，Codex 行不再写「未检出」为结论。
- 2026-05-13：首版枚举（epix → `woot@woot` SSH）。
