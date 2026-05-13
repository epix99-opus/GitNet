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
| 6 | [55-multi-node-multi-agent-git.md](55-multi-node-multi-agent-git.md) | **epix / glab / woot** 多节点 × Cursor/Codex/Claude 的 Git 身份总表与 `includeIf` 顺序 |
| 7 | [45-ssh-tailscale-for-humans.md](45-ssh-tailscale-for-humans.md) | 非技术向：Tailscale 机器名、SSH 别名、bare 路径 |
| 8 | [46-tailscale-remote-git-identity.md](46-tailscale-remote-git-identity.md) | epix→woot/glab：Tailscale SSH 落地 Git 片段与 `~/.ssh/config` 约定 |
| 9 | [22-glab-tailscale-epix-remote.md](22-glab-tailscale-epix-remote.md) | **Glab（Windows）本机 Tailscale 事实**与 epix 远程边界（与 46 互补：事实表 + 能力边界） |
| 10 | [20-windows-setup.md](20-windows-setup.md) | Windows：Git、换行、远端顺序 |
| 11 | [30-mac-epix-setup.md](30-mac-epix-setup.md) | epix：裸仓、SSH、launchd 镜像推送 |
| 12 | [50-sourcetree.md](50-sourcetree.md) | SourceTree 与系统 Git 对齐 |
| 13 | [70-docs-migration-map.md](70-docs-migration-map.md) | `docs/` 参考文与定稿章节对照 |
| 14 | [06-github-branch-protection.md](06-github-branch-protection.md) | GitHub 分支保护与 epix 主从一致 |
| 15 | [90-process-log.md](90-process-log.md) | 进程记录模板与 Tailscale/SSH 验证清单 |
| 16 | [91-glab-handoff-epix-ssh-verify.md](91-glab-handoff-epix-ssh-verify.md) | **Handoff**：需 glab 配合的 epix→glab SSH/Git 验收（见 GitHub Issue） |

## 模板与脚本

- [templates/gitconfig.windows.main.ini](templates/gitconfig.windows.main.ini)
- [templates/gitconfig.mac.main.ini](templates/gitconfig.mac.main.ini)
- [templates/gitconfig.fragment.agent.ini.example](templates/gitconfig.fragment.agent.ini.example)
- [templates/windows-glab-git-includeIf.ps1](templates/windows-glab-git-includeIf.ps1)（在 **glab 本机** PowerShell 执行，配置 `glab-*` 片段）
- [templates/epix-ssh-config-glab.fragment.conf](templates/epix-ssh-config-glab.fragment.conf)（合并到 epix `~/.ssh/config`；`User` 当前为 **GG**）
- [scripts/gitnet-push-github.sh](scripts/gitnet-push-github.sh)（复制到 epix `~/bin/` 使用）
- [scripts/setup-glab-openssh-for-epix.ps1](scripts/setup-glab-openssh-for-epix.ps1)（**glab 管理员**：OpenSSH + 防火墙 22 + `authorized_keys`）
- [scripts/91-glab-section-A-evidence.ps1](scripts/91-glab-section-A-evidence.ps1)（生成 §A 证据文本）
- [scripts/post-issue1-github-comment.ps1](scripts/post-issue1-github-comment.ps1)（需 `GITHUB_TOKEN`，向 Issue #1 发帖）
- [published/issue-1-glab-evidence-comment.md](published/issue-1-glab-evidence-comment.md)（glab §A 证据快照，可粘贴到 Issue）

## 仓库内 Agent 约定

见仓库根目录 [AGENTS.md](../AGENTS.md) 与 [.cursor/rules/](../.cursor/rules/)。

## GitHub 从镜像（只读灾备展示）

- HTTPS：<https://github.com/epix99-opus/GitNet>

日常协作 **push/pull 以 epix 裸仓为准**；向 GitHub 的更新由 epix 侧定时任务执行（见 [30-mac-epix-setup.md](30-mac-epix-setup.md)）。
