# GitNet 体系里的 Git：与「只装了系统 Git」有何不同

## 1. 相同点

- 各节点上执行 `git`、`git-upload-pack` 等，仍是 **Apple / Microsoft 官方渠道或团队认可的同一套 Git 发行版**（Xcode CLT、Git for Windows 等）。GitNet **不是** Git 的分叉或魔改二进制。
- 底层对象模型、提交图、合并语义，与普通 Git 教程一致。

## 2. 不同点：本仓库在「裸 Git」上叠加了什么

| 层次 | 说明 | 定稿章节 |
|------|------|----------|
| **拓扑与写权威** | 业务对象库的默认汇合点优先为 **epix 上 bare**；GitHub 多为**从镜像**，不作为日常多端合并枢纽（除非过渡并在进程日志说明）。 | [10-topology.md](10-topology.md) |
| **作者身份** | 用 **`includeIf` + 片段** 按目录区分 `{HOSTNAME}-{tool}`（如 `epix-cursor`），与人类全局兜底分离。 | [40-identity-and-includeIf.md](40-identity-and-includeIf.md)、[55-multi-node-multi-agent-git.md](55-multi-node-multi-agent-git.md) |
| **跨机访问** | Tailscale + SSH 别名、`HostName` 与 DNS 核对等，使 woot/glab 与 epix 可非交互协作。 | [46-tailscale-remote-git-identity.md](46-tailscale-remote-git-identity.md)、[22-glab-tailscale-epix-remote.md](22-glab-tailscale-epix-remote.md) |
| **可选数据面** | GitHub 双端轮询、`ff-only` 感知等，**不替代** bare 写权威。 | [92-github-auto-sync-collaboration.md](92-github-auto-sync-collaboration.md) |
| **人机契约** | 北极星、凭据不进仓库、进程留证。 | [08-agent-first-collaboration-vision.md](08-agent-first-collaboration-vision.md)、[90-process-log.md](90-process-log.md) |

一句话：**系统 Git** 提供引擎；**GitNet 手册**提供「推哪里、谁算作者、跨机怎么连、镜像算什么角色」的**团队运行栈**。

## 3. 特别价值（为何要单独成体系）

1. **审计与归因**：历史里能稳定区分「哪台机器、哪类工具」的提交，而不依赖事后猜 `user.name` 是否被 GUI 覆盖。
2. **减少错误默认**：Agent 目录与人类目录分轨，降低「用个人全局身份误提交到组织仓」的概率。
3. **单一集成真相**：多机多 Agent 时，以 **bare** 为默认写集成点，减少「GitHub 与 epix 谁才是主线」的长期分裂（与 [93-gitnet-phase-conclusion-and-cross-collab-git-playbook.md](93-gitnet-phase-conclusion-and-cross-collab-git-playbook.md) 一致）。
4. **可自动化**：路径规则、`BatchMode` SSH、脚本与清单可复跑，便于 Agent 执行闭环。

## 4. 相关章节

- 操作向：终端与图形历史图见 [51-git-cli-and-git-graph-user-guide.md](51-git-cli-and-git-graph-user-guide.md)。
- 多 Agent 同分支文件冲突见 [53-multi-agent-main-branch-and-agent-files.md](53-multi-agent-main-branch-and-agent-files.md)。
- 在 epix 上编辑 CAMA 的跨机方式见 [54-remote-work-cama-on-epix-from-other-nodes.md](54-remote-work-cama-on-epix-from-other-nodes.md)。

## 修订记录

| 日期 | 摘要 |
|------|------|
| 2026-05-14 | 初版：与系统 Git 的边界、叠加层与价值。 |
