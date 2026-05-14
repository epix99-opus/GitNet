# GitNet 第二轮深度评审：Git 总线上的多 Agent 协作模式

> **文档性质**：在 [94-multi-node-agent-inventory-raci-and-config-matrix.md](94-multi-node-agent-inventory-raci-and-config-matrix.md) 与 [93-gitnet-phase-conclusion-and-cross-collab-git-playbook.md](93-gitnet-phase-conclusion-and-cross-collab-git-playbook.md) §7 之上，把 **「每工具一轮整仓评审」** 的**信令、身份、分支与硬边界**写成可复用短规。**评审结论文面**见 `handbook/published/gitnet-r2-review-conclusions.md`（合成稿）与各 `review-r2-*.md`（分稿）；**母单与验收**见 GitHub **Issue #16**。

## 1. 信令（不靠 IDE 直连）

| 层级 | 用途 |
|------|------|
| **GitHub Issue** | 母单：范围、分支名、交付文件清单、合入闸、副机 relay 说明。 |
| **Git 分支 + PR** | 并行评审、可审计作者；合入 **`main`** 仅经 **PR**（本仓例外见 [10-topology.md](10-topology.md)、[CONTRIBUTING.md](../CONTRIBUTING.md)）。 |
| **epix→副机 SSH（BatchMode）** | `pull` / 枚举 / `git format-patch` 取回副机提交；**不是** Cursor↔Cursor 控制面。 |

**不承诺**：三机三 IDE 实时会话互调；若需编排控制面，仍以 [93](93-gitnet-phase-conclusion-and-cross-collab-git-playbook.md) §7.4 为界，**落地回 Git**。

## 2. 身份与路径（L1）

- 规则全文：[55-multi-node-multi-agent-git.md](55-multi-node-multi-agent-git.md) §3。
- **epix**：`epix-cursor` 须在 **`/Users/epix/Dev/`** 下工作副本提交；`epix-claude-code` 须在 **`…/agent-work/claude-code/`** 树内；`epix-codex` 须在 **`…/Dev/CodexDev/`** 或 **`…/agent-work/codex/`** 树内（与该机 `.gitconfig` 片段一致）。
- **woot / glab**：分别为 `woot-cursor`、`glab-cursor` 等；**禁止**为赶进度在同一克隆上并行两工具写入（见 `55` §3 原则 1）。

验收：`git config --show-origin user.name` 来源为片段文件，值为 **`{HOSTNAME}-{tool}`**。

## 3. 本轮（R2）分支与文件命名

见 Issue **#16** 表格。合成阶段增加：

- **`handbook/published/gitnet-r2-review-conclusions.md`**：汇总表、共识/分歧、与本文 **§1～2** 互链（避免双写协作模式长文）。

## 4. 副机 push 硬边界与 relay

- **HTTPS 无 TTY** 时，`git push` 常失败；可选：**`github` → `git@github.com:…` SSH remote**（见 [46-tailscale-remote-git-identity.md](46-tailscale-remote-git-identity.md)、[handbook/scripts/setup-glab-github-ssh-and-gh.ps1](scripts/setup-glab-github-ssh-and-gh.ps1)）。
- **relay**：副机仅本地 `commit` 后，由 epix 经 SSH `git format-patch` → 本机 `git am` → `git push github`；**不得改作者/日期头**（与 Issue #11 实践一致）。

## 5. 合入后必做

1. **`handbook/scripts/gitnet-sync-github-main-to-bare.sh`**（GitHub `main` → epix bare `ff-only`）。  
2. **`handbook/90-process-log.md`** 一条：Issue #、PR #、对账命令输出或「已与 bare 一致」说明。

## 修订记录

| 日期 | 摘要 |
|------|------|
| 2026-05-14 | 首版：R2 深度评审 Git 总线协作模式；链 Issue #16、`55`/`93`/`94`。 |
