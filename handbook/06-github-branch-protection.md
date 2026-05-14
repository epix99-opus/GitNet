# GitHub：分支保护与 GitNet 本仓「合入闸」

## 目的

- **组织默认**：防止协作者**习惯直推 GitHub `main`** 而与 epix bare 镜像/主线冲突；与 [10-topology.md](10-topology.md) 默认叙述一致。
- **GitNet 本元仓库（`epix99-opus/GitNet`）**：自 **2026-05-14** 起，**GitHub `main` 即合入闸**（须 **Pull Request**）；epix bare 上 **`main`** 仅由 **GitHub→bare ff-only** 同步；见 [10-topology.md](10-topology.md)「本元仓库与全局图」、[56-git-workflow-quality-practices.md](56-git-workflow-quality-practices.md)、[90-process-log.md](90-process-log.md)。

## 在 GitHub 网页上的最短路径（`epix99-opus/GitNet`）

1. **Settings** → **Branches** → **Branch protection rules** → **Add rule**。
2. **Branch name pattern**：填 `main`（若默认分支为 `master` 则填 `master`）。
3. 建议勾选（按团队严格程度取舍）：
   - **Require a pull request before merging**。
   - **Require approvals**（至少 **1** 人；单人维护可用仓库管理员 **`gh pr merge --admin`** 合入，见下节 CLI）。
   - **Do not allow bypassing the above settings**（按需；若开启，管理员也不能绕闸，紧急变更须先改规则）。
4. Save。用非管理员账号试推一次 `main`，应被拒绝即验收通过。

## 用 GitHub CLI 配置（本仓已执行示例）

在已 `gh auth login` 的机器上可复跑（参数可按团队收紧/放宽）：

```bash
gh api repos/epix99-opus/GitNet/branches/main/protection -X PUT --input - <<'JSON'
{
  "required_status_checks": null,
  "enforce_admins": false,
  "required_pull_request_reviews": {
    "required_approving_review_count": 1,
    "dismiss_stale_reviews": true,
    "require_code_owner_reviews": false
  },
  "restrictions": null,
  "required_linear_history": false,
  "allow_force_pushes": false,
  "allow_deletions": false
}
JSON
```

**验收**：`gh api repos/epix99-opus/GitNet/branches/main/protection -q .required_pull_request_reviews.required_approving_review_count` 应输出 `1`（或与团队设定一致）。

## 与 epix / bare 的关系（GitNet 本仓现行）

| 对象 | 角色 |
|------|------|
| **GitHub `main`** | **合入闸**：仅接受 **PR merge** 产生的更新；人类/Agent **不向 `main` 直推**（除非临时放宽规则并在 `90` 记录）。 |
| **工作克隆** | 日常在 **`chore/*` / `docs/*` 等分支** 上开发，`**git push -u github <分支>**` 打开 PR；**勿**用 **`git push origin main`** 把未过 PR 的提交写入 bare 以冒充合入。 |
| **epix bare `main`** | **跟随**：由 **`handbook/scripts/gitnet-sync-github-main-to-bare.sh`**（或 `~/bin/` 拷贝）对 **`github/main`** 做 **ff-only** 更新；与旧「bare **定时 push github** 更新镜像 `main`」**方向相反**，属登记例外。 |
| **旧脚本 `gitnet-push-github.sh`** | 已对 **GitNet 本仓主线** 默认 **停用**（见 [30-mac-epix-setup.md](30-mac-epix-setup.md)）；避免与分支保护冲突。 |

**其它业务仓**：仍适用「保护 GitHub 镜像、日常推 epix bare」的默认叙述，除非该仓在自身 `90` 另有登记。

## 修订记录

| 日期 | 摘要 |
|------|------|
| 2026-05-14 | 重写：GitNet 本仓 **GitHub 合入闸**、`gh api` 示例、与 bare **github→main** 同步；旧「仍推 epix」改为分层说明。 |
