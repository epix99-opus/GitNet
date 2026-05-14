# 初版 GitNet（v0.1）封存索引

> **文档性质**：**v0.1 封存清单**——把截至本版已形成并定稿的 **Git 使用规范、配置入口、脚本与自动化** 收敛为**单页索引**，供三节点人类与编程 Agent 对齐。**过程复盘与可外推长篇**仍以 [93-gitnet-phase-conclusion-and-cross-collab-git-playbook.md](93-gitnet-phase-conclusion-and-cross-collab-git-playbook.md) 为准；**93 = 叙事与复盘，97 = v0.1 交付包索引**。若与逐条操作冲突，以 [00-truth-sources.md](00-truth-sources.md) 及被引用章节的最新修订为准。

## 1. 范围声明

| 包含 | 不包含 |
|------|--------|
| 本仓库 **GitNet** 定稿 `handbook/`、根 `CONTRIBUTING.md` / `AGENTS.md`、`.cursor/rules` | 各**业务产品仓**的独立分支策略与 CI（除非该仓自行链回本手册） |
| **epix** 上 **bare** 与 **GitHub** 角色（组织默认 + **GitNet 本仓例外**） | 非 Git 的 Agent 运行时配置（由各工具 User Rules 等承担） |
| **BestGit** 组织模板仓作为**外推载体**（路径与周知见 [96-bestgit-org-template-and-rollout.md](96-bestgit-org-template-and-rollout.md)） | BestGit 内全文双写到 GitNet（仅链，不复制） |

## 2. 组织默认 vs GitNet 本元仓库（对照）

| 维度 | **其它业务仓（组织默认）** | **`epix99-opus/GitNet` 本元仓库（登记例外）** |
|------|------------------------------|-----------------------------------------------|
| **`main` 合入** | 推 **epix bare**（`origin`），镜像 GitHub 见 `30` | **GitHub PR** 合入 `main`；bare **`main`** 仅 **`github/main` ff-only** 跟随（`56` §3、`30` §4、`handbook/scripts/gitnet-sync-github-main-to-bare.sh`） |
| **工作副本禁止** | 依业务仓约定 | **禁止**为更新 `main` 而 **`git push origin main`** 绕过 PR（`CONTRIBUTING`、`AGENTS`） |
| **定时任务语义** | bare→GitHub **镜像**（`gitnet-push-github.sh` 等，见 `30`） | **`com.gitnet.sync-github-to-bare`**：**GitHub→bare**；勿再对 GitNet `main` 使用「仅 bare 推满 GitHub」的旧 plist 语义 |
| **提交语言** | 建议与业务仓 CONTRIBUTING 一致 | **首行 `<简短描述>` + 正文中文**；`type`/`scope` 英文关键字（`56` §4、`CONTRIBUTING`） |

## 3. 规范层（读什么）——v0.1 最小阅读切片

| 顺序 | 文档 | 用途 |
|------|------|------|
| 1 | [00-truth-sources.md](00-truth-sources.md) | 信源层级 |
| 2 | [05-project-scope-and-delivery.md](05-project-scope-and-delivery.md) | 项目边界 |
| 3 | [07-documentation-placement.md](07-documentation-placement.md) | 事实 / 过程 / 草稿落盘 |
| 4 | [08-agent-first-collaboration-vision.md](08-agent-first-collaboration-vision.md) | 北极星、全生命周期 × Git |
| 5 | [10-topology.md](10-topology.md) | 拓扑、**本仓例外**、多设备汇合 |
| 6 | [40-identity-and-includeIf.md](40-identity-and-includeIf.md) | 人类与 Agent 作者、`includeIf` |
| 7 | [55-multi-node-multi-agent-git.md](55-multi-node-multi-agent-git.md) | 三节点 × 三工具身份总表 |
| 8 | [06-github-branch-protection.md](06-github-branch-protection.md) | GitHub 分支保护与合入闸 |
| 9 | [30-mac-epix-setup.md](30-mac-epix-setup.md) | bare、launchd、**双路径脚本** |
| 10 | [56-git-workflow-quality-practices.md](56-git-workflow-quality-practices.md) | 全 PR、约定式提交、**中文铁律** |
| — | 根 [CONTRIBUTING.md](../CONTRIBUTING.md)、[AGENTS.md](../AGENTS.md) | 可操作清单与 Agent 契约 |

