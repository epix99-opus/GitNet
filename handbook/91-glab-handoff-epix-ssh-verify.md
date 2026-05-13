# glab 侧配合：epix→glab SSH 与 Git 身份验收（Handoff）

**GitHub Issue（回贴输出）**：https://github.com/epix99-opus/GitNet/issues/1

**收口总表（T1～T5）**：[published/collaboration-closeout-status.md](published/collaboration-closeout-status.md)

> 由 epix 上 Cursor Agent 建立：因 **Agent 内置 Shell 对 `glab:22` 探测超时**，无法在 epix 侧代出「SSH 已通」的终端证据，需 **glab 本机**（或你在 epix 本机 Terminal 重跑）完成下列验收，并把输出贴到 **Issue #1** 或本文件 PR 讨论串。

## 目标

- 确认 **Tailscale 内 epix 可 SSH 登录 glab**（或至少 **glab 本机 SSH/Git 配置正确**）。
- 确认 **`E:\Dev\GitNet`（或 `git rev-parse --show-toplevel` 实际路径）** 下 Git 作者命中 **`glab-cursor`** 片段。

## 问题（背景）

- epix 节点名即本 Mac；手册见 [46-tailscale-remote-git-identity.md](46-tailscale-remote-git-identity.md)、[22-glab-tailscale-epix-remote.md](22-glab-tailscale-epix-remote.md)。
- Cursor Agent 在 epix 上执行 `ssh glab "hostname"` 时出现 **`connect to host glab port 22: Operation timed out`**，与「你在本机 Terminal 已能通」可并存，故需 **glab 或人类**补证据。

## epix 公钥（glab `authorized_keys` 一整行）

**与 GitHub / glab 对接的定稿信源**：本仓库文件（**整行一条，勿断行、勿加引号弯字符**）：

- [templates/epix-id_ed25519.pub](templates/epix-id_ed25519.pub)

传给 `setup-glab-openssh-for-epix.ps1 -EpixPublicKeyLine` 时，用 PowerShell 从克隆根读取例如：

```powershell
$k = Get-Content -Raw "E:\Dev\GitNet\handbook\templates\epix-id_ed25519.pub"
.\handbook\scripts\setup-glab-openssh-for-epix.ps1 -EpixPublicKeyLine $k.Trim()
```

（此为 **公钥**，可入 git；**永远不要**把 `id_ed25519` **私钥**写入仓库。）

## 谁应在 glab 上 `git pull` / 跑管理员脚本

| 事项 | 负责人（在 **glab 本机**） |
|------|------------------------------|
| **`git pull`** 以更新 `handbook/scripts/` 等 | **glab 上 GitNet 工作副本的维护者**：本机人类，或 **工作区根目录在 glab 的** Cursor/其它 Agent（会话 cwd 必须在 glab，而非 epix） |
| **`setup-glab-openssh-for-epix.ps1`**（须**管理员** PowerShell） | 具备该 Windows 账户**管理员**权限的人；或人类明确授权后，由 **已在 glab 上以提升权限运行的会话** 代跑 |
| **脚本/手册的作者与推送** | 按 [10-topology.md](10-topology.md)：定稿与主线在 **epix bare**；GitHub 常为从镜像。glab 侧在多数流程下 **只拉取（pull）并执行**，不必替 epix 承担推送职责，除非团队另有约定并记入 [90-process-log.md](90-process-log.md) |

**epix 上的 Agent 不能替代**：无法在 GG 的 Windows 上替你执行本机 `git pull` 或管理员 PowerShell；此前说「请在 glab 上 git pull」指的就是上表第一行。

## 要求（在 glab 上以管理员或普通用户按需执行）

### A. glab 本机（PowerShell）

```powershell
Get-Service sshd | Format-List Status, StartType
git -C "E:\Dev\GitNet" rev-parse --show-toplevel
git -C "E:\Dev\GitNet" config --show-origin user.name
git -C "E:\Dev\GitNet" config --show-origin user.email
```

