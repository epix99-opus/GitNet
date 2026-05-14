# glab 侧：Windows + Git 总线复盘（备注）

- **路径与换行**：工作副本常见 `E:\Dev\GitNet`；`core.autocrlf=true` 与 handbook `20` / `55` §3.3 一致；PR 前注意 diff 噪声。
- **远程**：本机仅 `origin` → GitHub HTTPS 时，副机用 `git pull --ff-only origin main` 对齐；合入仍走 **GitHub PR**（`CONTRIBUTING`、`10`）。
- **SSH 批处理**：epix 侧 `ssh -o BatchMode=yes glab` 用于枚举与脚本验收；遇权限与 `authorized_keys` 见 `46` / `91`。
- **母单**：[Issue #11](https://github.com/epix99-opus/GitNet/issues/11)。

## 待 epix 集成

- [ ] PR 审查后合入；`90` 记闭环。
