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
- 验收：本地 `git log -1` 可见首条提交（当前：`f895f55`）；远程 push 以人类网络环境为准。


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