若仓库不在 `E:\Dev\GitNet`，把路径换成 `git rev-parse` 给出的根目录。

### B. 在 epix 本机 Terminal（可选，但强烈推荐）

由人类在 **epix 的 Terminal.app / iTerm**（非仅 Agent Shell）执行：

```bash
ssh glab "hostname"
ssh-keyscan glab.tailbb1446.ts.net 2>/dev/null | tail -1
git -C "$(ssh glab 'git -C E:/Dev/GitNet rev-parse --show-toplevel 2>/dev/null' | tr -d '\r')" config --show-origin user.name 2>/dev/null || true
```

与 [published/collaboration-closeout-status.md](published/collaboration-closeout-status.md) **T3** 对齐的**一行式**验收（已在实践中跑通；口令会话亦可，证据写入 `issue-1-glab-evidence-comment.md` §B）：

```bash
ssh glab 'cd /d E:\Dev\GitNet && git config --show-origin user.name'
```

期望出现 **`glab-cursor`**，且来源为 **`…\\.gitconfig-fragment-cursor`**。**无口令 / BatchMode** 仍以 [templates/epix-id_ed25519.pub](templates/epix-id_ed25519.pub) → GG `authorized_keys`（**T2**）为准。

（若路径含空格或盘符不同，以 glab 上 `rev-parse` 输出为准手动构造 `git -C`。）

## Agent 未完成项 → 人类（强制格式，与 [AGENTS.md](../AGENTS.md) 铁律一致）

凡 Agent **客观上不能执行** 的步骤，不得只列清单；须对**每一项**同时写：

| 字段 | 内容 |
|------|------|
| **原因** | 为何当前 Agent/会话不能继续（权限、凭证、网络、交互 UI 等） |
| **操作提示** | 在**哪台设备**、用**什么身份**（管理员/普通用户）、**可复制**的命令或菜单路径 |
| **验收** | 怎样算完成（命令预期输出、网页上可见状态等） |

### 与本 Issue handoff 相关的示例（若仍卡住）

**1）`sshd` 未安装 / 22 未监听（epix `ssh glab` 超时）**

