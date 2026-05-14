# GitNet Handbook（定稿）

本目录为 **GitNet** 仓库运维与多机协作的**唯一定稿信源**。环境事实、拓扑与操作步骤以本手册为准。

**北极星（项目本意）**：[08-agent-first-collaboration-vision.md](08-agent-first-collaboration-vision.md) — Agent 驱动开发的 **Git 宗旨与可外推框架**（全局规定、全生命周期 × Git、主分支/特性分支、多 Agent 信源仲裁）、最大化 Agent 可执行范围、全链路认证（公钥 + 经 OS/机外安全存储的口令/PAT）、**凭据明文不进 Git/Issue**；与 [AGENTS.md](../AGENTS.md) 一致。**组织模板仓（BestGit）**：[96-bestgit-org-template-and-rollout.md](96-bestgit-org-template-and-rollout.md)。**阶段结论成果**：[93-gitnet-phase-conclusion-and-cross-collab-git-playbook.md](93-gitnet-phase-conclusion-and-cross-collab-git-playbook.md)。

## 阅读顺序

| 顺序 | 文档 | 说明 |
|------|------|------|
| 1 | [00-truth-sources.md](00-truth-sources.md) | 信源层级、冲突处理规则 |
| 2 | [05-project-scope-and-delivery.md](05-project-scope-and-delivery.md) | 项目定义、交付边界、会话结论归并、人类检查清单 |
| 3 | [08-agent-first-collaboration-vision.md](08-agent-first-collaboration-vision.md) | **北极星** + **Git 宗旨与全生命周期框架** + **全链路认证**：全局 Git 规定、阶段×分支矩阵、多 Agent 信源仲裁；Agent 优先；公钥默认优先；凭据明文不进 Git/Issue |
| 4 | [07-documentation-placement.md](07-documentation-placement.md) | **内容落盘规则**：事实 / 过程 / 草稿各写何处；与 NetOps 网络事实源边界 |
| 5 | [10-topology.md](10-topology.md) | epix 权威裸仓、GitHub 从镜像、各端角色；**多设备 × 多 Agent 时 bare 为写集成与默认 push 汇合点的目标规范与最优实现** |
| 6 | [40-identity-and-includeIf.md](40-identity-and-includeIf.md) | 人类兜底与 Agent 作者名、`includeIf` 模板 |
| 7 | [55-multi-node-multi-agent-git.md](55-multi-node-multi-agent-git.md) | **epix / glab / woot** 多节点 × Cursor/Codex/Claude 的 Git 身份总表与 `includeIf` 顺序 |
| 8 | [45-ssh-tailscale-for-humans.md](45-ssh-tailscale-for-humans.md) | 非技术向：Tailscale 机器名、SSH 别名、bare 路径 |
| 9 | [46-tailscale-remote-git-identity.md](46-tailscale-remote-git-identity.md) | epix→woot/glab：Tailscale SSH 落地 Git 片段与 `~/.ssh/config` 约定 |
| 10 | [22-glab-tailscale-epix-remote.md](22-glab-tailscale-epix-remote.md) | **Glab（Windows）本机 Tailscale 事实**与 epix 远程边界（与 46 互补：事实表 + 能力边界） |
| 11 | [20-windows-setup.md](20-windows-setup.md) | Windows：Git、换行、远端顺序 |
| 12 | [30-mac-epix-setup.md](30-mac-epix-setup.md) | epix：裸仓、SSH、launchd 镜像推送 |
| 13 | [50-sourcetree.md](50-sourcetree.md) | SourceTree 与系统 Git 对齐 |
| 14 | [70-docs-migration-map.md](70-docs-migration-map.md) | `docs/` 参考文与定稿章节对照 |
| 15 | [06-github-branch-protection.md](06-github-branch-protection.md) | GitHub 分支保护与 epix 主从一致 |
| 16 | [90-process-log.md](90-process-log.md) | 进程记录模板与 Tailscale/SSH 验证清单 |
| 17 | [91-glab-handoff-epix-ssh-verify.md](91-glab-handoff-epix-ssh-verify.md) | **Handoff**：需 glab 配合的 epix→glab SSH/Git 验收（见 GitHub Issue） |
| 18 | [92-github-auto-sync-collaboration.md](92-github-auto-sync-collaboration.md) | **备选 · Git 数据面**：GitHub 双端轮询/`ff-only` 拉取；与 OpenClaw/Hermes **并行互备**关系见文内对比 |
| 19 | [93-gitnet-phase-conclusion-and-cross-collab-git-playbook.md](93-gitnet-phase-conclusion-and-cross-collab-git-playbook.md) | **阶段成果**：目标→方案→实现回顾；epix/glab Cursor Agent 协作复盘；**可外推**的大型多跨协作 Git 体系 · 规范 · 流程清单 |
| 20 | [94-multi-node-agent-inventory-raci-and-config-matrix.md](94-multi-node-agent-inventory-raci-and-config-matrix.md) | **三机盘点与 RACI**：工具清单、仓库表模板、纳入分层（L1～L3）、全局/项目配置矩阵；模板 [published/inventory-machine-TEMPLATE.md](published/inventory-machine-TEMPLATE.md) |
| 21 | [96-bestgit-org-template-and-rollout.md](96-bestgit-org-template-and-rollout.md) | **BestGit 组织模板仓**：分层 Git 方案归档、三节点周知入口、新开仓清单与 `bestgit-doctor`；独立仓库路径与建议 GitHub 镜像 |
| 22 | [52-gitnet-git-stack-vs-os-git.md](52-gitnet-git-stack-vs-os-git.md) | **体系 vs 系统 Git**：本栈叠加层（bare、includeIf、Tailscale、镜像角色）与特别价值 |
| 23 | [53-multi-agent-main-branch-and-agent-files.md](53-multi-agent-main-branch-and-agent-files.md) | **多 Agent × 主分支 × 根配置**：`AGENTS.md`/`CLAUDE.md` 等与合并冲突关系；`includeIf` 不解决冲突 |
| 24 | [54-remote-work-cama-on-epix-from-other-nodes.md](54-remote-work-cama-on-epix-from-other-nodes.md) | **副机在 epix 上干 CAMA**：Remote-SSH、SSH+CLI、副机克隆三模式与前置条件 |
| 25 | [51-git-cli-and-git-graph-user-guide.md](51-git-cli-and-git-graph-user-guide.md) | **人类操作**：Git CLI 最小闭环、冲突处理、`git log --graph`、Cursor/VS Code **Git Graph** 扩展 |
| 26 | [56-git-workflow-quality-practices.md](56-git-workflow-quality-practices.md) | **工作流质量**：约定式提交、小步与 `add -p`、特性分支与 PR、**`rebase -i` 边界**、分支清理；**元仓 vs 业务仓**分层 |

