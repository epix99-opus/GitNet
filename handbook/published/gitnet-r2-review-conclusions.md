# GitNet R2 整仓多工具深度评审：合成结论

> **母单**：[GitHub Issue #16](https://github.com/epix99-opus/GitNet/issues/16)  
> **协作模式定稿**：[98-gitnet-deep-review-round2-git-bus.md](../98-gitnet-deep-review-round2-git-bus.md)  
> **分稿**：`handbook/published/review-r2-*.md`（五篇）

## 1. 谁审了什么（汇总）

| 分稿 | 作者（Git） | 侧重点 |
|------|----------------|--------|
| [review-r2-epix-cursor.md](review-r2-epix-cursor.md) | epix-cursor | 信源链、`.cursor` 覆盖面、`published` 索引债 |
| [review-r2-epix-claude-code.md](review-r2-epix-claude-code.md) | epix-claude-code | 叙事一致性 08/93/94/97/98、合成稿必要性 |
| [review-r2-epix-codex.md](review-r2-epix-codex.md) | epix-codex | bash/PS1 可维护性、`gh`/token 边界、路径大小写 |
| [review-r2-woot-cursor.md](review-r2-woot-cursor.md) | woot-cursor | 副机 mac 同构、Codex PATH、preflight、github SSH |
| [review-r2-glab-cursor.md](review-r2-glab-cursor.md) | glab-cursor | Windows PS1、BOM、`gh`/SSH 新脚本、autocrlf |

**合入 PR**：#18～#22（均已 merge 至 `main`）；手册 **#17**（`98`+README）先行。

## 2. 共识（跨分稿）

1. **Git 总线足够**：Issue + 分支 + PR +（必要时）`format-patch` 中继，可闭环「多节点多工具」评审，**无需** IDE 控制面组网。
2. **`98` 降低漂移**：把 R2 信令与 relay 写入定稿后，与 `94`/`93` 分工明确。
3. **副机直推条件改善**：woot 已验证 **`git push github`**（SSH）；glab 本轮 **`git push origin`** 成功（`origin`→GitHub SSH），**中继不再是唯一路径**（仍保留为兜底）。
4. **脚本面健康**：核心 bash 使用 `set -euo pipefail`；PS1 与 `20` 的 5.1/BOM 约束一致。
5. **整仓范围可复扫**：使用 [gitnet-r2-scope-list.sh](../scripts/gitnet-r2-scope-list.sh) 对 `handbook/` 等前缀做计数，便于下一轮 diff 基线。

## 3. 分歧与取舍

| 主题 | 分歧点 | 本轮取舍 |
|------|--------|----------|
| 阅读顺序表长度 | Claude 稿倾向未来拆「基础/进阶」表 | **不改表结构**（P2 backlog），避免与 `README` 大范围冲突。 |
| `97` §9 SHA 叙事 | Claude 建议加「动态 HEAD」一句 | **已落地**：§9 增「当前 `main` 头」指针链 `90` 与合成结论，**保留** PR #7 文面锚点 `2aab83c…` 不删。 |
| CI 静态分析 | Codex 提 PSScriptAnalyzer 等 | **不纳入本轮**；需 Windows runner 或本机策略。 |

## 4. 有效协作模式（执行级）

1. **开母单**（Issue #16 类）：写清范围、分支名、交付文件名、合入闸。  
2. **epix 三身份**：分别在 `55` 规定的 **Dev / CodexDev / agent-work/claude-code** 克隆上开分支提交，保证 **L1 作者可证**。  
3. **副机 Cursor**：本地 `commit`；优先 **SSH `github`/`origin` 直推**；否则 **epix relay**（`format-patch`+`am`，不改作者）。  
4. **集成**：epix Cursor 开 PR、merge、`gitnet-sync-github-main-to-bare.sh`、`90` 一条。  
5. **合成**：本文 +（可选）脚本；单独 PR，避免与分稿混杂。

## 5. 下一轮改进（backlog）

以下三项已由 **PR（见 `90` 最新条）** 落地；余项仍为 backlog。

- [x] `97` §9：一句指针链 `90` / GitHub `main`（P2）。  
- [x] `handbook/README`：「published 主题索引」一行（P2）。  
- [x] 为高频运维脚本增加 **dry-run** 模式（P2）：`GITNET_SYNC_DRY_RUN=1` + `gitnet-sync-github-main-to-bare.sh`。  
- [ ] 删除 GitHub 上误推的短命分支（若有），保持 remote 整洁。

## 6. 验收命令（复制）

```bash
# 本机（epix）GitNet 根
./handbook/scripts/gitnet-r2-scope-list.sh
./handbook/scripts/gitnet-multi-agent-retro-preflight.sh
GITNET_SYNC_DRY_RUN=1 ./handbook/scripts/gitnet-sync-github-main-to-bare.sh
gh api repos/epix99-opus/GitNet/commits/main --jq .sha
git -C ~/git/GitNet.git rev-parse refs/heads/main
```

## 修订记录

| 日期 | 摘要 |
|------|------|
| 2026-05-14 | 首版：R2 合成结论；链 PR #17～#22、Issue #16、`98`、scope 脚本。 |
| 2026-05-14 | §5 backlog：三项已落地（`97` §9 动态头、`README` published 索引、`GITNET_SYNC_DRY_RUN`）；余「清理短命分支」仍为 backlog。 |
| 2026-05-14 | §3 表：`97` §9 行更新为已落地；§6 增 `GITNET_SYNC_DRY_RUN` 验收行。 |
