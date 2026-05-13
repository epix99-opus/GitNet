# 从 Glab（Windows）将已有 GitNet 推送到 GitHub

在 **Glab** 上打开 **PowerShell** 或 **cmd**，进入你本地的 GitNet 项目根目录（含 `.git` 的目录），按需替换路径。

## 若该目录已是 Git 仓库

```powershell
cd D:\Dev\GitNet
git remote -v
```

若尚无 `origin` 或 origin 不是 GitHub：

```powershell
git remote remove origin 2>$null
git remote add origin https://github.com/epix99-opus/GitNet.git
git branch -M main
git push -u origin main
```

若远端已有提交（例如在 Mac 上已推送过 README），先拉再推：

```powershell
git pull origin main --rebase
git push -u origin main
```

## 若该目录还不是 Git 仓库

```powershell
cd D:\Dev\GitNet
git init
git add .
git commit -m "chore: initial import from Glab"
git remote add origin https://github.com/epix99-opus/GitNet.git
git branch -M main
git push -u origin main
```

完成后在 Mac 上 `/Users/epix/Dev/NetGit` 执行 `git pull origin main` 即可对齐。

**注意**：请勿将密钥、Token、私钥提交进仓库；敏感项用本机 secret 或 SOPS（见 NetOps `docs/SOPS.md`）。
