# GitNet 阶段成果：多端协作回顾与跨大型项目 Git 体系建议

> **文档性质**：本仓库 **阶段性结论成果**（目标 → 方案 → 实现 → 复盘 → 可外推规范）。**定稿信源**仍以 [00-truth-sources.md](00-truth-sources.md) 为准；本文在 `10` / `08` / `05` / `55` / `90` 等章节之上做 **归纳与可复用提炼**，若与逐条操作冲突，以被引用章节的修订版为准。

## 1. 执行摘要

- **GitNet** 是面向 **Tailscale 局域网内多 Mac / Windows、多编程 Agent、人类** 的 **Git 与协作治理元仓库**（非单一业务应用的主产品仓），见 [05-project-scope-and-delivery.md](05-project-scope-and-delivery.md)。
- **本阶段完成**：`handbook/` 定稿骨架、多节点多 Agent 身份矩阵（`40`/`55`）、epix↔woot/glab 的 SSH/Git 操作手册（`46`/`22`/`91`）、GitHub 从镜像与分支保护指引（`06`/`10`）、公钥信源与 glab OpenSSH/ACL 脚本链、Issue #1 式 **Handoff + 证据文件**、备选数据面 `92`、北极星 **Agent-first + 全链路认证**（`08`）、以及 **「写集成与默认 push 在 epix bare」** 的目标规范（`10` 新增节）。
- **协作形态**：**epix 上 Cursor Agent** 与 **glab 上 Cursor Agent** 主要通过 **同一 Git 对象（GitHub `main` 镜像 + 本仓 pull/push）** 与 **Issue #1 / `published/` 证据** 对齐；**硬边界**（Windows 管理员、UAC、本机 Terminal 口令会话）由人类按 [AGENTS.md](../AGENTS.md) 交接格式补全。
- **外推价值**：下文 **§7** 将上述经验抽象为 **复杂大型、多跨协作** 项目可复用的 **Git 体系、规范与流程清单**（可移植到其它 mono-repo 或平台仓，按需裁剪）。
- **v0.1 封存索引（规范/配置/脚本清单 + 三机验收矩阵）**：[97-initial-gitnet-v0.1-deliverable.md](97-initial-gitnet-v0.1-deliverable.md)（**97 = 交付包索引**；本文 **93** 侧重过程复盘，二者互补）。

## 2. 目标（从意图到可验收）

| 层级 | 内容 | 定稿位置 |
|------|------|----------|
| **北极星** | Agent 可执行范围最大化；Git 规范可机读；默认 SSH 公钥 + 人类秘密经安全存储参与全链路 | [08-agent-first-collaboration-vision.md](08-agent-first-collaboration-vision.md) |
| **元项目定义** | 多设备/多 Agent Git 体系、epix 权威与 GitHub 从镜像、人机契约与唯一信源 | [05-project-scope-and-delivery.md](05-project-scope-and-delivery.md) |
| **拓扑与写权威** | epix bare 为业务权威；各端 ↔ bare；epix → GitHub 定时推送；**多设备汇合点** 目标规范 | [10-topology.md](10-topology.md) |
| **身份** | 人类与 GitHub 一致；Agent 为 `{HOSTNAME}-{tool}` + `includeIf` | [40-identity-and-includeIf.md](40-identity-and-includeIf.md)、[55-multi-node-multi-agent-git.md](55-multi-node-multi-agent-git.md) |
| **跨机落地** | Tailscale SSH、glab 脚本、woot 用户名为 `woot`、公钥单行信源 | [46-tailscale-remote-git-identity.md](46-tailscale-remote-git-identity.md)、[22-glab-tailscale-epix-remote.md](22-glab-tailscale-epix-remote.md) |

---

## 3. 方案（架构决策摘要）

