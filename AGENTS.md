# GitNet — Agent 与人类协作约定

本文件约束**在本仓库内工作的编程 Agent** 与**人类维护者**的行为边界。拓扑、路径与平台细节以 [handbook/](handbook/) 为唯一信源。

## 全局铁律（执行与上抛）

### 「全局」指什么、不指什么

- **指（原则范围）**：凡由 Agent 承担的任务，**不因换仓库或换会话就变卦**——能执行就执行到可验收为止；只有客观硬边界才交接人类，且须附原因与操作提示。
- **不指（Cursor 注入范围）**：本文件与 `.cursor/rules/` 写在 **GitNet 仓库内**时，在 Cursor 里默认只对**打开本仓库作为工作区**的会话稳定注入；这属于**本项目的契约与信源**，**不等于** Cursor 对「你电脑上每一个文件夹」自动生效。
- **全 Cursor、全工作区**：若要在 **所有** Cursor 工作区默认生效与本条等价的铁律，请使用 **Cursor Settings → Rules → User Rules**（或团队 **Team Rules**）。**勿假设**未配置 User Rules 时其它文件夹打开的工作区会自动带上本仓契约。一次性本机迁移、备份路径、存储键名等**过程细节**只记在 [`handbook/90-process-log.md`](handbook/90-process-log.md)，**不写入本文件**，以免随 Cursor 版本漂移。

### 条文

1. **默认闭环**：凡属 Agent **能够自行判断、设计、评审、执行、验收** 的事项（读代码、改仓库、跑可得的命令、写脚本与文档、做自检清单），**必须在本对话/本会话内做完**，不得用「请人类去做」替代。
2. **禁止无理由回抛**：不得把本可自动化或可清晰落地为「复制即执行」的步骤笼统丢给人类；若提供命令或步骤，Agent 应优先在自身环境能执行范围内**自己执行**。
3. **允许请求人类的唯一情形**：存在 **Agent 在客观上无法完成** 的硬边界（示例：未授权的凭证与密钥材料、物理设备上的首次生物识别/系统弹窗、无网络/无 SSH 到达目标机、法律或账号所有者明示批准）。此时 **必须** 同时给出：
   - **原因**（为何 Agent 不能继续）；
   - **操作提示**（逐步、可复制：在何设备、点何处、填何值、如何验收）。
4. **交接人类的格式（强制）**：凡列出「Agent 不能判断或不能执行的未完成项」时，**禁止**只写事项名称或一句「请人类处理」。每条未完成项须在同一处写清：**原因** + **操作提示**（命令/菜单路径逐步可复制）+ **验收标准**（怎样算完成）。会话回复、Issue/PR 评论、`handbook/90-process-log.md` 与各类 handoff 文档均适用。
5. **任务完成定义**：以「目标可验证地达成」或「不可逾越边界已用第 3～4 条格式交接」为准，不得停在未尝试的中间态。
6. **规划与可验证信号（与 Cursor Agent 习惯对齐）**：
   - **大改先规划**：多文件重构、架构/安全/发布相关、或需求边界不清时，**优先**使用 Cursor **Plan Mode**（或先在本会话写出可审阅的短方案与受影响文件列表）再动大 diff；与 [handbook/93-gitnet-phase-conclusion-and-cross-collab-git-playbook.md](handbook/93-gitnet-phase-conclusion-and-cross-collab-git-playbook.md) 的归纳层可并用。
   - **改代码后给信号**：本仓库若存在 **CI、lint、测试脚本**，在**实质改动**应用代码或构建配置后，**须**运行与变更相关的**最小**检查（单测文件 / 目标 lint），不得跳过可得的失败信号；仍遵守下文「禁止」中不得为过测而改测。
7. **人类协作提示（可选）**：换任务、模型明显跑偏或长会话后效果下降时，**新开对话**；续作可用 Cursor **`@Past Chats`** 拉取摘要，优于整段粘贴。

### 回合前与回合末：目标对齐与主动检索（与条文 1～7 一并遵守）

面向**所有任务类型**（不限于多机盘点）：约束「不读信源就编、不对齐用户目标就收口」。

