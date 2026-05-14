# 进程记录与实施验证

## 进程记录模板（复制下面一块追加写入）

```text
### YYYY-MM-DD — 标题
- 参与：人类 / Agent（工具名）
- 变更摘要：
- 涉及信源：handbook 章节 / AGENTS / 代码路径
- 回顾：是否清理临时文件、是否与其它文档冲突
```

---

## 已记录条目

### 2026-05-14 — BestGit：三工具周知落盘、推送、woot/glab `pull` 与自检 **MISS=0**

- 参与：Agent（Cursor，epix）
- 变更摘要：BestGit 提交 **`47a30a2`**（`docs/PROGRAMMING_AGENTS_WEEKLY_BRIEF.zh-CN.md`、`.cursor/rules/bestgit-agent-ironlaw.mdc`、`CLAUDE.md`、`AGENTS.md`、`scripts/verify-programming-agents-weekly-brief.sh` 等）；**`git push origin main`** 至 GitHub。**woot**（`ssh woot@$(tailscale ip -4 woot)`）与 **glab**（`ssh glab` + PowerShell + Git Bash）在 BestGit 根 **`git pull --ff-only`** 后执行 **`bash scripts/verify-programming-agents-weekly-brief.sh`**，均为 **OK=4 MISS=0**。说明：Cursor 打开 BestGit 工作区即加载 `.cursor/rules`；Codex/Claude 依赖人类把周知卡链进提示词或各业务仓 `CLAUDE.md`，Git 作者仍按各机 `includeIf`。
- 涉及信源：BestGit `docs/rollout-epix-glab-woot.md`、`README.md`、`90`
- 回顾：三节点工作副本已与 **`47a30a2`** 对齐；后续改周知卡须再 push 并三机 pull。

### 2026-05-14 — 三机 × 三工具 Git `includeIf` 核对与 glab 宽路径修复

- 参与：Agent（Cursor，epix）
- 变更摘要：**epix / woot**：核对 `~/.gitconfig` 与三片段（`cursor` / `codex` / `claude-code`），`git config --show-origin` 在样例仓已命中 **`{host}-cursor`**。**glab**：经 SSH 发现仅 **`gitdir:E:/DEV/GitNet/`** 时 **`E:/DEV/BestGit`** 落入人类全局 `Epix`；已重写 **`%USERPROFILE%\.gitconfig`**，增加 **`gitdir:E:/DEV/`**、**`gitdir:E:/Dev/`** 及 CodexDev 大小写对之 **`includeIf`**，`git -C E:/DEV/GitNet` 与 **`git -C E:/DEV/BestGit`** 均解析为 **`glab-cursor`**。更新 **`handbook/templates/windows-glab-git-includeIf.ps1`**、`gitconfig.windows.main.ini`、`55` §3.3/§6/修订记录。
- 涉及信源：`40`、`55`、`templates/windows-glab-git-includeIf.ps1`、`90`
- 回顾：**Cursor/Codex/Claude 的「会话铁律」**（User Rules、`.cursor/rules` 等）仍属各工具侧，与 Git 层互补；本回合只闭环 **Git 作者解析路径**。

### 2026-05-14 — 三节点 BestGit 落盘与编程 Agent 复测（woot / glab SSH）

- 参与：Agent（Cursor，epix）
- 变更摘要：在 **epix** 确认 `~/Dev/BestGit`；经 **`ssh -o BatchMode=yes woot@woot`** 克隆 BestGit 至 **`/Users/woot/Dev/BestGit`**；经 **`ssh glab` + PowerShell** 克隆至 **`E:\Dev\BestGit`**。编程 Agent：**组织口径**为 **epix / woot / glab 三节点均具备 Cursor、Codex CLI、Claude Code**；inventory 与 CAMA §1 已与此对齐，并保留 **BatchMode SSH** 下对 `codex` 的探测快照（**不得**据此写成整机未装）。已更新 GitNet `published/inventory-*-enumerated-agent.md`；CAMA `cama-git-inventory.md` 另仓提交。`AGENTS.md` 与 `.cursor/rules/gitnet-collaboration.mdc` 已链 BestGit `NEW_PROJECT_CHECKLIST`。
- 涉及信源：`90`、`published/inventory-*`、`AGENTS`、`.cursor/rules`、BestGit `docs/rollout-epix-glab-woot.md`、CAMA `cama-git-inventory`
- 回顾：glab 上 BestGit 当前 `user.name` 解析为 **Epix**（默认 gitconfig）；若要以 **glab-cursor** 提交，按 `55` 为 `E:/Dev/BestGit` 增加 `includeIf` 覆盖。

### 2026-05-14 — `46` §1.0：SSH 前先核对 Tailscale 与 DNS（纠正 inventory 误述）

