# 内容落盘规则（已定稿）

本文约定：**各类信息写入仓库的哪一目录/文件**，与 [00-truth-sources.md](00-truth-sources.md) 的信源层级一致；冲突时仍以 `00` 为准。

## 判别（先问一句）

在落笔前先归类：

| 类型 | 含义 | 落点 |
|------|------|------|
| **事实** | 拓扑、路径、主机名、远端 URL、可复现命令与验收标准 | `handbook/` 对应章节 |
| **过程** | 某次迁移、冲突处理、验证结果、例外与日期 | [90-process-log.md](90-process-log.md) |
| **草稿 / 调研** | 未定稿对照、思路、长文参考 | `docs/`；定稿后按 [70-docs-migration-map.md](70-docs-migration-map.md) 并入 `handbook/` 或删冗余，避免双权威长期并存 |

## 落盘矩阵（执行用）

| 内容类型 | 落盘位置 | 说明 |
|----------|----------|------|
| 拓扑、SSH、bare 路径、默认 push 目标、launchd、分支与保护策略 | `handbook/` 中 [10-topology.md](10-topology.md)、[30-mac-epix-setup.md](30-mac-epix-setup.md)、[20-windows-setup.md](20-windows-setup.md)、[06-github-branch-protection.md](06-github-branch-protection.md) 等 | 同一主题只维护一处，其它文档**链接**指向，禁止在 `docs/` 或根 `README` 重复写易变事实。 |
| 某次操作、冲突、验证、GitHub 例外流程 | [90-process-log.md](90-process-log.md) | 时间序 + 可验收摘要；与 AGENTS.md 中「例外须记录」一致。 |
| 参考稿、未定稿讨论、对照表草稿 | `docs/` | 定稿迁移路径见 [70-docs-migration-map.md](70-docs-migration-map.md)。 |
| Agent / 人类行为契约（铁律、完成定义、禁止项） | 根目录 [AGENTS.md](../AGENTS.md) 与 [.cursor/rules/](../.cursor/rules/) | **原则级**；多节点多工具的 Git 作者与 `includeIf` 总表见 [55-multi-node-multi-agent-git.md](55-multi-node-multi-agent-git.md)。具体路径与命令仍以 `handbook/` 其它章节为准，不反向复制长段拓扑进规则文件。 |
| **纯网络层**事实（IP、端口、Tailscale 节点表、局域网脚本事实源） | **NetOps** 仓库的 `configs/network_facts.env` 及该仓 Runbook | GitNet **不复制**一份易过期的 IP/端口表；本仓仅保留指向说明（见下节）。 |
| 人类口述的长期意图与叙事 | [人类初始指令.md](../人类初始指令.md) | **不承载**具体路径与密钥；与 `handbook/` / `00` 冲突时以定稿信源为准，并在进程日志或本文修订记录中注明。 |

## 与 NetOps 的边界

- **NetOps** 为个人/小团队的 **局域网与 Tailscale 运维事实源**（独立 git 仓库；本机常见路径示例：`~/Dev/NetOps`，以你机器为准）。
- GitNet 若需引用「glab / epixnas 等 Tailscale IP」，应链接或文字指向 NetOps 的 `configs/network_facts.env` 及 `docs/SOURCE_OF_TRUTH.md`，**不在 GitNet 内维护第二份网络事实表**。
- 若某事实同时属于「Git 拓扑」与「网络地址」：**Git 角色与 bare 路径**仍在 GitNet `handbook/`；**IP/端口**在 NetOps。

## 修订记录

- 2026-05-12：首次写入，落实「同意后续落盘建议」的定稿。
