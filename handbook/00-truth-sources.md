# 唯一信源与冲突规则

## 信源层级（从高到低）

**内容与目录应写到哪里（表格级指引）**：见 [07-documentation-placement.md](07-documentation-placement.md)（含 `docs/` / `handbook/` / NetOps 边界）。

1. **机器可验证事实**：操作系统、主机名、Tailscale DNS 名称、磁盘上的 bare 路径、SSH 是否连通。
2. **本目录 `handbook/`**：定稿拓扑、操作步骤、身份与远端约定；**有变更时在此更新**，并视需要在 [90-process-log.md](90-process-log.md) 记一笔。
3. **仓库根目录 [AGENTS.md](../AGENTS.md)**：编程 Agent 与人类的分工、**全局铁律（能执行则不得回抛人类）**、提交命名、禁止事项；与 handbook 冲突时，**以 handbook 拓扑与身份章节为准**，AGENTS 应改为引用 handbook 而非重复叙述拓扑细节。
4. **[人类初始指令.md](../人类初始指令.md)**：项目意图与范围；**不承载**具体路径、主机名、密钥等易变事实。若与 1～3 冲突，以 1～3 为准，并在此文或进程日志中注明「意图不变、落地以 handbook 为准」。
5. **`docs/` 下两篇参考文档**：历史与思路参考；**非定稿**。对照表见 [70-docs-migration-map.md](70-docs-migration-map.md)。
6. **[05-project-scope-and-delivery.md](05-project-scope-and-delivery.md)**：项目元定义、交付边界、会话结论归并、人类检查清单；与 `00` 不冲突时作为意图与验收的摘要信源。
7. **[08-agent-first-collaboration-vision.md](08-agent-first-collaboration-vision.md)**：**北极星**——以 Agent 为执行主体的多设备协作意图；与 AGENTS 铁律、秘密禁令一并阅读，避免把「意图」理解成「可违反安全」。

## 冲突时怎么处理

- **同一主题只维护一处**：例如「默认远端是谁」只写在 [10-topology.md](10-topology.md) 与对应平台 setup 中一处为主，其它文档用链接指向。
- **禁止双权威**：业务 Git 对象只有一个权威裸仓（epix）；GitHub 为从镜像，不在手册中描述为「与 epix 双向对拉的主线」。
- **修订流程**：改 handbook → 若影响 Agent 行为，同步改 AGENTS.md 或 `.cursor/rules` 中的链接与短约束 → 在 [90-process-log.md](90-process-log.md) 记录日期与摘要。

## Windows 与 Mac 事实

- 当前已确认的**工作副本**可存在于 Windows（例如本机 Cursor 工作区）；**权威 bare** 仅在名为 **epix** 的 Mac 上初始化与维护。
- 各 OS 的 `core.autocrlf` 等差异见 [20-windows-setup.md](20-windows-setup.md) 与 [30-mac-epix-setup.md](30-mac-epix-setup.md)，不得互相复制对方片段到本机全局配置。