- **原因**：安装 OpenSSH Server、改防火墙、`authorized_keys` 通常需 **Windows 管理员**；epix 侧 Agent Shell 对 `glab:22` 可能超时，不能代出 SSH 会话证据；公钥必须以仓库 [`templates/epix-id_ed25519.pub`](templates/epix-id_ed25519.pub)（或同源 [Raw URL](https://raw.githubusercontent.com/epix99-opus/GitNet/main/handbook/templates/epix-id_ed25519.pub)）为准，**勿从聊天手抄**，Agent 也不应代为口述公钥。
- **操作提示**：公钥整行以仓库文件为准（勿手抄）。若轮换密钥：在 **epix** 更新 `handbook/templates/epix-id_ed25519.pub` 后 **push**，并通知 **glab**。在 **glab** `git pull`，以管理员打开 PowerShell，`cd` 到仓库根（`git rev-parse --show-toplevel`），执行 [scripts/setup-glab-openssh-for-epix.ps1](scripts/setup-glab-openssh-for-epix.ps1)，**`-GitNetWorkdirWin`** 填实际根路径；脚本默认从 `handbook\templates\epix-id_ed25519.pub` 读取首条 `ssh-ed25519` 行（也可用 `Get-Content -Raw …\epix-id_ed25519.pub` 传入 `-EpixPublicKeyLine`）。完成后在 **epix Terminal**（非仅 Agent Shell）执行：`ssh glab "hostname"`。
- **验收**：`Get-Service sshd` 为 **Running**；epix 上 `ssh glab "hostname"` 返回 **GLAB**（或 glab 主机名）；Issue 可再贴一行该输出。

**2）Issue #1 尚未出现 glab 证据评论**

- **原因**：本机可能无 **`gh`** CLI，且环境变量中无 **`GITHUB_TOKEN`**（或 token 无 `issues:write`），REST API 发帖在 Agent 侧不可无凭证完成。
- **操作提示（二选一）**：  
  - **A. 浏览器**：打开 Issue #1，将 [`published/issue-1-glab-evidence-comment.md`](published/issue-1-glab-evidence-comment.md) 全文粘贴为评论；或运行 `handbook/scripts/91-glab-section-A-evidence.ps1` 刷新该文件后再贴。  
  - **B. API**：在 **glab** PowerShell 临时设置 ` $env:GITHUB_TOKEN='ghp_…或 fine-grained PAT' `（勿写入仓库），运行 `.\handbook\scripts\post-issue1-github-comment.ps1`。
- **验收**：Issue #1 可见评论块；其中 `user.name` 为 **glab-cursor** 且来源为 **`…\.gitconfig-fragment-cursor`**（用户名因机而异时在评论中注明即可）。

## 期望结果

- Issue 或 PR 中附上 **A** 的完整文本输出（可脱敏）；§A 中 `Get-Service sshd` 等为**当时快照**，若现机已装 OpenSSH Server 以 glab 本机为准。
- **§B（epix Terminal）**：将 `ssh glab "cd /d … && git config --show-origin user.name"` 等命令与输出写入 [`handbook/published/issue-1-glab-evidence-comment.md`](published/issue-1-glab-evidence-comment.md) §B，并与 [published/collaboration-closeout-status.md](published/collaboration-closeout-status.md) **T3** 对齐。
- **glab Cursor Agent 落地**：已将 **§A 实时输出**写入仓库 [`handbook/published/issue-1-glab-evidence-comment.md`](published/issue-1-glab-evidence-comment.md)（由 `handbook/scripts/91-glab-section-A-evidence.ps1` 生成）。若本机已配置 `GITHUB_TOKEN`（`issues:write`），可运行 [`handbook/scripts/post-issue1-github-comment.ps1`](scripts/post-issue1-github-comment.ps1) 自动发帖；否则请打开 Issue #1 后 **粘贴**该文件**含 §A+§B 全文**。
- **口令 vs 公钥**：交互会话可用口令；**Agent / `BatchMode`** 仍须 **T2**（`authorized_keys` 公钥）。若发现 **sshd 未运行** 或 **22 未监听**，在 glab 上按 [handbook/scripts/setup-glab-openssh-for-epix.ps1](scripts/setup-glab-openssh-for-epix.ps1) 重新跑或人工修复后再贴输出。

## 修订记录

- 2026-05-13：增补 **epix `id_ed25519.pub` 定稿副本** [templates/epix-id_ed25519.pub](templates/epix-id_ed25519.pub)，与 GitHub/glab 对接；与 `46` / `setup-glab-openssh` 交叉引用。
- 2026-05-13：首版（epix Agent 建立，待 glab 执行并回贴）。
- 2026-05-13：glab Agent 增补 `91-glab-section-A-evidence.ps1`、`published/issue-1-glab-evidence-comment.md`、可选 `post-issue1-github-comment.ps1`；更新期望结果说明。
- 2026-05-13：增补「未完成项交接人类」强制格式表及与本 handoff 相关的 sshd / Issue 发帖示例（对齐 `AGENTS.md`）。
- 2026-05-13：epix→glab 公钥信源改为仓库 `templates/epix-id_ed25519.pub`（及 Raw URL）；`setup-glab-openssh-for-epix.ps1` 默认读该文件；轮换密钥流程写入 §「Agent 未完成项」与期望结果。
- 2026-05-13：链到 [published/collaboration-closeout-status.md](published/collaboration-closeout-status.md)；证据脚本增加 SSH 诊断块。
- 2026-05-13：增补 **「谁应在 glab 上 git pull / 跑管理员脚本」** 职责表（与 epix Agent 边界区分）。
- 2026-05-13：§B 与 [collaboration-closeout-status.md](published/collaboration-closeout-status.md) T3 对齐的一行式 `git config` 验收；期望结果区分 §A 快照、§B、Issue 全文粘贴与 T2 公钥/BatchMode。
