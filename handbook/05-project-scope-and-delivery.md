# 项目定义、交付边界与「会话 → 手册」闭环

本文把**人类初始意图**、**GitNet 仓库自身定位**、以及「哪些写进手册、哪些走执行闭环」固定为定稿，避免结论只留在某次对话里。

## GitNet 是什么（元项目）

- **不是**某一业务应用的产品代码仓为主目标。
- **是**一套面向 **Tailscale 局域网内多 Mac + 多编程 Agent + 人类** 的 **Git 与协作治理** 的承载仓库：拓扑、身份、备份、手册、脚本模板、进程记录、Cursor 规则等。

## 人类最终要求（从《人类初始指令》归纳）

1. **可运行的多设备 / 多 Agent Git 体系**（含 SourceTree 与人类可操作路径）。
2. **epix 与 GitHub 的主从备份与日常同步**（已定稿为 epix 权威、GitHub 从镜像）。
3. **可治理的人机协同**：规则、skills、计划与迭代、交付后回顾、归并文档、清理无效物、**唯一信源**。
4. **持续维护**：多节点、多 Agent 的 Git 规则、方案、**进程记录**。
5. **铁律**：Agent 能判断执行的不得回抛人类；必须人类时须原因 + 操作提示（并已在 Cursor User Rules 与本仓库 `AGENTS.md` 落地）。

## 上次会话结论：哪些应文档化，哪些应「方案 → 评审 → 执行 → 验收」

以下按**性质**分类（与「当时是否已写入仓库」无关；**空白处已由本次提交补全**，见下文「验收」）。

| 会话内容 | 归类 | 应落在何处 |
|----------|------|------------|
| 对人类最终意图、GitNet 元项目定义、最佳实践原则 | **文档化** | 本文 + 必要时链到 [00-truth-sources.md](00-truth-sources.md)、[07-documentation-placement.md](07-documentation-placement.md)、[10-topology.md](10-topology.md) |
| 「已完成 / 未完成」对照表 | **文档化** | 本文「交付状态」；机器实值仍以 [90-process-log.md](90-process-log.md) 为准 |
| 对人类的具体建议（重启 Cursor、填表、分支保护、dotfiles） | **文档化（作检查清单）** | 本文「人类检查清单」；执行动作由责任方按清单做 |
| Windows / Mac 实配 Git、SSH、克隆、推送 | **方案 → 执行 → 验收** | 执行照 [20-windows-setup.md](20-windows-setup.md)、[30-mac-epix-setup.md](30-mac-epix-setup.md)；验收用其中自检命令 + [90-process-log.md](90-process-log.md) 表格 |
| epix launchd 定时推 GitHub | **方案 → 执行 → 验收** | [30-mac-epix-setup.md](30-mac-epix-setup.md) + 日志验收 |
| SourceTree 指向与远端 | **方案 → 执行 → 验收** | [50-sourcetree.md](50-sourcetree.md)；验收以能 fetch/push 为准 |
| GitHub 分支保护策略 | **方案 →（人类/管理员）执行 → 验收** | Agent 若无令牌/权限则无法代点 GitHub UI；**方案**可写进本文或另开短章 |
| 「Agent 最佳实践文献综述」 | **文档化（可选增强）** | 尚未单独立篇；若需要，后续增补 `handbook/25-agent-practices-notes.md` 或外链列表 |

## 交付状态（仓库内资产 vs 机上实装）

| 状态 | 内容 |
|------|------|
| **已在仓库内交付** | `handbook/` 全套、`AGENTS.md`、`.cursor/rules/`、模板与脚本、对照表、进程模板 |
| **已在人类本机执行（历史动作）** | Cursor `aicontext.personalContext` 追加铁律（见 `AGENTS.md` 中说明与备份路径） |
| **仍依赖各机 / 账号执行** | bare 初始化、SSH、launchd、SourceTree 点选、GitHub 保护规则、`90-process-log` 填实值 |

## 人类检查清单（可复制为工单）

1. 重启 Cursor 一次（User Rules 存储变更后习惯上更稳妥）。
2. 指派一人填写 [90-process-log.md](90-process-log.md) 中 Tailscale / SSH / bare 实值并完成表中命令验证。
3. 在 GitHub 上对主线配置与 epix 策略一致的**分支保护**（避免绕过 epix 直推）——步骤见 [06-github-branch-protection.md](06-github-branch-protection.md)。
4. （可选）另建 **dotfiles** 仓同步 `.gitconfig` 片段与 `ssh/config` 模板路径（不含私钥）。

## 会话结论的验收标准（针对「你做了吗」）

- **仅口头回复、未进手册**：不满足本项目「唯一信源」要求，视为**未完成文档化**。
- **本文件存在且 `handbook/README.md` 已链接**：视为会话中「应文档化」部分已完成**落盘验收**。
- **机上实装**：以各机执行 playbook 与 `90-process-log` 打勾为验收，**不由单条会话代替**。

## 修订记录

- 2026-05-12：首次写入，承接「人类用户最终要求 / 项目定义 / 文档 vs 执行 / 是否已写入仓库」类会话结论的归并。
