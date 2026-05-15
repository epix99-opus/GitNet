# 可外推资产目录（`reuse/CATALOG`）

**Raw URL 基座**（`main` 分支，只读）：`https://raw.githubusercontent.com/epix99-opus/GitNet/main/`  
表中 **Raw** 列为 **完整 URL**；外仓若用 subtree/submodule，以 pin 的 revision 替换 `main`。

**外引建议** 缩写：`Raw` = 链 Raw；`sub` = subtree/submodule；`copy` = 一次性拷贝（须附来源 SHA，见 [vendor/README.md](vendor/README.md)）。

---

## 仓根契约与 Cursor 规则

| 名称 | 适用场景 | 权威路径 | Raw URL | 外引建议 |
|------|----------|----------|---------|----------|
| Agent 与人类铁律、DoD、上抛格式 | 任何托管 Agent 的仓库 | `AGENTS.md` | https://raw.githubusercontent.com/epix99-opus/GitNet/main/AGENTS.md | Raw / 摘条款号入自家 `AGENTS` + SHA |
| 人类贡献与 PR 闸说明 | GitHub 合入流程 | `CONTRIBUTING.md` | https://raw.githubusercontent.com/epix99-opus/GitNet/main/CONTRIBUTING.md | Raw |
| GitNet 协作 Cursor 规则 | 本仓 Cursor 会话 | `.cursor/rules/gitnet-collaboration.mdc` | https://raw.githubusercontent.com/epix99-opus/GitNet/main/.cursor/rules/gitnet-collaboration.mdc | Raw；外仓复制 frontmatter 思路时改 `globs` |
| `reuse` 外推包 Cursor 规则 | 改 `reuse/` 或写外引文档 | `.cursor/rules/gitnet-reuse-pack.mdc` | https://raw.githubusercontent.com/epix99-opus/GitNet/main/.cursor/rules/gitnet-reuse-pack.mdc | Raw |

---

## 治理、愿景、范围、信源

| 名称 | 适用场景 | 权威路径 | Raw URL | 外引建议 |
|------|----------|----------|---------|----------|
| 信源与冲突处理 | 多文档并存时谁说了算 | `handbook/00-truth-sources.md` | https://raw.githubusercontent.com/epix99-opus/GitNet/main/handbook/00-truth-sources.md | Raw |
| 项目范围与交付 | 边界、里程碑 | `handbook/05-project-scope-and-delivery.md` | https://raw.githubusercontent.com/epix99-opus/GitNet/main/handbook/05-project-scope-and-delivery.md | Raw |
| Agent-first 协作愿景 | 方法论背景 | `handbook/08-agent-first-collaboration-vision.md` | https://raw.githubusercontent.com/epix99-opus/GitNet/main/handbook/08-agent-first-collaboration-vision.md | Raw |
| 文档放置规则（含 `reuse/` 指针） | 定稿 vs 草稿 | `handbook/07-documentation-placement.md` | https://raw.githubusercontent.com/epix99-opus/GitNet/main/handbook/07-documentation-placement.md | Raw |
| 文档迁移地图 | 旧路径到新路径 | `handbook/70-docs-migration-map.md` | https://raw.githubusercontent.com/epix99-opus/GitNet/main/handbook/70-docs-migration-map.md | Raw |
| 进程与验证日志（时间序） | 运维/变更留痕 | `handbook/90-process-log.md` | https://raw.githubusercontent.com/epix99-opus/GitNet/main/handbook/90-process-log.md | 外仓建等价物；思路 Raw |

---

## 身份、Git CLI、多 Agent

| 名称 | 适用场景 | 权威路径 | Raw URL | 外引建议 |
|------|----------|----------|---------|----------|
| 身份与 `includeIf` | 人机多身份分流 | `handbook/40-identity-and-includeIf.md` | https://raw.githubusercontent.com/epix99-opus/GitNet/main/handbook/40-identity-and-includeIf.md | Raw |
| 多节点多 Agent Git | 总览 | `handbook/55-multi-node-multi-agent-git.md` | https://raw.githubusercontent.com/epix99-opus/GitNet/main/handbook/55-multi-node-multi-agent-git.md | Raw |
| Git 栈 vs OS Git | 版本坑 | `handbook/52-gitnet-git-stack-vs-os-git.md` | https://raw.githubusercontent.com/epix99-opus/GitNet/main/handbook/52-gitnet-git-stack-vs-os-git.md | Raw |
| Git CLI 与 git-graph | 日常命令 | `handbook/51-git-cli-and-git-graph-user-guide.md` | https://raw.githubusercontent.com/epix99-opus/GitNet/main/handbook/51-git-cli-and-git-graph-user-guide.md | Raw |
| 多 Agent 与 `main` / Agent 文件 | 分支策略讨论 | `handbook/53-multi-agent-main-branch-and-agent-files.md` | https://raw.githubusercontent.com/epix99-opus/GitNet/main/handbook/53-multi-agent-main-branch-and-agent-files.md | Raw |

