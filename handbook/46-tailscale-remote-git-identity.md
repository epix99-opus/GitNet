# 经 Tailscale 为多节点配置 Git 身份（epix → woot / glab）

本文说明：从 **epix** 经 Tailscale SSH 在 **woot（macOS）**、**glab（Windows）** 上落地与 [55-multi-node-multi-agent-git.md](55-multi-node-multi-agent-git.md) 一致的 **`includeIf` + 片段**，并在 epix 侧维护 **`~/.ssh/config`** 以便非交互自检。

## 1. epix 侧前提

- epix 本机已加载用于登录远端的私钥（示例：`~/.ssh/id_ed25519`），且远端 **`authorized_keys` 已包含对应公钥**。
- **woot** 登录用户名为 **`woot`**（已验证：`woot@woot` 可公钥登录）；**不是** `epix@woot`。
- `~/.ssh/known_hosts` 含 `woot.tailbb1446.ts.net`（可由 `ssh-keyscan woot.tailbb1446.ts.net >> ~/.ssh/known_hosts` 追加）。

### 1.1 建议在 epix `~/.ssh/config` 增加

```sshconfig
Host woot woot.tailbb1446.ts.net
  User woot
  IdentityFile ~/.ssh/id_ed25519
```

（若你的私钥路径不同，改 `IdentityFile`。）

自检：

```bash
ssh woot "hostname -s; git config --show-origin user.name"
```

在 `~/Dev` 下任一仓库内应显示 `woot-cursor` 来源为 `~/.gitconfig-fragment-cursor`；在 `/tmp` 新 `git init` 仓库内应为人类 `Epix`。

---

## 2. woot（macOS）— 已由 Agent 从 epix 落地（可复查）

| 项 | 值 |
|----|-----|
| 备份 | `~/.gitconfig.backup-gitnet-YYYYMMDD`（在 woot 上） |
| 片段 | `~/.gitconfig-fragment-cursor`（`woot-cursor`）、`…-codex`、`…-claude-code` |
| `includeIf` | 与 epix 同构，路径前缀为 **`/Users/woot/`** |
| `agent-work` | 已创建 `~/agent-work/{cursor,codex,claude-code}/` |

---

## 3. glab（Windows）— 需一次性人类配合后再由 epix 代执行

当前常见状态：**TCP 22 未对 tailnet 开放或未装 OpenSSH Server**，从 epix `ssh-keyscan glab` 可能无响应；请先在本机完成：

1. **设置 → 应用 → 可选功能 → OpenSSH 服务器** 安装并启动 **`sshd`**；PowerShell（管理员）：`Start-Service sshd`；`Set-Service -Name sshd -StartupType 'Automatic'`。
2. **防火墙**：入站允许 **22**（域/专用/公用按你的网络配置文件勾选）。
3. **授权 epix 公钥**：将 epix 上 `~/.ssh/id_ed25519.pub` **整行**追加到 glab 上目标用户的 `C:\Users\<用户>\.ssh\authorized_keys`（若目录不存在则创建；权限按 OpenSSH 文档设置）。
4. 确认 glab 上 **SSH 登录用户名**（例如 `epix` 或微软账户短名）；在 epix `~/.ssh/config` 增加：

```sshconfig
Host glab glab.tailbb1446.ts.net
  User 你的Windows用户名
  IdentityFile ~/.ssh/id_ed25519
```

5. 在 epix 执行验证：

```bash
ssh-keyscan glab.tailbb1446.ts.net >> ~/.ssh/known_hosts
ssh glab "hostname && git --version"
```

通过后，在 **glab 本机** 用 PowerShell（可改 `$DevRoot`）执行 [templates/windows-glab-git-includeIf.ps1](templates/windows-glab-git-includeIf.ps1)，或按 [templates/gitconfig.windows.main.ini](templates/gitconfig.windows.main.ini) 手工编辑 `%USERPROFILE%\.gitconfig` 与三份片段，**HOSTNAME 一律用 `glab`**。

---

## 4. 修订记录

- 2026-05-13：首版；记录 woot 实装与 glab 人类配合门槛。
