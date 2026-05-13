# GitNet

本仓库为 **GitNet** 在 Mac 上的工作副本根目录；权威远端为 **GitHub** `epix99-opus/GitNet`。

## 网络与设备

- **Glab**：Windows 11 笔记本，Tailscale 节点名 `glab`，事实源 IP 见 [NetOps `configs/network_facts.env`](/Users/epix/Dev/NetOps/configs/network_facts.env) 中 `TAILSCALE_GLAB_IP`（与 `tailscale status` 保持一致）。
- 本机已验证：`ping` 与 `tailscale ping` 可达；**SSH 22 未对 tailnet 开放**（属预期可选能力），代码同步以 **Git push/pull** 为主。

## 当前状态

- 远端仓库曾为空；若你仅在 Glab 本地开发，请在本机首次推送前在 **Glab** 上完成「已有仓库绑定远端并推送」（见 [docs/GLAB_PUSH.md](docs/GLAB_PUSH.md)）。
- 若远端已有提交，在本目录执行：`git pull origin main`。

## 克隆（建议本地目录名与仓库一致）

```bash
cd /Users/epix/Dev
git clone https://github.com/epix99-opus/GitNet.git GitNet
cd GitNet
```

本机工作副本路径：**`/Users/epix/Dev/GitNet`**。
