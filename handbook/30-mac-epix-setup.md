# epix Mac：权威裸仓、SSH、launchd 向 GitHub 镜像

## 1. 路径约定（团队填实值后写入 [90-process-log.md](90-process-log.md)）

建议在 epix 上使用**固定路径**，例如：

- Bare 仓库目录：`/srv/git/GitNet.git` 或 `~/git/GitNet.git`（目录名以 `.git` 结尾表示 bare 较常见，非强制）
- 同步日志：`~/Library/Logs/GitNet/push-github.log`（可自定）

**本机实装（epix，已填）**：`/Users/epix/git/GitNet.git`（即 **`~/git/GitNet.git`**）；工作副本 **`/Users/epix/Dev/GitNet`** 的 **`origin`** 已指向该 bare，**`github`** 远程保留作镜像；进程与验证见 [90-process-log.md](90-process-log.md)。

下文以 `BARE=/srv/git/GitNet.git` 为例，替换为你的真实路径。

## 2. 初始化 bare（仅首次）

在 epix 上执行（需已安装 Xcode Command Line Tools 或 Git）：

```bash
sudo mkdir -p /srv/git
sudo chown "$USER":staff /srv/git
mkdir -p /srv/git/GitNet.git
cd /srv/git/GitNet.git
git init --bare --shared=group
```

若已有 GitHub 历史要迁入为主线的第一次填充：

```bash
# 在一临时目录克隆 GitHub（仅迁移期一次）
git clone https://github.com/epix99-opus/GitNet.git /tmp/GitNet-import
cd /tmp/GitNet-import
git remote add epix git@git-epix:/srv/git/GitNet.git   # 见 SSH 一节：Host 别名
git push epix --all
git push epix --tags
```

之后**日常以 epix bare 为权威**，GitHub 仅作从镜像。

## 3. 在 bare 上注册 GitHub remote

```bash
git -C /srv/git/GitNet.git remote add github git@github.com:epix99-opus/GitNet.git
# 已存在则改为 set-url
# git -C /srv/git/GitNet.git remote set-url github git@github.com:epix99-opus/GitNet.git
```

确保运行 launchd 的用户对 `GitNet.git` 有读写权限，且该用户的 `ssh` 能访问 `github.com`（密钥已添加到 GitHub）。

## 4. 推送脚本（由 launchd 每日调用）

创建 `~/bin/gitnet-push-github.sh`：

```bash
#!/bin/bash
set -euo pipefail
BARE="${BARE:-/srv/git/GitNet.git}"
LOG="${LOG:-$HOME/Library/Logs/GitNet/push-github.log}"
mkdir -p "$(dirname "$LOG")"
{
  echo "---- $(date '+%Y-%m-%dT%H:%M:%S%z') ----"
  git -C "$BARE" push github --all --prune
  echo "push ok"
} >>"$LOG" 2>&1
```

```bash
chmod +x ~/bin/gitnet-push-github.sh
mkdir -p ~/Library/Logs/GitNet
```

说明：

- `--all` 推送所有分支；若只想推 `main`，可改为 `git -C "$BARE" push github main`。
- bare 仓库在接收各端 `push` 后，对象已更新；本脚本**不再从工作副本 pull**，符合「epix 为权威、GitHub 为从」。

## 5. launchd（每日一次示例：02:30）

创建 `~/Library/LaunchAgents/com.gitnet.push-github.plist`：

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Label</key>
  <string>com.gitnet.push-github</string>
  <key>ProgramArguments</key>
  <array>
    <string>/bin/bash</string>
    <string>-lc</string>
    <string>/Users/你的短用户名/bin/gitnet-push-github.sh</string>
  </array>
  <key>StartCalendarInterval</key>
  <dict>
    <key>Hour</key>
    <integer>2</integer>
    <key>Minute</key>
    <integer>30</integer>
  </dict>
  <key>StandardOutPath</key>
  <string>/Users/你的短用户名/Library/Logs/GitNet/launchd-stdout.log</string>
  <key>StandardErrorPath</key>
  <string>/Users/你的短用户名/Library/Logs/GitNet/launchd-stderr.log</string>
</dict>
</plist>
```

加载与卸载：

```bash
launchctl load ~/Library/LaunchAgents/com.gitnet.push-github.plist
# launchctl unload ~/Library/LaunchAgents/com.gitnet.push-github.plist
```

手动试跑：

```bash
~/bin/gitnet-push-github.sh
tail -n 50 ~/Library/Logs/GitNet/push-github.log
```

## 6. SSH（epix 侧要点）

- epix 对外克隆地址形如：`git@git-epix:/srv/git/GitNet.git`（`git-epix` 为 `~/.ssh/config` 里 `Host`，见 [45-ssh-tailscale-for-humans.md](45-ssh-tailscale-for-humans.md)）。
- 访问 GitHub 使用同一用户下的 `Host github.com` 与 `IdentityFile`，保证 `git -C ... push github` 成功。
- 经 Tailscale **SSH 登录 glab**、追加 `known_hosts`、公钥与 `BatchMode` 验收见 [46-tailscale-remote-git-identity.md](46-tailscale-remote-git-identity.md) **§3**。若在 epix 上执行 `ssh-keyscan glab…` 报错 **`fdlim_get: bad value`**，先在同一 shell 执行 `ulimit -n 10240` 再重试，或使用 `StrictHostKeyChecking=accept-new`（见 `46` §3.3）。

## 7. 回滚

1. **停定时任务**：`launchctl unload ~/Library/LaunchAgents/com.gitnet.push-github.plist`
2. **删 plist**（可选）
3. **GitHub 上误推内容**：用 GitHub 的 revert / 分支保护；**不要**在未记录的情况下从 GitHub 强制回灌 epix bare，避免双权威冲突。灾备恢复流程须记在 [90-process-log.md](90-process-log.md)。

## 8. 与工作副本的关系

其它机器克隆 **bare 的 URL**，向 `origin` 推送；epix 本机若也要编辑，使用**单独工作目录**克隆同一 bare，勿在 bare 目录内直接编辑文件。

- **本机（epix）已用路径**：工作副本 **`/Users/epix/Dev/GitNet`** 的 **`origin` = `file:///Users/epix/git/GitNet.git`**（见 `90`）。

## 修订记录

| 日期 | 摘要 |
|------|------|
| 2026-05-14 | §1 增 **`~/git/GitNet.git`** 实装与 `90` 互指；§8 增本机 `file://` `origin` 一句。 |
