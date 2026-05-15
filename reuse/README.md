# GitNet `reuse/` — 可外推资产包（索引层）

本目录是 **GitNet 仓库内** 的 **外推索引与薄包装**：把已形成的方法、模板、脚本、流程与 Agent 契约 **目录化**，便于其它项目或其它会话中的 Agent **按表取用**，而**不把** `handbook/` 整本复制出去造成双权威。

## 与 `handbook/` 的关系（必读）

| 层级 | 职责 |
|------|------|
| **`handbook/`** | **唯一定稿信源**：拓扑、bare、SSH、launchd、逐条操作。 |
| **`reuse/`** | **外推入口**：清单、Raw 链、接入步骤、强约束给「外仓 Agent」；**不**替代 `handbook` 正文。 |

若冲突：**以 `handbook/` 与 [AGENTS.md](../AGENTS.md) 为准**；`reuse/` 仅作导航与拷贝策略说明。

## 5 分钟速览

1. 读 [**AGENT_MUST_READ.md**](AGENT_MUST_READ.md)（外仓 Agent **强约束**）。  
2. 打开 [**CATALOG.md**](CATALOG.md) 按分类找资产 → 用 **权威路径** 或 **Raw URL** 拉取。  
3. 新仓接入：跟 [**BOOTSTRAP_OTHER_REPO.md**](BOOTSTRAP_OTHER_REPO.md) 勾选。  
4. 需要物理拷贝进外仓时：先看 [**vendor/README.md**](vendor/README.md) 边界，再决定 **subtree / submodule / 单次拷贝**。

## 引用方式（三种）

- **Raw 链**：只读、无版本锁；适合文档链。  
- **git subtree / submodule**：版本跟随 GitNet `main`（或 pin tag）。  
- **一次性拷贝**：必须在拷贝头注明 **来源仓库 + commit SHA**，并安排定期对账。

## 修订

本包结构变更应记 [handbook/90-process-log.md](../handbook/90-process-log.md)；定稿事实变更仍在 `handbook/` 对应章。
