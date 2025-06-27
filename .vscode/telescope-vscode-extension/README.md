# Telescope for VSCode

Neovimの人気プラグイン「telescope.nvim」にインスパイアされたVSCode拡張機能です。

## 機能

- **高速なファイル検索**: ripgrepを使用した高速なファイル検索
- **ライブGrep検索**: プロジェクト全体のテキスト検索
- **カレントディレクトリ検索**: 現在のファイルのディレクトリ内での検索
- **ファジーマッチング**: telescope.nvimライクなファジー検索

## インストール方法

1. このディレクトリで以下のコマンドを実行:
   ```bash
   npm install
   npm run compile
   ```

2. VSCodeで`F5`を押して拡張機能開発ホストを起動

3. または、このディレクトリをVSCodeの拡張機能フォルダにコピー:
   - Windows: `%USERPROFILE%\.vscode\extensions`
   - macOS/Linux: `~/.vscode/extensions`

## 使い方

### コマンド

- `Telescope: Find Files` - プロジェクト内のファイルを検索
- `Telescope: Live Grep` - プロジェクト内のテキストを検索
- `Telescope: Find in Current Directory` - 現在のディレクトリ内でファイルを検索

### キーバインド

デフォルトのキーバインド:
- `Ctrl+Shift+P F` - ファイル検索
- `Ctrl+Shift+P G` - Grep検索

カスタムキーバインドは`keybindings.json`で設定可能:
```json
{
  "key": "space f f",
  "command": "telescope.findFiles",
  "when": "editorTextFocus"
}
```

## 設定

`settings.json`で以下の設定が可能:

```json
{
  "telescope.previewEnabled": true,
  "telescope.useRipgrep": true,
  "telescope.ignorePatterns": [".git", "node_modules", ".vscode"]
}
```

## 必要要件

- ripgrepがシステムにインストールされていること（高速検索のため）
- VSCode 1.74.0以上

## 既知の制限

- telescope.nvimの完全なプレビュー機能は実装されていません
- カスタムピッカーの作成はサポートされていません

## 今後の改善予定

- [ ] ファイルプレビュー機能の実装
- [ ] より高度なファジーマッチングアルゴリズム
- [ ] カスタムアクションの追加
- [ ] テーマのカスタマイズ