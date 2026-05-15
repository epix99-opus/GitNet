# 人类操作：把 GitNet `reuse/` 外推包接到「新项目」与三种编程 Agent

本文给 **人类维护者**：在**其它业务仓库**新开项目时，如何把 **`reuse/`** 的约束与索引交给 **Cursor、Codex CLI、Claude Code** 使用。  
**Git 作者名、`includeIf` 路径、拓扑默认值** 仍以 GitNet **`handbook/40`**、**`handbook/55`**、**`handbook/10`** 为准；本文只写 **外推包引用方式 + 各工具放哪克隆**，避免与定稿冲突。

---

## 0. 先选「版本锚」（强烈建议）

| 方式 | 做法 | 适用 |
|------|------|------|
| **固定 SHA** | 在浏览器打开 [GitHub 仓库 commit 列表](https://github.com/epix99-opus/GitNet/commits/main)，复制 **full SHA**；Raw 地址将 `raw.githubusercontent.com/epix99-opus/GitNet/main/` 中的 **`main`** 换成该 **SHA**（例如 `…/84998e4944531aa76754240aaea8683b31cf202e/reuse/…`）。 | 生产/长期外仓 |
| **跟随 `main`** | 使用下文 `raw.githubusercontent.com/.../main/...` | 能接受上游更新的探索仓 |

**Raw 基座**（`main`）：`https://raw.githubusercontent.com/epix99-opus/GitNet/main/`  
外推包三件套路径：

- `reuse/AGENT_MUST_READ.md`
- `reuse/CATALOG.md`
- `reuse/BOOTSTRAP_OTHER_REPO.md`

---

## 1. 所有新项目通用（与具体 Agent 无关）

在**对方仓库根**（与 `.git` 同级）完成下列最少集合；做完再交给任一 Agent 开干。

1. **根 `AGENTS.md`**（或你们已有等价物）中增加一节，例如标题 **「GitNet 外推包（只读索引）」**，正文必须包含：  
   - 一句：**本任务涉及多机/多 Agent/对齐 GitNet 规范时**，Agent **须先阅读** `AGENT_MUST_READ` 与 **`CATALOG`**（贴 **Raw URL**）。  
   - **版本锚**：写明 GitNet **commit SHA** 或 tag；若跟 `main`，写明「以拉取时 `main` 为准」并约定人类**季度对账**。  
   - 一句：**禁止**把 GitNet 实例路径（bare 路径、固定主机名）当作本项目的默认事实。  
2. **`CONTRIBUTING.md`**（若已有）：补一行「合并/分支策略若参考 GitNet，见 `CATALOG` 中 `56`、`06`、`10` 行」。  
3. **进程日志**：在对方仓建 **`PROCESS_LOG.md`** 或等价物（时间序），重大例外写一条——对应 GitNet **`90`** 思路。  
4. **接入勾选**：人类自己跟 [BOOTSTRAP_OTHER_REPO.md](BOOTSTRAP_OTHER_REPO.md)（可打印 Raw）。

**效力说明**：单靠「首条聊天贴链」**最弱**；写进 **`AGENTS.md` +（推荐）`.cursor/rules`** 后，**Cursor** 侧重复会话更稳；Codex / Claude Code 仍读仓库文件，故 **`AGENTS.md` 是三者共用的底线**。

---

## 2. 克隆目录与 Git 作者（三工具对齐）

三种工具的 **Git 作者**都由系统 **`git config`** 决定；GitNet 组织内推荐用 **`includeIf "gitdir:…"`** 按**目录**分流（见 **`handbook/55`** §3）。

| 工具 | 推荐工作区根（epix 示例；其它机器把 `epix` 换成本机 `HOSTNAME`） | 片段作者名示例 |
|------|------------------------------------------------------------------|----------------|
| **Cursor** | `~/Dev/<YourProject>/` 或 `~/agent-work/cursor/<YourProject>/` | `{HOSTNAME}-cursor` |
| **Codex CLI** | `~/Dev/CodexDev/<YourProject>/` 或 `~/agent-work/codex/<YourProject>/` | `{HOSTNAME}-codex` |
| **Claude Code** | `~/agent-work/claude-code/<YourProject>/`（或该机在 `55` §6 已登记的固定目录） | `{HOSTNAME}-claude-code` |

**验收（每个新克隆各跑一次）**：

```bash
cd /path/to/your/repo
git config --show-origin user.name
git config --show-origin user.email
```

应显示 **来自** `~/.gitconfig-fragment-cursor`（或 codex / claude-code 片段），**不是**误用人类全局名。人类兜底验收：在**未被** `includeIf` 覆盖的目录 `git init` 后执行同上，应回到人类 `user.name` / `epix99@icloud.com`（见 **`55`** §5）。

---

## 3. Cursor：新项目里怎么配

1. **用 Cursor 打开**对方仓库文件夹（File → Open Folder）。  
2. **仓库根**放置或更新 **`AGENTS.md`**（见 §1）。  
3. **（推荐）** 新建 **`.cursor/rules/`** 下一条规则文件，例如 `yourorg-reuse-gitnet.mdc`：  
   - `description`：说明「外推 / 多仓 / 对齐 GitNet 资产时先读 `reuse`」。  
   - `globs`：至少覆盖 `"**/*"` 或你们文档目录；可与 GitNet 的 **`gitnet-reuse-pack.mdc`** 思路一致（**不要**照抄 GitNet 拓扑进外仓）。  
   - 正文：三条以内——先读 Raw 的 `AGENT_MUST_READ` + `CATALOG`；定稿事实以**本仓** `README`/`handbook` 为准。  
4. **（可选）** Cursor **Settings → Rules → User Rules**：若你**个人**所有项目都要同一外推约束，可贴与 §3.3 等价的极短条（注意 User Rules 影响面大）。  
5. **首条 Agent 消息**（可选加强）：贴一句「遵守根 `AGENTS.md` §GitNet 外推包」+ 两个 Raw 链——**不能替代** §1～3，只能补当次强调。

---

## 4. Codex CLI：新项目里怎么配

1. **路径**：把业务仓克隆到 **`55`** 为 **Codex** 预留的 `gitdir` 下（见上表 §2），否则提交作者可能仍是 Cursor 或人类默认。  
2. **仓库根 `AGENTS.md`**：与 §1 相同；Codex **不读** `.cursor/rules`，**完全依赖**仓内可见的 `AGENTS.md` / `README.md`。  
3. **在终端**于仓库根执行 §2 的 `git config --show-origin` 验收。  
4. **会话**：新开 Codex 任务时，可首条消息写「先读本仓 `AGENTS.md` 中 GitNet 外推节 + Raw `CATALOG`」——与 Cursor 同理，属加强而非根约束。

---

## 5. Claude Code：新项目里怎么配

1. **路径**：工作区放在 **`agent-work/claude-code/`**（或该机 `55` §6 已追加的专用路径），保证 `includeIf` 命中 **`{HOSTNAME}-claude-code`** 片段。  
2. **仓库根 `AGENTS.md`**：与 §1 相同。  
3. **`~/.claude/`** 等与 Git 身份无关；**不要**在仓库 `--local` 写 `user.*` 除非刻意人类作者（见 **`40`** / **`55`**）。  
4. **验收**：§2 命令；若作者不对，先修 **`~/.gitconfig` 块顺序**（更具体的 `gitdir` 放后面）再试。

---

## 6. 与 `reuse/` 其它文档的分工

| 文档 | 给谁 | 用途 |
|------|------|------|
| [AGENT_MUST_READ.md](AGENT_MUST_READ.md) | Agent | 强约束、必读顺序 |
| [CATALOG.md](CATALOG.md) | 人类 + Agent | 资产表 + Raw |
| [BOOTSTRAP_OTHER_REPO.md](BOOTSTRAP_OTHER_REPO.md) | 人类 | 一页勾选接入 |
| **本文** | 人类 | 新项目 × 三工具落地步骤 |

---

## 7. 修订

变更本文件后，在 GitNet 本仓记 [handbook/90-process-log.md](../handbook/90-process-log.md)；若外推流程有定稿级变化，同步考虑 **`handbook/07`** 是否需补一句（由维护者判断）。
