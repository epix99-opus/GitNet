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

## 7. PowerShell 脚本与文本编码（GitNet `handbook/scripts`）

本仓库在 **glab** 上执行的 **Windows PowerShell 5.1**（`powershell.exe`，非 **PowerShell 7** `pwsh`）对脚本**源文件编码**敏感：

- **含中文**的 `.ps1` 须保存为 **UTF-8 带 BOM**（UTF-8 with BOM）。无 BOM 时，5.1 常按**当前代码页**（简体中文 Windows 多为 **GBK**）误读 UTF-8 字节流，导致 **ParserError**（例如「意外的标记 `}`」「意外的标记 `else`」），**与逻辑是否写对无关**。
- **维护方式**：用 VS Code / Cursor 打开脚本 → 右下角编码 → **Save with Encoding** → **UTF-8 with BOM**；或合并前用工具检查文件头为 **`EF BB BF`**。
- **PowerShell 7+**：对 UTF-8 无 BOM 更宽容；若团队统一用 `pwsh` 跑脚本，仍建议带 BOM，以免他人用 5.1 误跑。
- **交叉引用**：epix→glab 全流程见 [46-tailscale-remote-git-identity.md](46-tailscale-remote-git-identity.md) §3.1；`ssh-keyscan` / macOS 见同文 §3.3 与 [91-glab-handoff-epix-ssh-verify.md](91-glab-handoff-epix-ssh-verify.md) §B。

## 8. glab（GG）：GitHub 走 SSH + GitHub CLI（`gh`）

目标：**`ssh -T git@github.com` 成功**，且 **`gh auth status` 已登录**；本仓库 `origin` 使用 `git@github.com:epix99-opus/GitNet.git`。

1. **一键准备**（管理员不必，普通 PowerShell 即可）：在 GitNet 克隆根执行  
   `.\handbook\scripts\setup-glab-github-ssh-and-gh.ps1 -GitNetWorkdirWin 'E:\DEV\GitNet'`  
   会：按需 `winget` 安装 **GitHub CLI**、生成 **`%USERPROFILE%\.ssh\id_ed25519_github`**、在 **`%USERPROFILE%\.ssh\config`** 增加 `Host github.com`（`IdentitiesOnly yes`）、`ssh-keyscan github.com` 写入 `known_hosts`、将 **`origin` 改为 SSH URL**。
2. **人类一步（浏览器 OAuth）**：在新窗口或本机执行  
   `& 'C:\Program Files\GitHub CLI\gh.exe' auth login --hostname github.com --git-protocol ssh --web`  
   按浏览器完成登录（凭据进系统凭据库，**勿**把 token 写入仓库）。
3. **把公钥登记到 GitHub 账户**（二选一）：  
   - 登录后执行：  
     `gh ssh-key add $env:USERPROFILE\.ssh\id_ed25519_github.pub -t "glab-GG-windows"`  
   - 或打开 <https://github.com/settings/ssh/new>，粘贴 **`id_ed25519_github.pub` 整行**。
4. **验收**：`ssh -T git@github.com` 出现成功提示；`git ls-remote origin HEAD` 能列出远端提交。

**私钥**仅保留在 **`%USERPROFILE%\.ssh\`**，永不提交进 Git。若曾用 HTTPS `origin` 且希望保留备用远端，可自行 `git remote add github https://github.com/epix99-opus/GitNet.git`。