---

## 拓扑、GitHub、工作流质量

| 名称 | 适用场景 | 权威路径 | Raw URL | 外引建议 |
|------|----------|----------|---------|----------|
| 拓扑（bare / 镜像 / PR 例外） | 组织 Git 拓扑 | `handbook/10-topology.md` | https://raw.githubusercontent.com/epix99-opus/GitNet/main/handbook/10-topology.md | Raw；**禁止**照搬 bare 路径 |
| GitHub 分支保护 | `main` 保护 | `handbook/06-github-branch-protection.md` | https://raw.githubusercontent.com/epix99-opus/GitNet/main/handbook/06-github-branch-protection.md | Raw |
| 工作流质量与实践 | PR、提交信息 | `handbook/56-git-workflow-quality-practices.md` | https://raw.githubusercontent.com/epix99-opus/GitNet/main/handbook/56-git-workflow-quality-practices.md | Raw |
| GitHub 自动同步协作 | 定时同步叙事 | `handbook/92-github-auto-sync-collaboration.md` | https://raw.githubusercontent.com/epix99-opus/GitNet/main/handbook/92-github-auto-sync-collaboration.md | Raw |

---

## Tailscale、SSH、远端机

| 名称 | 适用场景 | 权威路径 | Raw URL | 外引建议 |
|------|----------|----------|---------|----------|
| Tailscale + 远端 Git + 身份 | 跨机 Git | `handbook/46-tailscale-remote-git-identity.md` | https://raw.githubusercontent.com/epix99-opus/GitNet/main/handbook/46-tailscale-remote-git-identity.md | Raw |
| SSH + Tailscale（人类向） | 人类操作 | `handbook/45-ssh-tailscale-for-humans.md` | https://raw.githubusercontent.com/epix99-opus/GitNet/main/handbook/45-ssh-tailscale-for-humans.md | Raw |
| glab Tailscale epix 远端 | 场景专章 | `handbook/22-glab-tailscale-epix-remote.md` | https://raw.githubusercontent.com/epix99-opus/GitNet/main/handbook/22-glab-tailscale-epix-remote.md | Raw |
| 远端 CAMA on epix | 工作流 | `handbook/54-remote-work-cama-on-epix-from-other-nodes.md` | https://raw.githubusercontent.com/epix99-opus/GitNet/main/handbook/54-remote-work-cama-on-epix-from-other-nodes.md | Raw |

---

## Handoff、证据、多机 RACI、Playbook

| 名称 | 适用场景 | 权威路径 | Raw URL | 外引建议 |
|------|----------|----------|---------|----------|
| glab Handoff + epix SSH 验证 | 跨机交接 | `handbook/91-glab-handoff-epix-ssh-verify.md` | https://raw.githubusercontent.com/epix99-opus/GitNet/main/handbook/91-glab-handoff-epix-ssh-verify.md | Raw |
| Phase 结论与跨仓 Git Playbook（**§7** 方法论） | 阶段收口、外推 | `handbook/93-gitnet-phase-conclusion-and-cross-collab-git-playbook.md` | https://raw.githubusercontent.com/epix99-opus/GitNet/main/handbook/93-gitnet-phase-conclusion-and-cross-collab-git-playbook.md | Raw |
| 多机 Agent 盘点 RACI 与配置矩阵 | 大表方法论 | `handbook/94-multi-node-agent-inventory-raci-and-config-matrix.md` | https://raw.githubusercontent.com/epix99-opus/GitNet/main/handbook/94-multi-node-agent-inventory-raci-and-config-matrix.md | Raw |

---

## 交付物、BestGit、深评