1. **单一 Git 业务权威**：epix 上 **bare**（路径见 `30` / `90` 实填）；禁止在第二台机器再立「第二 bare」作为业务主线。
2. **GitHub 角色**：**从镜像** + 人类可读 + Handoff 讨论（Issue）；**不推荐**日常把 GitHub 当作多端合并枢纽；过渡用法须在 [90-process-log.md](90-process-log.md) 记录。**例外**：**GitNet 本元仓库** 的 **`main`** 以 **GitHub PR 为合入闸**、bare **ff-only** 跟随，见 [10-topology.md](10-topology.md)、[56-git-workflow-quality-practices.md](56-git-workflow-quality-practices.md)、[97-initial-gitnet-v0.1-deliverable.md](97-initial-gitnet-v0.1-deliverable.md)。
3. **身份与目录解耦**：**谁提交**（`includeIf`）与 **推到哪里**（`origin` = bare）分离；`55` §5.1 链到 `10`。
4. **Handoff 模式**：对「对端 Agent 无法代劳」的事项，用 **Issue + 固定证据 Markdown（`published/`）+ PowerShell 证据脚本**（如 `91-glab-section-A-evidence.ps1`）减少聊天漂移。
5. **认证分层**：公钥优先；口令/PAT 仅经 OS 凭据管理器 / 机外路径 / 会话环境变量；**禁止**秘密明文进 Git、Issue 正文、`handbook/` 定稿段落（`08`）。
6. **数据面备选**：`92` + `gitnet-watch-github-sync.*` — **ff-only** 感知与拉取，**不替代** bare 写权威；与 Hermes/OpenClaw **并行互备**。
7. **分支治理**：GitHub 对 `main` **分支保护**（`06`）。**组织默认**：业务仓仍以 **bare 写集成** 为主、镜像叠层；**GitNet 本仓**：**PR 合入 `main`** + **`github→bare`**，见 **`10`/`56`/`97`**。历史句「仍应对 bare 操作」仅适用于**非 GitNet 本仓**或已登记迁回 bare 先写的流程。

---

## 4. 实现回顾（本仓库与提交历史脉络）

以下按 **主题** 归纳（与 `git log` 时间顺序大致一致；**精确哈希** 以 `git log` 为准）。

| 主题 | 实现要点 |
|------|----------|
| **仓库与手册骨架** | `git init` 后交付 `handbook/`、`AGENTS.md`、`.cursor/rules`、进程模板；确立 `00` 信源层级与 `07` 落盘规则。 |
| **多节点身份** | `55` + Windows/mac 模板；woot 经 epix SSH 实装 `woot-*`；glab 含盘符大小写、`git rev-parse` 与 `includeIf` 修正。 |
| **glab 网络事实** | `22` 与 `46` 互补：事实表 + epix 远程能力边界。 |
| **Handoff 与公钥** | `91` 链 Issue #1；`templates/epix-id_ed25519.pub` 为 **唯一公钥行信源**；`setup-glab-openssh-for-epix.ps1`、追加 `authorized_keys` 脚本、**Administrators 组** 与 `administrators_authorized_keys` / ACL/icacls 修复（BatchMode 公钥）。 |
| **证据与收口** | `published/issue-1-glab-evidence-comment.md`（§A glab / §B epix Terminal）；`published/collaboration-closeout-status.md`（T1～T5）；证据脚本增强 SSH 诊断。 |
| **GitHub 协作与镜像** | `origin` 在 glab/各端接入 GitHub 的 bootstrap；`92` 轮询方案与脚本；`06` 分支保护。 |
| **规范升格** | `10`：多设备多 Agent **bare 汇合** 目标规范 + 最优实现清单；`05`/`08`/`AGENTS` 与北极星、全链路认证对齐。 |

**GitHub 上记录**：与本仓库 **`main`** 提交历史、Issue #1 评论一致；**无独立于仓库的「第二文档源」**（镜像仓即公网可读副本）。

---

## 5. epix Cursor Agent × glab Cursor Agent 协作过程复盘

### 5.1 有效做法

- **单一信源**：争论点收敛到 `handbook/` 文件路径与模板，而非长聊天串。
- **可机器再生成的证据**：glab §A 由脚本输出；减少手工粘贴误差。
- **定稿公钥在树内**：`templates/epix-id_ed25519.pub` 避免「从聊天手抄」导致断行/弯引号。
- **收口表驱动**（`collaboration-closeout-status.md`）：T1～T5 明确 **谁验收、什么算完成**。
- **双端都能 `git pull`**：手册与脚本更新靠镜像传播到 glab 工作副本。

