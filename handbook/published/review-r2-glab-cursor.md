# R2 整仓深度评审（glab · Cursor）

> **母单**：[Issue #16](https://github.com/epix99-opus/GitNet/issues/16) · **协作模式**：[98](https://github.com/epix99-opus/GitNet/blob/main/handbook/98-gitnet-deep-review-round2-git-bus.md)

## 范围

在 **`E:\Dev\GitNet`** 阅读：`20-windows-setup.md`（§7 UTF-8 BOM、§8 `gh`/SSH）、`handbook/scripts/setup-glab-*.ps1`、`templates/windows-glab-git-includeIf.ps1`、`published/inventory-glab-enumerated-agent.md`；对照 `55` §3.3 路径大小写与 `core.autocrlf`。

## 结论摘要

1. **PS1 脚本与 5.1 现实对齐**：`setup-glab-openssh-for-epix.ps1` 等强调 **UTF-8 BOM**，与 `20` 一致，降低「中文注释乱码导致脚本半行执行」类事故。
2. **管理员与普通用户脚本拆分**：`append-epix-pubkey-to-local-authorized_keys.ps1` vs `…-administrators-…` 分流清晰，符合 Windows OpenSSH `Match Group administrators` 行为。
3. **`setup-glab-github-ssh-and-gh.ps1`（新）**：把 `winget` + `ssh-keygen` + `origin`→SSH + `gh auth login` 串成一条故事线，**补上 glab 直推的最后一块**；人类仍需 **web 登录** 与 **公钥上墙**——边界正确。
4. **autocrlf**：`inventory-glab` 与 `20` 已多次提示；R2 整仓评审时 **diff 噪声** 仍是 Windows 副机主要摩擦点（P2）。
5. **路径**：`E:\Dev` vs `E:\DEV` 在 `55` 用双 `includeIf` 规避——手册层已尽力，克隆路径仍建议团队统一。

## 问题与风险

| 级别 | 项 |
|------|-----|
| **P0** | 无凭据写入手册或脚本示例。 |
| **P1** | **`gh`/`ssh-agent` 会话差异**：非交互 SSH 下 `gh` 可能不在 PATH；深度自动化前应使用 **绝对路径** 或在 `inventory-glab` 记录（与 woot Codex 行类似）。 |
| **P2** | **PowerShell 版本**：若未来假设 PowerShell 7+，需在 `20` 显式最低版本，避免 5.1 语法混用。 |

## 建议

- **可执行**：在 glab 完成 `gh auth login` 后，用 **`git ls-remote github`**（或 SSH remote）做一次批处理验收，结果贴 Issue #16 或 `90`。
- **需人类决策**：是否统一 **`origin` 为 SSH** 后废弃 HTTPS remote（影响其他仅 HTTPS 工具链时需评估）。

## 无问题项

- `templates/epix-id_ed25519.pub` 作为公钥单行信源与 `46`/`91` 叙述一致。
- `91` Handoff 与 Issue #1 链仍可作为 glab 专项深度入口，不与 R2 整仓冲突。

## 修订记录

| 日期 | 摘要 |
|------|------|
| 2026-05-14 | R2 glab-cursor 首稿（Issue #16）。 |
