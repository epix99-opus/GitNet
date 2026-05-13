# epix — Git 仓库枚举（Agent 本机 + 可经 SSH 复跑）

> **生成方式**：本机 `find` `~/Dev`、`~/agent-work` 下 `.git` 目录，对每个顶层执行 `git branch --show-current`、`git remote get-url origin`、`git config --show-origin user.name`（见 [94](../94-multi-node-agent-inventory-raci-and-config-matrix.md) §5.5～§5.6）。**不含**私钥与 token。

**生成日期**：2026-05-13

## 仓库表

| 路径 | 分支 | `origin` | `user.name`（摘要） |
|------|------|----------|---------------------|
| `/Users/epix/Dev/CAMA/CAMA-codex-start` | main | *(无)* | `~/.gitconfig-fragment-cursor` → **epix-cursor** |
| `/Users/epix/Dev/CAMA/CAMA-concept` | CAMA_Cursor | *(无)* | **epix-cursor** |
| `/Users/epix/Dev/CodexDev/SelfEvo/paseo` | main | `https://github.com/getpaseo/paseo.git` | `~/.gitconfig-fragment-codex` → **epix-codex** |
| `/Users/epix/Dev/GitNet` | main | `https://github.com/epix99-opus/GitNet.git` | **epix-cursor** |
| `/Users/epix/Dev/Hermes` | main | *(无)* | **epix-cursor** |
| `/Users/epix/Dev/Hermes/cama-hermes-front-harness` | main | *(无)* | **epix-cursor** |
| `/Users/epix/Dev/NetOps` | main | *(无)* | **epix-cursor** |
| `/Users/epix/Dev/TraeDev/contabo` | cursor_dev | `git@github.com:epix99-opus/EpixNetwork.git` | **epix-cursor** |
| `/Users/epix/Dev/UOC` | main | *(无)* | **epix-cursor** |
| `/Users/epix/Dev/UniNode` | main | *(无)* | **epix-cursor** |
| `/Users/epix/Dev/UniNode/3399/.build/rkbin` | master | `https://github.com/rockchip-linux/rkbin.git` | **epix-cursor** |
| `/Users/epix/Dev/UniNode/3399/.build/rkdeveloptool` | master | `https://github.com/rockchip-linux/rkdeveloptool.git` | **epix-cursor** |
| `/Users/epix/Dev/open-design` | main | `https://github.com/nexu-io/open-design.git` | **epix-cursor** |

## 与 [10-topology.md](../10-topology.md) 的对照（摘要）

- 表中 **`origin` 为 GitHub 或其它远端** 的仓库：相对「**写集成在 epix bare**」目标，属 **L2 待对齐** 或已登记例外；请在 [90-process-log.md](../90-process-log.md) 按需记录迁移动作。
- **`(无) origin`**：可能为纯本地或后续再绑 remote；不视为已纳入对象层规范。

## 修订记录

- 2026-05-13：首版全表（Agent 本机枚举）。