- 参与：Agent（Cursor，epix）
- 变更摘要：此前在 **`ssh woot` 超时** 时未先跑 **`tailscale status` / `tailscale ping`** 与 **DNS 与 status 表 100.x 比对**，误将原因写成「Agent 不在 tailnet」。**实机核对**：`tailscale status` 上 **woot/glab 在线**，`tailscale ping woot` **有 pong**；`dscacheutil -q host -a name woot` 曾给出与 **status 表不一致** 之 **100.x**（旧地址 `tailscale ping` 为 **`no matching peer`**），可解释 **仅 SSH 超时**。已新增 [46-tailscale-remote-git-identity.md](46-tailscale-remote-git-identity.md) **§1.0**；更新 [inventory-woot-enumerated-agent.md](published/inventory-woot-enumerated-agent.md) 说明块与修订记录。
- 涉及信源：`46`、`published/inventory-woot-enumerated-agent.md`、`90`
- 回顾：处置见 `46` §1.0（flushcache / `HostName` / 等待 MagicDNS）。

### 2026-05-12 — `main` 全历史提交说明改为中文（拓扑与树不变）

- 参与：Agent（Cursor，epix）
- 变更摘要：使用 `git filter-branch -f --msg-filter` 仅重写提交说明；**父链与合并结构不变**，根提交至 `main` 顶端 **tree 与旧 `c59608c…` 一致**；`Co-authored-by` 等 trailer 保留英文以兼容工具链。映射与可复现命令见 [handbook/scripts/gitnet-rewrite-commit-messages-zh.sh](scripts/gitnet-rewrite-commit-messages-zh.sh)。**所有被重写提交的 SHA 已变**；若需更新 `origin/main` 须 **`git push --force-with-lease`**（已与团队约定后再执行）。
- 涉及信源：`90`、脚本 `handbook/scripts/`
- 回顾：可删除 `refs/original/refs/heads/main` 释放备份引用；需要回滚时用 `git reset --hard refs/original/refs/heads/main`（在删除前）。

### 2026-05-13 — BestGit 组织模板仓 + GitNet `96` 归档与 CAMA 落盘

- 参与：Agent（Cursor，epix）
- 变更摘要：于 **`/Users/epix/Dev/BestGit`** 初始化独立 Git 仓（方案 `docs/scheme-layered-git-governance.md`、新开仓清单、`templates/`、`scripts/bestgit-doctor.sh`、三节点 `rollout` 文档）；GitHub 已用 **`gh repo create epix99-opus/BestGit --public --push`** 创建并推送；GitNet 新增 [96-bestgit-org-template-and-rollout.md](96-bestgit-org-template-and-rollout.md) 与 [README.md](README.md) 阅读顺序第 21 项；`published/inventory-epix-enumerated-agent.md` 登记 BestGit 路径与 `origin`。CAMA-concept 增加 `regulations/bestgit-organization-template-rollout.zh-CN.md` 与 README 链；`cama-git-inventory` 更新 Last sync。
- 涉及信源：`96`、`README`、`90`、BestGit、CAMA
- 回顾：woot/glab 上的 `git clone` 须在远端 URL 可用后执行；inventory 表可选登记 BestGit 路径。

### 2026-05-13 — `08`：Agent 驱动开发的 Git 宗旨与全生命周期校准

- 参与：Agent（Cursor）
- 变更摘要：扩充 [08-agent-first-collaboration-vision.md](08-agent-first-collaboration-vision.md) — **双重角色**（运维宿主 / 可移植母版）、**全局共用 Git 规定** 清单、**全生命周期 × Git** 矩阵、**主分支与特性分支**、**每项目/Agent/节点** 表、**多智能体信源仲裁**；与 `05`/`07`/`10`/`40`/`55`/`06`/`90`/`93`/`94`/`AGENTS` 交叉引用；原「为实现北极星」四行表并入清单。[README.md](README.md) 北极星与阅读顺序第 3 项同步；[93-gitnet-phase-conclusion-and-cross-collab-git-playbook.md](93-gitnet-phase-conclusion-and-cross-collab-git-playbook.md) 修订记录互指 `08`。
- 涉及信源：`08`、`README`、`93`、`90`
- 回顾：操作命令与路径仍以 `10`/`46`/`30` 为准，不在 `08` 展开。

### 2026-05-13 — AGENTS / Cursor 规则：对齐官方习惯、去冗与本机细节迁出

