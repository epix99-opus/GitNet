# GitNet

多设备、多编程 Agent 与人类协作的 **Git 与治理** 元仓库。**拓扑、主从与身份**以 **[handbook/README.md](handbook/README.md)** 为准（**epix bare 为权威**，GitHub 为从镜像；日常勿把 GitHub 当唯一主线）。

**项目本意（北极星）**：在硬边界（法律与授权、**凭据明文不进 Git/Issue** 等）之内，**最大化 Agent 可执行范围**，用 Git、手册与脚本把多机多 Agent 协作尽量做到**可无人值守**；**全链路认证**（公钥默认优先 + 人类提供的口令/PAT 须经 OS 凭据库等安全存储后使用）见 **[handbook/08-agent-first-collaboration-vision.md](handbook/08-agent-first-collaboration-vision.md)**。

## 从这里开始

- [handbook/README.md](handbook/README.md)
- [handbook/08-agent-first-collaboration-vision.md](handbook/08-agent-first-collaboration-vision.md)（**北极星**：Agent 优先、多设备无人值守协作意图）
- [handbook/07-documentation-placement.md](handbook/07-documentation-placement.md)（写什么、写哪里）
- [handbook/55-multi-node-multi-agent-git.md](handbook/55-multi-node-multi-agent-git.md)（多机多 Agent Git 身份总表）
- [handbook/46-tailscale-remote-git-identity.md](handbook/46-tailscale-remote-git-identity.md)（epix→woot/glab 经 Tailscale 落地与 SSH 约定）
- [handbook/92-github-auto-sync-collaboration.md](handbook/92-github-auto-sync-collaboration.md)（GitHub 双端自动拉取与通知，见 `launchd`/计划任务）
- [handbook/93-gitnet-phase-conclusion-and-cross-collab-git-playbook.md](handbook/93-gitnet-phase-conclusion-and-cross-collab-git-playbook.md)（**阶段成果**：目标→方案→实现回顾；可外推的大型多跨协作 Git 体系清单）
- [AGENTS.md](AGENTS.md)

## 远端

- GitHub：<https://github.com/epix99-opus/GitNet>

## 工作副本路径（示例）

- **Mac（Epix）**：建议 `/Users/epix/Dev/GitNet`（与仓库名一致）。
- **Windows（Glab）**：例如 `E:\Dev\GitNet`。
- Tailscale 内节点互通以各自 `tailscale status` 为准；**代码同步以 Git fetch/pull/push 为主**（与是否开放 SSH 服务无关）。

若远端已有提交而本地有独立历史，先 `git pull origin main --rebase`；冲突处理与进程记录见 [handbook/90-process-log.md](handbook/90-process-log.md)。
