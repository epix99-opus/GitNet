# glab 侧配合：epix→glab SSH 与 Git 身份验收（Handoff）

**GitHub Issue（回贴输出）**：https://github.com/epix99-opus/GitNet/issues/1

> 由 epix 上 Cursor Agent 建立：因 **Agent 内置 Shell 对 `glab:22` 探测超时**，无法在 epix 侧代出「SSH 已通」的终端证据，需 **glab 本机**（或你在 epix 本机 Terminal 重跑）完成下列验收，并把输出贴到 **Issue #1** 或本文件 PR 讨论串。

## 目标

- 确认 **Tailscale 内 epix 可 SSH 登录 glab**（或至少 **glab 本机 SSH/Git 配置正确**）。
- 确认 **`E:\Dev\GitNet`（或 `git rev-parse --show-toplevel` 实际路径）** 下 Git 作者命中 **`glab-cursor`** 片段。

## 问题（背景）

- epix 节点名即本 Mac；手册见 [46-tailscale-remote-git-identity.md](46-tailscale-remote-git-identity.md)、[22-glab-tailscale-epix-remote.md](22-glab-tailscale-epix-remote.md)。
- Cursor Agent 在 epix 上执行 `ssh glab "hostname"` 时出现 **`connect to host glab port 22: Operation timed out`**，与「你在本机 Terminal 已能通」可并存，故需 **glab 或人类**补证据。

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

（若路径含空格或盘符不同，以 glab 上 `rev-parse` 输出为准手动构造 `git -C`。）

## 期望结果

- Issue 或 PR 中附上 **A** 的完整文本输出（可脱敏）。
- **glab Cursor Agent 落地**：已将 **§A 实时输出**写入仓库 [`handbook/published/issue-1-glab-evidence-comment.md`](published/issue-1-glab-evidence-comment.md)（由 `handbook/scripts/91-glab-section-A-evidence.ps1` 生成）。若本机已配置 `GITHUB_TOKEN`（`issues:write`），可运行 [`handbook/scripts/post-issue1-github-comment.ps1`](scripts/post-issue1-github-comment.ps1) 自动发帖；否则请打开 Issue #1 后 **粘贴**该文件内容（本机 Agent 已尝试 **复制到剪贴板** 并 **打开浏览器** 到 Issue 页）。
- 若执行了 **B**，附上 **`ssh glab "hostname"`** 一行成功输出。
- 若发现 **sshd 未运行** 或 **22 未监听**，在 glab 上按 [handbook/scripts/setup-glab-openssh-for-epix.ps1](scripts/setup-glab-openssh-for-epix.ps1) 重新跑或人工修复后再贴输出。

## 修订记录

- 2026-05-13：首版（epix Agent 建立，待 glab 执行并回贴）。
- 2026-05-13：glab Agent 增补 `91-glab-section-A-evidence.ps1`、`published/issue-1-glab-evidence-comment.md`、可选 `post-issue1-github-comment.ps1`；更新期望结果说明。
