# 身份与 includeIf

## 原则

- **人类兜底**（`~/.gitconfig` / `%USERPROFILE%\.gitconfig` 顶层 `[user]`）：`user.name` 与 `user.email` **与 GitHub 账号一致**（当前组织/用户：`epix99-opus`，邮箱：`epix99@icloud.com`；若 GitHub 显示名不同，以你账号设置为准，但需与「人类提交」一致）。
- **Agent 工作区**：通过 `includeIf "gitdir:...路径/"` 加载片段，**作者名** `HOSTNAME-TOOL`，**邮箱** 固定 `epix99@icloud.com`。
- **优先级**：仓库 `--local` > `includeIf` > 全局 `[user]`。除非有特殊需求，避免在仓库内再写 `user.*`，以免盖住 includeIf。

## `gitdir` 路径注意

- 条件路径建议**以斜杠结尾**，与 Git 文档惯例一致，例如 `gitdir:~/agent-work/cursor/`。
- Windows：`includeIf` 中可使用 `C:/...` 形式，片段 `path` 同样使用正斜杠较稳妥。

## 模板位置

| 文件 | 用途 |
|------|------|
| [templates/gitconfig.windows.main.ini](templates/gitconfig.windows.main.ini) | Windows 主配置 |
| [templates/gitconfig.mac.main.ini](templates/gitconfig.mac.main.ini) | macOS 主配置 |
| [templates/gitconfig.fragment.agent.ini.example](templates/gitconfig.fragment.agent.ini.example) | Agent 片段示例 |

## 自检命令

在**人类**常用仓库目录：

```bash
git config --show-origin user.name
git config --show-origin user.email
```

在 **Agent 工作区** 克隆的仓库内应看到片段文件路径为来源；在人类目录下应看到全局 `.gitconfig` 为来源。

## HOSTNAME 与 TOOL 命名

- **HOSTNAME**：与团队约定的机器短名一致（epix 上可为 `epix`）；避免空格与特殊符号。
- **TOOL**：`cursor`、`codex`、`claude-code` 等，全小写、短横线连接。

多编程节点（epix / glab / woot）与多工具并列时的 **`includeIf` 顺序与目录约定** 见 [55-multi-node-multi-agent-git.md](55-multi-node-multi-agent-git.md)。
