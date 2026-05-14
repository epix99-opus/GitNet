# 经 Tailscale 为多节点配置 Git 身份（epix → woot / glab）

本文说明：从 **epix** 经 Tailscale SSH 在 **woot（macOS）**、**glab（Windows）** 上落地与 [55-multi-node-multi-agent-git.md](55-multi-node-multi-agent-git.md) 一致的 **`includeIf` + 片段**，并在 epix 侧维护 **`~/.ssh/config`** 以便非交互自检。

## 1. epix 侧前提

- epix 本机已加载用于登录远端的私钥（示例：`~/.ssh/id_ed25519`），且远端 **`authorized_keys` 已包含对应公钥**。
- **woot** 登录用户名为 **`woot`**（已验证：`woot@woot` 可公钥登录）；**不是** `epix@woot`。
- `~/.ssh/known_hosts` 含 `woot.tailbb1446.ts.net`（可由 `ssh-keyscan woot.tailbb1446.ts.net >> ~/.ssh/known_hosts` 追加；若在 **macOS** 上遇 **`fdlim_get: bad value`**，与 glab 相同处理：先 `ulimit -n 10240` 或使用 `accept-new`，见 **§3.3**）。

### 1.0 远端在线与 SSH 前核对（避免「ping 通但 ssh 超时」误判）

**Agent 与人类在断言「某节点不可达」之前，应先做下面三步**（本机均在 **epix** 上执行）：

1. **`tailscale status`**：确认目标短名（如 `woot`、`glab`）在表中为 **在线**（非 `offline`）。
2. **`tailscale ping -c 1 <短名>`**：确认 **L3** 可达（有 `pong`）。
3. **再 `ssh`**：若 **`ssh woot@woot`（短名）** 出现 **`connect … port 22: Operation timed out`**，**不要**先下结论「对端不在线」。
4. **权威 IPv4（推荐，不经系统 DNS）**：执行 **`tailscale ip -4 woot`**（或 `glab`），输出应与 **`tailscale status`** 该行的 **100.x** 一致。**实机已验**：`ssh woot@<上述 100.x>` 可正常登录（与短名解析滞后无关）。
5. **与系统解析器交叉核对（可选）**：`dscacheutil -q host -a name woot`。若其 **100.x** 与 **`tailscale ip -4 woot`** 不一致，则短名 SSH 可能在连 **旧地址**；处置：刷新 DNS（`sudo dscacheutil -flushcache` + `sudo killall -HUP mDNSResponder`），或直接在 **`~/.ssh/config`** 的 `Host woot` 写 **`HostName` = `tailscale ip -4 woot` 的输出**（随节点重建以 **`tailscale status`/`tailscale ip`** 为准更新）。**网络事实登记**见 NetOps `configs/network_facts.env` 之 **`TAILSCALE_WOOT_IP`** 与 **`scripts/tailscale-peer-ipv4.sh`**。

**教训**：不得仅凭 **`ssh` 短名超时** 妄断 **对端未在线**；须先 **`tailscale status` / `tailscale ping` / `tailscale ip -4`**。

### 1.1 建议在 epix `~/.ssh/config` 增加

```sshconfig
Host woot woot.tailbb1446.ts.net
  # HostName 填 `tailscale ip -4 woot` 的当前输出（示例曾验：100.86.243.3）；短名 SSH 超时必核对此行
  HostName 100.86.243.3
  User woot
  IdentityFile ~/.ssh/id_ed25519
```

（若你的私钥路径不同，改 `IdentityFile`。**`HostName` 随 tailnet 节点重建会变**，以 **`tailscale ip -4 woot`** 为准。）

自检（短名）：

```bash
ssh woot "hostname -s; git config --show-origin user.name"
```

**自检（不经短名 DNS，与 NetOps 一致）**：

