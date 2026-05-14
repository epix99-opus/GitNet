#!/usr/bin/env bash
# 供 git filter-branch --msg-filter 调用：按 GIT_COMMIT 将说明改为中文，不改树与父提交关系。
# 用法（在 GitNet 根、已备份后）：
#   git filter-branch -f --msg-filter 'handbook/scripts/gitnet-rewrite-commit-messages-zh.sh' main
# 完成后可删除 refs/original： git update-ref -d refs/original/refs/heads/main
set -euo pipefail
old_msg=$(cat) || true
case "${GIT_COMMIT:-}" in
d10932c86e853bc782095ff79c549475cb7f8717) printf '%s\n' "文档：初始化 GitNet 工作区及 Glab 交接说明

Co-authored-by: Cursor <cursoragent@cursor.com>" ;;
2f3ea60c0cecda525f13dfce6f7c133d72a742fc) printf '%s\n' "文档：检出 main 前的检查点存档" ;;
9224752bf519ce986ccf593fd7be8010a7d5b677) printf '%s\n' "杂务：初始化仓库并交付 handbook" ;;
4af2a4ecb740d75897472a35554e31ee5c5b5323) printf '%s\n' "文档：在进程日志中记录首条提交哈希" ;;
f629aa635700398f34374bd7c5fd14d749672a91) printf '%s\n' "文档：澄清进程日志中提交哈希的表述" ;;
4236221849805102f315933adfdadfc120cb8aca) printf '%s\n' "文档：记录 GitHub origin 配置与需交互式 push 的交接" ;;
b3705049620b3b1fb05112322210709b45d6b1f9) printf '%s\n' "文档：说明需先 pull --rebase 否则 GitHub push 被拒" ;;
278eed1f939cd02c3fa819d8b2b7b8223217bcd7) printf '%s\n' "文档：记录变基冲突解决及 GitHub push 成功" ;;
be222f3706b31bfaed31d65a7612c91e83d5cf31) printf '%s\n' "文档（手册）：新增 07 落盘规则并串联交叉引用

Co-authored-by: Cursor <cursoragent@cursor.com>" ;;
b07af49613a111c027abdcb5f1d6f4f2a9056cca) printf '%s\n' "文档（进程）：记录 epix Git 身份与 includeIf 配置

Co-authored-by: Cursor <cursoragent@cursor.com>" ;;
79acb9224db33dadb7948fd3dcc66345a0aaca69) printf '%s\n' "文档（手册）：多节点多 Agent Git 矩阵与 epix 片段

Co-authored-by: Cursor <cursoragent@cursor.com>" ;;
f09cd2175155c26e2c543ca897e50758959ad2a4) printf '%s\n' "文档（手册）：将 07 落盘规则链到多节点矩阵

Co-authored-by: Cursor <cursoragent@cursor.com>" ;;
df3766bac079f70ab3d44e249d7cfc3351004229) printf '%s\n' "文档：Tailscale SSH woot Git 身份运行手册与 glab Windows 脚本

Co-authored-by: Cursor <cursoragent@cursor.com>" ;;
1a429cd8bae1bf3237fe1b53d3bd88eb36fb6207) printf '%s\n' "文档（手册）：55 修订说明与 woot SSH 推广

Co-authored-by: Cursor <cursoragent@cursor.com>" ;;
f4acbb34cbb8baddc8014a4caa7e5c526cc0a0a9) printf '%s\n' "文档：Glab Tailscale 事实表与 epix 远端边界（GitHub 同步）" ;;
39276b37b68d88a280cf818613cf4f8e2606df25) printf '%s\n' "文档：22 与 46 交叉引用（Tailscale Git 身份）" ;;
a0f5d57a37635f28738975c672d199c65b55ff0f) printf '%s\n' "功能（glab）：OpenSSH 安装脚本、epix ssh 片段、修正 includeIf gitdir 大小写" ;;
1c58b9b6a4450c40b45c1a41ef61ba5fa98626ba) printf '%s\n' "文档（手册）：glab 侧 epix SSH 验收交接（91）

Co-authored-by: Cursor <cursoragent@cursor.com>" ;;
ec916b0cf385361dd2ae6fc48add134bd7e34b1f) printf '%s\n' "文档（手册）：索引 91 glab SSH 验收交接

Co-authored-by: Cursor <cursoragent@cursor.com>" ;;
bb593097cb5d4cc67a7aac11fd91f26f70994886) printf '%s\n' "文档（手册）：91 链至 GitHub Issue #1

