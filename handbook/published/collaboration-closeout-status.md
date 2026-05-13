# GitNet 跨节点协作 — 收口状态（摘要）

> 由 epix 侧维护；**非** glab 机器命令输出。更新时请 `git commit` 并 `push`，便于 glab `git pull` 对齐。

| 编号 | 任务 | 状态 | 证据 / 下一步 |
|------|------|------|----------------|
| T1 | glab：`git config` 命中 `glab-cursor` + `epix99@icloud.com` | **完成** | [issue-1-glab-evidence-comment.md](issue-1-glab-evidence-comment.md) §A |
| T2 | glab：OpenSSH Server（`sshd`）安装并 **Running**；**epix 公钥已写入 GG 的 `authorized_keys`** | **进行中** | **epix Agent Shell（2026-05-13）**：`ssh glab` 已由 *超时* 变为 **`Permission denied (publickey)`**（且已 `ssh-keyscan` 写入 `known_hosts`），说明 **TCP/22 与主机密钥链路已通**，剩余为 **GG 账户未接受本机 `~/.ssh/id_ed25519.pub`**。请在 glab 管理员执行 [scripts/setup-glab-openssh-for-epix.ps1](../scripts/setup-glab-openssh-for-epix.ps1)（默认读仓库内 `epix-id_ed25519.pub`）后重试。 |
| T3 | epix：本机 **Terminal**（非 Cursor Agent Shell）`ssh glab "hostname"` 成功 | **待办** | 依赖 T2；成功后把一行输出贴 [Issue #1](https://github.com/epix99-opus/GitNet/issues/1) 或追加进证据文件 §B |
| T4 | Issue #1：结论可见（评论或关闭理由） | **进行中** | 可粘贴 `issue-1-glab-evidence-comment.md`；T2+T3 完成后由人类关闭 Issue |
| T5 | `92` 轮询同步（备选） | **可选** | 见 [92-github-auto-sync-collaboration.md](../92-github-auto-sync-collaboration.md)；与 Hermes/OpenClaw **并行** |

**「全部任务」在 Git 身份链路上的定义**：T1 已完成；**SSH 端到端验收**以 **T2+T3** 为准。编排类（Hermes/OpenClaw）不在本表范围。
