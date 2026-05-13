# 进程记录与实施验证

## 进程记录模板（复制下面一块追加写入）

```text
### YYYY-MM-DD — 标题
- 参与：人类 / Agent（工具名）
- 变更摘要：
- 涉及信源：handbook 章节 / AGENTS / 代码路径
- 回顾：是否清理临时文件、是否与其它文档冲突
```

---

## 已记录条目

### 2026-05-12 — 仓库初始化与手册交付（Agent）

- 参与：Agent（Cursor）
- 变更摘要：工作区原为「非 git 目录」；已 `git init`、`.gitignore`（排除 `.specstory/`）、根 `README.md` 指向 `handbook/`；新增 `handbook/06-github-branch-protection.md`；`handbook/README` 索引更新。
- 涉及信源：`handbook/*`、`AGENTS.md`、`.cursor/rules`、`.gitignore`、`README.md`
- 回顾：未提交密钥；`.specstory` 不纳入版本库。待人类：`git remote add` 指向 epix 或 GitHub 后首次 push。
- 验收：本地 `git log` 可见首条 root 提交 `f895f55`；后续文档修补以 `git log` 为准；远程 push 以人类网络环境为准。

### 2026-05-13 — Windows 配置 GitHub origin（人类已同意阶段 A）

- 参与：人类（书面同意）/ Agent（Cursor）
- 变更摘要：在 `E:\DEV\GitNet` 已执行 `git remote add origin https://github.com/epix99-opus/GitNet.git`（此前无 remote）；分支已为 `main`。后续非交互 `git push`（任务 970081）**退出码 1**：`! [rejected] main -> main (fetch first)` —— **远端 `main` 已有本地没有的提交**（例如 Mac 先推过 README），需先 **`git pull origin main --rebase`** 再 **`git push -u origin main`**。PowerShell 将 Git 的 stderr 显示为 `NativeCommandError` 属常见现象，可忽略类型只看 Git 原文。
- 涉及信源：`handbook/90-process-log.md`、本地 `.git/config`
- 回顾：人类在本机可交互终端执行下方命令；若仍有凭据弹窗，用 GitHub 账号 + PAT 或凭据管理器完成。
- 验收：`git ls-remote origin refs/heads/main` 与本地 `main` 顶提交一致；GitHub 网页可见完整历史。

**人类一步（复制执行）**：

```powershell
cd E:\DEV\GitNet
git remote -v
git pull origin main --rebase
git push -u origin main
```

若提示登录：使用 GitHub 账号 + PAT（或已配置的凭据管理器）。完成后将本段「验收」勾为已完成并填日期。

### 2026-05-13 — rebase 冲突解决并推送至 GitHub（Agent，Glab）

- 参与：Agent（Cursor）
- 变更摘要：`git pull origin main --rebase` 在 **`.gitignore`**、**`README.md`** 发生 add/add 冲突。已手工合并：`.gitignore` 含 Mac 侧（`.DS_Store`、`.env*`、密钥后缀）与 Glab 侧（`.specstory/`、`.tmp_*.py`）；`README.md` 以 `handbook` 为信源描述主从，并保留 Mac/Windows 工作路径示例。rebase 完成后已执行 **`git push -u origin main`**，`main` 已与 `origin/main` 对齐（顶提交以 `git log -1` 为准）。
- 验收：GitHub 网页 `main` 可见完整手册与 `handbook/`；Mac `/Users/epix/Dev/GitNet` 可 `git pull origin main` 快进。

---

## Tailscale / SSH / epix 实施验证清单

在 epix 与至少一台客户端（Windows 或其它 Mac）上完成下列项后，将**实值**填在第二列表格，并在底部「验证记录」签字或记日期。

### 待填实值

| 项 | 填写值 |
|----|--------|
| epix Tailscale MagicDNS（`HostName`） | |
| SSH `Host` 别名（建议 `git-epix`） | |
| SSH 登录用户（`User`） | |
| bare 全路径（例 `/srv/git/GitNet.git`） | |
| 克隆 URL（`git@...:...`） | |
| launchd 是否已 `load` | 是 / 否 |
| 首次 `git -C <bare> push github` 是否成功 | 是 / 否 |

### 命令验证（由技术角色执行）

在**客户端**：

```bash
ssh -T git@git-epix
# 将 git-epix 替换为表内 Host 别名
```

在 **epix**（有权限用户）：

```bash
git -C /你的/bare路径.git remote -v
git -C /你的/bare路径.git push github --dry-run
```

### 验证记录

| 日期 | 执行人 | 结果 |
|------|--------|------|
| | | |

---

## 已知占位说明

- GitHub 仓库 URL：<https://github.com/epix99-opus/GitNet>
- 在未填实值前，人类可按 [45-ssh-tailscale-for-humans.md](45-ssh-tailscale-for-humans.md) 将本页表格交给技术同学一次性填回。
