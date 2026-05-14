# R2 整仓深度评审（epix · Codex 视角：脚本与模板）

> **母单**：[Issue #16](https://github.com/epix99-opus/GitNet/issues/16) · **协作模式**：[98](../98-gitnet-deep-review-round2-git-bus.md)

## 范围

在 **`/Users/epix/Dev/CodexDev/GitNet`** 重点阅读：`handbook/scripts/*.sh`、`handbook/scripts/*.ps1`、`templates/*.ps1`、`templates/*.plist`；对照 `20`（PowerShell 5.1 / UTF-8 BOM 要求）与 `46`/`91` 中的 glab 路径。

## 结论摘要

1. **bash 脚本一致性较好**：`gitnet-sync-github-main-to-bare.sh`、`gitnet-watch-github-sync.sh`、`gitnet-push-github.sh` 等使用 `set -euo pipefail` 与明确 `BARE`/`LOG` 默认值，利于 Agent 批跑。
2. **`gitnet-multi-agent-retro-preflight.sh`**：将 Tailscale 与 BatchMode SSH 固化为一键，降低「ping 通但 ssh 挂」的误报成本；建议与 `46` §1.0 交叉链已在母单体现。
3. **PowerShell 脚本体积与职责**：`setup-glab-openssh-for-epix.ps1` 与新版 `setup-glab-github-ssh-and-gh.ps1` 分属「SSH 入站」与「GitHub 出站身份」——边界清晰；后续若再增 `gh` 子命令，建议拆 **PrivateFunctions** 文件避免单文件过长（P2）。
4. **敏感面**：`post-issue1-github-comment.ps1` 依赖 `GITHUB_TOKEN`——文档已警示；勿将 token 写入 plist 或手册示例（当前未见违规）。
5. **可维护性**：`gitnet-rewrite-commit-messages-zh.sh` 等改写类脚本应在 `56`/`CONTRIBUTING` 保持「慎用」提示——现有铁律已覆盖。

## 问题与风险

| 级别 | 项 |
|------|-----|
| **P0** | 无：未见硬编码私钥或 token 占位符。 |
| **P1** | **SSH 与 `gh` 的交互边界**：`setup-glab-github-ssh-and-gh.ps1` 末尾仍依赖人类 `gh auth login`；BatchMode Agent **不得**假装能代登录——须在 Issue 模板中固定写明（与 `98` §4 一致）。 |
| **P2** | **路径大小写**：glab 上 `E:\Dev` vs `E:\DEV` 历史问题在 `55`/`inventory-glab` 已多次出现；新 PS1 中 `Set-Location` 建议继续沿用「双路径探测」模式（若未来合并脚本可抽公共函数）。 |

## 建议

- **可执行**：为 `handbook/scripts` 增加 **dry-run** 开关（仅 `echo` 将要执行的 `git`/`ssh`）作为 P2 backlog，便于 Codex 回合做无副作用挑错。
- **需人类决策**：是否在 CI 引入 **PSScriptAnalyzer**（仅 Windows runner 或手动）；本仓当前无强制 CI 条。

## 无问题项

- `gitnet-sync-github-main-to-bare.sh` 对「bare 无 `github` remote」显式 `exit 2`，失败模式清晰。
- `templates/com.gitnet.sync-github-to-bare.plist` 与脚本路径在 `README` 模板区已互链。

## 修订记录

| 日期 | 摘要 |
|------|------|
| 2026-05-14 | R2 epix-codex 首稿（Issue #16）。 |