```bash
WOOT_TS_IP="$(tailscale ip -4 woot)"
ssh -o BatchMode=yes "woot@${WOOT_TS_IP}" "hostname -s; git config --show-origin user.name"
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

**公钥信源（唯一）**：仓库内 [`templates/epix-id_ed25519.pub`](templates/epix-id_ed25519.pub) 中**首条**以 `ssh-ed25519` 开头的数据行（可删去文件内 `#` 注释，仅保留一行）。与 `main` 对齐的 Raw 同源（任选其一）：  
<https://raw.githubusercontent.com/epix99-opus/GitNet/main/handbook/templates/epix-id_ed25519.pub> · <https://github.com/epix99-opus/GitNet/raw/main/handbook/templates/epix-id_ed25519.pub>  
**勿从聊天/邮件手抄**。epix 本机可 `cat ~/.ssh/id_ed25519.pub` 核对是否与上述文件**逐字符一致**。在 **epix** 上轮换密钥时：更新该文件 → `commit`/`push`（权威 bare 与镜像按团队流程）→ **通知 glab** 管理员重新执行本脚本或手工更新 `authorized_keys`。

1. 若仓库中尚无有效 `ssh-ed25519` 行：在 **epix** 将 `cat ~/.ssh/id_ed25519.pub` 的**整一行**写入上述文件后提交推送（否则 glab 侧脚本会因读不到有效行而失败，属预期）。
2. 在 **glab** `git pull` 后，以管理员打开 PowerShell，`cd` 到 GitNet 仓库根（例如 `E:\Dev\GitNet` 或 `E:\DEV\GitNet`），执行：

```powershell
Set-ExecutionPolicy -Scope Process Bypass -Force
.\handbook\scripts\setup-glab-openssh-for-epix.ps1 -GitNetWorkdirWin 'E:\DEV\GitNet'
```

（可选）显式指定公钥文件：`-EpixPublicKeyPath '.\handbook\templates\epix-id_ed25519.pub'`；或临时覆盖：`-EpixPublicKeyLine 'ssh-ed25519 …'`（仍须为完整一行，优先以仓库文件为准）。

`-GitNetWorkdirWin` 填 **`git rev-parse --show-toplevel`** 在资源管理器里对应的盘符路径（常见为 `E:\DEV\GitNet` 或 `E:\Dev\GitNet`）。脚本会安装/启动 **OpenSSH Server**、添加入站 **TCP 22** 规则、从文件或参数解析出的公钥写入 **`%USERPROFILE%\.ssh\authorized_keys`**、尽量打开 **`PubkeyAuthentication yes`** 并重启 **sshd**。

**脚本文本编码（维护 `handbook/scripts/*.ps1` 时必读）**：在 **Windows PowerShell 5.1** 下，含**中文**的脚本须保存为 **UTF-8 带 BOM**。若文件为 UTF-8 **无** BOM，解释器常按**系统 ANSI**（如简体中文 Windows 的 GBK）解码，会在**随机行**报 **ParserError**（例如「表达式或语句中包含意外的标记 `}`」），与 `if`/`else` 是否写对无关。用 VS Code / Cursor 另存为 **UTF-8 with BOM** 后重跑即可。仓库内 `setup-glab-openssh-for-epix.ps1` 已定稿为带 BOM；其它新增中文脚本须遵守同一规则。详见 [20-windows-setup.md](20-windows-setup.md) §7。

#### 3.1.1 若登录用户属于 **Administrators**（常见首用户 GG）

Windows 默认 `sshd_config` 含：

```text
Match Group administrators
       AuthorizedKeysFile __PROGRAMDATA__/ssh/administrators_authorized_keys
```

此时 **仅**维护 `%USERPROFILE%\.ssh\authorized_keys` **不足以**让公钥登录生效；epix 上 `ssh -o BatchMode=yes` 会得到 **`Permission denied (publickey,...)`**。须**额外**把同一公钥行写入 **`C:\ProgramData\ssh\administrators_authorized_keys`**（须管理员），并保证 ACL 为 **SYSTEM** 与 **Administrators** 完全控制（见 [scripts/setup-glab-openssh-for-epix.ps1](scripts/setup-glab-openssh-for-epix.ps1) §5 或单独运行 [scripts/append-epix-pubkey-to-administrators-authorized_keys.ps1](scripts/append-epix-pubkey-to-administrators-authorized_keys.ps1)）。

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

