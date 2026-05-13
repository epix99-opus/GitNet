=== A: glab PowerShell evidence (GitNet handoff) ===
Machine: GLAB
User:    GG
Toplevel:E:/DEV/GitNet

--- Get-Service sshd ---
(sshd service not found - OpenSSH Server may not be installed)
--- git rev-parse --show-toplevel ---
E:/DEV/GitNet
--- git config --show-origin user.name ---
file:C:/Users/GG/.gitconfig-fragment-cursor	glab-cursor
--- git config --show-origin user.email ---
file:C:/Users/GG/.gitconfig-fragment-cursor	epix99@icloud.com

--- B: epix Terminal → glab (human, 2026-05-13) ---

Command (epix):

```text
ssh glab "cd /d E:\Dev\GitNet && git config --show-origin user.name"
```

Output:

```text
file:C:/Users/GG/.gitconfig-fragment-cursor	glab-cursor
```

Notes: 本次会话在提示 `GG@glab's password:` 后成功（**口令认证**）。无交互/Agent Shell 仍依赖 **公钥** 写入 GG 的 `authorized_keys`（见 T2）。
