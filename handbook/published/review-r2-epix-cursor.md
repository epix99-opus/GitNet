# R2 整仓深度评审（epix · Cursor）

> **母单**：[GitHub Issue #16](https://github.com/epix99-opus/GitNet/issues/16) · **协作模式**：[98-gitnet-deep-review-round2-git-bus.md](../98-gitnet-deep-review-round2-git-bus.md)

## 范围

本轮在 **`/Users/epix/Dev/GitNet`** 静态阅读：`handbook/`（含 `published/`、`scripts/`）、`templates/`、`.cursor/rules/`、根 `AGENTS.md`、`CONTRIBUTING.md`、`README.md`；未改业务代码路径。

## 结论摘要

1. **信源链完整**：`00`→`10`→`55`→`90`/`97`/`98` 与根 `AGENTS` 对齐；GitHub PR 闸 + bare `ff-only` 在 `30`/`56`/`CONTRIBUTING` 中多处互链，副机读者不易迷路。
2. **`98` 补位恰当**：把 R2「信令 / L1 / relay」从聊天拉回定稿，与 `94` RACI、`93` §7 并列，降低多轮复盘时的口头漂移。
3. **Windows 侧近期增量合理**：`20` §8 与 `setup-glab-github-ssh-and-gh.ps1` 将「glab 直推」从不可执行变为**可脚本化 + 人类一步登录**，与 Issue #11 中继经验闭合。
4. **`.cursor` 面仍薄**：仅 `rules/gitnet-collaboration.mdc`；若团队扩大，可考虑与 `AGENTS` 重复的段落改为「指针 + 单一真源」避免双写漂移（P2）。
5. **`published/` 体量增长**：R1/R2 系列稿与 inventory 并存，建议在 `94` 或 `README` 增加「按主题检索」一行索引（P2），非阻塞。

## 问题与风险

| 级别 | 项 |
|------|-----|
| **P0** | 未发现阻塞合入或与安全铁律（密钥不进仓）冲突的项。 |
| **P1** | 整仓评审依赖「人类是否真在副机路径提交」；若仅 epix 代写会稀释多节点意义——**须**坚持 `55` 路径 + Issue #16 分支表。 |
| **P2** | 部分 `handbook/scripts` 假设 epix 路径（`$HOME/git/...`）；跨机复制命令时需读者自行替换（可在 `30` 再强调一句）。 |

## 建议

- **可执行**：合入各 `review-r2-*.md` 后跑一次 `gitnet-sync-github-main-to-bare.sh` 并在 `90` 写 PR 号（见 `98` §5）。
- **需人类决策**：是否在 GitHub 为 R2 类任务设 **label**（如 `review-r2`）以便筛选；非必须。

## 无问题项（显式确认）

- `set -euo pipefail` 在主要 bash 运维脚本中为常态（抽样 `handbook/scripts/*.sh`）。
- 根 `CONTRIBUTING` 对 PR→`main` 的表述与 `10`「本仓例外」一致。
- `AGENTS.md` 对「硬边界交接格式」与 `98` relay 描述不冲突。

## 修订记录

| 日期 | 摘要 |
|------|------|
| 2026-05-14 | R2 epix-cursor 首稿（Issue #16）。 |
