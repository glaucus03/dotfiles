# Neovimユーザーが選ぶべきVSCode拡張機能 完全ガイド

VSCodeの魅力の一つは豊富な拡張機能です。しかし、選択肢が多すぎて何を入れれば良いか迷ってしまいます。特にNeovimから移行する場合、慣れ親しんだ機能を代替する拡張機能選びは重要です。

今回は、実際に3ヶ月間試行錯誤して厳選した拡張機能を、カテゴリ別に紹介します。

## 必須の基盤拡張機能

### VSCodeVim - Vim emulation for Visual Studio Code

**ID**: `vscodevim.vim`

これがなければ始まりません。Vimのキーバインディングとモード概念をVSCodeに持ち込む拡張機能です。

設定例：
```json
{
  "vim.leader": "<space>",
  "vim.useSystemClipboard": true,
  "vim.hlsearch": true,
  "vim.surround": true,
  "vim.easymotion": true
}
```

Neovimとの違いで戸惑った点もありますが、基本的な操作は十分再現できます。特に`vim.easymotion`を有効にすると、hop.nvimライクな移動が可能になります。

### Material Theme - 見た目の統一

**ID**: `zhuangtongfa.material-theme`

Neovimではnightfoxテーマを愛用していましたが、VSCodeではMaterial Themeが最も近い色合いを提供してくれました。

```json
{
  "workbench.colorTheme": "One Dark Pro"
}
```

目の疲労軽減にも配慮された色設計で、長時間のコーディングでも快適です。

## ファイル操作・検索機能

### GitLens - Git supercharged

**ID**: `eamodio.gitlens`

NeovimでgitブレームやDiffviewを使っていたなら、GitLensは必須です。コードの履歴を視覚的に確認できる機能は、チーム開発で威力を発揮します。

特に気に入っているのは、行ごとのGit情報表示機能です。誰がいつ変更したかが一目で分かります。

### Project Manager - プロジェクト間の移動

**ID**: `alefragnani.project-manager`

複数のプロジェクトを扱う場合、素早いプロジェクト切り替えは必須です。Neovimのauto-session.nvimに近い体験を提供してくれます。

```json
{
  "projectManager.git.baseFolders": [
    "$home/dev"
  ]
}
```

Gitリポジトリを自動検出してプロジェクト一覧に追加してくれるため、管理の手間がありません。

## 言語サポート・LSP機能

### Python Development Pack

**ID**: `ms-python.python`、`ms-python.vscode-pylance`

Python開発なら必須の拡張機能セットです。特にPylanceの型チェック機能は、NeovimのLSP設定よりも設定が簡単で高機能です。

### Java Extension Pack

**ID**: `vscjava.vscode-java-pack`

Javaの開発環境構築がワンクリックで完了します。Neovimでは複雑な設定が必要だったデバッグ機能も、VSCodeなら簡単に使えます。

### Go - Golang開発支援

**ID**: `golang.go`

Go言語の開発には欠かせません。フォーマッタやリンタが自動的に設定され、すぐに開発を始められます。

## デバッグ・テスト機能

### Test Explorer UI

**ID**: `hbenl.vscode-test-explorer`

テストの実行と結果表示を統一的に管理できます。NeovimのNeotest.nvimと同等の機能を提供してくれます。

```json
{
  "testExplorer.codeLens": true,
  "testExplorer.gutterDecoration": true
}
```

テストケースごとの成功・失敗がエディタ上で視覚的に確認できるため、開発効率が向上しました。

## Git統合機能

### Git Graph - ブランチの可視化

**ID**: `mhutchie.git-graph`

ブランチの分岐・マージを視覚的に確認できます。コマンドラインのgitlogでは把握しにくい複雑なブランチ構造も、一目で理解できます。

### Git History - ファイル履歴の詳細表示

**ID**: `donjayamanne.githistory`

ファイルの変更履歴を詳細に追跡できます。特定の変更がいつ、なぜ行われたかを簡単に調べられるため、バグ調査で重宝しています。

## コードナビゲーション

### CodeAceJumper - 高速移動

**ID**: `lucax88x.codeacejumper`

Neovimのhop.nvimやeasymotion.vimに相当する機能です。画面内の任意の位置に素早くジャンプできます。

```json
{
  "aceJump.placeholder.backgroundColor": "yellow",
  "aceJump.placeholder.fontWeight": "bold"
}
```

### Bracket Pair Colorizer 2 - 括弧の視覚化

**ID**: `CoenraadS.bracket-pair-colorizer-2`

深いネストがある関数型言語やJavaScriptで威力を発揮します。対応する括弧が色分けされるため、構造が把握しやすくなります。

## ターミナル・統合機能

### Terminal Tabs - ターミナル管理

**ID**: `tyriar.terminal-tabs`

複数のターミナルをタブで管理できます。Neovimのtoggletermプラグインよりも視覚的で使いやすい印象です。

### Remote Development Extension Pack

**ID**: `ms-vscode-remote.vscode-remote-extensionpack`

SSH接続やDocker環境での開発が可能になります。Neovimでは複雑だったリモート開発環境の構築が、VSCodeなら簡単です。

## 厳選の理由と使い分け

### 入れなかった拡張機能

検証したものの、最終的に使わなくなった拡張機能もあります。

- **Prettier** - 言語ごとの設定で十分だった
- **Live Server** - 必要な時にだけインストールする方針に変更
- **TODO Highlight** - GitLensの機能で代替可能だった

### パフォーマンスとの兼ね合い

拡張機能を増やしすぎると、VSCodeの起動速度が遅くなります。本当に必要な機能だけを厳選することが重要です。

```bash
code --disable-extensions
```

定期的に拡張機能を無効化して、どれが本当に必要かを見直しています。

## 設定管理のコツ

### extensions.jsonによる管理

プロジェクトごとに推奨拡張機能を管理しています。

```json
{
  "recommendations": [
    "vscodevim.vim",
    "eamodio.gitlens",
    "ms-python.python"
  ]
}
```

新しいメンバーがプロジェクトに参加した時も、一括で必要な拡張機能をインストールできます。

### 設定の同期

VSCodeの設定同期機能を使って、複数のマシン間で拡張機能リストを共有しています。

```json
{
  "settingsSync.ignoredExtensions": [
    "ms-vscode.live-server"
  ]
}
```

マシン固有の拡張機能は同期から除外することで、環境に応じた最適化も可能です。

## まとめ

Neovimからの移行で重要なのは、すべてを一度に移行しようとしないことです。まずは基本的なVim操作から始めて、徐々に必要な機能を拡張機能で補完していくのがベストです。

今回紹介した拡張機能は、3ヶ月間の実際の開発作業で検証済みです。しかし、開発スタイルやプロジェクトの性質によって最適な選択は変わります。

自分のワークフローに合わせて、少しずつカスタマイズを進めてください。きっと、Neovimとは違った快適さを発見できるはずです。

---

*2025年6月 執筆*