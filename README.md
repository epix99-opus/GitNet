# GitNet

多设备、多编程 Agent 与人类协作的 **Git 与治理** 元仓库。**拓扑、主从与身份**以 **[handbook/README.md](handbook/README.md)** 为准（**epix bare 为权威**，GitHub 为从镜像；日常勿把 GitHub 当唯一主线）。

## 从这里开始

- [handbook/README.md](handbook/README.md)
- [handbook/07-documentation-placement.md](handbook/07-documentation-placement.md)（写什么、写哪里）
- [AGENTS.md](AGENTS.md)

## 远端

- GitHub：<https://github.com/epix99-opus/GitNet>

## 工作副本路径（示例）

- **Mac（Epix）**：建议 `/Users/epix/Dev/GitNet`（与仓库名一致）。
- **Windows（Glab）**：例如 `E:\Dev\GitNet`。
- Tailscale 内节点互通以各自 `tailscale status` 为准；**代码同步以 Git fetch/pull/push 为主**（与是否开放 SSH 服务无关）。

若远端已有提交而本地有独立历史，先 `git pull origin main --rebase`；冲突处理与进程记录见 [handbook/90-process-log.md](handbook/90-process-log.md)。
