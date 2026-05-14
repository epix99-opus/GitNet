# 参与 GitNet 仓库贡献

## 提交信息（默认）

本仓库采用 **[约定式提交](https://www.conventionalcommits.org/zh-hans/v1.0.0/)** 风格，与历史实践对齐：

```text
<type>(<scope>): <简短描述>
```

示例：`docs(handbook): 补充 56 工作流质量实践`、`fix(scripts): 修正 glab 脚本编码说明`。

**类型**常用：`feat`、`fix`、`docs`、`chore`、`refactor`、`test`、`ci`。**范围**建议用手册章、目录或子系统名（如 `handbook`、`90`、`glab`）。

## 工作流与分支

- **完整六条**（小步提交、`git add -p`、特性分支与 PR、`rebase -i`、分支清理、元仓库与业务仓分层）：见 [handbook/56-git-workflow-quality-practices.md](handbook/56-git-workflow-quality-practices.md)。
- **拓扑与 push 目标**（epix bare、GitHub 镜像）：见 [handbook/10-topology.md](handbook/10-topology.md)。
- **Agent 与人类契约**：见 [AGENTS.md](AGENTS.md)。

## 秘密

勿将密钥、token、口令、私钥写入仓库或 Issue 正文。凭据管理见 [handbook/08-agent-first-collaboration-vision.md](handbook/08-agent-first-collaboration-vision.md)。
