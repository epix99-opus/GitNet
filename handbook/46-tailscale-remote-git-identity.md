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

## 3. glab（Windows）— 一次性配合清单（顺序固定）

以下与仓库脚本一致；**事实表**见 [22-glab-tailscale-epix-remote.md](22-glab-tailscale-epix-remote.md)。Glab 当前 Windows 登录名（用于 SSH `User`）为 **`GG`**（与 `C:\Users\GG` 一致）；若你机不同，请全局替换。

### 3.1 glab：安装 OpenSSH、防火墙 22、authorized_keys（须管理员 PowerShell）

1. **公钥整行（与 GitHub 对接）**：以仓库定稿为准 → [templates/epix-id_ed25519.pub](templates/epix-id_ed25519.pub)（Raw：<https://github.com/epix99-opus/GitNet/raw/main/handbook/templates/epix-id_ed25519.pub>）。epix 本机可 `cat ~/.ssh/id_ed25519.pub` 核对是否与该文件**逐字符一致**。
2. 在 **glab** 以管理员打开 PowerShell，`cd` 到 GitNet 仓库根（例如 `E:\Dev\GitNet` 或 `E:\DEV\GitNet`），执行：

```powershell
Set-ExecutionPolicy -Scope Process Bypass -Force
.\handbook\scripts\setup-glab-openssh-for-epix.ps1 `
  -EpixPublicKeyLine 'ssh-ed25519 AAAA... epix@...' `
  -GitNetWorkdirWin 'E:\DEV\GitNet'
```

`-GitNetWorkdirWin` 填 **`git rev-parse --show-toplevel`** 在资源管理器里对应的盘符路径（常见为 `E:\DEV\GitNet` 或 `E:\Dev\GitNet`）。脚本会安装/启动 **OpenSSH Server**、添加入站 **TCP 22** 规则、把公钥写入 **`%USERPROFILE%\.ssh\authorized_keys`**、尽量打开 **`PubkeyAuthentication yes`** 并重启 **sshd**。

### 3.2 glab：写入 Git `includeIf` + 片段（普通 PowerShell 即可）

仍在 GitNet 根目录：

```powershell
Set-ExecutionPolicy -Scope Process Bypass -Force
.\handbook\templates\windows-glab-git-includeIf.ps1
```

脚本会用 **`git rev-parse --show-toplevel`** 解析真实 `gitdir` 大小写（例如 `E:/DEV/GitNet/`），避免 `includeIf` 与 Git 工作区不一致。本机自检：

```powershell
cd E:\Dev\GitNet   # 或你的 toplevel 目录
git config --show-origin user.name
```

应出现 **`glab-cursor`**，来源为 **`…\.gitconfig-fragment-cursor`**。

### 3.3 epix：启用 `Host glab` 并验收 SSH + Git

1. 将 [templates/epix-ssh-config-glab.fragment.conf](templates/epix-ssh-config-glab.fragment.conf) 合并进 **`~/.ssh/config`**（若原文件里已有被注释的 `Host glab` 段，**取消注释**并把 **`User`** 设为 **`GG`**）。
2. 在 epix：

```bash
ssh-keyscan glab.tailbb1446.ts.net >> ~/.ssh/known_hosts
ssh glab "cd /d E:\DEV\GitNet && git config --show-origin user.name"
```

（若 glab 上仓库在 `E:\Dev\GitNet`，把路径改成该目录。）成功时应看到 **`glab-cursor`**。

### 3.4 能力边界

- 以上实现的是 **SSH + Git 身份**；**不能**用同一套步骤「远程驱动 Glab 上所有 Cursor 图形 Agent」。
- 仓库内**永不**提交私钥、密码、PAT。

---

## 4. 修订记录

- 2026-05-13：首版；记录 woot 实装与 glab 人类配合门槛。
- 2026-05-13：glab 增补 `setup-glab-openssh-for-epix.ps1`、`epix-ssh-config-glab.fragment.conf`；`windows-glab-git-includeIf.ps1` 用 `git rev-parse` 对齐 `gitdir` 大小写；epix `User` 定稿为 **GG**。
