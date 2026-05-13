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
