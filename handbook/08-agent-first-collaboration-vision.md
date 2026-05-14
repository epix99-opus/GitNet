# 北极星：以 Agent 为执行主体的多设备协作（GitNet 项目意图）

本文把 GitNet 元仓库的**本意**与**可外推到任意业务仓的 Git 应用框架**写进定稿，便于人类与所有编程 Agent **周知一致目标**。条文级约束以 [AGENTS.md](../AGENTS.md) 与 `handbook/` 各章为准；信源冲突按 [00-truth-sources.md](00-truth-sources.md)。

## 根本目标与文档角色

### GitNet 元仓库的双重角色

| 角色 | 含义 |
|------|------|
| **(A) 本团队运维宿主** | Tailscale 多机、`epix` bare、脚本与 `published/` 证据的**定稿操作**见 [10-topology.md](10-topology.md)、[30-mac-epix-setup.md](30-mac-epix-setup.md)、[46-tailscale-remote-git-identity.md](46-tailscale-remote-git-identity.md) 等。元项目边界见 [05-project-scope-and-delivery.md](05-project-scope-and-delivery.md)。 |
| **(B) 可移植规范母版** | 面向「**任意业务仓 + 多人类 + 多 Agent**」的 **Git 对象层、身份、远程、分支、证据与进程** 约定；可复制或摘要到其他仓库的 `AGENTS.md` / `CONTRIBUTING.md`。**不**在本文规定各项目的编译器版本、构建/测试脚本细节（由业务仓 CI 与 README 自定）。 |

### 本仓库北极星的三个支柱

- **Agent 的可执行范围**：在**不突破法律与账号持有人授权**的前提下，尽量让 Agent 能独自完成「读仓库 → 设计/改文档与脚本 → 跑可得的自检命令 → 提交 → 推送（在会话 cwd 可达的 remote 上）→ 在 Issue/PR 留可验收证据」的闭环（执行纪律见 [AGENTS.md](../AGENTS.md)）。
- **Git 体系与规范的可机读性**：拓扑、身份、`includeIf`、handoff、收口表、进程日志等，以 **`handbook/` 为唯一信源**；落盘分层见 [07-documentation-placement.md](07-documentation-placement.md)。
- **多设备、多 Agent 的无人值守协作**：通过 **SSH 公钥（`BatchMode`，默认优先）**、**经安全渠道注入的口令/PAT（见下文「全链路认证」）**、**环境变量中的短期令牌（不入库）**、[92-github-auto-sync-collaboration.md](92-github-auto-sync-collaboration.md) 类轮询、以及未来编排栈（如 Hermes/OpenClaw，以外部仓库为准），把「等人类点一下」缩到**硬边界不可避免**的最小集。

## 全局共用 Git 规定（全节点 · 全 Agent · 全项目的抽象）

下列为**跨项目复用时的检查清单**；GitNet **本仓**的实填值仍以被引用章节为准。任何偏离须在 [90-process-log.md](90-process-log.md) 记原因与迁回条件。

| # | 规定（摘要） | 定稿与操作 |
|---|-------------|------------|
| 1 | **唯一写集成远程**：日常 `fetch`/`pull`/`push` 的汇合对象一致 | [10-topology.md](10-topology.md)（epix bare；GitHub 从镜像） |
| 2 | **`origin` / `github` 语义**：`origin` → 集成权威；`github` 等 → 辅助，默认不直推镜像 | `10` §默认远端命名；例外记 `90` |
| 3 | **作者可区分**：人类 vs `{HOSTNAME}-{tool}`，邮箱组织约定 | [40-identity-and-includeIf.md](40-identity-and-includeIf.md)、[55-multi-node-multi-agent-git.md](55-multi-node-multi-agent-git.md) |
| 4 | **秘密与凭据**：明文不进 Git / Issue 定稿 / `published/` | 下文「全链路认证」；`07` |
| 5 | **GitHub 分支保护**：保护**镜像**上的集成分支，防「习惯直推 GitHub」与 bare 主线冲突 | [06-github-branch-protection.md](06-github-branch-protection.md) |
| 6 | **Handoff 与证据**：跨机硬边界用 Issue + `published/` + 脚本输出，减少聊天漂移 | [91-glab-handoff-epix-ssh-verify.md](91-glab-handoff-epix-ssh-verify.md)、[published/collaboration-closeout-status.md](published/collaboration-closeout-status.md)；复盘结构见 [93-gitnet-phase-conclusion-and-cross-collab-git-playbook.md](93-gitnet-phase-conclusion-and-cross-collab-git-playbook.md) §5 |
| 7 | **Agent 回合与多机实测**：能 SSH 则实测落盘，禁止「只写流程」冒充完成 | [AGENTS.md](../AGENTS.md)、[94-multi-node-agent-inventory-raci-and-config-matrix.md](94-multi-node-agent-inventory-raci-and-config-matrix.md) |
| 8 | **外推清单**：复杂多跨项目可裁剪复用 | `93` §7；**组织模板**见 [96-bestgit-org-template-and-rollout.md](96-bestgit-org-template-and-rollout.md) |
| 9 | **SSH 公钥信源与 glab 落地** | [templates/epix-id_ed25519.pub](templates/epix-id_ed25519.pub)、`handbook/scripts/setup-glab-openssh-for-epix.ps1`（见 `46`） |
| 10 | **GitHub API / `gh`** | token **不入库**；凭据管理器或会话环境注入 |
| 11 | **提交信息与工作流质量**（约定式提交、小步、`add -p`、分支/PR、rebase -i 边界、分支清理） | [56-git-workflow-quality-practices.md](56-git-workflow-quality-practices.md)；根 [CONTRIBUTING.md](../CONTRIBUTING.md) |