- 参与：Agent（Cursor）
- 变更摘要：`AGENTS.md` — 「全工作区」段改为 **User Rules / Team Rules** 原则 + 过程细节迁 **`90`**；条文增 **6 规划与可验证信号**（Plan Mode、最小 lint/测）、**7 人类协作提示**（新会话、`@Past Chats`）；多机小节改为引用条文 **1～7**。`.cursor/rules/gitnet-collaboration.mdc` — **铁律长文删除**，改为 **`AGENTS.md` 为唯一全文** 的索引句，避免与根契约漂移重复。
- 涉及信源：`AGENTS.md`、`.cursor/rules/gitnet-collaboration.mdc`、`90`
- 回顾：Windows `personalContext` 具体操作与备份路径若仍需可查，应只在 `90` 历史条目中保留，不再写进 `AGENTS`。
  - **归档（原 `AGENTS` 曾写，今迁出）**：曾在 Windows 本机将铁律合并写入 Cursor 库键 **`aicontext.personalContext`**；整库备份示例文件名 **`state.vscdb.gitnet-ironlaw-backup`**（位于 **`%APPDATA%\Cursor\User\globalStorage\`** 下，随 Cursor 版本可能变化）。当前以 **Settings → Rules → User Rules** 界面为准维护全局条文。

### 2026-05-13 — AGENTS 增补「回合前与回合末：目标对齐与主动检索」

- 参与：Agent（Cursor）
- 变更摘要：在 [AGENTS.md](../AGENTS.md) 增加 **回合前**（一句可验收判据、含糊则先收敛）、**回合中**（不熟须先检索/读 `handbook` 再写、禁止臆造关键事实）、**回合末**（对照判据 + 与多机 DoD 叠加）；`.cursor/rules/gitnet-collaboration.mdc` 铁律条内增「回合纪律」指针；`94` §1 信息边界表增一行。
- 涉及信源：`AGENTS.md`、`94`、`90`
- 回顾：与既有「多机与盘点」小节互补，覆盖非盘点类任务。

### 2026-05-13 — 约束落盘：AGENTS「多机与盘点实测完成定义」+ Cursor 规则交叉引用

- 参与：Agent（Cursor）
- 变更摘要：在 [AGENTS.md](../AGENTS.md) 增补 **「多机与盘点：实测完成定义」**（DoD、`commit`/`push`、禁止文档顶替测量与「待填」占位、Git 身份≠OS 安装证据、非登录 SSH 的 PATH 陷阱、失败须换写法重试）；[.cursor/rules/gitnet-collaboration.mdc](../.cursor/rules/gitnet-collaboration.mdc) 铁律条下链到该节；[94-multi-node-agent-inventory-raci-and-config-matrix.md](94-multi-node-agent-inventory-raci-and-config-matrix.md) §1 信息边界增一行指向 `AGENTS`。
- 涉及信源：`AGENTS.md`、`94`、`90`
- 回顾：真·全 Cursor 默认仍依赖 User Rules；本批为 **本仓库与会话注入** 的硬约束。

### 2026-05-12 — 三机编程 Agent：Tailscale SSH 实机探测（非仅 Git 身份）

- 参与：Agent（Cursor，cwd epix）
- 变更摘要：在 **epix** 本机与经 **`ssh woot@woot`**、**`ssh glab`** 执行 `which`/`where` 与路径检查，结论落盘：**epix** — Cursor.app + `codex` + `claude`；**woot** — Cursor.app + `claude` + cursor-agent，**无** `/usr/local/bin/codex`；**glab** — Cursor + `claude.exe`，**`where codex` 未命中**。更新 [published/inventory-epix-enumerated-agent.md](published/inventory-epix-enumerated-agent.md)、[inventory-woot-enumerated-agent.md](published/inventory-woot-enumerated-agent.md)、[inventory-glab-enumerated-agent.md](published/inventory-glab-enumerated-agent.md)、[inventory-epix-starter.md](published/inventory-epix-starter.md)；[94-multi-node-agent-inventory-raci-and-config-matrix.md](94-multi-node-agent-inventory-raci-and-config-matrix.md) §5.3 链到上述「实机探测」节。
- 涉及信源：`94`、`published/inventory-*`、`46`
- 回顾：CAMA `regulations/cama-git-inventory.md` §1 矩阵同步见 **CAMA** 仓库单独提交（本仓不重复业务清单全文）。

### 2026-05-13 — CAMA-concept：派生 CAMA-git 方案/手册与三机清单

- 参与：Agent（Cursor，cwd epix）
- 变更摘要：在 **`/Users/epix/Dev/CAMA/CAMA-concept`** 新增 `doctrine/CAMA-git方案.md`、`doctrine/CAMA-git手册.md`、`regulations/cama-git-inventory.md`（合并 epix/glab/woot 枚举与 Agent 矩阵）；`AGENTS.md` / `README*` / `CHANGELOG` 绑定 Git 工程可信来源；提交 **`3b352d2`**。随后 Agent 已 **`git remote add origin https://github.com/epix99-opus/CAMA.git`** 并 **`git push -u origin CAMA_Cursor`**（铁律：不因「未配置」回抛人类）。
- 涉及信源：GitNet `handbook/published/inventory-*-enumerated-agent.md`、`94`、`10`、`55`、`08`
- 回顾：CAMA-concept 工作区尚有 **未暂存** 的删除/未跟踪文件（与 `3b352d2` 提交内容无关）；合并 `main` 或清理请人类另开任务以免与本线混淆。

### 2026-05-13 — 三机 Git 仓库：Agent 经 Tailscale SSH 枚举落盘

