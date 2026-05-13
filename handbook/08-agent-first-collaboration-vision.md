# 北极星：以 Agent 为执行主体的多设备协作（GitNet 项目意图）

本文把 GitNet 元仓库的**本意**写进定稿，便于人类与所有编程 Agent 在打开本仓库时**周知一致目标**。与 [AGENTS.md](../AGENTS.md) 铁律、 [05-project-scope-and-delivery.md](05-project-scope-and-delivery.md) 交付边界**互补**：本文侧重**意图与自动化方向**，条文级约束仍以 AGENTS + handbook 其它章节为准。

## 我们要最大化什么

- **Agent 的可执行范围**：在**不突破安全与法律**的前提下，尽量让 Agent 能独自完成「读仓库 → 设计/改文档与脚本 → 跑可得的自检命令 → 提交 → 推送（在会话 cwd 可达的 remote 上）→ 在 Issue/PR 留可验收证据」的闭环。
- **Git 体系与规范的可机读性**：拓扑、身份、`includeIf`、handoff、收口表、进程日志等，以 **`handbook/` 为唯一信源**，减少「只存在于聊天」的协作状态。
- **多设备、多 Agent 的无人值守协作**：通过 **SSH 公钥（`BatchMode`）**、**环境变量中的短期令牌（不入库）**、[92-github-auto-sync-collaboration.md](92-github-auto-sync-collaboration.md) 类轮询、以及未来编排栈（如 Hermes/OpenClaw，以外部仓库为准），把「等人类点一下」缩到**硬边界不可避免**的最小集。

## 我们**不**声称什么（避免误解）

- **不是**「任何操作都 100% 无人类」：首次设备授权、账号法定持有人批准、物理 UAC、以及**任何秘密的首次注入**，仍可能落在人类侧；此时 AGENTS **第 3～4 条**交接格式适用。
- **不是**让 Agent 在聊天中接收**口令 / PAT / 私钥**并代登远程主机：秘密**不得**写入仓库、Issue、日志；也不得要求 Agent 用聊天里的口令去 SSH——这既违反本仓库安全规则，也无法在多数 Agent 运行时中安全审计。

## 为实现北极星，仓库侧应持续靠拢的具体措施

| 方向 | 说明 |
|------|------|
| **SSH** | 各节点优先 **公钥** 登录；glab 与 epix 之间以 [templates/epix-id_ed25519.pub](templates/epix-id_ed25519.pub) 为信源维护 `authorized_keys`，避免交互式口令阻塞脚本与 Agent Shell。 |
| **GitHub API** | Issue/PR 自动化发帖使用 **`GITHUB_TOKEN` 环境变量**（或 `gh` 已登录会话），**不**把 token 写入 Git。 |
| **收口与证据** | 协作状态见 [published/collaboration-closeout-status.md](published/collaboration-closeout-status.md)；可粘贴证据见 [published/issue-1-glab-evidence-comment.md](published/issue-1-glab-evidence-comment.md)。 |
| **主从策略不变** | 业务权威仍在 **epix bare**；GitHub 从镜像；见 [10-topology.md](10-topology.md)。北极星是**执行自动化**，不是改拓扑。 |

## 修订记录

- 2026-05-13：首版（Agent-first 意图定稿；与 AGENTS 铁律、秘密禁令对齐）。
