# GitNet 跨节点协作 — 收口状态（摘要）

> 由 epix 侧维护；**非** glab 机器命令输出。更新时请 `git commit` 并 `push`，便于 glab `git pull` 对齐。

| 编号 | 任务 | 状态 | 证据 / 下一步 |
|------|------|------|----------------|
| T1 | glab：`git config` 命中 `glab-cursor` + `epix99@icloud.com` | **完成** | [issue-1-glab-evidence-comment.md](issue-1-glab-evidence-comment.md) §A |
| T2 | glab：OpenSSH Server（`sshd`）安装并 **Running**；**epix 公钥已写入 GG 的 `authorized_keys`**（无口令 `ssh glab`） | **完成** | **glab（本机 Agent，2026-05-13）**：`Get-Service sshd` → **Running**；`authorized_keys` 已含仓库定稿公钥行（运行 [scripts/append-epix-pubkey-to-local-authorized_keys.ps1](scripts/append-epix-pubkey-to-local-authorized_keys.ps1) 幂等确认，与 [templates/epix-id_ed25519.pub](../templates/epix-id_ed25519.pub) 一致）。**epix 侧验收**：建议再跑 `ssh -o BatchMode=yes glab "hostname"` 确认免口令。 |
| T3 | epix：本机 **Terminal**（非 Cursor Agent Shell）对 glab 跑通 **GitNet 路径下** `git config --show-origin user.name` | **完成** | 证据：[issue-1-glab-evidence-comment.md](issue-1-glab-evidence-comment.md) §B（`glab-cursor` + `C:/Users/GG/.gitconfig-fragment-cursor`） |
| T4 | Issue #1：证据上墙并收口 | **进行中** | **证据上墙**：将 [issue-1-glab-evidence-comment.md](issue-1-glab-evidence-comment.md) **含 §A+§B 全文** 粘贴为 Issue #1 评论（或 `GITHUB_TOKEN` + `post-issue1-github-comment.ps1`）。**关闭 Issue**：由人类在认可当前验证（含「口令交互 + §B」）或 **T2 公钥无口令** 完成后执行。 |
| T5 | `92` 轮询同步（备选） | **可选** | 见 [92-github-auto-sync-collaboration.md](../92-github-auto-sync-collaboration.md)；与 Hermes/OpenClaw **并行** |

**「全部任务」在 Git 身份链路上的定义**：T1、**T2**、**T3** 已完成（T2 建议 epix 再验 `BatchMode`）；**Issue 证据上墙** 见 T4；编排类（Hermes/OpenClaw）不在本表范围。