- 参与：Agent（Cursor，cwd 在 epix）
- 变更摘要：本机 `find` 枚举 epix `~/Dev`+`~/agent-work`；`ssh woot@woot`、`ssh glab` + PowerShell 枚举远端含 `.git` 路径；对代表性路径取 `git branch` / `remote` / `user.name`；新增 [published/inventory-epix-enumerated-agent.md](published/inventory-epix-enumerated-agent.md)、[inventory-woot-enumerated-agent.md](published/inventory-woot-enumerated-agent.md)、[inventory-glab-enumerated-agent.md](published/inventory-glab-enumerated-agent.md)；更新 [94-multi-node-agent-inventory-raci-and-config-matrix.md](94-multi-node-agent-inventory-raci-and-config-matrix.md) §1/§3/§5（**§5.6** 跨机枚举为默认、修正铁律表述）。
- 涉及信源：`94`、`published/inventory-*-enumerated-agent.md`、`46`/`91` SSH 前提
- 回顾：枚举深度/根路径可按团队扩大后重跑并覆盖提交。

### 2026-05-13 — 三机 Agent 盘点与 RACI 落盘（94 + 模板 + epix starter）

- 参与：Agent（Cursor）
- 变更摘要：新增 [94-multi-node-agent-inventory-raci-and-config-matrix.md](94-multi-node-agent-inventory-raci-and-config-matrix.md)（分层纳入定义 L1～L3、RACI、全局/项目配置矩阵、可复制盘点命令）；[published/inventory-machine-TEMPLATE.md](published/inventory-machine-TEMPLATE.md)（空白表）；[published/inventory-epix-starter.md](published/inventory-epix-starter.md)（**仅 GitNet 一行**示例，含当前 `origin`/片段来源）；[handbook/README.md](README.md) 阅读顺序第 20 项与模板与脚本索引；[55-multi-node-multi-agent-git.md](55-multi-node-multi-agent-git.md) 文首 glab 说明与收口表对齐、演进清单链到 `94`。
- 涉及信源：`94`、`55`、`published/inventory-*`
- 回顾：**完整三机仓库枚举**须人类/各机在各自主机执行 `94` §5 后填表或贴本文；勿在无输出时编造清单。

### 2026-05-13 — 文档收口：glab/epix 全流程（UTF-8 BOM、`ssh-keyscan`、`BatchMode`）

- 参与：人类（实机验收）/ Agent（Cursor）
- 变更摘要：将本会话已验证事实写入定稿手册：**Windows PowerShell 5.1** 对 **UTF-8 无 BOM** 中文脚本误读致 **ParserError**（根因与维护规则 → [20-windows-setup.md](20-windows-setup.md) §7、[46-tailscale-remote-git-identity.md](46-tailscale-remote-git-identity.md) §3.1）；**epix** 上 **`ssh-keyscan` → `fdlim_get: bad value`** 与 **`ulimit -n` / `accept-new`** 绕过（→ `46` §3.3、[91-glab-handoff-epix-ssh-verify.md](91-glab-handoff-epix-ssh-verify.md) §B）；**Administrators** 与 **`administrators_authorized_keys`** 在 [22-glab-tailscale-epix-remote.md](22-glab-tailscale-epix-remote.md) §3.C 与 `91` 期望结果中显式化；[30-mac-epix-setup.md](30-mac-epix-setup.md) §6 链到 glab SSH；[published/collaboration-closeout-status.md](published/collaboration-closeout-status.md) **T2** 标为完成（管理员重跑 `setup-glab-openssh-for-epix.ps1` 后 epix `ssh glab` / `git config` 已验）；`setup-glab-openssh-for-epix.ps1` 末尾 epix 提示增补 **`ulimit`** 行。**对各节点对齐**：本条对应提交已由 Agent **推送到 GitHub `main`**（仓库 `epix99-opus/GitNet`），作为与 **glab** 同源的通知面；**glab** 工作副本执行 `git pull origin main`（或你的 GitHub 远端名）。**epix**：若工作副本的 **`origin`（或常用拉取远端）指向该 GitHub 仓库**，执行 **`git pull`** 即可与 glab 收到同一文档与脚本；若日常仅以 **epix bare** 为写入口，须在 epix 侧将 GitHub `main` **fetch/merge 入 bare**（或等效流程）后，再在其它克隆上 `git pull` bare，勿假设未拉取前 bare 已含 GitHub 顶提交。
- 涉及信源：`46`、`91`、`20`、`30`、`22`、`README`、`90`、`published/collaboration-closeout-status.md`、`scripts/setup-glab-openssh-for-epix.ps1`
- 回顾：与 [AGENTS.md](../AGENTS.md)「对象权威在 epix bare」一致时，**GitHub 本条仍可作为「已发布给各克隆阅读」的交换面**；epix 人类按上段「epix bare」一句并入即可。与「不向 GitHub 作为主线强推」策略不冲突：本批为文档与 glab 脚本收口，且已在本文记录。

