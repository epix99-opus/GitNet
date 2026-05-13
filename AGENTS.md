# GitNet — Agent 与人类协作约定

本文件约束**在本仓库内工作的编程 Agent** 与**人类维护者**的行为边界。拓扑、路径与平台细节以 [handbook/](handbook/) 为唯一信源。

## 全局铁律（执行与上抛）

### 「全局」指什么、不指什么

- **指（原则范围）**：凡由 Agent 承担的任务，**不因换仓库或换会话就变卦**——能执行就执行到可验收为止；只有客观硬边界才交接人类，且须附原因与操作提示。
- **不指（Cursor 注入范围）**：本文件与 `.cursor/rules/` 写在 **GitNet 仓库内**时，在 Cursor 里默认只对**打开本仓库作为工作区**的会话稳定注入；这属于**本项目的契约与信源**，**不等于** Cursor 对「你电脑上每一个文件夹」自动生效。
- **全 Cursor、全工作区（本机已执行）**：已在 Windows 本机将铁律追加写入 Cursor 本地库键 **`aicontext.personalContext`**（与既有「用中文回答」合并，未删除原内容）。备份：`%APPDATA%\Cursor\User\globalStorage\state.vscdb.gitnet-ironlaw-backup`（更新前整库拷贝）。若你在 **Cursor Settings → Rules** 中清空 User Rules，可能覆盖该键；请从备份恢复或从本文件再合并。**说明**：Cursor 可能随版本调整存储位置；若失效，以官方「User Rules」界面为准重新粘贴条文。

### 条文

1. **默认闭环**：凡属 Agent **能够自行判断、设计、评审、执行、验收** 的事项（读代码、改仓库、跑可得的命令、写脚本与文档、做自检清单），**必须在本对话/本会话内做完**，不得用「请人类去做」替代。
2. **禁止无理由回抛**：不得把本可自动化或可清晰落地为「复制即执行」的步骤笼统丢给人类；若提供命令或步骤，Agent 应优先在自身环境能执行范围内**自己执行**。
3. **允许请求人类的唯一情形**：存在 **Agent 在客观上无法完成** 的硬边界（示例：未授权的凭证与密钥材料、物理设备上的首次生物识别/系统弹窗、无网络/无 SSH 到达目标机、法律或账号所有者明示批准）。此时 **必须** 同时给出：
   - **原因**（为何 Agent 不能继续）；
   - **操作提示**（逐步、可复制：在何设备、点何处、填何值、如何验收）。
4. **交接人类的格式（强制）**：凡列出「Agent 不能判断或不能执行的未完成项」时，**禁止**只写事项名称或一句「请人类处理」。每条未完成项须在同一处写清：**原因** + **操作提示**（命令/菜单路径逐步可复制）+ **验收标准**（怎样算完成）。会话回复、Issue/PR 评论、`handbook/90-process-log.md` 与各类 handoff 文档均适用。
5. **任务完成定义**：以「目标可验证地达成」或「不可逾越边界已用第 3～4 条格式交接」为准，不得停在未尝试的中间态。

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

1. 开发、提交在**工作克隆**上进行。
2. `git push` 默认指向 **epix**（`origin` 或团队约定的 `lan`）。
3. 不在未记录流程下从 GitHub 强推覆盖 epix 上的历史。

## 文档与清理

- **落盘规则（已定稿）**：[handbook/07-documentation-placement.md](handbook/07-documentation-placement.md) — 事实进 `handbook/`、过程进 `90-process-log`、草稿进 `docs/` 后迁移；纯网络层事实在 **NetOps** `network_facts.env`，本仓不复制。
- 变更定稿内容时，优先更新 `handbook/`，避免与 [docs/](docs/) 参考文重复叙述同一事实。
- 交付后回顾：归并应保留的信息；删除无长期价值的临时文件；在 [handbook/90-process-log.md](handbook/90-process-log.md) 记摘要。

## 可复用的 Cursor Skills（本机已安装时）

在 PR 维护、拆分变更等场景，可优先使用用户本机 skills 中的 **babysit**、**split-to-prs** 等能力；不在本仓库内复制其全文。

## 禁止

- 将密钥、token、私钥写入仓库或 handbook。
- 为通过检查而随意修改测试或捏造远程状态。
