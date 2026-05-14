# glab — Git 仓库枚举（Agent 经 Tailscale SSH）

> **生成方式**：从 **epix** 执行 `ssh -o BatchMode=yes glab 'powershell …'` 枚举含 `.git` 的目录，再对各目录 `git` 查询（见 [94](../94-multi-node-agent-inventory-raci-and-config-matrix.md) §5.6）。**扫描根**：`E:\Dev`、`%USERPROFILE%\agent-work`（深度 4）。

**生成日期**：2026-05-13

## 编程 Agent 工具（实机探测）

> **探测日期**：2026-05-12（首版）；**2026-05-14** 经 **epix** `ssh -o BatchMode=yes glab` **复测**（BestGit 落盘同批）；远端 **`cmd.exe` / PowerShell**：`where.exe`。

| 工具 | 结论 | 证据（可复跑） |
|------|------|----------------|
| **Cursor** | 已安装 | `where cursor` → `C:\Users\GG\AppData\Local\Programs\cursor\resources\app\bin\cursor`（及 `.cmd`）；`%LOCALAPPDATA%\Programs\cursor\Cursor.exe` 存在 |
| **Codex CLI** | **未**在 PATH 发现 | `where codex` 退出码 1（未找到） |
| **Claude Code** | 已安装 | `where claude` → `C:\Users\GG\.local\bin\claude.exe` |

## 仓库表

| 路径 | 分支 / 状态 | `origin` | `user.name`（摘要） |
|------|---------------|----------|---------------------|
| `E:\Dev\GitNet` | main | `https://github.com/epix99-opus/GitNet.git` | `C:/Users/GG/.gitconfig-fragment-cursor` → **`glab-cursor`** |
| `E:\Dev\3399` | 空仓库 / 无提交（`HEAD` 不可用） | *(无)* | `C:/Users/GG/.gitconfig` → **`Epix`**（**未**命中 `glab-*`；应按 `55` §3.3 增加覆盖 `E:/Dev/` 或该路径的 `includeIf`，或明确本仓为人类维护并记入 `90`） |
| `E:\Dev\BestGit` | main | `https://github.com/epix99-opus/BestGit.git` | `C:/Users/GG/.gitconfig` → **`Epix`**（新克隆；可按 `55` 将 `E:/Dev/BestGit` 纳入 fragment 以使用 **`glab-cursor`**） |

## 修订记录

- 2026-05-14：编程 Agent **复测**（结论同前：`where.exe cursor` / `claude`；`codex` 未命中）；登记 **`E:\Dev\BestGit`**（按 BestGit `docs/rollout-epix-glab-woot.md` 克隆）。
- 2026-05-12：增补「编程 Agent 工具」实机探测（`where` 输出摘要）。
- 2026-05-13：首版枚举（epix → `glab` SSH + PowerShell）。
