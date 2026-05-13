# epix 机 — 盘点表（starter：仅 GitNet 一行示例）

> **全量枚举**：见同目录 [inventory-epix-enumerated-agent.md](inventory-epix-enumerated-agent.md)（Agent 本机 `find` 生成）。

> **说明**：本文件为 **epix** 上在 GitNet 仓库内执行 §5.4 命令的 **示例一行**；**完整盘点**请复制 [inventory-machine-TEMPLATE.md](inventory-machine-TEMPLATE.md) 为 `inventory-epix.md` 并枚举 `~/Dev`、`~/agent-work` 下全部仓库。`origin` 为 GitHub 表示与 [10-topology.md](../10-topology.md) 目标规范对照下为 **过渡态**（可在 `90-process-log.md` 登记迁回 bare）。

## 主机元数据

| 字段 | 填写 |
|------|------|
| **主机名（Tailscale）** | epix |
| **OS** | macOS |
| **填写人 / 日期** | Agent starter / 2026-05-12（工具行已实机探测） |

## 已安装的编程 Agent 工具（实机）

| 工具 | 已安装？（是/否） | 主要工作目录（若适用） |
|------|------------------|------------------------|
| Cursor | 是（`/Applications/Cursor.app`；CLI 见 `inventory-epix-enumerated-agent`） | `/Users/epix/Dev/GitNet` |
| Codex CLI | 是（`/usr/local/bin/codex`） | `/Users/epix/Dev/CodexDev/`（约定，见 `94`） |
| Claude Code | 是（`~/.local/bin/claude`） | `~/agent-work/claude-code/`（约定，见 `55`/`94`） |

## 仓库清单（示例一行）

| 仓库根路径 | 当前分支 | `origin` URL（可脱敏） | `origin` 是否 bare 目标 | `user.name` 来源片段 | 命中 Agent？ | 最后提交（一行） | 备注 |
|------------|----------|------------------------|-------------------------|----------------------|-------------|------------------|------|
| `/Users/epix/Dev/GitNet` | main | `https://github.com/epix99-opus/GitNet.git` | 否（GitHub） | `~/.gitconfig-fragment-cursor` | cursor | `14d3099 2026-05-13 … docs(93)` | 与 `10` 目标：迁 `origin` → bare 后登记 `90` |

## 修订记录

- 2026-05-12：Codex / Claude Code 行改为实机探测结果；与 `inventory-epix-enumerated-agent` 探测节一致。
- 2026-05-13：starter 行（GitNet），其余待人类补全。
