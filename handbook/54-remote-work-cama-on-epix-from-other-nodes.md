# 其它节点上的编程 Agent：如何「直接」在 epix 的 CAMA 上工作

「直接」有两种常见含义：**工作目录在 epix 磁盘上**（与副机本地克隆相对）。下文三种模式按此区分。

> **路径以盘点为准**：epix 上 CAMA 相关路径示例见 [published/inventory-epix-enumerated-agent.md](published/inventory-epix-enumerated-agent.md)（如 `/Users/epix/Dev/CAMA/CAMA-concept`）。**每个 CAMA 克隆的 `origin`、默认分支以该目录下 `git remote -v` / `git branch` 为准**，本文不冒充唯一裸仓 URL。

## 模式 A：Remote-SSH（推荐：副机 UI，代码在 epix）

1. 在 **woot / glab** 上打开 **Cursor**（或 VS Code 等支持 Remote SSH 的 IDE）。
2. 通过 SSH 连接到 **epix**（`Host` / `User` / `IdentityFile` 以你本机 `~/.ssh/config` 为准；Tailscale 与短名解析问题见 [46-tailscale-remote-git-identity.md](46-tailscale-remote-git-identity.md) §1.0～1.1）。
3. **打开文件夹** 选 epix 上的 CAMA 路径（见上表 inventory）。
4. 此后终端、Git、扩展宿主均在 **epix**；`git config --show-origin user.name` 应命中 epix 上 `includeIf`（如 **epix-cursor**），见 [55-multi-node-multi-agent-git.md](55-multi-node-multi-agent-git.md)。

**特点**：副机无需再维护一份 CAMA 工作副本；网络中断时编辑不可用。

## 模式 B：SSH 终端 + CLI Agent（Codex / Claude 等）

1. 从副机执行 `ssh <epix别名>` 登录 epix。
2. `cd` 到 CAMA 仓库根（路径同上，以实机为准）。
3. 在会话内运行 `codex`、`claude` 等；身份仍由 **epix** 的 `includeIf` 决定。

**特点**：无 IDE 也可用；注意勿在**同一克隆**上开两个写会话导致工作区互相踩踏（见 [53-multi-agent-main-branch-and-agent-files.md](53-multi-agent-main-branch-and-agent-files.md)）。

## 模式 C：副机本地克隆，向 epix bare（或约定远端）推送

1. 在 woot/glab 上 `git clone` CAMA（或已有克隆），`origin` 指向团队约定的**写权威**（常为 epix bare，见 [10-topology.md](10-topology.md)）。
2. 在副机编辑、`commit`、`push`。

**特点**：工作目录在**副机**；与模式 A 不同，但对象库仍可与 epix 主线一致。离线可本地提交，联网再推。

## 前置与安全

- **Tailscale**：断言可达前执行 `tailscale status`、`tailscale ping`；短名 SSH 异常时核对 **`tailscale ip -4 <节点>`** 与 `HostName`，见 `46` §1.0。
- **凭据**：口令、token、私钥不入 Git、不入 Issue；见 [08-agent-first-collaboration-vision.md](08-agent-first-collaboration-vision.md)。

## 相关章节

- 本体系与「只装 Git」的差异：[52-gitnet-git-stack-vs-os-git.md](52-gitnet-git-stack-vs-os-git.md)。
- Git 日常命令与历史图：[51-git-cli-and-git-graph-user-guide.md](51-git-cli-and-git-graph-user-guide.md)。

## 修订记录

| 日期 | 摘要 |
|------|------|
| 2026-05-14 | 初版：Remote-SSH、SSH+CLI、副机克隆三路径。 |