| 名称 | 适用场景 | 权威路径 | Raw URL | 外引建议 |
|------|----------|----------|---------|----------|
| BestGit 组织模板与推广 | 组织级 Git 模板（**不**镜像全文入 `reuse`） | `handbook/96-bestgit-org-template-and-rollout.md` | https://raw.githubusercontent.com/epix99-opus/GitNet/main/handbook/96-bestgit-org-template-and-rollout.md | Raw |
| GitNet v0.1 交付物 | 历史交付包说明 | `handbook/97-initial-gitnet-v0.1-deliverable.md` | https://raw.githubusercontent.com/epix99-opus/GitNet/main/handbook/97-initial-gitnet-v0.1-deliverable.md | Raw |
| Deep review round2 Git bus | 架构评审记录 | `handbook/98-gitnet-deep-review-round2-git-bus.md` | https://raw.githubusercontent.com/epix99-opus/GitNet/main/handbook/98-gitnet-deep-review-round2-git-bus.md | Raw |

---

## 环境与桌面工具

| 名称 | 适用场景 | 权威路径 | Raw URL | 外引建议 |
|------|----------|----------|---------|----------|
| Windows 设置 | glab 等 | `handbook/20-windows-setup.md` | https://raw.githubusercontent.com/epix99-opus/GitNet/main/handbook/20-windows-setup.md | Raw |
| Mac epix 设置 | 本机开发 | `handbook/30-mac-epix-setup.md` | https://raw.githubusercontent.com/epix99-opus/GitNet/main/handbook/30-mac-epix-setup.md | Raw |
| SourceTree | GUI 使用 | `handbook/50-sourcetree.md` | https://raw.githubusercontent.com/epix99-opus/GitNet/main/handbook/50-sourcetree.md | Raw |

---

## `handbook/templates/`（模板资产）

| 名称 | 适用场景 | 权威路径 | Raw URL | 外引建议 |
|------|----------|----------|---------|----------|
| Agent `gitconfig` 片段示例 | `includeIf` 片段起点 | `handbook/templates/gitconfig.fragment.agent.ini.example` | https://raw.githubusercontent.com/epix99-opus/GitNet/main/handbook/templates/gitconfig.fragment.agent.ini.example | copy 或 sub；改路径 |
| Mac `gitconfig` 主片段 | 人类 Mac | `handbook/templates/gitconfig.mac.main.ini` | https://raw.githubusercontent.com/epix99-opus/GitNet/main/handbook/templates/gitconfig.mac.main.ini | copy + 本地改写 |
| Windows `gitconfig` 主片段 | 人类 Windows | `handbook/templates/gitconfig.windows.main.ini` | https://raw.githubusercontent.com/epix99-opus/GitNet/main/handbook/templates/gitconfig.windows.main.ini | copy + 本地改写 |
| epix SSH `glab` 片段 | SSH config 片段 | `handbook/templates/epix-ssh-config-glab.fragment.conf` | https://raw.githubusercontent.com/epix99-opus/GitNet/main/handbook/templates/epix-ssh-config-glab.fragment.conf | copy |
| epix 部署公钥（单行信源） | `authorized_keys` | `handbook/templates/epix-id_ed25519.pub` | https://raw.githubusercontent.com/epix99-opus/GitNet/main/handbook/templates/epix-id_ed25519.pub | Raw |
| launchd：GitHub→bare 同步 | macOS 定时 | `handbook/templates/com.gitnet.sync-github-to-bare.plist` | https://raw.githubusercontent.com/epix99-opus/GitNet/main/handbook/templates/com.gitnet.sync-github-to-bare.plist | copy；改 `ProgramArguments` |
| launchd：watch GitHub | macOS 定时 | `handbook/templates/com.gitnet.watch-github.plist` | https://raw.githubusercontent.com/epix99-opus/GitNet/main/handbook/templates/com.gitnet.watch-github.plist | copy |
| Windows `includeIf` 辅助 PS1 | Windows 身份 | `handbook/templates/windows-glab-git-includeIf.ps1` | https://raw.githubusercontent.com/epix99-opus/GitNet/main/handbook/templates/windows-glab-git-includeIf.ps1 | copy |
| watch GitHub 同步 PS1 | Windows 调度配套 | `handbook/templates/gitnet-watch-github-sync.ps1` | https://raw.githubusercontent.com/epix99-opus/GitNet/main/handbook/templates/gitnet-watch-github-sync.ps1 | copy |

---

## `handbook/scripts/`（脚本·自动化）

