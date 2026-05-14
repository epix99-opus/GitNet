# 高价值 Git 工作流：业界共识与本项目分层落地

本文把「提交信息规范、小步提交、分支与 PR、交互式变基、部分暂存、分支清理」六条**可复用实践**写进定稿，并与 **`08`/`10`/`51`/`53`/`06`/`30`** 对齐。**GitNet 本元仓库**自 **2026-05-14** 起实行 **GitHub PR 合入闸**（见 §3）。

## 1. 为何此前「有碎片、无总账」

| 原因 | 说明 |
|------|------|
| **条文分散** | 分支与 PR、rebase 节律、合并策略等已在 [08-agent-first-collaboration-vision.md](08-agent-first-collaboration-vision.md) 矩阵与 [10-topology.md](10-topology.md)；`git add -p` 已在 [51-git-cli-and-git-graph-user-guide.md](51-git-cli-and-git-graph-user-guide.md) 最小闭环中出现。 |
| **未显式命名「约定式提交」** | 仓库内提交已多次使用 **`type(scope): subject`** 形态（如 `docs(handbook): …`），但未在定稿中写成**团队默认格式**，不利于新成员与 Agent 对齐。 |
| **元仓库例外已升格** | 自 **2026-05-14** 起 GitNet 本仓已采用 **§3 全 PR**；旧「main 小步」叙述见 `90` 迁移条。 |

## 2. 六条共识 ↔ 本仓库定稿索引

| # | 共识要点 | 本项目中的位置 |
|---|----------|----------------|
| 1 | **约定式提交** `type(scope): subject` | 本文 **§4**；根目录 [CONTRIBUTING.md](../CONTRIBUTING.md) |
| 2 | **小步、一事一提交** | `08` 编程阶段「小步、可回滚」；本文 **§5** |
| 3 | **集成分支上不用 main 直接堆功能** | **GitNet 本仓**：§3、§6；**其它仓**：`08` + `06` |
| 4 | **`git rebase -i` 整理历史** | 本文 **§7**；与 `08`「合入前 rebase」互补（一个管**合入前**，一个管**推送前整理本地**） |
| 5 | **`git add -p` 部分暂存** | `51` §1；本文 **§5** |
| 6 | **合并后删分支、清理远端** | 本文 **§8** |

## 3. GitNet 本元仓库（现行）：GitHub 合入闸 + bare ff-only 跟随

自 **2026-05-14** 起（迁移决议与验收见 [90-process-log.md](90-process-log.md)），**仅对仓库 `epix99-opus/GitNet`**：

### A. 必须遵守

1. **禁止**为更新 **`main`** 而 **`git push origin main`**（bare）以绕过 GitHub **分支保护**与审计链。
2. **必须**在 **`docs/*` / `chore/*` / `fix/*` / `feat/*`** 等分支上开发；**`git push -u github <分支>`** 后在 GitHub 开 **Pull Request**，合并进 **`github/main`**。
3. **必须**在 PR merge 后（或由定时任务）在 epix 执行 **`gitnet-sync-github-main-to-bare.sh`**，使 **bare `refs/heads/main`** 与 **`github/main`** **fast-forward** 一致（脚本见 [30-mac-epix-setup.md](30-mac-epix-setup.md) §4）。
4. **提交信息**：仍遵守本文 **§4** 约定式提交。
5. **秘密**：禁止凭据明文进任何提交。

### B. 其它业务仓（组织默认）

仍按 [08-agent-first-collaboration-vision.md](08-agent-first-collaboration-vision.md) 与 [10-topology.md](10-topology.md)：**bare 集成**、**定时 `push github`** 镜像，除非该仓在自身 **`90`** 登记与本节 **§3.A** 同构的例外。

### 3.5 已选模式与迁回

本仓已**锁定**为 **§3.A 全 PR**（GitHub 合入闸）。若将来迁回「bare 先写 `main` 再镜像 GitHub」，须：**解除/放宽 GitHub 保护**、恢复 **`gitnet-push-github.sh`** 语义、更新 **`10`/`06`/`30`/`08`** 与本章，并在 **`90`** 写原因与双端 SHA 验收。

## 4. 约定式提交（Conventional Commits）— 本项目默认

**一行格式**：

```text
<type>(<scope>): <简短描述>
```