**阶段复盘（可选深读）**：[93-gitnet-phase-conclusion-and-cross-collab-git-playbook.md](93-gitnet-phase-conclusion-and-cross-collab-git-playbook.md)。

## 4. 配置层（装什么）——模板索引

路径均在仓库内 **`handbook/templates/`**（与 `40` / `55` / `20` / `46` 交叉阅读）。

| 文件 | 节点 / 场景 | 备注 |
|------|-------------|------|
| [gitconfig.mac.main.ini](templates/gitconfig.mac.main.ini) | epix / macOS 人类基底 | 与 `40` 片段合并策略 |
| [gitconfig.windows.main.ini](templates/gitconfig.windows.main.ini) | glab / Windows 人类基底 | 与 `55` §3 配合 |
| [gitconfig.fragment.agent.ini.example](templates/gitconfig.fragment.agent.ini.example) | 各节点 Agent 片段示例 | `{HOSTNAME}-{tool}` |
| [windows-glab-git-includeIf.ps1](templates/windows-glab-git-includeIf.ps1) | **glab** | 宽 `gitdir:` 覆盖 `E:/Dev/` 等；见 `55` §3.3 |
| [epix-ssh-config-glab.fragment.conf](templates/epix-ssh-config-glab.fragment.conf) | **epix** `~/.ssh/config` | 合并片段；`User` 以实机为准 |
| [epix-id_ed25519.pub](templates/epix-id_ed25519.pub) | epix→glab | **公钥单行唯一定稿信源**；勿手抄 |

**Windows 中文 PowerShell 脚本**：凡仓库内新增/维护的 **`handbook/scripts/*.ps1`** 含中文时，须 **UTF-8 带 BOM**（见 [20-windows-setup.md](20-windows-setup.md) §7）。

## 5. 脚本与自动化层（跑什么）

路径均在 **`handbook/scripts/`**（部署到 `~/bin` 的同名脚本以 `30` 与 `90` 为准）。

| 脚本 | 主要节点 | 管理员 | 说明 |
|------|----------|--------|------|
| [gitnet-sync-github-main-to-bare.sh](scripts/gitnet-sync-github-main-to-bare.sh) | epix（bare 所在机） | 否 | **仅 GitNet 本仓**：`fetch github` → 更新 bare `refs/heads/main`（ff-only）；日志 `~/Library/Logs/GitNet/sync-github-to-bare.log` |
| [gitnet-push-github.sh](scripts/gitnet-push-github.sh) | epix | 否 | **其它仓** 镜像推；GitNet `main` 默认 no-op（`GITNET_LEGACY_PUSH_GITHUB_MAIN=1` 例外）；与 `30`/`90` 一致 |
| [gitnet-watch-github-sync.sh](scripts/gitnet-watch-github-sync.sh) | epix | 否 | `92` 备选数据面；**不替代** bare 写权威 |
| [setup-glab-openssh-for-epix.ps1](scripts/setup-glab-openssh-for-epix.ps1) | **glab** | **是** | OpenSSH Server、`authorized_keys` / `administrators_authorized_keys` |
| [append-epix-pubkey-to-local-authorized_keys.ps1](scripts/append-epix-pubkey-to-local-authorized_keys.ps1) | glab | 否 | 当前用户 `authorized_keys` |
| [append-epix-pubkey-to-administrators-authorized_keys.ps1](scripts/append-epix-pubkey-to-administrators-authorized_keys.ps1) | glab | **是** | Administrators 组 |
| [91-glab-section-A-evidence.ps1](scripts/91-glab-section-A-evidence.ps1) | glab | 否 | Handoff §A 证据 |
| [post-issue1-github-comment.ps1](scripts/post-issue1-github-comment.ps1) | 任 | 否 | 需 `GITHUB_TOKEN` |
| [gitnet-rewrite-commit-messages-zh.sh](scripts/gitnet-rewrite-commit-messages-zh.sh) | 维护者 | — | 历史说明改写；慎用，见 `90` |

**LaunchAgents 模板**（`handbook/templates/`）：`com.gitnet.sync-github-to-bare.plist`、`com.gitnet.watch-github.plist`；**glab** 计划任务示例：`gitnet-watch-github-sync.ps1`。

**可复制命令块（只读提示）**：[gitnet-v0.1-rollout-print-checks.sh](scripts/gitnet-v0.1-rollout-print-checks.sh)（打印三节点建议验收命令，不执行 SSH）。