### 3.3 epix：启用 `Host glab`、写入 `known_hosts` 并验收 SSH + Git

1. 将 [templates/epix-ssh-config-glab.fragment.conf](templates/epix-ssh-config-glab.fragment.conf) 合并进 **`~/.ssh/config`**（若原文件里已有被注释的 `Host glab` 段，**取消注释**并把 **`User`** 设为 **`GG`**）。
2. 在 epix **Terminal**（建议与 [91-glab-handoff-epix-ssh-verify.md](91-glab-handoff-epix-ssh-verify.md) §B 一致）追加主机公钥：

```bash
ssh-keyscan glab.tailbb1446.ts.net >> ~/.ssh/known_hosts
```

若 Apple 自带的 `ssh-keyscan` 报错 **`fdlim_get: bad value`**（常见于 `ulimit -n` 为 **unlimited** 时，OpenSSH 将 64 位 fd 上限塞进 `int` 溢出）：**同一 shell** 先收紧上限再扫描，例如：

```bash
ulimit -n 10240
ssh-keyscan glab.tailbb1446.ts.net >> ~/.ssh/known_hosts
```

**替代**：若客户端支持 **`StrictHostKeyChecking=accept-new`**（OpenSSH 8+），可跳过 `ssh-keyscan`，用首次成功连接写入 `known_hosts`：

```bash
ssh -o StrictHostKeyChecking=accept-new glab "hostname"
```

3. 验收 Git 片段（路径与 glab 上 `git rev-parse --show-toplevel` 一致）：

```bash
ssh glab "cd /d E:\DEV\GitNet && git config --show-origin user.name"
```

（若 glab 上仓库在 `E:\Dev\GitNet`，把路径改成该目录。）成功时应看到 **`glab-cursor`**。无口令 / **BatchMode** 须已在 glab 完成 §3.1 + §3.1.1（含 `administrators_authorized_keys` 时），epix 上可再验：`ssh -o BatchMode=yes glab "hostname"`。

### 3.4 能力边界

- 以上实现的是 **SSH + Git 身份**；**不能**用同一套步骤「远程驱动 Glab 上所有 Cursor 图形 Agent」。
- 仓库内**永不**提交私钥、密码、PAT。

---

## 4. 修订记录

- 2026-05-14：§1.0 增补 **`tailscale ip -4`** 为权威 IPv4、**`ssh woot@<100.x>` 实机可登** 之自检；§1.1 示例 `HostName` 与 **不经短名 DNS** 的 `WOOT_TS_IP` 自检块；互指 NetOps `network_facts.env` / `scripts/tailscale-peer-ipv4.sh`。
- 2026-05-14：新增 **§1.0** — SSH 前先 **`tailscale status` / `tailscale ping`**；**DNS 解析 100.x 与 status 表不一致** 可导致「Tailscale 在线但 `ssh woot` 超时」；附 flushcache / `HostName` 处置要点。
- 2026-05-13：首版；记录 woot 实装与 glab 人类配合门槛。
- 2026-05-13：glab 增补 `setup-glab-openssh-for-epix.ps1`、`epix-ssh-config-glab.fragment.conf`；`windows-glab-git-includeIf.ps1` 用 `git rev-parse` 对齐 `gitdir` 大小写；epix `User` 定稿为 **GG**。
- 2026-05-13：§3.1.1 **Administrators** 与 `administrators_authorized_keys`（BatchMode 根因）；`setup-glab-openssh-for-epix.ps1` 增 ProgramData 公钥写入。
- 2026-05-13：§3.1 增补 **PowerShell 5.1 + UTF-8 BOM** 说明（无 BOM 中文脚本 ParserError）；§3.3 增补 epix 上 **`ssh-keyscan` / `fdlim_get`** 与 **`accept-new`** 替代；链到 `20` §7。
