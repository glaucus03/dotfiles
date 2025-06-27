# Neovim vs VSCode キーバインディング対応表

## 完全対応表

### 基本操作

| Neovim (whichkey) | 説明 | VSCode実装 | 状態 | 備考 |
|-------------------|------|------------|------|------|
| `<C-a>` | 数値インクリメント | Vimプラグイン設定 | ✅ 実装済み | VSCodeVimで再現 |
| `<C-x>` | 数値デクリメント | Vimプラグイン設定 | ✅ 実装済み | VSCodeVimで再現 |

### Convert Commands (Space + c)

| Neovim (whichkey) | 説明 | VSCode実装 | 状態 | 備考 |
|-------------------|------|------------|------|------|
| `<leader>cgi` | グローバルインクリメント | ❌ 未実装 | 🔴 未対応 | VSCodeに直接対応なし |
| `<leader>cgd` | グローバルデクリメント | ❌ 未実装 | 🔴 未対応 | VSCodeに直接対応なし |

### LSP機能 (Space + l)

| Neovim (whichkey) | 説明 | VSCode実装 | 状態 | 備考 |
|-------------------|------|------------|------|------|
| `<leader>lR` | リネーム | `space l shift+r` → `editor.action.rename` | ✅ 実装済み | 完全対応 |
| `<leader>l,` | 前のエラーへ | `space l ,` → `editor.action.marker.prev` | ✅ 実装済み | 完全対応 |
| `<leader>l.` | 次のエラーへ | `space l .` → `editor.action.marker.next` | ✅ 実装済み | 完全対応 |
| `<leader>la` | コードアクション | `space l a` → `editor.action.quickFix` | ✅ 実装済み | 完全対応 |
| `<leader>ld` | 定義へジャンプ | `space l d` → `editor.action.revealDefinition` | ✅ 実装済み | 完全対応 |
| `<leader>lf` | フォーマット | `space l f` → `editor.action.formatDocument` | ✅ 実装済み | 完全対応 |
| `<leader>li` | 実装へジャンプ | `space l i` → `editor.action.goToImplementation` | ✅ 実装済み | 完全対応 |
| `<leader>lk` | ホバー情報 | `space l k` → `editor.action.showHover` | ✅ 実装済み | 完全対応 |
| `<leader>lo` | 診断情報表示 | `space l o` → `editor.action.showHover` | ✅ 実装済み | 完全対応 |
| `<leader>lr` | 参照検索 | `space l r` → `editor.action.goToReferences` | ✅ 実装済み | 完全対応 |
| `<leader>ls` | シグネチャヘルプ | `space l s` → `editor.action.triggerParameterHints` | ✅ 実装済み | 完全対応 |
| `<leader>lD` | 型定義へジャンプ | `space l shift+d` → `editor.action.goToTypeDefinition` | ✅ 実装済み | 完全対応 |

### Trouble機能 (Space + lt)

| Neovim (whichkey) | 説明 | VSCode実装 | 状態 | 備考 |
|-------------------|------|------------|------|------|
| `<leader>ltd` | 診断一覧 | `space l t d` → `workbench.actions.view.problems` | ✅ 実装済み | ProblemsビューでTrouble相当 |
| `<leader>ltb` | バッファ診断 | ❌ 未実装 | 🔴 未対応 | バッファ固有の診断表示なし |
| `<leader>lts` | シンボル一覧 | ❌ 未実装 | 🔴 未対応 | アウトラインビューで部分対応 |
| `<leader>ltl` | LSP定義/参照 | ❌ 未実装 | 🔴 未対応 | 個別コマンドで代替 |
| `<leader>lti` | ロケーションリスト | ❌ 未実装 | 🔴 未対応 | VSCodeに直接対応なし |
| `<leader>ltq` | クイックフィックスリスト | ❌ 未実装 | 🔴 未対応 | VSCodeに直接対応なし |