### 2026-05-13 — 阶段成果：93 多端协作回顾与可外推 Git 体系清单

- 参与：Agent（Cursor）/ 人类（前期意图与验收已分散在 Issue、`90`、§B）
- 变更摘要：新增 [93-gitnet-phase-conclusion-and-cross-collab-git-playbook.md](93-gitnet-phase-conclusion-and-cross-collab-git-playbook.md)（GitNet **目标→方案→实现** 归纳；epix/glab Cursor Agent 协作复盘；**§7** 供其它大型多跨项目复用的 Git 体系/规范/流程）；[README.md](README.md) 阅读顺序与北极星旁链到 `93`。
- 涉及信源：全文交叉引用 `05`/`08`/`10`/`40`/`46`/`55`/`90`/`91`/`92`、`published/*`、Issue #1。
- 回顾：`93` 为归纳层；操作细节仍以被引用章节为准。

### 2026-05-13 — 定稿：多设备多 Agent 以 epix bare 为写集成权威（10-topology）

- 参与：人类（意图确认）/ Agent（Cursor）
- 变更摘要：在 [10-topology.md](10-topology.md) 落盘 **目标规范**（可经实机运行后改为「已定」）：**日常 `fetch`/`pull`/`push` 汇合于 epix bare**；GitHub 为从镜像；过渡性以 GitHub 汇合须在本文记录原因与迁回验收；增补 bare 侧 / 各克隆 / 并发 / 次优路径 / 感知层五段「最优实现」清单。[55-multi-node-multi-agent-git.md](55-multi-node-multi-agent-git.md) 增 §5.1；[AGENTS.md](../AGENTS.md) 日常工作流链到 `10`；[README.md](README.md) 阅读顺序更新对 `10` 的说明。
- 涉及信源：`10-topology.md`、`55`、`AGENTS.md`、`README.md`
- 回顾：与既有 `30`（bare+launchd）、`06`（分支保护）、`92`（轮询感知）不冲突；控制面编排仍以各项目为准。

### 2026-05-12 — 仓库初始化与手册交付（Agent）

- 参与：Agent（Cursor）
- 变更摘要：工作区原为「非 git 目录」；已 `git init`、`.gitignore`（排除 `.specstory/`）、根 `README.md` 指向 `handbook/`；新增 `handbook/06-github-branch-protection.md`；`handbook/README` 索引更新。
- 涉及信源：`handbook/*`、`AGENTS.md`、`.cursor/rules`、`.gitignore`、`README.md`
- 回顾：未提交密钥；`.specstory` 不纳入版本库。待人类：`git remote add` 指向 epix 或 GitHub 后首次 push。
- 验收：本地 `git log` 可见首条 root 提交 `f895f55`；后续文档修补以 `git log` 为准；远程 push 以人类网络环境为准。

### 2026-05-13 — Windows 配置 GitHub origin（人类已同意阶段 A）

- 参与：人类（书面同意）/ Agent（Cursor）
- 变更摘要：在 `E:\DEV\GitNet` 已执行 `git remote add origin https://github.com/epix99-opus/GitNet.git`（此前无 remote）；分支已为 `main`。后续非交互 `git push`（任务 970081）**退出码 1**：`! [rejected] main -> main (fetch first)` —— **远端 `main` 已有本地没有的提交**（例如 Mac 先推过 README），需先 **`git pull origin main --rebase`** 再 **`git push -u origin main`**。PowerShell 将 Git 的 stderr 显示为 `NativeCommandError` 属常见现象，可忽略类型只看 Git 原文。
- 涉及信源：`handbook/90-process-log.md`、本地 `.git/config`
- 回顾：人类在本机可交互终端执行下方命令；若仍有凭据弹窗，用 GitHub 账号 + PAT 或凭据管理器完成。
- 验收：`git ls-remote origin refs/heads/main` 与本地 `main` 顶提交一致；GitHub 网页可见完整历史。

**人类一步（复制执行）**：

```powershell
cd E:\DEV\GitNet
git remote -v
git pull origin main --rebase
git push -u origin main
```

若提示登录：使用 GitHub 账号 + PAT（或已配置的凭据管理器）。完成后将本段「验收」勾为已完成并填日期。

### 2026-05-13 — rebase 冲突解决并推送至 GitHub（Agent，Glab）

- 参与：Agent（Cursor）
- 变更摘要：`git pull origin main --rebase` 在 **`.gitignore`**、**`README.md`** 发生 add/add 冲突。已手工合并：`.gitignore` 含 Mac 侧（`.DS_Store`、`.env*`、密钥后缀）与 Glab 侧（`.specstory/`、`.tmp_*.py`）；`README.md` 以 `handbook` 为信源描述主从，并保留 Mac/Windows 工作路径示例。rebase 完成后已执行 **`git push -u origin main`**，`main` 已与 `origin/main` 对齐（顶提交以 `git log -1` 为准）。
- 验收：GitHub 网页 `main` 可见完整手册与 `handbook/`；Mac `/Users/epix/Dev/GitNet` 可 `git pull origin main` 快进。