## 模板与脚本

- [templates/gitconfig.windows.main.ini](templates/gitconfig.windows.main.ini)
- [templates/gitconfig.mac.main.ini](templates/gitconfig.mac.main.ini)
- [templates/gitconfig.fragment.agent.ini.example](templates/gitconfig.fragment.agent.ini.example)
- [templates/windows-glab-git-includeIf.ps1](templates/windows-glab-git-includeIf.ps1)（在 **glab 本机** PowerShell 执行，配置 `glab-*` 片段）
- [templates/epix-ssh-config-glab.fragment.conf](templates/epix-ssh-config-glab.fragment.conf)（合并到 epix `~/.ssh/config`；`User` 当前为 **GG**）
- [templates/epix-id_ed25519.pub](templates/epix-id_ed25519.pub)（**epix→glab SSH 公钥单行信源**；`setup-glab-openssh-for-epix.ps1` 默认读取 / 亦可 `-EpixPublicKeyLine`；勿从聊天手抄；轮换后更新并 push，再通知 glab 更新 `authorized_keys`）
- [scripts/gitnet-watch-github-sync.sh](scripts/gitnet-watch-github-sync.sh)（epix：`launchd` 轮询 `origin`，`ff-only` 合并；见 `92`）
- [templates/gitnet-watch-github-sync.ps1](templates/gitnet-watch-github-sync.ps1)（glab：计划任务轮询）
- [templates/com.gitnet.watch-github.plist](templates/com.gitnet.watch-github.plist)（epix `LaunchAgents` 示例，间隔秒见 plist 内 `StartInterval`）
- [scripts/setup-glab-openssh-for-epix.ps1](scripts/setup-glab-openssh-for-epix.ps1)（**glab 管理员**：OpenSSH + 防火墙 22 + 用户 `authorized_keys` + 若属 Administrators 则 **`ProgramData\ssh\administrators_authorized_keys`**；脚本须 **UTF-8 带 BOM** 以便 PowerShell 5.1 正确解析中文，见 `20` §7）
- [scripts/append-epix-pubkey-to-local-authorized_keys.ps1](scripts/append-epix-pubkey-to-local-authorized_keys.ps1)（**glab 当前用户**：仅将定稿公钥行追加到 `%USERPROFILE%\.ssh\authorized_keys`，无需管理员；幂等；**若账户在 Administrators 组会提示另跑管理员脚本**）
- [scripts/append-epix-pubkey-to-administrators-authorized_keys.ps1](scripts/append-epix-pubkey-to-administrators-authorized_keys.ps1)（**glab 管理员**：写入 `C:\ProgramData\ssh\administrators_authorized_keys`，解决 `Match Group administrators` 下 BatchMode 公钥失败）
- [scripts/91-glab-section-A-evidence.ps1](scripts/91-glab-section-A-evidence.ps1)（生成 §A 证据文本）
- [scripts/post-issue1-github-comment.ps1](scripts/post-issue1-github-comment.ps1)（需 `GITHUB_TOKEN`，向 Issue #1 发帖）
- [published/collaboration-closeout-status.md](published/collaboration-closeout-status.md)（**T1～T5 收口表**：谁在等谁）
- [published/issue-1-glab-evidence-comment.md](published/issue-1-glab-evidence-comment.md)（glab §A 证据快照，可粘贴到 Issue）
- [published/inventory-machine-TEMPLATE.md](published/inventory-machine-TEMPLATE.md)（**三机 Git 仓库盘点表模板**；见 `94`）
- [published/inventory-epix-starter.md](published/inventory-epix-starter.md)（epix 上 **GitNet 一行示例**，完整盘点见 `inventory-epix-enumerated-agent`）
- [published/inventory-epix-enumerated-agent.md](published/inventory-epix-enumerated-agent.md)（**epix** 本机 `~/Dev` + `~/agent-work` 枚举表）
- [published/inventory-woot-enumerated-agent.md](published/inventory-woot-enumerated-agent.md)（**woot**，经 `ssh woot@woot`）
- [published/inventory-glab-enumerated-agent.md](published/inventory-glab-enumerated-agent.md)（**glab**，经 `ssh glab` + PowerShell）

## 仓库内 Agent 约定

见仓库根目录 [AGENTS.md](../AGENTS.md) 与 [.cursor/rules/](../.cursor/rules/)。

## GitHub 从镜像（只读灾备展示）

- HTTPS：<https://github.com/epix99-opus/GitNet>

日常协作 **push/pull 以 epix 裸仓为准**；向 GitHub 的更新由 epix 侧定时任务执行（见 [30-mac-epix-setup.md](30-mac-epix-setup.md)）。**例外（对齐通知面）**：当提交已由任一端 **push 到 GitHub `main`**（例如 glab/Agent 收口文档后），需要与 glab 同树的 **epix 工作副本**若将 **GitHub** 设为拉取远端，应执行 **`git pull`** 载入同一提交；若以 **bare** 为唯一写入口，在 epix 将 GitHub 变更 **并入 bare** 后再从 bare 分发，详见 [90-process-log.md](90-process-log.md) 当日「文档收口」条。
