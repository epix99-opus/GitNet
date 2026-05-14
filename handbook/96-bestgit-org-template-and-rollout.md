# BestGit 组织模板仓与三节点周知

> **性质**：GitNet 定稿中的**归档与入口**；模板正文在 **BestGit** 独立仓库维护，本页只写**路径、远端约定与回链**，避免双权威。

## BestGit 是什么

- **独立仓库名**：`BestGit`（组织级 Git / Agent 分层模板）。
- **epix 本机路径（约定）**：`/Users/epix/Dev/BestGit`（与 [55-multi-node-multi-agent-git.md](55-multi-node-multi-agent-git.md) 中 `~/Dev` 树一致）。
- **方案全文**（分层：节点 Git / 项目 / Agent）：在 BestGit 内 **`docs/scheme-layered-git-governance.md`**（通过 clone 阅读）；核心结论与 GitNet `08`/`93`/`94`/`AGENTS` **对齐互补**。

## 远端与镜像（建议）

- **建议 GitHub 镜像**：`https://github.com/epix99-opus/BestGit.git`（**已创建**；各克隆 `git pull` 即可）。
- **与 GitNet 主从策略**：BestGit 为**模板文本**，不要求 bare 权威（除非团队另行规定）；业务仓仍以 [10-topology.md](10-topology.md) 为准。

## 三节点与所有 Agent 如何周知

1. 各节点按 BestGit 仓库内 **`docs/rollout-epix-glab-woot.md`** 完成 clone（文内 **`<BestGit-URL>`** 请使用 **`https://github.com/epix99-opus/BestGit.git`** 或 SSH `git@github.com:epix99-opus/BestGit.git`）。
2. **v0.1 基线**：三节点与所有编程 Agent 须能打开并执行 GitNet **[`97-initial-gitnet-v0.1-deliverable.md`](97-initial-gitnet-v0.1-deliverable.md)** 中的验收矩阵（Raw：<https://raw.githubusercontent.com/epix99-opus/GitNet/main/handbook/97-initial-gitnet-v0.1-deliverable.md>）；CAMA pilot 检验文见该章 §7 链。
3. **所有 Agent**：在业务仓 `AGENTS` 或工具 User Rules 中增加一句：**新开仓执行 BestGit `docs/NEW_PROJECT_CHECKLIST.md`**。
4. **盘点可选**：将 `…/BestGit` 路径记入 [published/inventory-*-enumerated-agent.md](published/inventory-epix-enumerated-agent.md) 或 CAMA `cama-git-inventory`「备注」列。

## 与 GitNet 章节关系

| GitNet | 关系 |
|--------|------|
| [08-agent-first-collaboration-vision.md](08-agent-first-collaboration-vision.md) | 北极星与全生命周期框架；BestGit 为**落地载体** |
| [55-multi-node-multi-agent-git.md](55-multi-node-multi-agent-git.md) | `includeIf` 与节点路径；BestGit `templates/` 与之配合 |
| [94-multi-node-agent-inventory-raci-and-config-matrix.md](94-multi-node-agent-inventory-raci-and-config-matrix.md) | L1～L3；清单与 `bestgit-doctor` 与之配合 |
| [97-initial-gitnet-v0.1-deliverable.md](97-initial-gitnet-v0.1-deliverable.md) | **初版封存**；与上文「三节点与所有 Agent」步骤 **§2（v0.1 基线）** 联动 |
| [AGENTS.md](../AGENTS.md) | 铁律与多机 DoD；业务仓复制自 BestGit 片段 |

## 修订记录

- 2026-05-13：§「三节点与所有 Agent」增 **v0.1 基线**（链 **`97`** Raw）；「与 GitNet 章节关系」表增 **`97`** 行；与 GitNet 封存交付对齐。
- 2026-05-13：GitHub 仓库 **`epix99-opus/BestGit`** 已创建并推送；周知步骤中的 clone URL 已固定。
- 2026-05-13：首版（BestGit 建仓 + 本页归档与周知入口）。
