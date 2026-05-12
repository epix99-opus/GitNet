# Windows：Git 与远端

## 1. 安装校验

PowerShell：

```powershell
git --version
where.exe git
```

建议安装 [Git for Windows](https://git-scm.com/download/win)。后续 SourceTree 与 Cursor 的「Git 可执行文件」应指向**同一** `git.exe`（见 [50-sourcetree.md](50-sourcetree.md)）。

## 2. 换行符

本仓库策略（与维护方案一致）：

```powershell
git config --global core.autocrlf true
```

macOS/epix 使用 `input`；见 [30-mac-epix-setup.md](30-mac-epix-setup.md) 侧说明。不要在 Windows 上复制 Mac 的 `autocrlf` 值。

## 3. 人类身份（全局兜底）

```powershell
git config --global user.name "epix99-opus"
git config --global user.email "epix99@icloud.com"
```

若 GitHub 显示名与登录名不同，以你**希望在提交历史显示的人类名**为准，与 GitHub 账号保持一致性即可。

## 4. includeIf 与 Agent 片段

编辑 `%USERPROFILE%\.gitconfig`，从 [templates/gitconfig.windows.main.ini](templates/gitconfig.windows.main.ini) 复制结构；Agent 规则见 [40-identity-and-includeIf.md](40-identity-and-includeIf.md)。

## 5. 克隆与工作流

1. 确保 Tailscale 已连接，且 [45-ssh-tailscale-for-humans.md](45-ssh-tailscale-for-humans.md) 中 SSH 已通。
2. 克隆（示例，`git-epix` 与路径替换为实值）：

```powershell
cd $env:USERPROFILE\src
git clone git@git-epix:/srv/git/GitNet.git GitNet
cd GitNet
```

3. 可选添加只读 GitHub 远端：

```powershell
git remote add github git@github.com:epix99-opus/GitNet.git
git fetch github
```

4. **默认 push 目标**应为 epix（`origin`），不要日常 `push github` 以免与「GitHub 为从」策略冲突。

## 6. 自检

```powershell
git config --show-origin --list | findstr user
ssh -T git@git-epix
ssh -T git@github.com
```
