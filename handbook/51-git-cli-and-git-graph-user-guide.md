# Git 命令行与「Git Graph」：人类操作指南

面向：**已在仓库目录中**、需要日常拉取/提交/看图谱的维护者。与本项目**远端习惯**（epix bare、GitHub 镜像）的关系见 [10-topology.md](10-topology.md)；图形客户端 SourceTree 与系统 Git 对齐见 [50-sourcetree.md](50-sourcetree.md)。

## 1. 终端最小闭环

在克隆根目录执行（路径按你的本机为准）：

```bash
git status                    # 哪些文件被改、是否在分支上
git diff                      # 未暂存改动
git add -p                    # 交互式挑选块（可选）；或 git add <文件>
git commit -m "说明本次目的"   # 生成提交
git pull --ff-only            # 与远端同步（若团队允许 fast-forward only）
git push                      # 推到上游（本项目中常为 epix bare，见 10）
```

**新建分支并切换**：

```bash
git checkout -b feat/my-topic    # 或 git switch -c feat/my-topic
```

**合入主线（示例）**：

```bash
git checkout main
git pull --ff-only
git merge feat/my-topic          # 无冲突则自动产生 merge commit；策略依团队约定
```

## 2. 冲突出现时

- `git pull` 或 `git merge` 可能停住并提示 **CONFLICT**。
- 用 `git status` 查看 **both modified** 的文件。
- 打开这些文件，搜索 **`<<<<<<<`**：在 **`=======`** 与 **`>>>>>>>`** 之间选择保留内容或合并两边，删除标记行。
- 保存后：`git add <已解决文件>`，再 `git commit`（merge）或按 rebase 提示 `git rebase --continue`。

更多 Agent/多会话同文件场景见 [53-multi-agent-main-branch-and-agent-files.md](53-multi-agent-main-branch-and-agent-files.md)。**约定式提交、小步拆分、`rebase -i` 与分支清理**见 [56-git-workflow-quality-practices.md](56-git-workflow-quality-practices.md)。

## 3. 终端里的「历史图」

最近若干条、带分支装饰的一维图：

```bash
git log --graph --oneline --decorate -n 30
```

查看**尚未推到远端**的提交（假设上游分支为 `main`）：

```bash
git fetch
git log origin/main..HEAD --oneline
```

## 4. Cursor / VS Code 扩展「Git Graph」

1. **安装**：扩展市场搜索 **Git Graph**（作者 mhutchie 的扩展为常用实现之一；若改用其它图谱扩展，以扩展说明为准）。
2. **打开**：命令面板（macOS `Cmd+Shift+P` / Windows `Ctrl+Shift+P`）→ 输入 **Git Graph: View Git Graph**（或侧栏 Git Graph 图标）。
3. **使用**：点选节点可看该提交的变更列表；与内置「源代码管理」互补——前者偏**历史与分支拓扑**，后者偏**当前工作区**。

**注意**：扩展仍调用**本机同一 `git` 可执行文件**；若图形里作者与终端不一致，检查 IDE 是否指向了另一套 Git（对照 [50-sourcetree.md](50-sourcetree.md) 的「与系统 Git 对齐」思路）。

## 5. 与本项目阅读顺序的衔接

- 拓扑与默认 push：[10-topology.md](10-topology.md)。
- 多机身份：[55-multi-node-multi-agent-git.md](55-multi-node-multi-agent-git.md)。
- 在 epix 上远程开 CAMA：[54-remote-work-cama-on-epix-from-other-nodes.md](54-remote-work-cama-on-epix-from-other-nodes.md)。
- **提交规范与工作流六条（约定式提交、分支、rebase -i 等）**：[56-git-workflow-quality-practices.md](56-git-workflow-quality-practices.md)；根 [CONTRIBUTING.md](../CONTRIBUTING.md)。

## 修订记录

| 日期 | 摘要 |
|------|------|
| 2026-05-14 | 初版：CLI 闭环、`git log --graph`、Git Graph；§2/§5 链 **`56`** 与根 `CONTRIBUTING.md`。 |
