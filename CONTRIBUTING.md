# 参与 GitNet 仓库贡献

## 提交信息（默认）

本仓库采用 **[约定式提交](https://www.conventionalcommits.org/zh-hans/v1.0.0/)** 风格：

```text
<type>(<scope>): <简短描述>
```

示例：`docs(handbook): 同步 06 分支保护说明`、`chore(scripts): 增加 github→bare 同步脚本`。

**类型**常用：`feat`、`fix`、`docs`、`chore`、`refactor`、`test`、`ci`。**范围**建议用手册章、目录或子系统名（如 `handbook`、`90`、`glab`）。

## 合入流程（GitNet 本仓，2026-05-14 起）

**`main` 仅通过 GitHub Pull Request 合入**；epix bare 上 **`main`** 由 **`gitnet-sync-github-main-to-bare.sh`** 与 **`github/main` ff-only 对齐**。详见 [handbook/10-topology.md](handbook/10-topology.md) 例外节、[handbook/56-git-workflow-quality-practices.md](handbook/56-git-workflow-quality-practices.md) §3、[handbook/30-mac-epix-setup.md](handbook/30-mac-epix-setup.md) §4～§5。

### 操作清单（工作副本已配置 `origin` = bare、`github` = GitHub 时）

1. **`git checkout main`** → **`git pull github main`**（或先 `fetch github`）保持与远端 **`main`** 一致。
2. **`git checkout -b docs/your-topic`**（或 `chore/`、`fix/`、`feat/` 前缀）。
3. 编辑、`git add …`，**小步** **`git commit -m 'type(scope): …'`**（可用 **`git add -p`**）。
4. **`git push -u github docs/your-topic`**。
5. 在 GitHub 上 **New Pull Request**（base **`main`** ← compare 你的分支）。已装 **`gh`** 时可：`gh pr create --base main --head docs/your-topic --title "…" --body "…"`。
6. 审查与合并：默认分支保护要求 **至少 1 个 approving review**；**单人维护**可用仓库管理员执行 **`gh pr merge <N> --admin --merge`**（或网页等效）完成合入。
7. 在 **epix** 上执行 **`~/bin/gitnet-sync-github-main-to-bare.sh`**（或等待 **`com.gitnet.sync-github-to-bare`** launchd），将 **bare `main`** 与 **`github/main`** 对齐。
8. 回到工作副本：**`git fetch origin`**，**`git checkout main`**，**`git merge --ff-only origin/main`**（或 `git pull --ff-only origin main`）。

**禁止**：为更新 **`main`** 而 **`git push origin main`**（把未过 PR 的提交推上 bare）。

## 其它约定

- **六条工作流质量实践**（`rebase -i`、分支清理等）：[handbook/56-git-workflow-quality-practices.md](handbook/56-git-workflow-quality-practices.md)。
- **分支保护配置**：[handbook/06-github-branch-protection.md](handbook/06-github-branch-protection.md)。
- **Agent 与人类契约**：[AGENTS.md](AGENTS.md)。

## 秘密

勿将密钥、token、口令、私钥写入仓库或 Issue 正文。凭据管理见 [handbook/08-agent-first-collaboration-vision.md](handbook/08-agent-first-collaboration-vision.md)。