### 5.2 摩擦与根因

| 现象 | 根因 | 对策（已部分落盘） |
|------|------|---------------------|
| epix Agent Shell `ssh glab` 超时/公钥拒绝 | Agent 网络通道与 **BatchMode** 公钥路径、Windows **管理员组** `sshd` 行为差异 | `91` 说明边界；`46` §管理员；人类 Terminal 出 §B；脚本写 `administrators_authorized_keys` |
| `git push` 被拒、需 `pull --rebase` | 多端对 **同一 ref** 写入 | 规范收敛到 **bare + 节律**（`10`）；过渡期的 GitHub 双写记入 `90` |
| 人类口令会话 vs 自动化 | 全链路尚未全部公钥化 | `08` 分层：公钥优先 + 安全存储口令；不把「仅公钥」当停摆借口 |

### 5.3 与「最优拓扑」的差距（诚实结论）

- **当前常态**：多端仍以 **GitHub** 为可见汇合点的比重较高时，属于手册所述 **次优/过渡**；迁回 **「仅 bare 接收写集成」** 需在每台机改 `remote` 并在 `90` 记迁移验收。
- **T2/T4**：以 [published/collaboration-closeout-status.md](published/collaboration-closeout-status.md) 为准；**BatchMode 免口令** 与 **Issue 证据上墙** 可作为阶段完全收口标志。

---

## 6. 阶段交付物清单（仓库内）

| 类别 | 代表路径 |
|------|----------|
| 拓扑与写权威 | `handbook/10-topology.md` |
| 北极星与认证 | `handbook/08-agent-first-collaboration-vision.md`、`handbook/05-project-scope-and-delivery.md` |
| 身份与多机 | `handbook/40-*.md`、`handbook/55-*.md`、`handbook/templates/gitconfig.*` |
| SSH / glab / woot | `handbook/46-*.md`、`handbook/22-*.md`、`handbook/91-*.md`、`handbook/templates/epix-ssh-config-glab.fragment.conf` |
| 脚本 | `handbook/scripts/setup-glab-openssh-for-epix.ps1`、`append-epix-pubkey-*.ps1`、`91-glab-section-A-evidence.ps1`、`gitnet-watch-github-sync.sh`、`.ps1`、`com.gitnet.watch-github.plist` |
| 证据与收口 | `handbook/published/*.md` |
| 进程与模板 | `handbook/90-process-log.md` |
| 人机契约 | `AGENTS.md`、`.cursor/rules/gitnet-collaboration.mdc` |

---

## 7. 可复用：复杂大型「多跨协作」项目的 Git 体系 · 规范 · 流程

> **适用**：多地、多 OS、多 Agent、多人类；单一业务仓库或 mono-repo；需要 **审计友好** 与 **Agent 可执行** 并重。可按项目裁剪。

### 7.1 Git 体系（对象层）

1. **明确唯一「集成远程」**：所有工作副本默认 **`push`/`pull` 指向同一对象**（本项目的 **epix bare**）；镜像（如 GitHub）**只读展示**或由 **单一路径**（定时任务）写入。
2. **单一公钥/密钥信源**：跨机 SSH 公钥以 **仓库内受控文件或内部 Secret 管理** 为准，禁止聊天手抄。
3. **remote 命名约定**：`origin` = 集成权威；`github` 等 = 辅助，并在文档中写清 **禁止默认 push** 到镜像（除非登记例外）。
4. **分支与保护**：默认分支启用 **分支保护**；防止「绕过权威远程的直推习惯」。
5. **备选数据面**：轮询/Webhook **仅用于感知与 ff-only 合并**，不改变写权威归属。

### 7.2 规范（人与 Agent）