### 2026-05-12 — 内容落盘规则定稿（handbook/07）

- 参与：人类（同意落盘建议）/ Agent（Cursor）
- 变更摘要：新增 [07-documentation-placement.md](07-documentation-placement.md)（事实→`handbook/`、过程→`90-process-log`、草稿→`docs/` 后迁移、网络事实→NetOps）；更新 [00-truth-sources.md](00-truth-sources.md)、[handbook/README.md](README.md)、根 [README.md](../README.md)、[AGENTS.md](../AGENTS.md)、[05-project-scope-and-delivery.md](05-project-scope-and-delivery.md)、[70-docs-migration-map.md](70-docs-migration-map.md)、[人类初始指令.md](../人类初始指令.md) 的交叉引用。
- 涉及信源：上述路径
- 回顾：未在 GitNet 内复制 `network_facts.env`；与 NetOps 边界见 `07` 第二节。

### 2026-05-12 — 本机 Git 人类兜底与 Agent includeIf（epix）

- 参与：人类（同意）/ Agent（Cursor）
- 变更摘要：`~/.gitconfig` 备份为 `~/.gitconfig.backup-gitnet-2026-05-12`；全局 `user.email` 改为 **`epix99@icloud.com`**，`user.name` 维持 **`Epix`**；新增 **`~/.gitconfig-fragment-cursor`**（`epix-cursor` / `epix99@icloud.com`）；`includeIf gitdir:/Users/epix/Dev/` 与 `gitdir:/Users/epix/agent-work/cursor/` 加载片段；已创建目录 **`~/agent-work/cursor/`**（含 `.gitkeep`）供手册约定路径使用。
- 涉及信源：`handbook/40-identity-and-includeIf.md`、模板 `templates/gitconfig.*`
- 验收：`cd /Users/epix/Dev/GitNet && git config --show-origin user.name` 来源为片段；`/tmp` 下新 `git init` 仓库来源为全局 `.gitconfig`。
- 回顾：凡在 **`~/Dev/`** 下任意仓库提交，作者均为 **`epix-cursor`**；若需在 `~/Dev/` 内保留人类作者，可用该仓库 `git config --local user.*` 覆盖或移出 `~/Dev/`。

### 2026-05-12 — epix 多工具 Git 片段（cursor / codex / claude-code）

- 参与：人类（同意整体方案）/ Agent（Cursor）
- 变更摘要：新增 `~/.gitconfig-fragment-codex`（`epix-codex`）、`~/.gitconfig-fragment-claude-code`（`epix-claude-code`）；`~/.gitconfig` 增加 `includeIf` 至 `~/Dev/CodexDev/`、`~/agent-work/codex/`、`~/agent-work/claude-code/`（顺序：宽 `~/Dev/` 在前，窄 `CodexDev` 等在后以覆盖）；新建手册 [55-multi-node-multi-agent-git.md](55-multi-node-multi-agent-git.md) 描述 epix/glab/woot 总表；更新 [40-identity-and-includeIf.md](40-identity-and-includeIf.md)、[templates/gitconfig.mac.main.ini](templates/gitconfig.mac.main.ini)、[handbook/README.md](README.md)。
- 验收：`GitNet` 目录下 `user.name=epix-cursor`；`Dev/CodexDev/SelfEvo/paseo` 下 `user.name=epix-codex`；`/tmp` 新仓库为人类 `Epix`。
- 回顾：**woot** 已由后续条目经 Tailscale SSH 落地；**glab** 见 `46` / Windows 脚本；若 Claude 主力不在 `agent-work/claude-code/`，可在该机 `.gitconfig` 末尾追加 `includeIf`。

### 2026-05-13 — Tailscale SSH：woot Git 片段落地；glab 待开 sshd

- 参与：Agent（Cursor）/ 人类（glab 待配合 OpenSSH）
- 变更摘要：**woot** SSH 有效用户为 **`woot`**（`epix@woot` 公钥未授权）；经 `woot@woot` + `~/.ssh/id_ed25519` 写入与 epix 同构的 `~/.gitconfig`、三片段、`~/agent-work/{cursor,codex,claude-code}`；备份 `~/.gitconfig.backup-gitnet-*`；epix 侧 `~/.ssh/known_hosts` 追加 `woot.tailbb1446.ts.net`，新建 **`~/.ssh/config`** 中 `Host woot`。新增 [46-tailscale-remote-git-identity.md](46-tailscale-remote-git-identity.md)、[templates/windows-glab-git-includeIf.ps1](templates/windows-glab-git-includeIf.ps1)；更新 [55-multi-node-multi-agent-git.md](55-multi-node-multi-agent-git.md)、[handbook/README.md](README.md)、根 [README.md](../README.md)。
- 验收：`ssh woot 'cd /Users/woot/Dev/ccdev/everything-claude-code && git config --show-origin user.name'` → `woot-cursor`；`ssh woot 'mktemp -d /tmp/gitXXXX'` 内 `git init` → 人类 `Epix`。
- 回顾：**glab** 从 epix `ssh-keyscan`/TCP 22 无响应；人类完成 [46](46-tailscale-remote-git-identity.md) 第三节后，在 glab 运行 `windows-glab-git-includeIf.ps1`（或手工编辑），再在 epix 取消注释 `~/.ssh/config` 中 `Host glab` 并填用户名。

