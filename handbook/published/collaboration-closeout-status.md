# GitNet 跨节点协作 — 收口状态（摘要）

> 由 epix 侧维护；**非** glab 机器命令输出。更新时请 `git commit` 并 `push`，便于 glab `git pull` 对齐。

| 编号 | 任务 | 状态 | 证据 / 下一步 |
|------|------|------|----------------|
| T1 | glab：`git config` 命中 `glab-cursor` + `epix99@icloud.com` | **完成** | [issue-1-glab-evidence-comment.md](issue-1-glab-evidence-comment.md) §A |
| T2 | glab：OpenSSH Server（`sshd`）安装并 **Running**；**epix 公钥已写入 GG 的 `authorized_keys`**（无口令 `ssh glab`） | **进行中** | **`sshd`：Running**。`%USERPROFILE%\.ssh\authorized_keys` 已含定稿公钥行。若 GG ∈ **Administrators**（默认 `sshd_config` 的 `Match Group administrators`），**还须**写入 `C:\ProgramData\ssh\administrators_authorized_keys`（见 `46` §3.1.1）；已在 [setup-glab-openssh-for-epix.ps1](scripts/setup-glab-openssh-for-epix.ps1) 增加 §5 自动写入，**请 glab 管理员重跑一次该脚本**，或单独以管理员运行 [append-epix-pubkey-to-administrators-authorized_keys.ps1](scripts/append-epix-pubkey-to-administrators-authorized_keys.ps1)。**epix 验收**：`ssh -o BatchMode=yes glab hostname`。 |
| T3 | epix：本机 **Terminal**（非 Cursor Agent Shell）对 glab 跑通 **GitNet 路径下** `git config --show-origin user.name` | **完成** | 证据：[issue-1-glab-evidence-comment.md](issue-1-glab-evidence-comment.md) §B（`glab-cursor` + `C:/Users/GG/.gitconfig-fragment-cursor`） |
| T4 | Issue #1：证据上墙并收口 | **进行中** | **证据上墙**：将 [issue-1-glab-evidence-comment.md](issue-1-glab-evidence-comment.md) **含 §A+§B 全文** 粘贴为 Issue #1 评论（或 `GITHUB_TOKEN` + `post-issue1-github-comment.ps1`）。**关闭 Issue**：由人类在认可当前验证（含「口令交互 + §B」）或 **T2 公钥无口令** 完成后执行。 |
| T5 | `92` 轮询同步（备选） | **可选** | 见 [92-github-auto-sync-collaboration.md](../92-github-auto-sync-collaboration.md)；与 Hermes/OpenClaw **并行** |

**「全部任务」在 Git 身份链路上的定义**：T1、**T3** 已完成；**T2** 以 epix **`BatchMode` 公钥免口令** 为最终验收；**Issue 证据上墙** 见 T4；编排类（Hermes/OpenClaw）不在本表范围。
