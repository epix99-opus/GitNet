# R2 整仓深度评审（woot · Cursor）

> **母单**：[Issue #16](https://github.com/epix99-opus/GitNet/issues/16) · **协作模式**：[98](https://github.com/epix99-opus/GitNet/blob/main/handbook/98-gitnet-deep-review-round2-git-bus.md)

## 范围

在 **`/Users/woot/Dev/GitNet`** 对照阅读：`55`（woot 路径块）、`46`（Tailscale SSH）、`published/inventory-woot-enumerated-agent.md`、`handbook/scripts` 中与 macOS 相关说明；抽样 `templates/gitconfig.mac.main.ini`。

## 结论摘要

1. **与 epix 同构可预期**：woot 使用 `woot-cursor` 片段 + `~/Dev/` / `agent-work/` 分层，与 `55` §3.4 一致，**副机评审不应抄 epix 主目录路径**。
2. **Codex 探测痛点已文档化**：inventory 对 `zsh -l` vs `zsh -lic` 的说明有利于在 woot 上跑批处理时不误判「未安装」。
3. **`github` SSH remote**：在 woot 上配置 `github`→SSH 后，可减少对 epix `format-patch` 中继的依赖（与 Issue #11 后续一致）。
4. **preflight 脚本**：`gitnet-multi-agent-retro-preflight.sh` 在 epix 跑、探测 woot 仓 HEAD——woot 侧无额外负担，适合纳入周知回合。
5. **整仓范围**：woot 非 bare 权威节点，**评审焦点**宜放在「身份 + 可达性 + 不直推 `main`」而非 launchd 细节（属 epix）。

## 问题与风险

| 级别 | 项 |
|------|-----|
| **P0** | 无。 |
| **P1** | **Keychain / cursor-agent**：inventory 已记 login keychain 与 `cursor-agent --version` 异常；R2 不扩大 scope，但 **P1 运维噪声** 仍在。 |
| **P2** | 若 woot 与 epix **同时**改同一 `published/` 文件，PR 冲突概率上升——应坚持「一机一分支一文件」直至合成。 |

## 建议

- **可执行**：每轮复盘前在 woot 执行 `git pull --ff-only origin main` 后开分支（与 `98` §2 一致）。
- **需人类决策**：是否在 woot 安装 **`gh` CLI** 以便副机直接开 PR（可选）。

## 无问题项

- `templates/gitconfig.mac.main.ini` 与 epix 模板同构，woot 仅替换 HOSTNAME 前缀即可。
- `46` §1.0 对 `tailscale ip -4` 的权威表述降低 woot 短名 SSH 超时误判。

## 修订记录

| 日期 | 摘要 |
|------|------|
| 2026-05-14 | R2 woot-cursor 首稿（Issue #16）。 |