1. **回合前**：用 **一句可验收的话** 写出本回合完成判据（可嵌入用户原文中的结果词：例如「三机路径级探测写入 `published/` 并已 push」）；判据若含糊，**先**缩小范围或列出可验证假设再动手，禁止默认猜错范围后长篇交付。
2. **回合中**：对不熟路径、未读过的 `handbook/` 段落、未知符号或跨文件行为，**须**在改代码/写结论前用仓库内检索/读文件工具 **先读后写**；关键事实（拓扑、SSH 名、remote、bare 路径）以 `handbook/` 与 `AGENTS` 为准，**禁止**凭印象臆造。
3. **回合末**：在宣称「已完成」前，**逐项对照**回合前那句判据；若判据含可运行命令或可展示输出，**须**已实际执行或已按条文 **3～4** 交接硬边界。涉及多机/SSH 可测事实时，还须满足下文 **「多机与盘点：实测完成定义」**。

### 多机与盘点：实测完成定义（铁律的操作化）

下列约束与上文 **条文 1～7**、**「回合前与回合末：目标对齐与主动检索」** 一并遵守；操作细节与命令模板见 [handbook/94-multi-node-agent-inventory-raci-and-config-matrix.md](handbook/94-multi-node-agent-inventory-raci-and-config-matrix.md) §5、`handbook/published/inventory-*-enumerated-agent.md`。

1. **回合完成定义（DoD）**：任务若涉及「各机是否安装某编程 Agent/CLI」「可执行路径」「跨机仓库枚举」等**可经网络与 SSH 验证的事实**——在 **epix 上 `ssh -o BatchMode=yes glab` / `ssh -o BatchMode=yes woot@woot` 已能成功**（或仅需本机命令）时，本回合交付须同时满足：**已实际执行**与结论对应的命令（或等价的一键脚本）、**结论写入受版本控制的信源**（默认可落盘 `handbook/published/inventory-*-enumerated-agent.md` 等 `94` 约定路径）、**已 `git commit`**；若该工作副本对约定远端有写权限且团队策略允许，则 **`git push` 至约定分支**。**禁止**仅以「已撰写流程/模板/RACI/可复制命令块」作为回合结束态。
2. **禁止「待填」冒充完成**：凡表格或清单字段表示**各机实测事实**（安装与否、绝对路径、`origin` 实值等），在 Agent **客观上能跑通 SSH/本机命令** 时，**不得**长期保留「待填」「依实机」「人类补」等占位而不尝试。尝试失败时：该字段改为 **失败事实**（含命令与 stderr/退出码摘要），并仅在满足条文 **3～4** 时上抛人类。
3. **证据层级（禁止混淆）**：仓库内的 `git config --show-origin user.name` / `user.email` 仅证明 **该克隆上的身份解析（L1）**；**不**自动等价于「OS 已安装 Cursor/Codex/Claude Code 等」。声称某工具**已安装**须有 **`which` / `where` / 绝对路径存在性** 或官方等价验收之一，并写入落盘文件或 `90`（脱敏）。
4. **非登录 SSH 与 PATH**：经 `ssh host 'cmd'` 的远端环境 **PATH 可能短于交互登录 shell**（例如 macOS 上不含 `~/.local/bin`）。**`command -v` 为空** 不得单独推出「未安装」；须补充：对已知标准路径的探测、目录列举、或注明「仅登录会话可见」。
5. **命令失败时的义务**：远端无输出、非零退出、引号/编码导致脚本失败——须在合理次数内 **换写法重试**（例如 Windows 上优先 `where`、`cmd /c` 等最小面），并记录每次失败要点；**不得**单次失败后以「已在 handbook 记录步骤」收口为完成。

## 项目本意（与 handbook 对齐）