## 全生命周期 × Git（框架矩阵）

**用途**：约束「每个阶段 Git 该管什么」；**不**替代业务仓的产品流程工具（看板、OKR）。**业务仓**若未定义 release/tag 策略，须在首次发版前于该仓 `90`（或等价进程日志）**书面固化**下列「分支/标签」列的约定。

| 阶段 | Git 目标（对象 / 可追溯） | 推荐分支与标签习惯 | 文档与证据落点 | 人类 vs Agent（摘要） | 深链 |
|------|---------------------------|----------------------|----------------|------------------------|------|
| **早期探讨** | 决策有引用、可链接到后续提交 | 可用 `docs/` 草稿或长期分支 `explore/<topic>`；不污染 `main` 历史则优先草稿 PR/MR | [07-documentation-placement.md](07-documentation-placement.md)；结论迁入 `handbook/` 或 ADR 后删草稿 | 人类拍板方向；Agent 整理与检索 | `05`、`07`、`93` §7.3 |
| **产品设计** | 需求与范围可 diff | **`design/<feature>`** 或单仓 **`main` + 目录约定**；大变更仍建议分支 | 设计稿与范围进仓或链 Issue；**不**把凭据写进仓库 | 人类验收范围；Agent 起草与交叉引用 | `05`、`90` |
| **技术架构** | 重大结构变更可审计 | **`arch/<topic>`** 或 ADR 提交序列在 `main` 上 | ADR 文件名约定由业务仓定；GitNet 用 `handbook/` 定稿 | 人类关键架构决策；Agent 执行迁移与链接 | `00`、`07`、`93` §7 |
| **编程开发** | 小步、可回滚、作者可辨 | **`feature/<topic>`** 或 **`agent/<host>-<tool>/<topic>`**（团队**选一种**命名，在业务仓 `90` 首次登记）；向集成分支合并前 **`fetch` + `pull --rebase`** 节律见 `10` | 提交信息可读；复杂点链 Issue | Agent 主力；人类按目录 `includeIf` 与代码审查 | `10`、`40`、`55`、[AGENTS.md](../AGENTS.md) |
| **评审测试** | 合并门禁与镜像一致 | **PR/MR → 集成分支**；保护规则见 `06`；必要时 **`release/x.y` 分支**只收修复 | CI 日志、测试报告进 CI 工件或 Issue；**最小可复现**命令可进 `published/` 式证据 | 人类合并权；Agent 修测迭代 | `06`、`93` §7.3 |
| **交付上线** | 版本可指向唯一提交 | **`vX.Y.Z` 附注标签**（annotated tag）指向集成分支上已发布提交；**热修复**从标签分 **`hotfix/…`** | 发布说明可 `CHANGELOG` + Git 附注；GitNet 大阶段回顾进 `93` | 人类发版按钮与合规；Agent 填 changelog 草案 | 业务仓自定；GitNet 见 `93` |
| **运行维护** | 生产修复可 cherry-pick 回开发线 | **`hotfix/*` → 集成分支 → 必要时 cherry-pick 到 `develop`/`main`**；镜像只读，回写仍走集成远程 | 事故时间线进 `90`；根因与补丁链 commit | 人类批准 hotfix；Agent 准备分支与 diff | `10`、`90`、`93` §7.1 |

