# 给非技术用户：Tailscale、SSH 与「地址」是什么

若克隆地址里 `git@` 后面的主机名不确定，先问团队是否在 `handbook/22-glab-tailscale-epix-remote.md` 写了 **Glab** 的 MagicDNS（Windows 节点）。

## 一句话

你在 SourceTree 里要填的「仓库地址」，技术同学会整理成一条类似：

`git@git-epix:/srv/git/GitNet.git`

你只要**整行复制粘贴**；其中 **`git-epix`** 是昵称，**`/srv/git/GitNet.git`** 是 epix 电脑上的文件夹位置（裸仓库）。

## Tailscale 是什么（在本项目里干什么用）

- 让你的 Windows、多台 Mac 像在同一个「虚拟局域网」里，**用机器名互相找到**，不必把家里的公网 IP 暴露出去。
- 装好 Tailscale 并登录同一账号后，每台设备会有一个 **MagicDNS 名字**（像 `epix` 或 `epix.your-tailnet.ts.net`，以你控制台显示为准）。这个名字相当于「在虚拟局域网里的门牌号」。

## SSH 里的三个词

| 词 | 通俗意思 | 你要做什么 |
|----|----------|------------|
| **Host 别名**（如 `git-epix`） | 通讯录里的「快捷名称」，在 `~/.ssh/config`（Mac）或 `C:\Users\你\.ssh\config`（Windows）里配置 | 不用自己编；让技术同学在配置文件里写好，你记住克隆地址里 `@` 后面到 `:` 之前的那一段 |
| **路径**（如 `/srv/git/GitNet.git`） | epix 磁盘上裸仓库文件夹的**全路径** | 同样整段由技术同学提供；若迁移目录，只改这一处 |
| **用户**（常为 `git`） | SSH 登录到「专门提供 Git 服务」的账户名 | 克隆 URL 里 `git@` 的 `git` 一般不要改 |

## 技术同学会为你准备什么

1. 在 epix 上建好 **bare** 目录，并把**完整路径**写进 [90-process-log.md](90-process-log.md)。
2. 在你本机 `~/.ssh/config` 或 Windows 的 `.ssh\config` 写入类似：

```text
Host git-epix
    HostName epix.your-tailnet.ts.net
    User 你的Mac登录名
    IdentityFile ~/.ssh/id_ed25519_epix
```

（`HostName` 用 Tailscale DNS；`User` 若是多用户共享 bare 可能用 `git` 专用账户，以实际为准。）

3. 给你一条 **克隆 URL** 用于 SourceTree： `git@git-epix:/srv/git/GitNet.git`

## 和 GitHub 的关系

- **日常写代码、提交、推送**：对着 **epix**（局域网快）。
- **GitHub**：备份和在没连 Tailscale 时查看；主线更新由 epix 定时推到 GitHub，你一般**不用**每天自己对 GitHub 点推送。

## 怎么确认「通了」

让技术同学帮你在终端执行（或你自己复制运行）：

```bash
ssh -T git@git-epix
```

第一次会问是否信任指纹，输入 `yes`；成功会显示有 shell 或 Git 相关提示（依服务器配置而定）。再按 [20-windows-setup.md](20-windows-setup.md) 克隆。
