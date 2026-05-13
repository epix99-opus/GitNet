# `docs/` 参考文 → `handbook/` 定稿 对照表

说明：`docs/` 下两篇为起草与参考，**非唯一信源**。未定稿材料先放 `docs/`，定稿迁移与目录边界见 [07-documentation-placement.md](07-documentation-placement.md)。已定稿差异与采纳关系如下。

## 《Git 多设备多账号体系、跨系统配置与长期维护方案》

| 参考文档章节 | handbook 定稿位置 | 已定稿差异 / 备注 |
|--------------|-------------------|-------------------|
| 一、核心需求：双备份「双向同步」 | [10-topology.md](10-topology.md)、[AGENTS.md](../AGENTS.md) | 定稿改为 **epix bare 权威 + GitHub 单向镜像**；不推荐日常「双向对拉」以免冲突 |
| 二、includeIf 三级身份 | [40-identity-and-includeIf.md](40-identity-and-includeIf.md)、[templates/](templates/) | 采纳；人类=GitHub 账号；Agent=`HOSTNAME-TOOL` + 统一邮箱 |
| 三、SSH 多密钥 | [45-ssh-tailscale-for-humans.md](45-ssh-tailscale-for-humans.md)、[30-mac-epix-setup.md](30-mac-epix-setup.md) | 采纳思路；Host 名示例统一为 `git-epix`（可改） |
| 三、双远程 + 手动双向同步脚本 | [20-windows-setup.md](20-windows-setup.md)、[30-mac-epix-setup.md](30-mac-epix-setup.md) | 定稿：**push 以 epix 为主**；GitHub 由 epix **定时 push**，不用工作副本对 GitHub 做日常主线 push |
| 四、桌面客户端 | [50-sourcetree.md](50-sourcetree.md) | 定稿强调与**系统 Git/OpenSSH** 一致 |
| 五、维护清单 | [90-process-log.md](90-process-log.md)、[00-truth-sources.md](00-truth-sources.md) | 合并为维护与进程记录；双仓对比时以 **epix vs GitHub** 角色为准 |

## 《Git 跨系统多设备统一配置与长期维护设想》

| 参考文档章节 | handbook 定稿位置 | 已定稿差异 / 备注 |
|--------------|-------------------|-------------------|
| 三、全局统一身份 | [40-identity-and-includeIf.md](40-identity-and-includeIf.md) | 人类全局一致；Agent 在子目录用 includeIf **刻意区分**作者名 |
| 四、Dotfiles + 软链接 | （未单独成章） | **可选后续**：可在 `handbook/80-dotfiles-optional.md` 扩展；当前不阻塞 GitNet 主线 |
| 四、includeIf 扩展 | [templates/](templates/) | 采纳 |
| 五、中心 Bare | [10-topology.md](10-topology.md)、[30-mac-epix-setup.md](30-mac-epix-setup.md) | 采纳；权威落在 **epix** |
| 五、feature/develop/main 流程 | （未强制写入定稿） | **后续修订清单**：若团队需要 Git Flow，在 `10-topology` 增补分支策略一节 |
| 六、维护与排查 | [90-process-log.md](90-process-log.md) | 采纳思路 |

## 后续修订清单（建议）

1. 在 `handbook/10-topology.md` 增加「分支与保护规则」一节（是否与 GitHub branch protection 对齐）。
2. 可选：`handbook/80-dotfiles-optional.md` 描述 dotfiles 仓库同步 `.gitconfig`。
3. 若迁移完成：在 `docs/` 两篇顶部增加一行指向 `handbook/README.md`（**需人类确认**是否改历史参考文件）。