Co-authored-by: Cursor <cursoragent@cursor.com>" ;;
e967dcba77abecdeadff18c67b74691c6b9703ce) printf '%s\n' "文档（glab）：Issue #1 交接证据、§A 脚本、可选 GitHub API 发帖" ;;
ae24441d3ae0af0659fe2158a36130f286e98ef9) printf '%s\n' "文档：要求向人类交接时须写明原因、步骤与验收标准" ;;
792d420c39a6a7acb6ae31402244aa2b4982d920) printf '%s\n' "文档：提交 epix id_ed25519.pub 供 glab GitHub 交接

Co-authored-by: Cursor <cursoragent@cursor.com>" ;;
1686bb27ada39e0380ae9b5adb419d20df28260b) printf '%s\n' "文档与脚本：定稿公钥置于 handbook/templates" ;;
42ffb205f254b6f295a52a9122aeae9736db2d5d) printf '%s\n' "文档（手册）：GitHub 双向自动同步方案（92）与脚本

Co-authored-by: Cursor <cursoragent@cursor.com>" ;;
64418dfdbaac2e72a83b556d6fbbc7241ca0713a) printf '%s\n' "文档（92）：标注 Git 同步为备选路径；对比 Hermes/OpenClaw

Co-authored-by: Cursor <cursoragent@cursor.com>" ;;
4355a582db797ff7dbe8da567514cd08c7c85371) printf '%s\n' "手册：协作收口表、证据脚本 SSH 诊断、Issue #1 进展记录

Co-authored-by: Cursor <cursoragent@cursor.com>" ;;
b57c29894254473e7e0e65bd7f3397d3d567eb4f) printf '%s\n' "修复（glab）：icacls 授权串与 PowerShell、sshd 读取 authorized_keys" ;;
8ca1db286add2d2b54308d087df12378c621e627) printf '%s\n' "修复（glab）：避免 Test-Path ACL 抛错；icacls 为 SYSTEM 与用户授权" ;;
36058413434e63055ea32b5d2a7241fd75adcb20) printf '%s\n' "修复（glab）：Add-Content 前修复 ACL/takeown；保留用户对 authorized_keys 的 (M)" ;;
4f1b397435565f7a2e625e1b899b051aacbae47a) printf '%s\n' "文档（91）：明确 glab 上由谁执行 git pull 与管理员脚本" ;;
37a8530a9ceb576b19d2be555c99c026b6aa082a) printf '%s\n' "已发布：§B epix 终端 glab Git 身份；T3 完成

Co-authored-by: Cursor <cursoragent@cursor.com>" ;;
ab5670f1bfec0752c3c2d554dad05b5709a9bdf7) printf '%s\n' "文档：91 与 T4 对齐 §B/T3；记录剩余人类步骤" ;;
06f40e84e4e02b5d96fd32c4191cad985ebee46a) printf '%s\n' "文档：Agent 优先北极星愿景与 AGENTS 对齐" ;;
52ffcd8b5ede9f44fc5f2530fc7fa155be9605ef) printf '%s\n' "文档：全链路认证——人类提供的秘密须安全存储；禁止明文进 Git" ;;
2a5803557e5cd23a82eaf7add5918b8bc1f99161) printf '%s\n' "文档（05）：北极星与全链路认证对齐" ;;
46f66124734562f9055dedfd57d1531c0b2543a1) printf '%s\n' "功能（glab）：追加 epix 公钥脚本；glab 工作区 T2 完成" ;;
1e89d0109377686b3848b6a56fe1021dd19e603f) printf '%s\n' "修复（glab）：Administrators 组 BatchMode SSH 使用 administrators_authorized_keys" ;;
1e74fb7b3261401cc38009fb2cb290f387124bf1) printf '%s\n' "手册：bare 为写集成权威的目标规范与多机最优实现（10-topology）

Co-authored-by: Cursor <cursoragent@cursor.com>" ;;
351dc7d4c5c5b327c711bffeb6c82ca9e18dcd79) printf '%s\n' "修复（ps）：UTF-8 BOM 与嵌套 if，修复 WinPS 5.1 下 setup-glab-openssh 解析" ;;
c52a7c5556fa1fb9aa6bb2d0c51598f91b2cc42e) printf '%s\n' "文档（手册）：收口 glab-epix SSH（UTF-8 BOM、ssh-keyscan、T2）" ;;
98c4616c6bdca11bd45c78bfbb7562e3a5adb214) printf '%s\n' "文档（手册）：明确 GitHub main 为 epix/glab 文档对齐通知面" ;;
14d3099533e6c4a4fb71b4d47c205da0b1ca8b73) printf '%s\n' "文档（93）：阶段成果——多端协作回顾与可外推 Git 体系清单

