# epix — Git 仓库枚举（Agent 本机 + 可经 SSH 复跑）

> **生成方式**：本机 `find` `~/Dev`、`~/agent-work` 下 `.git` 目录，对每个顶层执行 `git branch --show-current`、`git remote get-url origin`、`git config --show-origin user.name`（见 [94](../94-multi-node-agent-inventory-raci-and-config-matrix.md) §5.5～§5.6）。**不含**私钥与 token。

**生成日期**：2026-05-13

## 编程 Agent 工具（实机探测）

> **探测日期**：2026-05-12；在 **epix** 本机执行（非仅凭 Git `user.name` 推断）。

**组织口径（2026-05-14）**：**三编程 Agent** = **Cursor（IDE）** + **OpenAI Codex CLI（终端 `codex`）** + **Claude Code（`claude` CLI）**。**epix / woot / glab 三台节点均纳入该三套能力**（与 CAMA `regulations/cama-git-inventory.md` §1 对齐）。下表为 **epix 本机**可点名路径；woot/glab 的逐条证据见对应 `inventory-*` 文件——**不得**仅凭「BatchMode SSH 里 `command -v` / `where` 为空」认定整机未装 Codex CLI。

| 工具 | 结论 | 证据（可复跑） |
|------|------|----------------|
| **Cursor** | 已安装 | `/Applications/Cursor.app` 存在；默认 shell **无** `cursor` 于 `PATH`；`~/.local/bin/cursor-agent`、`agent` 为 **cursor-agent** 符号链 |
| **Codex CLI** | 已安装 | `command -v codex` → `/usr/local/bin/codex` |
| **Claude Code** | 已安装 | `~/.local/bin/claude` → `~/.local/share/claude/versions/2.1.122`（`claude --version` 可自检） |

## 仓库表

| 路径 | 分支 | `origin` | `user.name`（摘要） |
|------|------|----------|---------------------|
| `/Users/epix/Dev/CAMA/CAMA-codex-start` | main | *(无)* | `~/.gitconfig-fragment-cursor` → **epix-cursor** |
| `/Users/epix/Dev/CAMA/CAMA-concept` | CAMA_Cursor | *(无)* | **epix-cursor** |
| `/Users/epix/Dev/CodexDev/SelfEvo/paseo` | main | `https://github.com/getpaseo/paseo.git` | `~/.gitconfig-fragment-codex` → **epix-codex** |
| `/Users/epix/Dev/GitNet` | main | **`origin`** → `file:///Users/epix/git/GitNet.git`；**`github`** → `https://github.com/epix99-opus/GitNet.git` | **epix-cursor** |
| `/Users/epix/Dev/Hermes` | main | *(无)* | **epix-cursor** |
| `/Users/epix/Dev/Hermes/cama-hermes-front-harness` | main | *(无)* | **epix-cursor** |
| `/Users/epix/Dev/NetOps` | main | *(无)* | **epix-cursor** |
| `/Users/epix/Dev/TraeDev/contabo` | cursor_dev | `git@github.com:epix99-opus/EpixNetwork.git` | **epix-cursor** |
| `/Users/epix/Dev/UOC` | main | *(无)* | **epix-cursor** |
| `/Users/epix/Dev/UniNode` | main | *(无)* | **epix-cursor** |
| `/Users/epix/Dev/UniNode/3399/.build/rkbin` | master | `https://github.com/rockchip-linux/rkbin.git` | **epix-cursor** |
| `/Users/epix/Dev/UniNode/3399/.build/rkdeveloptool` | master | `https://github.com/rockchip-linux/rkdeveloptool.git` | **epix-cursor** |
| `/Users/epix/Dev/open-design` | main | `https://github.com/nexu-io/open-design.git` | **epix-cursor** |
| `/Users/epix/Dev/BestGit` | main | `https://github.com/epix99-opus/BestGit.git` | **epix-cursor** |

## 与 [10-topology.md](../10-topology.md) 的对照（摘要）

- 表中 **`origin` 为 GitHub 或其它远端** 的仓库：相对「**写集成在 epix bare**」目标，属 **L2 待对齐** 或已登记例外；请在 [90-process-log.md](../90-process-log.md) 按需记录迁移动作。
- **`/Users/epix/Dev/GitNet`（本表 epix 行）**：**`origin` → `file:///Users/epix/git/GitNet.git`**（epix bare），**`github` → HTTPS 镜像**；与 `10` 写权威一致（2026-05-14 实装，见 `90`）。
- **`(无) origin`**：可能为纯本地或后续再绑 remote；不视为已纳入对象层规范。

## 修订记录

- 2026-05-14：**GitNet** 工作副本 `origin` 改为 **`file:///Users/epix/git/GitNet.git`**（bare），`github` 保留；与 `10`/`90` 对齐。
- 2026-05-14：编程 Agent 节增补 **组织口径**（三节点均具备 Cursor / Codex CLI / Claude Code），与 CAMA §1 及 woot/glab inventory 互指。
- 2026-05-13：仓库表追加 **`/Users/epix/Dev/BestGit`**；`origin` 更新为 GitHub **`epix99-opus/BestGit`**；与 `96` / CAMA `cama-git-inventory` 对齐。
- 2026-05-12：增补「编程 Agent 工具」实机探测（Cursor.app / codex / claude 路径）。
- 2026-05-13：首版全表（Agent 本机枚举）。