| 名称 | 适用场景 | 权威路径 | Raw URL | 外引建议 |
|------|----------|----------|---------|----------|
| GitHub `main` → bare `ff-only` | PR 闸后对齐 bare | `handbook/scripts/gitnet-sync-github-main-to-bare.sh` | https://raw.githubusercontent.com/epix99-opus/GitNet/main/handbook/scripts/gitnet-sync-github-main-to-bare.sh | sub / copy；先 `GITNET_SYNC_DRY_RUN=1` |
| watch + 同步 shell | 与 plist 配套 | `handbook/scripts/gitnet-watch-github-sync.sh` | https://raw.githubusercontent.com/epix99-opus/GitNet/main/handbook/scripts/gitnet-watch-github-sync.sh | sub / copy |
| push `github` remote | 人类/Agent 推送 | `handbook/scripts/gitnet-push-github.sh` | https://raw.githubusercontent.com/epix99-opus/GitNet/main/handbook/scripts/gitnet-push-github.sh | copy |
| 多 Agent retro preflight | 发 retro 前检查 | `handbook/scripts/gitnet-multi-agent-retro-preflight.sh` | https://raw.githubusercontent.com/epix99-opus/GitNet/main/handbook/scripts/gitnet-multi-agent-retro-preflight.sh | copy |
| R2 scope 列表 | 评审范围 | `handbook/scripts/gitnet-r2-scope-list.sh` | https://raw.githubusercontent.com/epix99-opus/GitNet/main/handbook/scripts/gitnet-r2-scope-list.sh | copy |
| v0.1 rollout 打印检查 | 清单打印 | `handbook/scripts/gitnet-v0.1-rollout-print-checks.sh` | https://raw.githubusercontent.com/epix99-opus/GitNet/main/handbook/scripts/gitnet-v0.1-rollout-print-checks.sh | copy |
| 提交信息改写（中文等） | 历史清理（慎用） | `handbook/scripts/gitnet-rewrite-commit-messages-zh.sh` | https://raw.githubusercontent.com/epix99-opus/GitNet/main/handbook/scripts/gitnet-rewrite-commit-messages-zh.sh | copy；高风险须审批 |
| setup glab GitHub SSH + gh | Windows 一站 | `handbook/scripts/setup-glab-github-ssh-and-gh.ps1` | https://raw.githubusercontent.com/epix99-opus/GitNet/main/handbook/scripts/setup-glab-github-ssh-and-gh.ps1 | copy |
| setup glab OpenSSH for epix | Windows OpenSSH | `handbook/scripts/setup-glab-openssh-for-epix.ps1` | https://raw.githubusercontent.com/epix99-opus/GitNet/main/handbook/scripts/setup-glab-openssh-for-epix.ps1 | copy |
| append epix pubkey → Administrators authorized_keys | 域管机 | `handbook/scripts/append-epix-pubkey-to-administrators-authorized_keys.ps1` | https://raw.githubusercontent.com/epix99-opus/GitNet/main/handbook/scripts/append-epix-pubkey-to-administrators-authorized_keys.ps1 | copy |
| append epix pubkey → local authorized_keys | 本机 | `handbook/scripts/append-epix-pubkey-to-local-authorized_keys.ps1` | https://raw.githubusercontent.com/epix99-opus/GitNet/main/handbook/scripts/append-epix-pubkey-to-local-authorized_keys.ps1 | copy |
| post Issue #1 GitHub comment | 自动化评论 | `handbook/scripts/post-issue1-github-comment.ps1` | https://raw.githubusercontent.com/epix99-opus/GitNet/main/handbook/scripts/post-issue1-github-comment.ps1 | copy；须 token 环境变量 |
| 91 Handoff §A 证据采集 | Handoff 证据 | `handbook/scripts/91-glab-section-A-evidence.ps1` | https://raw.githubusercontent.com/epix99-opus/GitNet/main/handbook/scripts/91-glab-section-A-evidence.ps1 | copy |

---

## `handbook/published/`（已定稿对外证据 / 方法论样例）

