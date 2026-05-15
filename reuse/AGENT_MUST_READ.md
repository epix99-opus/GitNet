# 外仓 / 外会话 Agent — **强制阅读**（`reuse` 包）

> 若你在 **其它 Git 仓库**、**其它 Cursor 工作区**、或 **被人类粘贴本段** 的情况下使用 GitNet 的可复用成果：**必须先读完本节与 [CATALOG.md](CATALOG.md)**，再动手改外仓或写接入文档。  
> **本文件不是法律文件**；其效力来自：**你的任务被指派为「遵循 GitNet 外推包」** 或 **外仓 `AGENTS`/README 显式引用本包**。

## 1. 信源铁律（违反则视为未按包执行）

1. **唯一事实源**：可复现的拓扑、路径、SSH、bare、launchd —— **只信** GitNet **`handbook/`** 中对应章节（以 Raw 打开 `main` 为准），**禁止**把聊天、旧 PDF、或本包某次摘录当「最新事实」。  
2. **禁止双写**：外仓若需要「自己的拓扑」，**在自家 `handbook`/`docs` 写自家事实**；从 GitNet 只 **链** 或 **拷贝已标注 SHA 的片段**，不得在两家仓库各改一版同一事实长期分叉。  
3. **禁止默认套用 epix 路径**：`~/git/...`、`woot@woot` 等仅为 **GitNet 组织实例**；外仓须按自家主机与 remote 重写。  
4. **秘密**：私钥、token、口令 **不得** 进入 Git 对象、Issue 正文、定稿手册；公钥单行信源见 `CATALOG` 中 `templates/epix-id_ed25519.pub` 条目。

## 2. 必读顺序（外推任务）

1. [reuse/README.md](README.md)（5 分钟）  
2. **本文**  
3. [reuse/CATALOG.md](CATALOG.md) — 只对你需要的 **行** 打开权威路径或 Raw  
4. [reuse/BOOTSTRAP_OTHER_REPO.md](BOOTSTRAP_OTHER_REPO.md) — 若在做「新仓接入」  
5. 根 [AGENTS.md](https://raw.githubusercontent.com/epix99-opus/GitNet/main/AGENTS.md) 中与「铁律、上抛格式、DoD」相关条文（外仓可摘 **条款号** 写入自家 `AGENTS`）

## 3. 最小闭环（与 GitNet 本仓 Agent 对齐）

- **Plan → 改 → 测 → 记录**：大改先规划；改后跑可得的最小检查；进程与验证写入 **外仓等价物**（如 `PROCESS_LOG.md`），重大例外须可审计。  
- **多机可验证事实**：若任务声称「各机已安装 / 已可达」，须满足 **已跑命令 + 落盘证据**（GitNet 范式见 `handbook/94` 与 `published/inventory-*` 条目于 `CATALOG`）。

## 4. 版本锚点（强制）

在外仓 `AGENTS.md` / `CONTRIBUTING.md` / README 中引用本包时，**须**写明至少一项：

- GitNet **commit SHA**（`main` 上 `git rev-parse HEAD`），或  
- **标签**（若有），或  
- **子模块 / subtree** 所 pin 的 revision。

便于日后 diff「我们当时按哪版 GitNet 接入」。

## 5. 与本仓 Cursor Agent 的关系

在 **GitNet 本仓库** 内工作时：仍以根 **`AGENTS.md`** 与 **`.cursor/rules/gitnet-collaboration.mdc`** 为准；**修改 `reuse/` 下文件**时须遵守 `.cursor/rules/gitnet-reuse-pack.mdc`。