**GitNet 本元仓库惯例（`epix99-opus/GitNet`，2026-05-14 起）**：**一律**在 **`chore/*` / `docs/*` / `fix/*` / `feat/*`** 等特性分支上开发；**`git push -u github <分支>`** 后在 GitHub 开 **Pull Request** 合入 **`main`**；**禁止**为更新 **`main`** 而 **`git push origin main`**（绕过 PR）。PR merge 后，epix 上执行 **`gitnet-sync-github-main-to-bare.sh`** 使 bare `main` 与 **`github/main`** ff-only 对齐（见 [10-topology.md](10-topology.md)、[56-git-workflow-quality-practices.md](56-git-workflow-quality-practices.md)、[90-process-log.md](90-process-log.md)）。**其它业务仓**仍按上表阶段选分支策略，并在该仓 `90` 固化命名。

## 跨设备、多 Agent：主分支与特性分支协作

- **集成分支（常名 `main`）**：解析于**集成远程**（GitNet 场景为 [10-topology.md](10-topology.md) 所述 **epix bare**）上的、供各机 **`merge`/`fast-forward` 对齐** 的**唯一主线**；GitHub 上的 `main` 若为镜像，配合 [06-github-branch-protection.md](06-github-branch-protection.md) 防绕过。
- **特性分支**：并行开发时 **一人一机一 Agent 一分支** 为推荐，减少多 Agent 同时推同一 ref；命名在「`feature/…`」与「`agent/<host>-<tool>/…`」中**择一**并在业务仓 `90` 固化。合入前本地 **`git pull --rebase origin <集成支名>`**（或等价）以减少分叉，与 `10`「开工节律」一致。
- **合并策略**：团队可择 **merge commit**（保留分支拓扑）或 **squash merge**（主线更直）；须在业务仓 `90` 或 `CONTRIBUTING` **写清一种默认**；Agent 执行时不得擅自改团队已选策略。
- **RACI 与盘点**：三机谁负责枚举、谁填表，见 [94-multi-node-agent-inventory-raci-and-config-matrix.md](94-multi-node-agent-inventory-raci-and-config-matrix.md) §3 与 [published/inventory-machine-TEMPLATE.md](published/inventory-machine-TEMPLATE.md)。

## 每项目、每 Agent、每节点的通用约定

| 对象 | 约定（摘要） | 详情 |
|------|-------------|------|
| **每项目** | **L1** 身份（`includeIf` / 片段）、**L2** `origin` 指向约定集成远程、**L3**（可选）根 `AGENTS` 与项目规则 | [94-multi-node-agent-inventory-raci-and-config-matrix.md](94-multi-node-agent-inventory-raci-and-config-matrix.md) §2；业务仓可只要求 L1+L2 |
| **每 Agent** | 作者名 **`{HOSTNAME}-{tool}`**，邮箱 **`epix99@icloud.com`**；目录树与 `includeIf` 顺序；避免同一克隆目录被两工具同时写 | `55` §1～3；[AGENTS.md](../AGENTS.md) |
| **每节点设备** | 工作克隆 ↔ bare；**不要**在第二台机器另立业务 bare；SSH 别名与用户（如 `woot@woot`） | `10` 角色表；`46`、`22` |

## 多智能体并行协作（信源仲裁）

多个 Agent 会话或人类与 Agent 并行时，**不以聊天为唯一真相**：争议与状态以 **`handbook/` 定稿段落**、`published/` **可机器再生成的证据**、[90-process-log.md](90-process-log.md) **进程**为准；有效做法归纳见 [93-gitnet-phase-conclusion-and-cross-collab-git-playbook.md](93-gitnet-phase-conclusion-and-cross-collab-git-playbook.md) §5.1。编排控制面（Hermes/OpenClaw）与 Git 数据面的边界见 **`93` §7.4**。

## 全链路认证：跨节点、跨 OS、跨 Agent（人类意图，周知）

**人类初衷（定稿）**：本项目必须为真实开发形成**全链路可自主执行**的协作机制；**不得**让「尚未完成公钥配置」单独成为停摆理由——在兼顾安全的前提下，**人类向 Agent 提供的口令、PAT 等，Agent 有义务协助以安全方式存储并在自动化中使用**（存储形态见下，**禁止**明文进入 Git 对象）。

### 分层策略（公钥优先，口令为授权补充）