| 名称 | 适用场景 | 权威路径 | Raw URL | 外引建议 |
|------|----------|----------|---------|----------|
| R2 评审结论汇总 | 决策记录 | `handbook/published/gitnet-r2-review-conclusions.md` | https://raw.githubusercontent.com/epix99-opus/GitNet/main/handbook/published/gitnet-r2-review-conclusions.md | Raw |
| 协作 closeout 状态 | 状态面 | `handbook/published/collaboration-closeout-status.md` | https://raw.githubusercontent.com/epix99-opus/GitNet/main/handbook/published/collaboration-closeout-status.md | Raw |
| Issue #1 glab 证据评论 | Issue 证据范式 | `handbook/published/issue-1-glab-evidence-comment.md` | https://raw.githubusercontent.com/epix99-opus/GitNet/main/handbook/published/issue-1-glab-evidence-comment.md | Raw |
| inventory 机器模板 | 新开机器表 | `handbook/published/inventory-machine-TEMPLATE.md` | https://raw.githubusercontent.com/epix99-opus/GitNet/main/handbook/published/inventory-machine-TEMPLATE.md | copy 到自家仓库改名 |
| epix inventory starter | 样例 | `handbook/published/inventory-epix-starter.md` | https://raw.githubusercontent.com/epix99-opus/GitNet/main/handbook/published/inventory-epix-starter.md | Raw |
| epix enumerated agent inventory | 完整枚举样例 | `handbook/published/inventory-epix-enumerated-agent.md` | https://raw.githubusercontent.com/epix99-opus/GitNet/main/handbook/published/inventory-epix-enumerated-agent.md | Raw |
| glab enumerated agent inventory | 完整枚举样例 | `handbook/published/inventory-glab-enumerated-agent.md` | https://raw.githubusercontent.com/epix99-opus/GitNet/main/handbook/published/inventory-glab-enumerated-agent.md | Raw |
| woot enumerated agent inventory | 完整枚举样例 | `handbook/published/inventory-woot-enumerated-agent.md` | https://raw.githubusercontent.com/epix99-opus/GitNet/main/handbook/published/inventory-woot-enumerated-agent.md | Raw |
| review R2 epix Cursor | 评审记录 | `handbook/published/review-r2-epix-cursor.md` | https://raw.githubusercontent.com/epix99-opus/GitNet/main/handbook/published/review-r2-epix-cursor.md | Raw |
| review R2 epix Claude Code | 评审记录 | `handbook/published/review-r2-epix-claude-code.md` | https://raw.githubusercontent.com/epix99-opus/GitNet/main/handbook/published/review-r2-epix-claude-code.md | Raw |
| review R2 epix Codex | 评审记录 | `handbook/published/review-r2-epix-codex.md` | https://raw.githubusercontent.com/epix99-opus/GitNet/main/handbook/published/review-r2-epix-codex.md | Raw |
| review R2 glab Cursor | 评审记录 | `handbook/published/review-r2-glab-cursor.md` | https://raw.githubusercontent.com/epix99-opus/GitNet/main/handbook/published/review-r2-glab-cursor.md | Raw |
| review R2 woot Cursor | 评审记录 | `handbook/published/review-r2-woot-cursor.md` | https://raw.githubusercontent.com/epix99-opus/GitNet/main/handbook/published/review-r2-woot-cursor.md | Raw |
| retro multi-agent glab 2026-05 | Retro 样例 | `handbook/published/retro-multi-agent-glab-2026-05.md` | https://raw.githubusercontent.com/epix99-opus/GitNet/main/handbook/published/retro-multi-agent-glab-2026-05.md | Raw |
| retro multi-agent woot 2026-05 | Retro 样例 | `handbook/published/retro-multi-agent-woot-2026-05.md` | https://raw.githubusercontent.com/epix99-opus/GitNet/main/handbook/published/retro-multi-agent-woot-2026-05.md | Raw |

---

## `reuse/` 包自身（外推入口）

| 名称 | 适用场景 | 权威路径 | Raw URL | 外引建议 |
|------|----------|----------|---------|----------|
| `reuse` 人类与 Agent 入口 | 外项目了解包 | `reuse/README.md` | https://raw.githubusercontent.com/epix99-opus/GitNet/main/reuse/README.md | Raw |
| 外仓 Agent 强制阅读 | 强约束 | `reuse/AGENT_MUST_READ.md` | https://raw.githubusercontent.com/epix99-opus/GitNet/main/reuse/AGENT_MUST_READ.md | Raw |
| 本目录 | 资产表 | `reuse/CATALOG.md` | https://raw.githubusercontent.com/epix99-opus/GitNet/main/reuse/CATALOG.md | Raw |
| 外项目接入清单 | 勾选 onboarding | `reuse/BOOTSTRAP_OTHER_REPO.md` | https://raw.githubusercontent.com/epix99-opus/GitNet/main/reuse/BOOTSTRAP_OTHER_REPO.md | Raw |
| vendor 物理拷贝说明 | 拷贝边界 | `reuse/vendor/README.md` | https://raw.githubusercontent.com/epix99-opus/GitNet/main/reuse/vendor/README.md | Raw |

---

## 不纳入本表（防范围爆炸）

- **`docs/`** 草稿整体：晋升路径见 `handbook/07`；单篇稳定外推后再入 `handbook` 并补一行于此表。  
- **BestGit / CAMA 外链仓库全文**：仅用 `96`/`97` 与本仓 `54` 作指针；不镜像。
