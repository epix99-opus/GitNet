# `reuse/vendor/` — 可选物理拷贝区

## 用途

仅用于存放 **脱离 `handbook/` 全文上下文仍可单独使用** 的极少数文件（例如小型 `gitconfig` 片段示例）。

## 规则

1. **默认留空**：优先用 [CATALOG.md](../CATALOG.md) 中的 **Raw 链** 或 **subtree**，避免副本漂移。  
2. **凡放入本目录的文件**须在文件首注释块内写明：  
   - 来源：`https://github.com/epix99-opus/GitNet`  
   - 路径：如 `handbook/templates/...`  
   - **锚定 SHA**：复制时的 `git rev-parse HEAD`  
3. **禁止**：凭据、私钥、token、完整 `handbook` 镜像。  
4. **维护**：若 GitNet 上游更新，拷贝方负责 diff；本目录**不**保证与 `main` 自动同步。
