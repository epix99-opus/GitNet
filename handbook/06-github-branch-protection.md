# GitHub：与「epix 权威、本仓为从」一致的分支保护

## 目的

防止协作者**习惯直推 GitHub** 而与 epix bare 主线冲突；与 [10-topology.md](10-topology.md) 一致。

## 在 GitHub 网页上的最短路径（`epix99-opus/GitNet`）

1. **Settings** → **Branches** → **Branch protection rules** → **Add rule**。
2. **Branch name pattern**：填 `main`（若默认分支为 `master` 则填 `master`）。
3. 建议勾选（按团队严格程度取舍）：
   - **Require a pull request before merging**（或至少 **Restrict who can push** 为管理员）。
   - **Do not allow bypassing the above settings**（管理员也遵守，可选）。
4. Save。用非管理员账号试推一次，应被拒绝即验收通过。

## 与 epix 的关系

- 保护的是 **GitHub 上的镜像**；日常开发仍推 **epix**。
- epix 定时 `push github` 若使用有权限的 machine 账户，需保证该账户**仍能推**（可把 bot 用户加入允许直推的例外，或改用只推特定分支的 CI——超出本页范围时在 [90-process-log.md](90-process-log.md) 记决策）。
