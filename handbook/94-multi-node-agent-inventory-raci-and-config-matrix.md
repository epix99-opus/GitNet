# 三节点编程 Agent：盘点、规范对齐与分工（RACI + 配置矩阵）

> **定位**：在 [55-multi-node-multi-agent-git.md](55-multi-node-multi-agent-git.md)（身份与目录）之上，提供 **实机盘点方法**、**「纳入 GitNet 体系」的分层定义**、**三机 RACI** 与 **全局/项目配置矩阵**。**对象层**（`origin`、bare）以 [10-topology.md](10-topology.md) 为准；**意图与认证**见 [08-agent-first-collaboration-vision.md](08-agent-first-collaboration-vision.md)；**可外推流程**见 [93-gitnet-phase-conclusion-and-cross-collab-git-playbook.md](93-gitnet-phase-conclusion-and-cross-collab-git-playbook.md) §7。

## 1. 信息边界（禁止臆造清单）

| 类型 | 来源 |
|------|------|
| **规范约定**（每机最多 Cursor/Codex/Claude Code、作者名、`includeIf` 路径前缀） | `55`、`40` |
| **各机已装哪些工具、有哪些 Git 仓库** | **仅**来自各机执行本文 **§5** 命令后的输出；填入 [published/inventory-machine-TEMPLATE.md](../published/inventory-machine-TEMPLATE.md) 的副本，或摘要至 [90-process-log.md](90-process-log.md)（敏感 URL 脱敏） |
| **glab SSH 与 GitNet 路径实值** | 以 [published/collaboration-closeout-status.md](published/collaboration-closeout-status.md)、[published/issue-1-glab-evidence-comment.md](published/issue-1-glab-evidence-comment.md) 为准；本文件**不**复制易变用户名路径 |

---

## 2. 「纳入 GitNet Git 体系」分层定义

| 层级 | 验收条件 | 参考 |
|------|----------|------|
| **L1 身份** | 在对应 Agent 目录下的仓库内：`git config --show-origin user.name` 来源为 **片段文件**，值为 **`{HOSTNAME}-{tool}`**；`user.email` 为 **`epix99@icloud.com`** | `55` §5 |
| **L2 对象** | `git remote -v` 中 **`origin` 指向团队约定的 epix bare**（或过渡方案已在 `90` 登记）；GitHub 不作为未登记的日常写主线 | `10`「规范状态」「多设备 × 多 Agent」、`55` §5.1 |
| **L3 元契约（GitNet 本仓）** | 根目录 `AGENTS.md`、`.cursor/rules/` 生效 | 仓库根 |

**说明**：业务仓库可只要求 **L1+L2**；根 `AGENTS.md` 可由组织模板复制并改为「引用 GitNet handbook URL」。

---

## 3. 三机角色与 RACI（简表）

| 事项 | epix | glab | woot | 备注 |
|------|------|------|------|------|
| **bare 与 launchd 推镜像** | **R/A** | I | I | `30`、`10` |
| **GitNet handbook 定稿编辑** | **R/A** | C | C | glab/woot 以 `git pull` 对齐 |
| **公钥信源与 epix→glab/woot SSH** | **R/A** | C（本机执行脚本） | I | `46`、`91`、`templates/epix-id_ed25519.pub` |
| **Windows 专用脚本与 ACL** | I | **R/A**（本机管理员/用户） | — | `handbook/scripts/*.ps1` |
| **各机 `includeIf` 与片段** | **R**（模板在仓内）/ 各机 **A** | **A** | **A** | `55`、`templates/` |
| **实机盘点表填写** | **A** | **A** | **A** | 见 §5、`published/inventory-machine-TEMPLATE.md` |

**图例**：R=负责定稿/规范，A=批准或实机执行，C=协商/被告知，I=知情。

**按工具分工（推荐）**：Cursor 主力 **`~/Dev/`**（或 `agent-work/cursor/`）；Codex **`~/Dev/CodexDev/`** 或 **`agent-work/codex/`**；Claude Code **`agent-work/claude-code/`**（`55` §3.2～3.4）。**避免**同一克隆目录被两工具同时写。

---

## 4. 全局级 vs 项目级配置矩阵