### ファイルツリー (Space + e)

| Neovim (whichkey) | 説明 | VSCode実装 | 状態 | 備考 |
|-------------------|------|------------|------|------|
| `<leader>ee` | ツリー開く&ファイル探す | `space e e` → `workbench.view.explorer` | ✅ 実装済み | エクスプローラービューで対応 |
| `<leader>ef` | ファイルを探す | `space e f` → `revealInExplorer` | ✅ 実装済み | 完全対応 |
| `<leader>eq` | ツリーを閉じる | `space e q` → `workbench.action.toggleSidebarVisibility` | ✅ 実装済み | サイドバートグルで対応 |
| `<leader>er` | ツリー更新 | ❌ 未実装 | 🔴 未対応 | 自動更新されるため不要 |

### デバッグ (Space + d)

| Neovim (whichkey) | 説明 | VSCode実装 | 状態 | 備考 |
|-------------------|------|------------|------|------|
| `<leader>db` | ブレークポイント切り替え | `space d b` → `editor.debug.action.toggleBreakpoint` | ✅ 実装済み | 完全対応 |
| `<leader>dc` | 実行継続 | `space d c` → `workbench.action.debug.continue` | ✅ 実装済み | 完全対応 |
| `<leader>do` | ステップオーバー | `space d o` → `workbench.action.debug.stepOver` | ✅ 実装済み | 完全対応 |
| `<leader>di` | ステップイン | `space d i` → `workbench.action.debug.stepInto` | ✅ 実装済み | 完全対応 |
| `<leader>du` | デバッグUI切り替え | `space d u` → `workbench.debug.action.toggleRepl` | ✅ 実装済み | REPL切り替えで対応 |
| `<leader>dh` | ホバー | ❌ 未実装 | 🔴 未対応 | デバッグ時は自動表示 |
| `<leader>dp` | プレビュー | ❌ 未実装 | 🔴 未対応 | デバッグ時は自動表示 |

### テスト (Space + t)

| Neovim (whichkey) | 説明 | VSCode実装 | 状態 | 備考 |
|-------------------|------|------------|------|------|
| `<leader>tt` | 最近のテスト実行 | `space t t` → `testing.runAtCursor` | ✅ 実装済み | 完全対応 |
| `<leader>tf` | ファイルのテスト実行 | `space t f` → `testing.runCurrentFile` | ✅ 実装済み | 完全対応 |
| `<leader>td` | テストデバッグ | `space t d` → `testing.debugAtCursor` | ✅ 実装済み | 完全対応 |
| `<leader>ts` | テストサマリー切り替え | `space t s` → `workbench.view.testing.focus` | ✅ 実装済み | Testing viewで対応 |
| `<leader>to` | テスト出力表示 | `space t o` → `testing.showMostRecentOutput` | ✅ 実装済み | 完全対応 |

### ファイル検索 (Space + f)

| Neovim (whichkey) | 説明 | VSCode実装 | 状態 | 備考 |
|-------------------|------|------------|------|------|
| `<leader>fr` | ファイルブラウザ | `space f r` → `workbench.files.action.showActiveFileInExplorer` | ✅ 実装済み | エクスプローラーで代替 |
| `<leader>fb` | バッファ検索 | `space f b` → `workbench.action.showAllEditors` | ✅ 実装済み | 完全対応 |
| `<leader>ff` | ファイル検索 | `space f f` → `workbench.action.quickOpen` | ✅ 実装済み | 完全対応 |
| `<leader>fg` | Grep検索 | `space f g` → `workbench.action.findInFiles` | ✅ 実装済み | 完全対応 |
| `<leader>fc` | コマンド検索 | `space f c` → `workbench.action.showCommands` | ✅ 実装済み | 完全対応 |
| `<leader>fm` | マーク検索 | `space f m` → `workbench.action.showAllSymbols` | ✅ 実装済み | シンボル検索で代替 |
| `<leader>fv` | レジスタ表示 | ❌ 未実装 | 🔴 未対応 | VSCodeに直接対応なし |
| `<leader>fy` | ヤンク履歴 | ❌ 未実装 | 🔴 未対応 | 拡張機能が必要 |