| 层级 | 用途 | 推荐机制 |
|------|------|-----------|
| **默认（自动化 / BatchMode）** | Agent Shell、CI、脚本 | **SSH 公钥**；glab 侧维护 [templates/epix-id_ed25519.pub](templates/epix-id_ed25519.pub) → `authorized_keys`（见 `46` / `setup-glab-openssh-for-epix.ps1`）。 |
| **授权补充（人类显式提供秘密时）** | 公钥尚未就绪、或人类选择口令路径 | **安全存储 + 受控读取**：见下「可接受的存储与使用形态」。 |

### 可接受的存储与使用形态（明文值不得进入本仓库 / Issue / `published/`）

以下满足「**安全方式存储和使用**」的工程含义；**仍禁止**将口令/PAT/私钥**明文**写入 `handbook/`、根 `README`、`published/`、任何 **commit**，或贴在 **GitHub Issue/PR 可被搜索引擎索引的正文**中。

1. **操作系统凭据管理器**  
   - **Windows**：`cmdkey` 写入 **Windows 凭据管理器**（Generic 凭据），脚本与工具通过系统 API / 已集成组件读取；或 **Git Credential Manager** 对 HTTPS。  
   - **macOS**：**Keychain**；**Linux**：**libsecret** / 发行版推荐密钥环。

2. **机外或用户配置目录中的受控文件**（**不**在 GitNet 工作树内、**不**被 `git add`）  
   - 例如 `%USERPROFILE%\.config\gitnet\` 下权限收紧（仅当前用户）的文件，由人类写入一次；脚本通过**绝对路径**读取。仓库内**只**允许出现**路径约定与文件名占位**，不出现真实值。

3. **会话前注入的环境变量**  
   - 人类在本机终端先 `set` / `export`，再启动 IDE/Agent；仓库脚本**仅引用变量名**（如 `GITNET_GITHUB_TOKEN`），并在 `handbook` 中说明含义。

4. **企业密钥库**（团队若已部署）  
   - HashiCorp Vault、1Password CLI、云厂商 Secret Manager 等；Agent 通过**已配置的** CLI/SDK 拉取短期凭据。

5. **SSH 口令自动化（最后手段，仅人类授权后）**  
   - 使用 **`sshpass` / Expect** 等时，口令来源**必须**是上述 1～4 之一，**不得**硬编码在仓库；可在本机添加 **`.gitignore` 已忽略的 wrapper 脚本**（路径在机外亦可），本仓库仅链到运维规范或内部仓。

### Agent 对人类提供秘密时的义务

- **不得**以「只用公钥」为唯一教条拒绝继续开发；应同时给出：**公钥收敛路径** + **在人类授权下**通过凭据管理器/机外文件/环境变量**落地可执行方案**。  
- **必须**协助人类把秘密从「聊天」迁移到「安全存储」：给出逐步、可复制、**不含明文示例值**的命令（例如 `cmdkey` 的参数结构、`setx` 的变量名约定）。  
- **不得**在回复中**复述**人类刚提供的口令全文；不得在日志中打印解密后的值。

## 我们**不**声称什么（避免误解）

- **不是**「任何操作都 100% 无人类」：首次设备授权、法定批准、物理 UAC、以及**秘密的首次写入安全存储**，仍常需人类在场；此时 AGENTS **第 3～4 条**交接格式适用。  
- **不是**把聊天当成凭据仓库：聊天有留存与泄露面；**定稿与长期真相**仍以 `handbook/` + 安全存储中的引用为准。

## 修订记录

- 2026-05-14：**GitNet 本元仓库惯例**改为 **GitHub PR 合入 `main`** + bare **`gitnet-sync-github-main-to-bare.sh` ff-only**；与 `10` 本仓例外、`30`、`06`、`90` 迁移条一致。
- 2026-05-14：全局清单增 **#11**（提交信息与工作流质量 → **`56`**）；「GitNet 本元仓库惯例」初稿链 **`56`**。
- 2026-05-13：首版（Agent-first 意图定稿；与 AGENTS 铁律、秘密禁令对齐）。
- 2026-05-13：增补 **全链路认证**（人类提供的口令/PAT 须安全存储与使用；公钥默认优先；禁止明文进 Git/Issue/手册）；与「不因公钥未完成而停摆」的人类意图对齐。
- 2026-05-13：扩充 **根本目标与双重角色**、**全局共用 Git 规定**清单、**全生命周期 × Git** 矩阵、**主分支/特性分支**、**每项目/Agent/节点** 约定表、**多智能体信源仲裁**；与 `05`/`07`/`10`/`40`/`55`/`06`/`90`/`93`/`94`/`AGENTS` 交叉引用；删除重复的「为实现北极星」四行表（内容并入全局清单）。
