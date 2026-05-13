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
- 变更摘要：在 `E:\DEV\GitNet` 已执行 `git remote add origin https://github.com/epix99-opus/GitNet.git`（此前无 remote）；分支已为 `main`。因 Cursor 集成终端对 **HTTPS 推送** 常阻塞在 **Git Credential Manager** 交互（浏览器/弹窗），Agent 侧 **非交互 push 未完成**。
- 涉及信源：`handbook/90-process-log.md`、本地 `.git/config`
- 回顾：人类请在 **本机 PowerShell/cmd（可弹出凭据）** 或 **SourceTree** 中执行下方「人类一步」完成验收；若任务管理器中有卡住的 `git.exe`，可结束后再推。
- 验收：`git ls-remote origin refs/heads/main` 能列出远端提交且与本地 `main` 一致；GitHub 网页可见 `main` 历史。

**人类一步（复制执行）**：

```powershell
cd E:\DEV\GitNet
git remote -v
git push -u origin main
```

若提示登录：使用 GitHub 账号 + PAT（或已配置的凭据管理器）。完成后将本段「验收」勾为已完成并填日期。

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