1. **作者身份可证明**：`git config --show-origin user.name` 可区分人类与 `{HOSTNAME}-{tool}`；大仓用 `includeIf` 按目录绑定工具。
2. **交接格式**：凡 Agent 不能完成的步骤，必须 **原因 + 逐步操作 + 验收标准**（`AGENTS` 第 3～4 条）；Issue/PR 与手册同构。
3. **秘密治理**：分层认证；**明文不进 Git/Issue/定稿手册**；人类提供的口令/PAT 走凭据管理器或机外路径（见 `08`）。
4. **信源层级**：机器事实 > `handbook/` > `AGENTS` > 聊天；冲突时改手册并记 `90`。
5. **阶段结论**：每个大阶段产出一篇 **回顾 + 外推清单**（本文即 GitNet 元仓库的范例），避免知识散失。

### 7.3 流程（执行闭环）

| 阶段 | 建议动作 |
|------|----------|
| **启动** | 写清拓扑一页纸；定 remote；定公钥信源；开 Issue 作 Handoff 母单。 |
| **并行开发** | 开工 `fetch` + `pull --rebase`；小步提交；推送至集成远程；冲突本地解。 |
| **跨机验收** | 固定脚本生成证据 → 粘贴 `published/` 或 Issue；收口表更新状态。 |
| **镜像发布** | 单通道从权威推到只读镜像；人类通知「镜像已更新」可选自动化（`92` 类）。 |
| **例外** | 任何偏离默认拓扑的行为，**进程日志**记原因与迁回条件。 |
| **收口** | 关闭 Issue 前核对收口表；大阶段合并回顾文档（如本文）。 |

### 7.4 与「编排控制面」的关系

- **Git 数据面**（本仓库 `92`、bare、镜像）解决 **对象是否一致**。
- **Hermes / OpenClaw** 等解决 **谁做什么、门禁与任务语义**；落地仍应 **落回各机 Git 操作**。
- **二者并行互备**，见 `92` 文内对比表。

---

## 8. 已知局限与建议下一迭代

1. **全面迁回「仅 bare 写集成」**：各端 `origin` 对齐 bare，减少 GitHub 双端直推；在 `90` 记迁移与对账命令输出。
2. **T2 最终验收**：epix `ssh -o BatchMode=yes glab …` 稳定成功（管理员组与 `administrators_authorized_keys` 已脚本化，见收口表 T2）。
3. **T4**：Issue #1 证据上墙与关闭策略由人类确认。
4. **可选**：`92` launchd/计划任务实装与告警渠道。
5. **大仓扩展**：若业务代码仓与 GitNet 分离，可将 **`93` §7** 抽取为组织级模板，GitNet 保留指向链接。

---

## 9. 文档与记录索引（本地 = GitHub `main` 镜像）

| 用途 | 路径或 URL |
|------|----------------|
| 本阶段结论（本文） | `handbook/93-gitnet-phase-conclusion-and-cross-collab-git-playbook.md` |
| **初版封存索引（v0.1）** | `handbook/97-initial-gitnet-v0.1-deliverable.md` |
| 手册目录 | `handbook/README.md` |
| 进程日志 | `handbook/90-process-log.md` |
| 协作收口 | `handbook/published/collaboration-closeout-status.md` |
| 证据快照 | `handbook/published/issue-1-glab-evidence-comment.md` |
| Handoff | `handbook/91-glab-handoff-epix-ssh-verify.md` |
| 三机盘点与 RACI | `handbook/94-multi-node-agent-inventory-raci-and-config-matrix.md` |
| Issue 讨论 | `https://github.com/epix99-opus/GitNet/issues/1` |

---

## 修订记录

- 2026-05-13：§1 增 **`97` v0.1 封存索引** 指针；§3 项 **2/7** 与 **GitHub PR 闸 + bare ff-only** 对齐（组织默认与本仓例外分述）。
- 2026-05-13：`08` 已吸收 **全生命周期 × Git** 与 **主分支/特性分支** 的产品化叙述；本文 §7 仍为 **外推清单与流程表**；生命周期阶段粒度与矩阵以 [08-agent-first-collaboration-vision.md](08-agent-first-collaboration-vision.md) 为准，与本节互补。
- 2026-05-13：首版；GitNet 元仓库 **阶段成果** + **跨大型协作 Git 体系建议**（回顾 epix/glab Cursor Agent 协作与全手册脉络）。
