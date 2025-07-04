# VSCodeでVimライクなキーバインディングを実現する実践ガイド

VSCodeでVimの操作感を再現するには、VSCodeVim拡張機能だけでは不十分です。特にカスタマイズされたNeovim環境から移行する場合、詳細なキーバインディング設定が必要になります。

今回は、実際に私が設定したキーバインディングを例に、VSCodeでVimライクな環境を構築する方法を解説します。

## 基本的なエスケープキーの設定

Vimユーザーなら誰もが設定している`jj`でのエスケープ。VSCodeでも当然設定したい機能です。

### 日本語入力への対応

私は日本語でコメントを書くことが多いため、`っj`でのエスケープも設定しました。これにより、日本語入力モードでも違和感なくエスケープできます。

```json
{
  "vim.insertModeKeyBindings": [
    {
      "before": ["j", "j"],
      "after": ["<Esc>"]
    },
    {
      "before": ["っ", "j"],
      "after": ["<Esc>"]
    }
  ]
}
```

この設定により、どんな入力状況でもスムーズにノーマルモードに戻れます。

## ウィンドウ操作の統一

分割ウィンドウ間の移動は開発効率に直結します。エディタだけでなく、ターミナルでも同じキーバインディングで移動できるよう設定しています。

```json
{
  "key": "ctrl+h",
  "command": "workbench.action.focusLeftGroup",
  "when": "editorTextFocus"
},
{
  "key": "ctrl+h",
  "command": "workbench.action.focusLeftGroup",
  "when": "terminalFocus"
}
```

`ctrl+h/j/k/l`でエディタとターミナルを統一的に操作できるため、思考を中断することなく作業を続けられます。

## Leaderキーによる高度な操作

Neovimで最も愛用していたのがLeaderキーによる操作です。`<Space>`を起点とした一連のキーシーケンスで、様々な機能に素早くアクセスできます。

### LSP機能へのアクセス

コードジャンプやリファクタリングは、開発作業の中核です。Neovimと同じキーバインディングでアクセスできるよう設定しました。

```json
{
  "key": "space l d",
  "command": "editor.action.revealDefinition",
  "when": "editorTextFocus"
},
{
  "key": "space l shift+r",
  "command": "editor.action.rename",
  "when": "editorTextFocus"
}
```

`Space l d`で定義にジャンプ、`Space l R`でリネーム。Neovimユーザーなら直感的に操作できるはずです。

### ファイル操作の効率化

ファイル検索やバッファ切り替えも、Leaderキーから統一的にアクセスできます。

```json
{
  "key": "space f f",
  "command": "workbench.action.quickOpen",
  "when": "!terminalFocus"
},
{
  "key": "space f g",
  "command": "workbench.action.findInFiles",
  "when": "!terminalFocus"
}
```

`Space f f`でファイル検索、`Space f g`でgrep検索。Telescopeの操作感にかなり近づけられました。

## ターミナル統合の工夫

VSCodeの統合ターミナルは便利ですが、Vimライクに操作するには設定が必要です。

### エスケープキーの動作

ターミナルでもエスケープキーでエディタにフォーカスを戻せるよう設定しています。

```json
{
  "key": "escape",
  "command": "workbench.action.focusActiveEditorGroup",
  "when": "terminalFocus"
}
```

これにより、ターミナルからエディタへのスムーズな移動が可能になります。

### ターミナルのトグル操作

Neovimのtoggletermプラグインのように、素早くターミナルを表示・非表示できます。

```json
{
  "key": "ctrl+q",
  "command": "workbench.action.terminal.toggleTerminal",
  "when": "!terminalFocus"
}
```

## 詳細なVim設定

VSCodeVim拡張機能では、より細かなVim設定も可能です。

### システムクリップボードとの連携

```json
{
  "vim.useSystemClipboard": true,
  "vim.highlightedyank.enable": true,
  "vim.highlightedyank.duration": 200
}
```

ヤンクした内容が一瞬ハイライトされるため、何をコピーしたかが視覚的に分かります。

### 検索とハイライト