Co-authored-by: Cursor <cursoragent@cursor.com>" ;;
5e216d183d2b3d800e053393ceb9530145fc1660) printf '%s\n' "手册（94）：三机 Agent 盘点、RACI、配置矩阵与 inventory 模板

Co-authored-by: Cursor <cursoragent@cursor.com>" ;;
a7801e5f2e6ce508d74c975592c81f1efc986ba3) printf '%s\n' "功能（inventory）：三机经 SSH 枚举落盘；94 §5.6 与铁律对齐

Co-authored-by: Cursor <cursoragent@cursor.com>" ;;
4c8364b1e9bbb6edd4050e016d2f3602303ebb3e) printf '%s\n' "文档（90）：记录 CAMA-concept 派生 CAMA-git 方案、手册与清单

Co-authored-by: Cursor <cursoragent@cursor.com>" ;;
8ecdb2ab67b2151ba3849465e8644bb8f37bc8ac) printf '%s\n' "文档（90）：更正 CAMA 已配置 origin 并已 push CAMA_Cursor

Co-authored-by: Cursor <cursoragent@cursor.com>" ;;
aa60cfef79cff35563e82e4a8fa8b6095764b17a) printf '%s\n' "文档（手册）：三机编程 Agent 实机探测落盘（Tailscale SSH）

epix/woot/glab 经本机与 ssh 执行 which/where 与路径检查；inventory-* 增「实机探测」节；94 §5.3 链到证据；90 记进程。

Co-authored-by: Cursor <cursoragent@cursor.com>" ;;
9f943efbff3f06caad955ad06d664b2480f6421b) printf '%s\n' "杂务（agents）：多机盘点实测完成定义写入 AGENTS 与规则

完成定义（DoD）、禁止文档顶替与待填占位、Git 身份≠OS 安装、SSH PATH、失败重试；94 §1 与 90 交叉引用。

Co-authored-by: Cursor <cursoragent@cursor.com>" ;;
dfc0c771f8d229ad9758c8711ef81d16be39e969) printf '%s\n' "杂务（agents）：回合前与回合末目标对齐与主动检索写入契约

一句可验收判据、先读后写、收尾对照；规则与 94 §1、90 同步。

Co-authored-by: Cursor <cursoragent@cursor.com>" ;;
68f16d640e6aedcacd31de8fa19bca487f4e98b0) printf '%s\n' "文档（agents）：对齐 Cursor 习惯、AGENTS 为契约全文、规则去重

条文 6/7 Plan 与最小验证、人类对话提示；全工作区改指 User Rules；本机键名迁 90 归档；gitnet-collaboration 仅索引 AGENTS。

Co-authored-by: Cursor <cursoragent@cursor.com>" ;;
af1156f3257fd2b8460281cba31bfa81afafcfe1) printf '%s\n' "文档（手册）：08 全生命周期 Git 框架与全局规定

双重角色、生命周期矩阵、主分支/特性分支、多智能体仲裁；README/93/90 同步。

Co-authored-by: Cursor <cursoragent@cursor.com>" ;;
70b8d051ff63ce9b338c8144439682e0a00fd754) printf '%s\n' "文档（90）：进程条内 README 链接修正

Co-authored-by: Cursor <cursoragent@cursor.com>" ;;
2f579af6e430c23a54054f05d11ac4e08553d91f) printf '%s\n' "文档（手册）：BestGit 组织模板仓归档 96 与交叉引用

96 入口、README 阅读顺序、90 进程；08 全局表链 96；94 修订与 §7 索引。

Co-authored-by: Cursor <cursoragent@cursor.com>" ;;
18ee4596d47ef4e1dd3f8c36a5fdd40fd5560107) printf '%s\n' "文档（已发布）：epix 枚举表登记 BestGit 路径

Co-authored-by: Cursor <cursoragent@cursor.com>" ;;
cffbd01ada64c01c7af78086aa46f4df6d5e961e) printf '%s\n' "文档：BestGit 已建 GitHub 仓；inventory origin 与 96 修订

Co-authored-by: Cursor <cursoragent@cursor.com>" ;;
c59608c954eef9b29012ff6128867e3faf27ba9f) printf '%s\n' "文档（90）：BestGit 条补充 gh 建仓与 inventory

Co-authored-by: Cursor <cursoragent@cursor.com>" ;;
*) printf '%s' "$old_msg" ;;
esac
