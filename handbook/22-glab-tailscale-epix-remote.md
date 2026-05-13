# Glab（Windows）Tailscale 事实与 epix 侧远程协作边界

本文供 **epix（Mac）** 经 **GitHub 拉取本仓** 后按图施工；事实字段来自 **Glab 本机** 一次 `tailscale` 查询（见文末日期）。**不得**在本文或仓库内写入私钥、密码、API token。

## 1. 本机 Tailscale 事实（Glab / Windows）

| 项 | 值 |
|----|-----|
| 节点名（Tailscale 列表） | `glab` |
| MagicDNS FQDN | `glab.tailbb1446.ts.net`（末尾点号可省略） |
| MagicDNS 后缀（整网） | `tailbb1446.ts.net` |
| Tailscale IPv4（100.x） | `100.119.210.69` |
| Tailscale 客户端版本 | `1.96.3`（以本机 `tailscale version` 为准） |
| 局域网（示例，会变） | `tailscale netcheck` 曾报告 `self=192.168.50.227`；**以当时本机为准** |

从 **epix** 上连通性自检（在 epix 终端执行）：

```bash
ping -c 3 glab.tailbb1446.ts.net
# 或
ping -c 3 100.119.210.69
```

当前 tailnet 内可见 **epix**（macOS）与 **glab**（windows）均为 `active` / 在线时，即表示 **L3 已通**。

## 2. 「root 方式」与常见误解

- **Tailscale 不提供 Unix `root`**：它提供的是 **加密的 Overlay 网络**与（若管理员开启）**Tailscale SSH** 等能力；能否登录本机 shell，取决于 **Windows 是否安装并开放 SSH**、**账号与公钥**，与是否加入 tailnet 是两层问题。
- **无法**让 epix 在技术上「一键接管 Glab 上所有 Cursor / Claude / Codex **图形界面 Agent**」：各 IDE 的 Agent **没有**标准远程总线；跨机协作应拆成：
  - **Git**：推/拉 GitHub 或 epix bare（见 [10-topology.md](10-topology.md)）；
  - **命令行/脚本**：经 **SSH** 在 Glab 上跑 `git`、构建、测试（需单独开通与授权）；
  - **远程开发**：使用 **VS Code / Cursor Remote-SSH** 连到 Glab（若 Glab 上装 OpenSSH Server 且账号就绪），本质是「在 Glab 上开一个远端工作区」，**不是**从 epix 遥控本机已打开的每一个本地 Agent 实例。

## 3. 推荐给 epix 的「能落地」的三种能力（按侵入性从低到高）

### A. 仅 Git（最低权限，优先）

- epix 与 Glab **都只**通过 `origin`（epix bare 或 GitHub）同步仓库；不在 Glab 上开 shell。
- 与当前 GitNet 主从策略一致。

### B. Tailscale SSH（若 tailnet 策略已开启）

- 在 epix 上：`tailscale ssh <glab-windows-用户名>@glab`（具体语法以你们 **Tailscale ACL / 版本** 为准）。
- 前提：Glab Windows 上 **Tailscale 客户端** 已登录同一 tailnet，且 **ACL 允许** 从 epix 角色发起 SSH。

### C. OpenSSH Server（Windows）+ 公钥

1. Windows：**设置 → 应用 → 可选功能 → OpenSSH 服务器** 安装并启动 `sshd`；防火墙仅允许 **Tailscale 接口或 100.64.0.0/10** 来源（由网络管理员收紧，勿对公网 0.0.0.0 开放 22）。
2. `C:\ProgramData\ssh\sshd_config`：建议 `PasswordAuthentication no`，仅公钥。
3. epix `~/.ssh/config` 示例：

```sshconfig
Host glab-win
    HostName glab.tailbb1446.ts.net
    User 你的Windows用户名
    IdentityFile ~/.ssh/id_ed25519_glab
```

4. epix 上验收：`ssh glab-win` 能进 PowerShell/cmd 即成功。

## 4. 与「通过 GitHub 提供给 epix」的关系

- **交付路径**：将本文件合并进 `main` 并 `git push` 后，epix 执行 `git pull`，即获得**与仓库版本一致**的接入说明。
- **若 tailnet 名或 IP 变更**：在 Glab 上重跑 `tailscale status` / `tailscale status --json`，更新本表并在 [90-process-log.md](90-process-log.md) 记一行。

## 5. 安全铁律（摘要）

- 仓库内**永不**提交：私钥、密码、PAT、`sshd` 私配中的密钥材料。
- **禁止**把 Windows 管理员密码交给「方便 epix 操作」；用 **SSH 公钥 + 最小权限账号**。
- 需要 **ACL 级** 放行（谁可 SSH 谁）时，在 **Tailscale Admin** 修改，并由人类管理员验收。

---

**记录**：事实字段摘录于 Glab 本机命令行，`tailscale status` 与 `tailscale status --json`（日期以 Git 提交日为准）。
