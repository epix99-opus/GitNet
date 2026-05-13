# 多节点 × 多 Agent：Git 身份与目录总方案

本文在 [40-identity-and-includeIf.md](40-identity-and-includeIf.md) 之上，对 **epix / glab / woot** 三台「编程主力节点」与 **多类编程 Agent**（Cursor、Codex、Claude Code 等）给出**统一约定**与**落地检查表**。网络 IP 仍以 NetOps `network_facts.env` 为准，本文只写 **Git 作者名与 `includeIf` 策略**。

> **实机说明**：**woot** 已由 epix 经 Tailscale SSH（用户 **`woot@woot`**）落地 `includeIf` 与片段；**glab** 在 epix 侧 **`ssh-keyscan`/TCP 22 不可用**（OpenSSH 未暴露或未装），须人类按 [46-tailscale-remote-git-identity.md](46-tailscale-remote-git-identity.md) 开启 `sshd` 并授权公钥后，再在 epix 执行 `ssh glab ...` 或于 glab 本机运行 [templates/windows-glab-git-includeIf.ps1](templates/windows-glab-git-includeIf.ps1)。

---

## 1. 命名约定（全节点一致）

| 维度 | 规则 | 示例 |
|------|------|------|
| **HOSTNAME** | 与 Tailscale 机器名一致（小写、无空格），便于日志与提交历史对齐 | `epix`、`glab`、`woot` |
| **TOOL** | 全小写，工具代号 | `cursor`、`codex`、`claude-code` |
| **作者名** | `{HOSTNAME}-{TOOL}` | `epix-cursor`、`glab-codex`、`woot-claude-code` |
| **邮箱** | 一律 **`epix99@icloud.com`**（Agent 与人类兜底均为此组织约定邮箱；人类展示名仍用全局 `user.name`） | — |
| **人类兜底** | 各机全局 `[user]`：`name` 与 GitHub 展示策略一致，`email = epix99@icloud.com` | 见各 OS 模板 |

---

## 2. 节点一览（Tailscale 名 → 角色）