| 层级 | 配置内容 | 三机共性 |
|------|----------|----------|
| **全局 · Git** | 顶层 `[user]`（人类）；`includeIf` → `~/.gitconfig-fragment-*` / Windows 等价路径 | `40`、`templates/gitconfig.mac.main.ini`、`templates/gitconfig.windows.main.ini` |
| **全局 · SSH** | `~/.ssh/config`：Tailscale 主机别名、`User`（woot 为 **`woot`**）、`IdentityFile` | `45`、`46` |
| **全局 · 换行** | Windows `core.autocrlf` 等 | `20` |
| **全局 · 工具（非 Git）** | Cursor：User Rules / Skills（见 `AGENTS`）；Codex：`~/.codex/`；Claude：`~/.claude/` | `55` §4 |
| **项目级** | `git remote`（`origin`/`github`）；**避免** `--local user.*` 除非人类作者例外 | `40`、`10` |

---

## 5. 实机盘点：可复制命令与填表

### 5.1 示例（epix 仅 GitNet 一行）

见 [published/inventory-epix-starter.md](../published/inventory-epix-starter.md)（随仓库更新可修订；**非**全机枚举）。

### 5.2 复制模板

```bash
# 在 GitNet 克隆根执行（路径按你本机调整）
cp handbook/published/inventory-machine-TEMPLATE.md handbook/published/inventory-$(hostname -s).md
```

将 `inventory-$(hostname -s).md` 填完后：**可 commit**（脱敏后）或把摘要写入 `90-process-log.md`。

### 5.3 工具是否安装（各机人类自查）

| 工具 | macOS | Windows |
|------|--------|---------|
| **Cursor** | 已安装则可在 Applications 或 `cursor` CLI | 已安装则有 Cursor 应用 |
| **Codex CLI** | 例如 `which codex` 或依团队安装路径 | 依安装文档 |
| **Claude Code** | 依 Anthropic 安装指引 | 若未使用可标「未部署」 |

### 5.4 枚举 Git 仓库（只读；限制深度避免过慢）

**macOS（epix / woot）** — 在需盘点的根目录执行（示例深度 4，可按需调整）：

```bash
ROOT="$HOME/Dev"
find "$ROOT" "$HOME/agent-work" -maxdepth 4 -name .git -type d 2>/dev/null | while read g; do repo=$(dirname "$g"); git -C "$repo" rev-parse --show-toplevel 2>/dev/null; done | sort -u
```

**Windows（glab）** — PowerShell（示例根 `E:\Dev`）：

```powershell
Get-ChildItem -Path E:\Dev, "$env:USERPROFILE\agent-work" -Directory -Recurse -Depth 3 -ErrorAction SilentlyContinue |
  ForEach-Object { if (Test-Path (Join-Path $_.FullName '.git')) { $_.FullName } }
```

### 5.5 每个仓库一行记录（写入模板表内）

在仓库根执行：

```bash
pwd
git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "(not a branch)"
git remote -v
git config --show-origin user.name 2>/dev/null | head -1
git config --show-origin user.email 2>/dev/null | head -1
git log -1 --format='%h %ci %s' 2>/dev/null || echo "(empty)"
```

**脱敏**：HTTPS remote 中的 token、内网 IP 若不想公开，在表中写 `origin → (redacted)` 并在 `90` 说明「实值已记在某某私有笔记」。

---

## 6. 整改与收口

| 发现 | 动作 |
|------|------|
| `user.name` 非 `{HOSTNAME}-*` 且应为 Agent 提交 | 调整目录或追加 `includeIf`（`55`）；勿在业务仓随意 `--local` 覆盖 |
| `origin` 非 bare 且未在 `90` 登记 | 迁移 `remote` 或在 `90` 记例外与迁回日期（`10`） |
| 新主机加入 | 复制 `55` 同构表；更新本盘点文件；`90` 记日期 |

---

## 7. 与其它章节的交叉引用

- 身份路径总表：`55`
- bare 汇合与 push 节律：`10`
- 北极星与秘密：`08`
- 阶段复盘与外推清单：`93` §7
- glab Handoff 与 Issue：`91`、[Issue #1](https://github.com/epix99-opus/GitNet/issues/1)
- 进程与实值：`90`

---

## 修订记录

- 2026-05-13：首版（计划 `94` 落盘：盘点模板、RACI、配置矩阵、分层纳入定义）。
