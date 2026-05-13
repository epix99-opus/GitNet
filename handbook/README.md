# GitNet Handbook（定稿）

本目录为 **GitNet** 仓库运维与多机协作的**唯一定稿信源**。环境事实、拓扑与操作步骤以本手册为准。

## 阅读顺序

| 顺序 | 文档 | 说明 |
|------|------|------|
| 1 | [00-truth-sources.md](00-truth-sources.md) | 信源层级、冲突处理规则 |
| 2 | [05-project-scope-and-delivery.md](05-project-scope-and-delivery.md) | 项目定义、交付边界、会话结论归并、人类检查清单 |
| 3 | [07-documentation-placement.md](07-documentation-placement.md) | **内容落盘规则**：事实 / 过程 / 草稿各写何处；与 NetOps 网络事实源边界 |
| 4 | [10-topology.md](10-topology.md) | epix 权威裸仓、GitHub 从镜像、各端角色 |
| 5 | [40-identity-and-includeIf.md](40-identity-and-includeIf.md) | 人类兜底与 Agent 作者名、`includeIf` 模板 |
| 6 | [45-ssh-tailscale-for-humans.md](45-ssh-tailscale-for-humans.md) | 非技术向：Tailscale 机器名、SSH 别名、bare 路径 |
| 7 | [20-windows-setup.md](20-windows-setup.md) | Windows：Git、换行、远端顺序 |
| 8 | [30-mac-epix-setup.md](30-mac-epix-setup.md) | epix：裸仓、SSH、launchd 镜像推送 |
| 9 | [50-sourcetree.md](50-sourcetree.md) | SourceTree 与系统 Git 对齐 |
| 10 | [70-docs-migration-map.md](70-docs-migration-map.md) | `docs/` 参考文与定稿章节对照 |
| 11 | [06-github-branch-protection.md](06-github-branch-protection.md) | GitHub 分支保护与 epix 主从一致 |
| 12 | [90-process-log.md](90-process-log.md) | 进程记录模板与 Tailscale/SSH 验证清单 |

## 模板与脚本

- [templates/gitconfig.windows.main.ini](templates/gitconfig.windows.main.ini)
- [templates/gitconfig.mac.main.ini](templates/gitconfig.mac.main.ini)
- [templates/gitconfig.fragment.agent.ini.example](templates/gitconfig.fragment.agent.ini.example)
- [scripts/gitnet-push-github.sh](scripts/gitnet-push-github.sh)（复制到 epix `~/bin/` 使用）

## 仓库内 Agent 约定

见仓库根目录 [AGENTS.md](../AGENTS.md) 与 [.cursor/rules/](../.cursor/rules/)。

## GitHub 从镜像（只读灾备展示）

- HTTPS：<https://github.com/epix99-opus/GitNet>

日常协作 **push/pull 以 epix 裸仓为准**；向 GitHub 的更新由 epix 侧定时任务执行（见 [30-mac-epix-setup.md](30-mac-epix-setup.md)）。