| Tailscale 名 | OS | 编程节点 | 备注 |
|--------------|-----|----------|------|
| **epix** | macOS | 是 | 权威 bare 所在机；本方案默认 `hostname -s` 为 `epix` |
| **glab** | Windows 11 | 是 | 工作副本常见盘符 `E:\` / `D:\`；`core.autocrlf=true` |
| **woot** | macOS | 是 | 与 epix **同构**：用 macOS 模板 + `HOSTNAME=woot` |

---

## 3. 目录与 `includeIf` 策略（推荐）

### 3.1 原则

1. **按路径区分 Agent 身份**：`includeIf "gitdir:…/"` 必须指向「该工具主要改代码的目录树」，且**更具体的子路径块写在更后面**，以便覆盖较宽的父路径（例如先 `~/Dev/`，后 `~/Dev/CodexDev/`）。
2. **`agent-work/<TOOL>/`**：与 [templates/gitconfig.mac.main.ini](templates/gitconfig.mac.main.ini) 一致，用于「只给某工具用」的克隆/工作副本；每机可建空目录备查。
3. **避免双权威**：不在仓库 `--local` 写 `user.*`，除非该仓刻意要覆盖节点默认（见 [40-identity-and-includeIf.md](40-identity-and-includeIf.md)）。

### 3.2 epix（macOS）— 推荐块顺序

| 顺序 | `gitdir` 前缀（示例） | 片段作者名 | 说明 |
|------|------------------------|------------|------|
| 1 | `/Users/epix/Dev/` | `epix-cursor` | Cursor 主力区（**已实装**） |
| 2 | `/Users/epix/agent-work/cursor/` | `epix-cursor` | 手册约定专用树（**已实装**） |
| 3 | `/Users/epix/Dev/CodexDev/` | `epix-codex` | 覆盖 Codex 目录（**已实装**） |
| 4 | `/Users/epix/agent-work/codex/` | `epix-codex` | Codex 专用克隆区（**已实装**） |
| 5 | `/Users/epix/agent-work/claude-code/` | `epix-claude-code` | Claude Code 工作区（**已实装**；片段 `~/.gitconfig-fragment-claude-code`） |

若某工具实际只在 **`~/Dev/其他目录`** 工作，可在该机 `.gitconfig` **末尾**追加一行更精确的 `includeIf`，无需改本文件。

### 3.3 glab（Windows）— 推荐块顺序

| 顺序 | `gitdir` 前缀（示例，按你本机用户目录改写） | 片段作者名 |
|------|---------------------------------------------|------------|
| 1 | `C:/Users/你的用户名/Dev/` | `glab-cursor` |
| 2 | `C:/Users/你的用户名/agent-work/cursor/` | `glab-cursor` |
| 3 | `C:/Users/你的用户名/Dev/CodexDev/`（若存在） | `glab-codex` |
| 4 | `C:/Users/你的用户名/agent-work/codex/` | `glab-codex` |
| 5 | `C:/Users/你的用户名/agent-work/claude-code/` | `glab-claude-code` |

路径一律在 `includeIf` 中用 **正斜杠**；片段文件路径同样用 `C:/Users/.../.gitconfig-fragment-cursor` 形式（见 [40-identity-and-includeIf.md](40-identity-and-includeIf.md)）。

### 3.4 woot（macOS）— 与 epix 同构

将上表 epix 的路径前缀改为 **woot 用户主目录**（例如 `/Users/woot/Dev/`），作者名分别为 **`woot-cursor`**、`woot-codex`、`woot-claude-code`。**不要用 epix 的主目录路径抄到 woot 上**。

> **SSH 登录用户**：经 Tailscale 验证，**woot 机 Unix 用户名为 `woot`**（`epix@woot` 默认不可用）；epix 侧 `~/.ssh/config` 应使用 `User woot`。详见 [46-tailscale-remote-git-identity.md](46-tailscale-remote-git-identity.md)。

---

## 4. 各工具与「非 Git」配置边界（简述）

| 工具 | Git 作者由谁决定 | 其它配置 |
|------|------------------|----------|
| **Cursor** | 上述 `includeIf` + 仓库根 [AGENTS.md](../AGENTS.md)、`.cursor/rules/` | User Rules / Skills 见 AGENTS；**不入本表详述** |
| **Codex CLI** | 同上（依赖系统 `git`） | `~/.codex/` 等；与 Git 身份解耦 |
| **Claude Code** | 同上 | `~/.claude/` 等；建议工作区落在 `agent-work/claude-code/` 或单独 `includeIf` |

---

## 5. 三机自检命令（复制执行）

**macOS（epix / woot）** — 在「应走 Agent」的仓库根：

```bash
git config --show-origin user.name
git config --show-origin user.email
```

**Windows（glab）** — PowerShell：

```powershell
git config --show-origin user.name
git config --show-origin user.email
```

**人类兜底** — 在 `/tmp` 或任意非 `includeIf` 覆盖目录新建 `git init` 后执行同上，应指向全局 `.gitconfig` 的人类 `user.name` / `epix99@icloud.com`。

---

## 6. 演进清单（可选）

1. **woot / glab**：按上表补齐片段文件与 `includeIf`；结果记入 [90-process-log.md](90-process-log.md)。
2. **Claude Code 主力目录**：若固定在 `~/Dev/CcDev` 等，可在该机 `.gitconfig` 末尾增加对应 `includeIf` → `epix-claude-code`（或 `HOSTNAME-claude-code`）。
3. **若某仓要人类作者**：仅在该仓库 `git config --local user.name` / `user.email`，并记录在进程日志。

---

## 修订记录

- 2026-05-13：补充 **woot** 经 Tailscale SSH 实装与 **glab** 门槛；SSH 用户名为 **`woot`**；新增 [46-tailscale-remote-git-identity.md](46-tailscale-remote-git-identity.md)。
- 2026-05-12：首版；基于 epix 当前 `~/Dev` + `agent-work` 实装与 tailnet 节点名归纳 glab/woot 方案。