## 6. 三节点 × 三编程 Agent — v0.1 周知验收矩阵

**编程 Agent**：Cursor、OpenAI Codex CLI（`codex`）、Claude Code（`claude`）。**节点**：epix、woot、glab（与 `55` / `94` 一致）。

对每一格（节点 × 工具），在具备该工具的工作区内完成：

1. **GitNet**：`git fetch github`（或等价）后，工作副本可见 **含本 `97` 的 `main`**（或该节点跟踪分支已 merge 自 `main`）。
2. **BestGit**（若该节点已克隆）：`git pull --ff-only` 到与 GitHub `main` 一致。
3. **CAMA-concept**：在 pilot 仓内按 [CAMA-concept 检验文档](https://github.com/epix99-opus/CAMA/blob/CAMA_Cursor/docs/gitnet-v0.1-rollout-verification.zh-CN.md)（分支以实仓为准）执行 **身份解析** 小节命令。
4. **证据（主）**：更新 GitNet [`published/inventory-*-enumerated-agent.md`](published/inventory-epix-enumerated-agent.md) 对应表 **备注** 列，填 **「v0.1 周知：日期 / 工具 / OK 或阻塞摘要」**。
5. **证据（副）**：可在 CAMA 检验文档内勾选；**避免**与 inventory 重复粘贴大段输出。

**woot / glab** 上无本地 GUI Agent 会话时：由 **epix `ssh -o BatchMode=yes …`** 执行等价命令，结论写入 **inventory-woot / inventory-glab** 或 [`90-process-log.md`](90-process-log.md)（硬边界按 `AGENTS`）。

| 节点 \\ 工具 | Cursor | Codex CLI | Claude Code |
|--------------|--------|-----------|-------------|
| **epix** | 在 `~/Dev/GitNet` 工作区验收 | 在 `includeIf` 命中之克隆验收 | 同上 |
| **woot** | 经 SSH 或本机 `~/Dev/...` | 经 SSH 或本机 | 经 SSH 或本机 |
| **glab** | `E:\Dev\...` 工作区或 SSH | 经 SSH / Git Bash | 经 SSH |

## 7. CAMA 检验项目（pilot）

- **主检验仓（epix 本机路径）**：`/Users/epix/Dev/CAMA/CAMA-concept`（与 [inventory-epix-enumerated-agent.md](published/inventory-epix-enumerated-agent.md) 登记一致）。
- **检验文档**：CAMA-concept 仓库内 **`docs/gitnet-v0.1-rollout-verification.zh-CN.md`**（与 [54-remote-work-cama-on-epix-from-other-nodes.md](54-remote-work-cama-on-epix-from-other-nodes.md)、[96-bestgit-org-template-and-rollout.md](96-bestgit-org-template-and-rollout.md) 互链）。
- **周知链**：BestGit [`docs/rollout-epix-glab-woot.md`](https://github.com/epix99-opus/BestGit/blob/main/docs/rollout-epix-glab-woot.md) → 读本 **`97`** → 跑 CAMA 检验清单。

## 8. 与 BestGit / 三节点关系

- **BestGit**：组织模板、新开仓清单、`bestgit-doctor`；周知步骤见 [96-bestgit-org-template-and-rollout.md](96-bestgit-org-template-and-rollout.md)。
- **GitHub Raw（便于非克隆阅读）**：`97` 本文可用  
  `https://raw.githubusercontent.com/epix99-opus/GitNet/main/handbook/97-initial-gitnet-v0.1-deliverable.md`

## 9. 文面基线锚点

- **含义**：标记「v0.1 文面已冻结」的 **GitHub `main` 提交**，便于三机对照是否已 pull 到该点之后。
- **本轮（2026-05-13，PR #7 合入 + bare 同步后）**：GitHub `main` 与 `~/git/GitNet.git` **refs/heads/main** 均为 **`2aab83c77940069d6fdafa9bbb1c00736816b094`**（与 [90-process-log.md](90-process-log.md)「v0.1 封存发布」条一致）。

## 修订记录

| 日期 | 摘要 |
|------|------|
| 2026-05-13 | 首版：v0.1 封存索引、对照表、配置/脚本索引、验收矩阵、CAMA pilot 指针。 |
| 2026-05-13 | **文面基线**：PR #7 后 GitHub `main` 与 bare 对齐 **`2aab83c…`**（见 `90` 同条）。 |
