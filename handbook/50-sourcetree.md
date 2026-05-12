# SourceTree 与系统 Git 对齐

## 为什么和 handbook 写在一起

SourceTree 是**人类**用的图形客户端；与 Cursor/CLI 共用**同一套** Git 与 SSH，才能避免「终端里是一种作者，图形里是另一种」的混乱。

## Windows 设置清单

1. **选项 → Git**：选择「使用系统 Git」或指向与 `where git` 一致的 `git.exe`。
2. **选项 → SSH 客户端**：优先 **OpenSSH**（与 `~/.ssh` / `C:\Users\你\.ssh` 一致）；若用内置 PuTTY，需自行转换密钥，本手册默认 OpenSSH。
3. **克隆 / 添加仓库**：
   - **首选远端**：epix bare，URL 形态见 [45-ssh-tailscale-for-humans.md](45-ssh-tailscale-for-humans.md)（`git@git-epix:...`）。
   - **可选第二个远端** `github`：仅用于拉取或演练，勿作为日常默认推送目标（见 [10-topology.md](10-topology.md)）。
4. **提交时作者信息**：在未单独配置仓库本地 `user` 的前提下，SourceTree 会使用全局 `.gitconfig`；Agent 目录下仓库应命中 `includeIf`，请在对应仓库目录用终端执行 `git config --show-origin user.name` 验证。

## macOS 设置清单

1. SourceTree **偏好设置 → Git**：指定与终端一致的 Git。
2. **SSH**：使用系统 `ssh` 与 `~/.ssh/config` 中的 `Host` 别名克隆 `git@git-epix:...`。

## 常见现象

- **克隆失败：Permission denied (publickey)**：SSH 密钥未加入 epix 的 `authorized_keys`，或 `IdentityFile` 指错；见 SSH 手册与运维同学排查。
- **推送到了 GitHub 而非 epix**：检查「默认远端」与当前分支的上游（upstream）绑定。
