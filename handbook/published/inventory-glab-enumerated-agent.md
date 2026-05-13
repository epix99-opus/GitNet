# glab — Git 仓库枚举（Agent 经 Tailscale SSH）

> **生成方式**：从 **epix** 执行 `ssh -o BatchMode=yes glab 'powershell …'` 枚举含 `.git` 的目录，再对各目录 `git` 查询（见 [94](../94-multi-node-agent-inventory-raci-and-config-matrix.md) §5.6）。**扫描根**：`E:\Dev`、`%USERPROFILE%\agent-work`（深度 4）。

**生成日期**：2026-05-13

## 仓库表

| 路径 | 分支 / 状态 | `origin` | `user.name`（摘要） |
|------|---------------|----------|---------------------|
| `E:\Dev\GitNet` | main | `https://github.com/epix99-opus/GitNet.git` | `C:/Users/GG/.gitconfig-fragment-cursor` → **`glab-cursor`** |
| `E:\Dev\3399` | 空仓库 / 无提交（`HEAD` 不可用） | *(无)* | `C:/Users/GG/.gitconfig` → **`Epix`**（**未**命中 `glab-*`；应按 `55` §3.3 增加覆盖 `E:/Dev/` 或该路径的 `includeIf`，或明确本仓为人类维护并记入 `90`） |

## 修订记录

- 2026-05-13：首版枚举（epix → `glab` SSH + PowerShell）。