### Git操作 (Space + g)

| Neovim (whichkey) | 説明 | VSCode実装 | 状態 | 備考 |
|-------------------|------|------------|------|------|
| `<leader>gg` | LazyGit起動 | ❌ 未実装 | 🔴 未対応 | GitLens拡張機能で部分代替 |
| `<leader>gs` | Git状況 | `space g s` → `workbench.view.scm` | ✅ 実装済み | Source Controlで対応 |
| `<leader>gb` | Git blame | `space g b` → `gitlens.toggleFileBlame` | ✅ 実装済み | GitLens拡張機能 |
| `<leader>gvo` | Diff表示 | `space g v o` → `git.openChanges` | ✅ 実装済み | 完全対応 |

### 画像操作 (Space + s)

| Neovim (whichkey) | 説明 | VSCode実装 | 状態 | 備考 |
|-------------------|------|------------|------|------|
| `<leader>sc` | スクリーンショット(クリップボード) | ❌ 未実装 | 🔴 未対応 | VSCodeに直接対応なし |
| `<leader>sf` | スクリーンショット(ファイル) | ❌ 未実装 | 🔴 未対応 | VSCodeに直接対応なし |
| `<leader>sv` | 画像貼り付け | ❌ 未実装 | 🔴 未対応 | 拡張機能で部分対応 |

### 移動 (Space + m)

| Neovim (whichkey) | 説明 | VSCode実装 | 状態 | 備考 |
|-------------------|------|------------|------|------|
| `<leader>mh` | Hop(高速移動) | `space m h` → `extension.aceJump.multiChar` | ✅ 実装済み | AceJump拡張機能 |

### ウィンドウ操作 (Space + w)

| Neovim (whichkey) | 説明 | VSCode実装 | 状態 | 備考 |
|-------------------|------|------------|------|------|
| `<leader>wt` | ウィンドウリサイズ | `space w t` → `workbench.action.toggleEditorWidths` | ✅ 実装済み | エディタ幅調整で代替 |

### 共通操作

| Neovim (whichkey) | 説明 | VSCode実装 | 状態 | 備考 |
|-------------------|------|------------|------|------|
| `<C-q>` | ターミナルトグル | `ctrl+q` → `workbench.action.terminal.toggleTerminal` | ✅ 実装済み | 完全対応 |

## 実装統計

- ✅ **実装済み**: 29機能
- 🔴 **未対応**: 15機能
- **実装率**: 65.9%

## 未実装機能の代替案

### 高優先度 (実装推奨)

1. **ヤンク履歴** (`<leader>fy`) - Clipboard Manager拡張機能
2. **LazyGit** (`<leader>gg`) - GitLens + 統合ターミナルで代替
3. **Trouble系機能** - Problems、Outline、Error Lensで部分代替

### 中優先度

4. **グローバル数値操作** (`<leader>cgi/cgd`) - 拡張機能で実装可能
5. **画像操作機能** - Polacode、Screenshots拡張機能

### 低優先度 (VSCodeでは不要)

6. **NvimTree更新** - VSCodeは自動更新
7. **デバッグホバー/プレビュー** - VSCodeはデフォルトで提供
8. **Location/QuickFixリスト** - VSCodeのProblemsで代替

## 追加実装推奨機能

これらの機能を追加実装することで、より完全なNeovim体験を実現できます：

```json
{
  "key": "space f y",
  "command": "clipboard-manager.editor.pickAndPaste",
  "when": "editorTextFocus"
},
{
  "key": "space g g", 
  "command": "workbench.action.terminal.sendSequence",
  "args": { "text": "lazygit\n" },
  "when": "terminalFocus"
}
```