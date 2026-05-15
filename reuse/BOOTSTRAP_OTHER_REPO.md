# 外项目接入清单（一页勾选）

> 每步完成后打 `[x]`。详细条目与 Raw 链见 [CATALOG.md](CATALOG.md)。

## A. 选拓扑与写权威（必选其一并写进自家 README）

- [ ] **A1 组织默认**：业务集成在 **单 bare**；GitHub 为镜像；多端 `push` → bare（见 GitNet `handbook/10` 组织默认节）。  
- [ ] **A2 PR 闸例外**（如 GitNet 本仓模式）：`main` 仅经 **GitHub PR**；bare **`ff-only`** 跟随 `github/main`（见 `10` 例外、`56`、`CONTRIBUTING` 思路）。  
- [ ] **A3** 已在自家文档写清：**`origin` / `github` 各自语义**，禁止团队成员混用。

## B. 身份与 `includeIf`（多 Agent 时推荐）

- [ ] **B1** 已读 GitNet `handbook/40`、`55`，并按自家 **HOSTNAME + 路径前缀** 生成片段（可用 `handbook/templates/gitconfig.*` 为起点）。  
- [ ] **B2** 已在自家仓库验证：`git config --show-origin user.name` 在 Agent 目录下为 `{host}-{tool}`。

## C. 跨机 SSH（若用 Tailscale）

- [ ] **C1** 已读 `handbook/46` §1.0（`tailscale ping` / `tailscale ip -4` / 短名 SSH 超时排查）。  
- [ ] **C2** `BatchMode` 公钥登录已通；Windows 管理员组已按 `91` / `setup-glab-openssh-for-epix.ps1` 类流程处理（若适用）。

## D. 分支保护与合入

- [ ] **D1** GitHub `main` 分支保护策略与团队角色一致（`06` 思路）。  
- [ ] **D2** 约定式提交 / 中文摘要策略是否与 GitNet 对齐（按需裁剪 `56`）。

## E. 进程与证据

- [ ] **E1** 已建立时间序进程日志（等价 `90`）。  
- [ ] **E2** Handoff 类任务已选：Issue + `published/` 式证据 或 自家等价物（`94` §5 思路）。

## F. 自动化脚本（按需）

- [ ] **F1** 已从 `CATALOG` 挑选脚本；读清脚本内 **路径常量** 并改为自家路径。  
- [ ] **F2** 对 `gitnet-sync-github-main-to-bare.sh` 类脚本：理解 **`GITNET_SYNC_DRY_RUN=1`** 再上线定时任务。

## G. 外推包自身

- [ ] **G1** 已在自家 README 或 `AGENTS` 中链到 **本包 `reuse/README.md` 的 Raw URL**，并写明 **GitNet 版本锚点**（见 `AGENT_MUST_READ` §4）。
