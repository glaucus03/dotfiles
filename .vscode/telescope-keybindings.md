# Telescope.nvim 機能の VSCode での実現方法

## 主要機能の対応表

### ファイル検索機能

| Telescope機能 | VSCodeコマンド | キーバインド | 説明 |
|-------------|--------------|------------|------|
| find_files | workbench.action.quickOpen | `Space f f` | ファイル名でファイルを検索 |
| live_grep | workbench.action.findInFiles | `Space f g` | ファイル内容をgrep検索 |
| buffers | workbench.action.showAllEditors | `Space f b` | 開いているバッファ一覧 |
| file_browser | workbench.files.action.showActiveFileInExplorer | `Space f r` | ファイルブラウザ |

### LSP機能

| Telescope機能 | VSCodeコマンド | キーバインド | 説明 |
|-------------|--------------|------------|------|
| lsp_definitions | editor.action.revealDefinition | `Space l d` | 定義へジャンプ |
| lsp_references | editor.action.goToReferences | `Space l r` | 参照検索 |
| lsp_document_symbols | workbench.action.gotoSymbol | `Ctrl+Shift+O` | ドキュメントシンボル |
| lsp_workspace_symbols | workbench.action.showAllSymbols | `Ctrl+T` | ワークスペースシンボル |

### Git機能

| Telescope機能 | VSCodeコマンド | キーバインド | 説明 |
|-------------|--------------|------------|------|
| git_status | workbench.view.scm | `Space g s` | Git変更ファイル一覧 |
| git_commits | gitlens.showCommitSearch | - | コミット履歴 |
| git_branches | git.checkout | - | ブランチ切り替え |

### その他の機能

| Telescope機能 | VSCodeコマンド | キーバインド | 説明 |
|-------------|--------------|------------|------|
| commands | workbench.action.showCommands | `Space f c` | コマンドパレット |
| marks | workbench.action.gotoSymbol | `Space f m` | マーク（シンボル）へジャンプ |
| registers | - | `Space f v` | レジスタ表示（拡張機能が必要） |

## VSCodeでTelescopeライクな体験を実現するための追加設定

### 1. Quick Open の拡張設定

```json
{
  // ファイル検索をより Telescope に近づける
  "workbench.quickOpen.closeOnFocusLost": false,
  "workbench.quickOpen.preserveInput": false,
  "search.quickOpen.includeSymbols": true,
  "search.quickOpen.includeHistory": true
}
```

### 2. 検索の詳細設定

```json
{
  // ripgrep を使用した高速検索
  "search.useRipgrep": true,
  "search.followSymlinks": true,
  "search.smartCase": true,
  "search.useGlobalIgnoreFiles": true
}
```

### 3. 推奨される追加拡張機能

- **Telescope UI 風の拡張機能**:
  - `alefragnani.project-manager` - プロジェクト間の素早い切り替え
  - `fabiospampinato.vscode-commands` - カスタムコマンドの作成
  
- **ファジー検索の強化**:
  - `tomrijndorp.find-it-faster` - より高速なファイル検索
  
- **Git統合の強化**:
  - `mhutchie.git-graph` - Gitグラフの視覚化
  - `eamodio.gitlens` - Git履歴とblame機能

## 制限事項と回避策

### 1. プレビュー機能
Telescopeのようなリアルタイムプレビューは完全には再現できませんが、VSCodeのQuick Openで`→`キーを使用することで簡易的なプレビューが可能です。

### 2. カスタムピッカー
Telescopeの高度なカスタムピッカーは、VSCode拡張機能を作成することで部分的に再現可能です。

### 3. 統一されたインターフェース
VSCodeでは機能ごとに異なるUIが使用されますが、キーバインドを統一することで操作感を近づけることができます。