- **北极星**：在遵守本条与 handbook 的前提下，**尽量扩大 Agent 自主完成的范围**，构建可机读的 Git 体系、规范与流程，使多设备、多 Agent 的开发协作**最大限度少依赖人类临场操作**。定稿叙述见 [handbook/08-agent-first-collaboration-vision.md](handbook/08-agent-first-collaboration-vision.md)。
- **秘密与凭证（与 `08` 全链路认证对齐）**：
  - **禁止**：将私钥、token、**口令/PAT 明文**写入本仓库、Issue、定稿 `handbook/` 正文、`published/`、或任何可被 `git clone` 带走的提交；禁止在 GitHub Issue/PR **正文**粘贴可索引的明文凭据。
  - **人类若向 Agent 提供口令/PAT 以解除阻塞**：Agent **须**协助纳入 **OS 凭据管理器 / 机外受控文件 / 会话环境变量 / 企业密钥库** 等安全形态，并在自动化中经上述渠道**使用**——不得仅以「等公钥」为由拒绝推进；定稿流程与分层策略见 [handbook/08-agent-first-collaboration-vision.md](handbook/08-agent-first-collaboration-vision.md) §全链路认证。
  - **聊天**：不得要求 Agent **复述**人类刚提供的完整秘密；人类应避免在聊天中长期依赖明文凭据，尽快迁入安全存储。

## 信源

- 定稿操作与拓扑：[handbook/README.md](handbook/README.md)
- 进程与验证记录：[handbook/90-process-log.md](handbook/90-process-log.md)

## 仓库角色（必须遵守）

- **权威 Git 对象**：**epix** Mac 上的 **bare** 仓库。
- **GitHub**（`https://github.com/epix99-opus/GitNet`）：**从镜像**；由 epix 侧定时任务推送更新。Agent **不要**假设「以 GitHub 为主进行双向合并」。
- **例外**：灾备演练或人类明确指令，且须在 `handbook/90-process-log.md` 记录。

## 提交身份

- **人类**全局兜底：`user.name` / `user.email` 与 **GitHub 账号一致**（邮箱 `epix99@icloud.com`；用户名与 GitHub 展示策略一致即可）。
- **Agent**：在 `includeIf` 指定的 Agent 工作目录下，作者名 **`{HOSTNAME}-{tool}`**（如 `epix-cursor`），邮箱 **`epix99@icloud.com`**。详见 [handbook/40-identity-and-includeIf.md](handbook/40-identity-and-includeIf.md) 与 [handbook/55-multi-node-multi-agent-git.md](handbook/55-multi-node-multi-agent-git.md)（多节点总表）。

## 日常工作流

1. 开发、提交在**工作克隆**上进行；**新开业务仓**在首次推送前须按 BestGit **`docs/NEW_PROJECT_CHECKLIST.md`** 自检（本机路径见 GitNet `96` / BestGit `docs/rollout-epix-glab-woot.md`；全工作区习惯可同步写入 Cursor **User Rules**）。
2. `git push` 默认指向 **epix**（`origin` 或团队约定的 `lan`），即 **epix bare** 为写集成权威；**多设备多 Agent** 的节律、并发与 GitHub 次优路径见 [handbook/10-topology.md](handbook/10-topology.md)「规范状态与演进」「多设备 × 多 Agent」。
3. **提交信息、小步提交、分支与 PR、`rebase -i`、`add -p`、分支清理**：见根目录 [CONTRIBUTING.md](CONTRIBUTING.md) 与 [handbook/56-git-workflow-quality-practices.md](handbook/56-git-workflow-quality-practices.md)（**元仓库**与**业务仓**分层说明在 `56` §3）。
4. 不在未记录流程下从 GitHub 强推覆盖 epix 上的历史。

## 文档与清理

- **落盘规则（已定稿）**：[handbook/07-documentation-placement.md](handbook/07-documentation-placement.md) — 事实进 `handbook/`、过程进 `90-process-log`、草稿进 `docs/` 后迁移；纯网络层事实在 **NetOps** `network_facts.env`，本仓不复制。
- 变更定稿内容时，优先更新 `handbook/`，避免与 [docs/](docs/) 参考文重复叙述同一事实。
- 交付后回顾：归并应保留的信息；删除无长期价值的临时文件；在 [handbook/90-process-log.md](handbook/90-process-log.md) 记摘要。

## 可复用的 Cursor Skills（本机已安装时）

在 PR 维护、拆分变更等场景，可优先使用用户本机 skills 中的 **babysit**、**split-to-prs** 等能力；不在本仓库内复制其全文。

## 禁止

- 将密钥、token、私钥写入仓库或 handbook。
- 为通过检查而随意修改测试或捏造远程状态。
