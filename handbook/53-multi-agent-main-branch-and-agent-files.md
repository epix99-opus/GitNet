# 多 Agent、主分支与仓库根配置文件：会不会冲突？

本文回答：多个编程 Agent（或多会话）都在 **`main`（或同一长期分支）** 上提交，并在仓库根留下 **`AGENTS.md`**、**`CLAUDE.md`**、**`.cursor/rules/*`** 等——**会不会冲突**、与 **`includeIf`** 是什么关系。

> **命名**：本仓库约定根文件为 **`AGENTS.md`**（见仓库根 [AGENTS.md](../AGENTS.md)），与 Cursor 常见约定一致。不建议再引入并行的 `AGENT.md`，以免双信源。

## 1. 结论表

| 情形 | 是否会产生 Git 冲突 |
|------|----------------------|
| 两个主体先后改**同一文件同一区域**，后推送者在推送前未合并对方提交 | **会**：`push` 被拒或需先 `pull`/`pull --rebase`，出现合并冲突时需人工解决。 |
| 各工具各改**不同文件**（例如只改 `.cursor/rules/foo.md` 与只改 `CLAUDE.md`） | **通常不会**：可快进或自动合并。 |
| 多节点各有**本地克隆**，各自提交、**作者不同**、修改不重叠 | **对象库无冲突**：远端接受多条不同 `author` 的提交；冲突只发生在**合并两条历史**时。 |
| 同一节点、同一目录、**两个进程同时写同一工作区** | **文件系统/工作区风险**（非 Git 语义）：可能丢改；应用层应避免并行写同一克隆。 |

## 2. `includeIf` 不解决什么

- **`includeIf`** 只决定 **`user.name` / `user.email` 从哪条片段读**（见 [55-multi-node-multi-agent-git.md](55-multi-node-multi-agent-git.md)）。
- **不消除**多人改同一文件的合并冲突，也不替代「先拉后推」的习惯。

## 3. 推荐做法（降低冲突）

1. **一个会话一条分支**（如 `feat/agent-topic`），合入 `main` 前 `pull` + PR/评审或与团队约定合并方式——与 [08-agent-first-collaboration-vision.md](08-agent-first-collaboration-vision.md) 中主分支/特性分支的叙述一致；**约定式提交、rebase -i 边界、分支清理**见 [56-git-workflow-quality-practices.md](56-git-workflow-quality-practices.md)。
2. **若必须在 `main` 上直接改**：养成 **`git pull`（或 `pull --rebase`）→ 编辑 → `commit` → `push`** 的习惯；避免长时间本地分叉。
3. **共享配置文件分块**：`AGENTS.md` / `CLAUDE.md` 用清晰二级标题分「Cursor / Codex / Claude」或「通用 / 各工具」，减少多人改同一小段。
4. **大改前沟通或锁文件**：与团队节奏一致即可；Git 本身无「锁」概念，靠流程或外部工具。

## 4. 冲突长什么样（便于识别）

- 推送时：`! [rejected]`、`non-fast-forward`。
- 合并或 rebase 后：工作区内文件出现 **`<<<<<<<`** / **`=======`** / **`>>>>>>>`** 标记，需编辑后 `git add` 再继续 `merge`/`rebase`。

命令级入门见 [51-git-cli-and-git-graph-user-guide.md](51-git-cli-and-git-graph-user-guide.md)。

## 修订记录

| 日期 | 摘要 |
|------|------|
| 2026-05-14 | 初版；§3 链 **`56`**。 |