```json
{
  "vim.hlsearch": true,
  "vim.ignorecase": true,
  "vim.smartcase": true,
  "vim.incsearch": true
}
```

Neovimと同じ検索体験を維持できます。

### キーコンフリクトの解決

VSCodeとVimのキーバインディングが競合する場合があります。必要に応じて無効化しています。

```json
{
  "vim.handleKeys": {
    "<C-a>": false,
    "<C-f>": false,
    "<C-p>": false
  }
}
```

## 実際の使用感

これらの設定により、Neovimからの移行はかなりスムーズでした。特に効果的だったのは以下の点です。

1. **筋肉記憶の維持** - 慣れ親しんだキーバインディングをそのまま使える
2. **統一的な操作** - エディタとターミナルで同じキーで移動できる
3. **段階的な学習** - VSCode固有の機能も徐々に取り入れられる

## 設定時の注意点

キーバインディング設定では、いくつか注意すべき点があります。

### コンテキストの指定

同じキーでも、エディタとターミナルで異なる動作をさせたい場合は、`when`条件を適切に設定する必要があります。

```json
{
  "key": "ctrl+q",
  "command": "workbench.action.terminal.kill",
  "when": "terminalFocus"
},
{
  "key": "ctrl+q",
  "command": "workbench.action.terminal.toggleTerminal",
  "when": "!terminalFocus"
}
```

### 拡張機能との競合

他の拡張機能とキーバインディングが競合することがあります。VSCodeの設定画面で確認し、必要に応じて調整しましょう。

## Neovim whichkey.lua との完全対応表

実際のNeovim設定（whichkey.lua）とVSCodeキーバインディングの対応状況を詳細にまとめました。

### 実装統計
- ✅ **実装済み**: 29機能 (65.9%)
- 🔴 **未対応**: 15機能 (34.1%)

### 主要機能の対応状況

| カテゴリ | Neovim | VSCode実装 | 状態 |
|----------|--------|------------|------|
| **LSP機能** | `<leader>l*` | 完全対応 | ✅ 100% |
| **ファイル検索** | `<leader>f*` | ほぼ対応 | ✅ 85% |
| **デバッグ** | `<leader>d*` | 完全対応 | ✅ 100% |
| **テスト** | `<leader>t*` | 完全対応 | ✅ 100% |
| **Git操作** | `<leader>g*` | 部分対応 | 🟡 75% |
| **Trouble機能** | `<leader>lt*` | 部分対応 | 🟡 25% |

### 未実装の主要機能

1. **ヤンク履歴** (`<leader>fy`) - Clipboard Manager拡張機能で対応可能
2. **Trouble系機能** (`<leader>lt*`) - Problems/Outline ビューで部分代替
3. **画像操作** (`<leader>s*`) - 専用拡張機能が必要
4. **グローバル数値操作** (`<leader>cg*`) - カスタム拡張機能で実装可能

### 代替実装の推奨事項

重要度の高い未実装機能については、以下の方法で対応できます：

```json
// ヤンク履歴（拡張機能：Clipboard Manager）
{
  "key": "space f y",
  "command": "clipboard-manager.editor.pickAndPaste",
  "when": "editorTextFocus"
},

// LazyGit代替
{
  "key": "space g g",
  "command": "workbench.action.terminal.sendSequence",
  "args": { "text": "lazygit\n" },
  "when": "terminalFocus"
}
```

詳細な対応表は[keybinding-mapping-analysis.md](../keybinding-mapping-analysis.md)を参照してください。

## まとめ

詳細なキーバインディング設定により、VSCodeでもVimライクな操作感を実現できます。重要なのは、自分のワークフローに合わせて段階的に設定を追加していくことです。

約66%の機能が完全に再現でき、残りの機能も拡張機能や代替手段で補完可能です。最初はエスケープキーやウィンドウ移動から始めて、徐々にLeaderキーやLSP機能のバインディングを追加していけば、ストレスなく移行できるでしょう。

設定は個人の好みや作業スタイルによって大きく異なります。今回紹介した設定をベースに、あなたなりのカスタマイズを見つけてください。

---

*2025年6月 執筆*