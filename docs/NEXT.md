# 接管后的下一步（迭代入口）

## 与 NetOps / UniNode 的边界

- **NetOps**（`/Users/epix/Dev/NetOps`）：`network_facts.env`、Runbook、Tailscale 与局域网事实源；GitNet 消费这些事实时应用环境变量或文档链接引用，不把运维密钥写进应用仓。
- **UniNode**：可视化拓扑与编排；与 NetOps 的分工见 [NetOps/docs/PRD_ALIGNMENT.md](../../NetOps/docs/PRD_ALIGNMENT.md)。若 GitNet 提供「节点/API」类能力，先对照 UniNode PRD：`/Users/epix/Dev/UniNode/Docs/03_PRD_本地部署控制台产品.md`，避免重复造轮子。

## 建议的短期任务顺序

1. 在 Glab 上按 [GLAB_PUSH.md](GLAB_PUSH.md) 将真实代码推送到 `origin`，Mac 上 `git pull` 对齐。
2. 为 GitNet 声明运行时依赖（语言版本、包管理器）并补最小 `README` 中的「开发与运行」一节。
3. 若需从 Mac 访问 Glab 上的服务：在 NetOps 或本仓记录端口与协议（SSH、HTTP、SMB 等），与 Tailscale ACL 一并核对。

## 可选工程化

- 在 GitNet 根目录增加 `.gitignore`（按技术栈选择模板）。
- CI（GitHub Actions）在首次有测试/构建命令后再加，避免空转。
