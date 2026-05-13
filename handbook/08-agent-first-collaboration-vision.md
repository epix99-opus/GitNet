# 北极星：以 Agent 为执行主体的多设备协作（GitNet 项目意图）

本文把 GitNet 元仓库的**本意**写进定稿，便于人类与所有编程 Agent 在打开本仓库时**周知一致目标**。与 [AGENTS.md](../AGENTS.md) 铁律、 [05-project-scope-and-delivery.md](05-project-scope-and-delivery.md) 交付边界**互补**：本文侧重**意图与自动化方向**，条文级约束仍以 AGENTS + handbook 其它章节为准。

## 我们要最大化什么

- **Agent 的可执行范围**：在**不突破法律与账号持有人授权**的前提下，尽量让 Agent 能独自完成「读仓库 → 设计/改文档与脚本 → 跑可得的自检命令 → 提交 → 推送（在会话 cwd 可达的 remote 上）→ 在 Issue/PR 留可验收证据」的闭环。
- **Git 体系与规范的可机读性**：拓扑、身份、`includeIf`、handoff、收口表、进程日志等，以 **`handbook/` 为唯一信源**，减少「只存在于聊天」的协作状态。
- **多设备、多 Agent 的无人值守协作**：通过 **SSH 公钥（`BatchMode`，默认优先）**、**经安全渠道注入的口令/PAT（见下文「全链路认证」）**、**环境变量中的短期令牌（不入库）**、[92-github-auto-sync-collaboration.md](92-github-auto-sync-collaboration.md) 类轮询、以及未来编排栈（如 Hermes/OpenClaw，以外部仓库为准），把「等人类点一下」缩到**硬边界不可避免**的最小集。

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

## 为实现北极星，仓库侧应持续靠拢的具体措施

| 方向 | 说明 |
|------|------|
| **SSH** | **默认**公钥；口令路径按上文「全链路认证」接入 **OS 级安全存储**，与 [templates/epix-id_ed25519.pub](templates/epix-id_ed25519.pub) / `authorized_keys` 收敛并行。 |
| **GitHub API** | `GITHUB_TOKEN` 或 `gh` 登录；token **不入库**；可经凭据管理器或会话环境注入。 |
| **收口与证据** | 协作状态见 [published/collaboration-closeout-status.md](published/collaboration-closeout-status.md)；可粘贴证据见 [published/issue-1-glab-evidence-comment.md](published/issue-1-glab-evidence-comment.md)（**脱敏**，不含口令）。 |
| **主从策略不变** | 业务权威仍在 **epix bare**；GitHub 从镜像；见 [10-topology.md](10-topology.md)。 |

## 修订记录

- 2026-05-13：首版（Agent-first 意图定稿；与 AGENTS 铁律、秘密禁令对齐）。
- 2026-05-13：增补 **全链路认证**（人类提供的口令/PAT 须安全存储与使用；公钥默认优先；禁止明文进 Git/Issue/手册）；与「不因公钥未完成而停摆」的人类意图对齐。