### 2026-05-13 — glab：epix 公钥以仓库 `templates/epix-id_ed25519.pub` 为信源

- 参与：Agent（Cursor）
- 变更摘要：新增 [`templates/epix-id_ed25519.pub`](templates/epix-id_ed25519.pub)（说明性 `#` 注释 + Raw URL）；[`scripts/setup-glab-openssh-for-epix.ps1`](scripts/setup-glab-openssh-for-epix.ps1) 在未传 `-EpixPublicKeyLine`/`-EpixPublicKeyPath` 时从 `-GitNetWorkdirWin\handbook\templates\epix-id_ed25519.pub` 读取首条 `ssh-ed25519` 行，无效则报错且不写入 `authorized_keys`；更新 [46](46-tailscale-remote-git-identity.md)、[91](91-glab-handoff-epix-ssh-verify.md)、[handbook/README.md](README.md)。
- 涉及信源：上述路径
- 回顾：远程 `main` 已含 epix 公钥行；本提交合并注释 + 脚本默认读文件逻辑。密钥轮换时由 epix 更新该文件并 push，再通知 glab 重跑脚本或手改 `authorized_keys`。

### 2026-05-13 — 协作任务收口：状态表 + 证据脚本增强（epix）

- 参与：Agent（Cursor）
- 变更摘要：新增 [published/collaboration-closeout-status.md](published/collaboration-closeout-status.md)（T1～T5：`glab-cursor` 已验 / `sshd`+`ssh glab` 待办 / `92` 可选）；[scripts/91-glab-section-A-evidence.ps1](scripts/91-glab-section-A-evidence.ps1) 增补 `Get-Service *ssh*`、`Get-WindowsCapability OpenSSH.Server*`、`Get-NetTCPConnection :22` 诊断块；`handbook/README.md`、`91` 链到收口表。
- 验收：glab 重跑证据脚本后应覆盖 `published/issue-1-glab-evidence-comment.md` 中更丰富的 SSH 诊断；人类已在 epix Terminal 完成 §B；Issue #1 可在人类确认 **公钥无口令**（T2）或接受「仅口令交互」后关闭。
- 回顾：epix Agent Shell `ssh glab` 仍可能超时，不以该结果否定 glab 本机已配置情形。
- 补充（同日稍后）：`ssh-keyscan` 后 `ssh glab` 变为 **`Permission denied (publickey)`**（非超时），说明 **22/HostKey 已通**，待 glab 将 epix 公钥写入 GG 的 `authorized_keys`；已在 Issue #1 评论与 `published/collaboration-closeout-status.md` 更新 T2 表述。

### 2026-05-13 — epix Terminal 验证 glab Git 身份（人类）

- 参与：人类（epix Terminal）
- 变更摘要：`ssh glab "cd /d E:\Dev\GitNet && git config --show-origin user.name"` 成功；输出 `file:...\.gitconfig-fragment-cursor` → **`glab-cursor`**。会话为 **口令认证**；已将命令与输出写入 `published/issue-1-glab-evidence-comment.md` §B，并更新 `published/collaboration-closeout-status.md`（T3 完成，T2 仍区分「公钥无口令」）。
- 涉及信源：`published/issue-1-glab-evidence-comment.md`、`published/collaboration-closeout-status.md`
- 回顾：Agent Shell 仍建议以公钥闭环，避免交互口令。

### 2026-05-13 — 91 / 收口表 T4 与 Issue 证据链对齐（Agent）

- 参与：Agent（Cursor）
- 变更摘要：更新 [91-glab-handoff-epix-ssh-verify.md](91-glab-handoff-epix-ssh-verify.md)（§B 一行式验收、期望结果含 §A 快照说明与 §B、口令 vs 公钥）；更新 [published/collaboration-closeout-status.md](published/collaboration-closeout-status.md) **T4**（证据上墙 vs 关闭 Issue 条件）。
- 涉及信源：上述路径
- 回顾：**未**在 glab 写入 `authorized_keys`（硬边界）；**未**向 Issue #1 发帖（无 `GITHUB_TOKEN`）。剩余：人类粘贴 `issue-1-glab-evidence-comment.md` 全文、择机关闭 Issue、可选完成 T2 公钥。

### 2026-05-13 — 定稿「北极星」：Agent 优先的多机协作意图（Agent）

