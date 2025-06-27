# Neovim設定からVSCodeへの移行ガイド

このディレクトリには、Neovimの設定をVSCodeに移行するための設定ファイルとカスタム拡張機能が含まれています。

## 📁 ディレクトリ構造

```
.vscode/
├── settings.json              # VSCodeエディタ設定
├── keybindings.json          # キーバインディング設定
├── extensions.json           # 推奨拡張機能リスト
├── telescope-keybindings.md  # Telescope機能の対応表
├── telescope-vscode-extension/  # カスタム拡張機能
└── README.md                 # このファイル
```

## 🚀 セットアップ手順

### 1. 設定ファイルのコピー

以下のファイルをVSCodeのユーザー設定ディレクトリにコピーします：

**Windows:**
```bash
cp settings.json %APPDATA%\Code\User\
cp keybindings.json %APPDATA%\Code\User\
```

**macOS/Linux:**
```bash
cp settings.json ~/.config/Code/User/
cp keybindings.json ~/.config/Code/User/
```

### 2. 必須拡張機能のインストール

最低限以下の拡張機能をインストールしてください：

```bash
code --install-extension vscodevim.vim
code --install-extension zhuangtongfa.material-theme
code --install-extension PKief.material-icon-theme
code --install-extension eamodio.gitlens
```

または、VSCodeで`extensions.json`を開き、推奨される拡張機能をすべてインストールします。

### 3. カスタム拡張機能のセットアップ（オプション）

より完全なTelescope体験を得るために：

```bash
cd telescope-vscode-extension
npm install
npm run compile
```

その後、VSCodeで`F5`を押して拡張機能をテストできます。

## 🎯 主要なキーマッピング

### 基本操作
- `jj` / `っj` - Insertモードから抜ける
- `;` - コマンドパレット（Neovimの`:`相当）
- `Space` - Leaderキー

### ウィンドウ操作
- `Ctrl+h/j/k/l` - ウィンドウ間の移動
- `Shift+h/l` - タブの切り替え

### ファイル検索（Telescope相当）
- `Space f f` - ファイル検索
- `Space f g` - Grep検索
- `Space f b` - バッファ一覧
- `Space f c` - コマンドパレット

### LSP機能
- `Space l d` - 定義へジャンプ
- `Space l r` - 参照検索
- `Space l a` - コードアクション
- `Space l f` - フォーマット
- `Space l Shift+r` - リネーム

### Git操作
- `Space g g` - Git変更を開く
- `Space g s` - Gitステータス
- `Space g b` - Git blame表示

### デバッグ
- `Space d b` - ブレークポイント設定
- `Space d c` - デバッグ継続
- `Space d i/o` - ステップイン/オーバー

## 🔧 カスタマイズ

### settings.jsonの主要設定

```json
{
  // Vimモードの設定
  "vim.leader": "<space>",
  "vim.useSystemClipboard": true,
  
  // エディタ設定
  "editor.lineNumbers": "relative",
  "editor.tabSize": 2,
  
  // テーマ
  "workbench.colorTheme": "One Dark Pro"
}
```

### 追加のカスタマイズ

1. **フォント設定**: `editor.fontFamily`でお好みのフォントに変更
2. **テーマ**: `workbench.colorTheme`で別のテーマに変更
3. **キーバインド**: `keybindings.json`でカスタマイズ

## 📝 Neovimとの違い

### 実装されている機能
- ✅ 基本的なVimキーバインド
- ✅ ファイル検索とGrep
- ✅ LSP機能（定義ジャンプ、参照検索など）
- ✅ Git統合
- ✅ デバッグ機能
- ✅ ターミナル統合

### 制限事項
- ❌ telescope.nvimの完全なプレビュー機能
- ❌ 一部のVimプラグイン固有の機能
- ❌ カスタムLuaスクリプト

### 代替ソリューション
- **ファイルプレビュー**: Quick Openで`→`キーを使用
- **カスタムコマンド**: tasks.jsonでタスクを定義
- **高度な検索**: GitLensやProject Managerなどの拡張機能を活用

## 🤝 トラブルシューティング

### Vimキーバインドが効かない
1. VSCodeVim拡張機能がインストールされているか確認
2. `vim.useCtrlKeys`が`true`に設定されているか確認

### ファイル検索が遅い
1. ripgrepがインストールされているか確認
2. `files.watcherExclude`で不要なフォルダを除外

### 拡張機能の競合
1. 類似機能の拡張機能を無効化
2. キーバインドの競合を`keybindings.json`で解決

## 📚 参考リンク

- [VSCode Vim拡張機能ドキュメント](https://github.com/VSCodeVim/Vim)
- [VSCodeキーバインドリファレンス](https://code.visualstudio.com/docs/getstarted/keybindings)
- [VSCode設定リファレンス](https://code.visualstudio.com/docs/getstarted/settings)