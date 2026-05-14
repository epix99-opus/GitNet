# epix Mac：权威裸仓、SSH、launchd 向 GitHub 镜像

## 1. 路径约定（团队填实值后写入 [90-process-log.md](90-process-log.md)）

建议在 epix 上使用**固定路径**，例如：

- Bare 仓库目录：`/srv/git/GitNet.git` 或 `~/git/GitNet.git`（目录名以 `.git` 结尾表示 bare 较常见，非强制）
- 同步日志：`~/Library/Logs/GitNet/push-github.log`（可自定）

**本机实装（epix，已填）**：`/Users/epix/git/GitNet.git`（即 **`~/git/GitNet.git`**）；工作副本 **`/Users/epix/Dev/GitNet`** 的 **`origin`** 指向该 bare，**`github`** 用于 **PR 与合入闸**（**GitNet 本仓**例外，见 [10-topology.md](10-topology.md)）；进程与验证见 [90-process-log.md](90-process-log.md)。

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

## 4. GitNet 本元仓库：`github/main` → bare `main`（ff-only）

**登记例外**（见 [10-topology.md](10-topology.md)、[06-github-branch-protection.md](06-github-branch-protection.md)）：GitHub **`main`** 仅经 **PR merge** 更新；bare 上 **`main`** 由本脚本 **fast-forward** 对齐 **`github/main`**。

仓库内脚本：[scripts/gitnet-sync-github-main-to-bare.sh](scripts/gitnet-sync-github-main-to-bare.sh)。安装到本机：

```bash
install -m 0755 handbook/scripts/gitnet-sync-github-main-to-bare.sh ~/bin/gitnet-sync-github-main-to-bare.sh
mkdir -p ~/Library/Logs/GitNet
~/bin/gitnet-sync-github-main-to-bare.sh
tail -n 30 ~/Library/Logs/GitNet/sync-github-to-bare.log
```

环境变量：`BARE`（默认 **`$HOME/git/GitNet.git`**）、`LOG`（默认 **`~/Library/Logs/GitNet/sync-github-to-bare.log`**）。**预演**：`GITNET_SYNC_DRY_RUN=1` 与脚本同路径执行，仅打印将运行的 `git fetch`、**不写日志、不拉取**（见 `98` §5）。

### 4.1 停用「bare 直推 GitHub `main`」旧脚本

`~/bin/gitnet-push-github.sh` 在 **GitNet 本仓**已改为：默认 **不写** `push github`（仅写日志说明）；**勿**再对 **`com.gitnet.push-github`** 依赖其更新 `main`。若确需恢复旧行为（**不推荐**，且易与 GitHub 分支保护冲突），仅可临时设置 **`GITNET_LEGACY_PUSH_GITHUB_MAIN=1`** 后执行（须在 [90-process-log.md](90-process-log.md) 记原因）。

## 5. launchd：GitNet 本仓用「同步到 bare」而非「推镜像 main」

**加载**（示例 plist 见 [templates/com.gitnet.sync-github-to-bare.plist](templates/com.gitnet.sync-github-to-bare.plist)；复制到 `~/Library/LaunchAgents/` 后按需改路径）：

```bash
cp handbook/templates/com.gitnet.sync-github-to-bare.plist ~/Library/LaunchAgents/
launchctl load ~/Library/LaunchAgents/com.gitnet.sync-github-to-bare.plist
```

**若曾加载旧任务** `com.gitnet.push-github`（bare→github），须先卸载以免与分支保护语义冲突：

```bash
launchctl unload ~/Library/LaunchAgents/com.gitnet.push-github.plist
```

手动试跑同步：

```bash
~/bin/gitnet-sync-github-main-to-bare.sh
tail -n 50 ~/Library/Logs/GitNet/sync-github-to-bare.log
```

## 6. 其它业务 bare：向 GitHub「镜像推送」（组织默认）

下列脚本适用于 **未**登记「GitHub 合入闸」的其它 bare：由 epix 定时 **`push github`** 更新镜像（与 [10-topology.md](10-topology.md) 默认「bare→GitHub」一致）。

创建 `~/bin/gitnet-push-github.sh`（若与本机 GitNet 停用版不同名，可自行命名如 `gitnet-push-github-otherbare.sh`）：

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

**launchd 示例**（每日一次）：仍可用 **`com.gitnet.push-github.plist`**（ProgramArguments 指向上述脚本）；路径占位改为本机用户，见历史草稿：

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

```bash
launchctl load ~/Library/LaunchAgents/com.gitnet.push-github.plist
# launchctl unload ~/Library/LaunchAgents/com.gitnet.push-github.plist
```

## 7. SSH（epix 侧要点）

- epix 对外克隆地址形如：`git@git-epix:/srv/git/GitNet.git`（`git-epix` 为 `~/.ssh/config` 里 `Host`，见 [45-ssh-tailscale-for-humans.md](45-ssh-tailscale-for-humans.md)）。
- 访问 GitHub 使用同一用户下的 `Host github.com` 与 `IdentityFile`，保证 `git -C ... push github` 成功。
- 经 Tailscale **SSH 登录 glab**、追加 `known_hosts`、公钥与 `BatchMode` 验收见 [46-tailscale-remote-git-identity.md](46-tailscale-remote-git-identity.md) **§3**。若在 epix 上执行 `ssh-keyscan glab…` 报错 **`fdlim_get: bad value`**，先在同一 shell 执行 `ulimit -n 10240` 再重试，或使用 `StrictHostKeyChecking=accept-new`（见 `46` §3.3）。

## 8. 回滚

1. **停定时任务**：`launchctl unload ~/Library/LaunchAgents/com.gitnet.sync-github-to-bare.plist` 与（若曾启用）`launchctl unload ~/Library/LaunchAgents/com.gitnet.push-github.plist`
2. **删 plist**（可选）
3. **GitHub 上误推内容**：用 GitHub 的 revert / 分支保护；**不要**在未记录的情况下从 GitHub 强制回灌 epix bare，避免双权威冲突。灾备恢复流程须记在 [90-process-log.md](90-process-log.md)。

## 9. 与工作副本的关系

其它机器克隆 **bare 的 URL**，向 `origin` 推送；epix 本机若也要编辑，使用**单独工作目录**克隆同一 bare，勿在 bare 目录内直接编辑文件。

- **本机（epix）已用路径**：工作副本 **`/Users/epix/Dev/GitNet`** 的 **`origin` = `file:///Users/epix/git/GitNet.git`**（见 `90`）。

## 修订记录

| 日期 | 摘要 |
|------|------|
| 2026-05-14 | **§4～§6** 分拆：GitNet **github→bare** 同步脚本与 **sync** launchd；**§6** 保留其它 bare 的 **push github** 模板；**§8/§9** 编号调整；`push-github` 卸载说明。 |
| 2026-05-14 | §1 增 **`~/git/GitNet.git`** 实装与 `90` 互指；§8 增本机 `file://` `origin` 一句。 |