- 参与：Agent（Cursor）
- 变更摘要：新增 [08-agent-first-collaboration-vision.md](08-agent-first-collaboration-vision.md)；根 [README.md](../README.md)、[AGENTS.md](../AGENTS.md)、[05-project-scope-and-delivery.md](05-project-scope-and-delivery.md)、[00-truth-sources.md](00-truth-sources.md)、[handbook/README.md](README.md)、[.cursor/rules/gitnet-collaboration.mdc](../.cursor/rules/gitnet-collaboration.mdc) 交叉引用；初版强调「凭据不进 Git」。**同日稍后**见下条「全链路认证」演进。
- 涉及信源：上述路径
- 回顾：**未**将任何口令写入仓库。凭据使用策略以下条定稿为准。

### 2026-05-13 — 全链路认证：人类口令/PAT 的安全存储与使用（定稿）

- 参与：Agent（Cursor）
- 变更摘要：重写 [08-agent-first-collaboration-vision.md](08-agent-first-collaboration-vision.md) §全链路认证（公钥默认优先 + 口令经 OS 凭据库/机外文件/环境变量/密钥库；Agent 有义务协助迁移秘密、不得仅以公钥未完成阻塞开发）；更新 [AGENTS.md](../AGENTS.md) 秘密与凭证条文、[.cursor/rules/gitnet-collaboration.mdc](../.cursor/rules/gitnet-collaboration.mdc)、[.gitignore](../.gitignore)（`*.credentials.local` 等忽略模式）。
- 涉及信源：上述路径
- 回顾：**不变**——凭据**明文**仍不得进入 Git 对象与 Issue；与「安全方式存储和使用」的工程含义一致。

### 2026-05-13 — glab：authorized_keys 公钥行由本机脚本确认（Agent）

- 参与：Agent（Cursor，工作区在 glab）
- 变更摘要：新增 [scripts/append-epix-pubkey-to-local-authorized_keys.ps1](scripts/append-epix-pubkey-to-local-authorized_keys.ps1)；于本机执行后确认 `C:\Users\GG\.ssh\authorized_keys` 已含定稿 `ssh-ed25519` 行；`Get-Service sshd` 为 **Running**；更新 [published/collaboration-closeout-status.md](published/collaboration-closeout-status.md) **T2** 为完成。
- 涉及信源：上述路径
- 回顾：建议 epix 再验 `ssh -o BatchMode=yes glab "hostname"`。

### 2026-05-13 — glab：Administrators 组与 `administrators_authorized_keys`（BatchMode 根因）

- 参与：Agent（Cursor）
- 变更摘要：`C:\ProgramData\ssh\sshd_config` 中 `Match Group administrators` 导致管理员账户**不读** `%USERPROFILE%\.ssh\authorized_keys`；文档 [46](46-tailscale-remote-git-identity.md) 增 §3.1.1；[setup-glab-openssh-for-epix.ps1](scripts/setup-glab-openssh-for-epix.ps1) 增 §5 写入 `administrators_authorized_keys`；新增 [append-epix-pubkey-to-administrators-authorized_keys.ps1](scripts/append-epix-pubkey-to-administrators-authorized_keys.ps1)；[append-epix-pubkey-to-local-authorized_keys.ps1](scripts/append-epix-pubkey-to-local-authorized_keys.ps1) 对 Administrators 成员给出警告；收口表 T2 回到进行中直至管理员重跑脚本。
- 涉及信源：上述路径
- 回顾：本会话非提升权限，未能写入 `ProgramData\ssh\`；需人类**管理员 PowerShell** 重跑 `setup-glab-openssh-for-epix.ps1` 或单独管理员 append 脚本。

## Tailscale / SSH / epix 实施验证清单

在 epix 与至少一台客户端（Windows 或其它 Mac）上完成下列项后，将**实值**填在第二列表格，并在底部「验证记录」签字或记日期。

### 待填实值

| 项 | 填写值 |
|----|--------|
| epix Tailscale MagicDNS（`HostName`） | |
| SSH `Host` 别名（建议 `git-epix`） | |
| SSH 登录用户（`User`） | |
| bare 全路径（例 `/srv/git/GitNet.git`） | |
| 克隆 URL（`git@...:...`） | |
| launchd 是否已 `load` | 是 / 否 |
| 首次 `git -C <bare> push github` 是否成功 | 是 / 否 |

### 命令验证（由技术角色执行）

在**客户端**：

```bash
ssh -T git@git-epix
# 将 git-epix 替换为表内 Host 别名
```

在 **epix**（有权限用户）：

```bash
git -C /你的/bare路径.git remote -v
git -C /你的/bare路径.git push github --dry-run
```

### 验证记录

| 日期 | 执行人 | 结果 |
|------|--------|------|
| | | |

---

## 已知占位说明

- GitHub 仓库 URL：<https://github.com/epix99-opus/GitNet>
- 在未填实值前，人类可按 [45-ssh-tailscale-for-humans.md](45-ssh-tailscale-for-humans.md) 将本页表格交给技术同学一次性填回。
