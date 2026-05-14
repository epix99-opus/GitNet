# woot 侧：多 Agent + Git 总线复盘（草案）

- **网络**：经 epix `ssh -o BatchMode=yes woot@woot` 与 Tailscale 核对可用；详见 handbook `46` §1.0。
- **Git 总线**：副机以 `git pull --ff-only origin main` 对齐 GitHub `main`，再以特性分支 + PR 交付；勿绕过 CONTRIBUTING 直推 `main`。
- **路径与身份**：本路径命中 `woot-cursor` 片段（`55` §3.4）；Codex/Claude 宜使用 `agent-work/` 下独立克隆，避免双写。
- **母单**：[Issue #11](https://github.com/epix99-opus/GitNet/issues/11)。

## 待 epix 集成

- [ ] PR 审查后合入；`90` 记闭环。