- **`type`**（常用）：`feat`（行为变化）、`fix`、`docs`、`chore`（工具/杂项）、`refactor`（无行为变化的重构）、`test`、`ci`。
- **`scope`**：可选；建议用 **目录或子系统**，如 `handbook`、`glab`、`90`、`scripts`。
- **描述（铁律）**：首行 **`<简短描述>`** 与 **提交正文**须为**中文**、**祈使语气**；`type`/`scope` 仍为上述英文关键字。**例外**：`Co-authored-by:` 等 trailer、工具要求的固定字段、须原文照录的上游引用，可保留必要英文行。

**好处**（与业界共识一致）：扫 `git log` 即可区分文档/功能；`git bisect` 易定位；可用工具从 log **生成 CHANGELOG**（本仓大阶段回顾仍归 `93`/`90`，不强制自动化）。

规范全文可参考：[Conventional Commits 1.0.0](https://www.conventionalcommits.org/zh-hans/v1.0.0/)

## 5. 小步提交与 `git add -p`

- **小步**：一次提交只解决**一类**问题（单文档修正、单脚本修复、单章交叉引用），便于 `revert` 与评审。
- **部分暂存**：同一文件含两类改动时，优先 **`git add -p`** 拆成两次提交，避免「一条提交里夹无关 diff」。详见 `51` §1。

## 6. 分支与 PR（GitNet 本仓）

- **开发**：在 **特性分支** 上提交；**`git push -u github <分支>`** 打开 PR，**base = `main`**。
- **合入**：在 GitHub 完成 **PR merge**（单人仓库可用 **`gh pr merge --admin`** 满足 **1 人审批** 规则，见 [06-github-branch-protection.md](06-github-branch-protection.md)）。
- **对齐 bare**：merge 后执行 **`~/bin/gitnet-sync-github-main-to-bare.sh`**（或等待 launchd），再在工作副本 **`git fetch origin`**，使本地 **`main`** 与 **bare / GitHub** 一致。
- **禁止**：为更新 **`main`** 而 **`git push origin main`**（除非 `90` 登记的紧急流程）。
- **多 Agent**：仍遵守 [53-multi-agent-main-branch-and-agent-files.md](53-multi-agent-main-branch-and-agent-files.md)。

**其它业务仓**：仍可按「特性分支 → **推 bare（`origin`）** → 镜像 GitHub」的默认；见 `10` 默认节。

## 7. 交互式变基 `git rebase -i` — 使用边界

**适用**：**尚未推送**或**仅个人分支**上的「多笔本地提交」合并成更清晰的一条或几条，再推送。

**慎用 / 须团队规则**：

- 已 **`push`** 且他人可能已基于其工作的提交，**改写历史**须 **`--force-with-lease`** 且仅限**约定窗口**（例如个人特性分支），**禁止**对 **`main`** 强推重写，除非灾备流程并记入 `90`。
- **GitNet 本仓**：合入 **`main`** 的唯一权威为 **GitHub PR merge**；bare 仅 **ff-only 跟随**（见 §3）。

**示例**（整理最近 5 条未推送提交，仅作说明）：

```bash
git fetch github
git rebase -i HEAD~5   # 在编辑器中 squash/reword/fixup；推送用 github 远程分支
```

## 8. 分支清理

合并并删除远程特性分支后，本地执行：

```bash
git fetch --prune github
git branch -d feature/old-topic    # 已合并的本地分支
```

保持 **`git branch -a`** 可读，避免「分支乱麻」；与 `08`「定期枚举」精神一致。

## 9. 相关章节

- 北极星与生命周期矩阵：`08`
- 拓扑与 push 节律：`10`
- CLI 与 Git Graph：`51`
- 多 Agent 与 `main` 文件冲突：`53`
- GitHub 保护：`06`

## 修订记录

| 日期 | 摘要 |
|------|------|
| 2026-05-14 | 初版（六条、约定式提交、rebase -i）。 |
| 2026-05-14 | **§3 锁定**：GitHub 合入闸 + bare ff-only；**§6** 改 GitNet 流程；**§3.5** 改为迁回说明；§7/§8 示例 fetch 目标调整。 |
| 2026-05-13 | **§4**：提交首行描述与正文**铁律中文**（`type`/`scope` 仍英文关键字）；与根 `CONTRIBUTING` 对齐。 |
