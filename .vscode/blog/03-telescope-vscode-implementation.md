# VSCodeでTelescope.nvimの体験を再現する方法

Neovimユーザーにとって、Telescope.nvimは欠かせないプラグインです。ファジーファインダーとしての完成度は非常に高く、ファイル検索からLSP機能まで統一されたインターフェースで操作できます。

VSCodeに移行する際、この体験をどう再現するかが最大の課題でした。今回は、その解決策を具体的に紹介します。

## Telescope.nvimの魅力とは

Neovimで3年間Telescopeを使い続けて感じた魅力は、主に3つです。

1. **統一されたインターフェース** - ファイル検索、grep、LSP機能すべてが同じUI
2. **高速な検索** - ripgrepによる高速な全文検索
3. **リアルタイムプレビュー** - 検索結果を選択する前に内容を確認できる

これらの体験をVSCodeで再現するには、複数のアプローチが必要でした。

## VSCodeデフォルト機能の活用

まず最初に、VSCodeの既存機能をTelescope風に設定しました。

### ファイル検索の最適化

VSCodeのQuick Openは基本的な機能ですが、設定次第でかなり使いやすくなります。

```json
{
  "workbench.quickOpen.closeOnFocusLost": false,
  "workbench.quickOpen.preserveInput": false,
  "search.quickOpen.includeSymbols": true,
  "search.quickOpen.includeHistory": true
}
```

`closeOnFocusLost`を無効にすることで、Telescopeのように検索ウィンドウが勝手に閉じることがなくなります。

### 検索機能の強化

ripgrepを使った高速検索を有効にし、Telescopeと同等の検索速度を実現しました。

```json
{
  "search.useRipgrep": true,
  "search.followSymlinks": true,
  "search.smartCase": true,
  "search.useGlobalIgnoreFiles": true
}
```

### 統一されたキーバインディング

Telescopeの操作感を維持するため、すべての検索機能を`Space f`以下に配置しました。

```json
{
  "key": "space f f",
  "command": "workbench.action.quickOpen"
},
{
  "key": "space f g",
  "command": "workbench.action.findInFiles"
},
{
  "key": "space f b",
  "command": "workbench.action.showAllEditors"
}
```

## 限界を感じた部分

VSCodeの標準機能だけでは、Telescopeの体験を完全に再現できませんでした。特に困ったのが以下の点です。

1. **プレビュー機能の不足** - ファイル内容をリアルタイムで確認できない
2. **インターフェースの統一性** - 機能ごとに異なるUIが表示される
3. **カスタマイズ性の制限** - 独自のピッカーを作成できない

これらの問題を解決するため、カスタム拡張機能の開発に着手しました。

## カスタム拡張機能の開発

VSCodeの拡張機能APIを使って、Telescopeライクなインターフェースを実装しました。

### QuickPickの活用

VSCodeの`createQuickPick`APIを使用して、基本的なピッカーを作成しました。

```typescript
const quickPick = vscode.window.createQuickPick<TelescopeItem>();
quickPick.placeholder = 'Type to search files...';
quickPick.matchOnDescription = true;
quickPick.matchOnDetail = true;
```

### ripgrepとの統合

バックエンドでripgrepを実行し、結果をリアルタイムで表示します。

```typescript
exec(`rg --files ${ignoreArgs}`, { cwd: workspaceFolder.uri.fsPath }, (error, stdout) => {
  if (!error) {
    const files = stdout.split('\n').filter(f => f.trim());
    quickPick.items = files.map(file => ({
      label: path.basename(file),
      description: path.dirname(file),
      filePath: path.join(workspaceFolder.uri.fsPath, file)
    }));
  }
});
```

### 動的フィルタリング

入力に応じてリアルタイムでフィルタリングを行います。

```typescript
quickPick.onDidChangeValue(value => {
  if (value) {
    const filtered = quickPick.items.filter(item => 
      item.label.toLowerCase().includes(value.toLowerCase()) ||
      item.description?.toLowerCase().includes(value.toLowerCase())
    );
    quickPick.items = filtered;
  }
});
```

## Live Grep機能の実装

Telescopeの`live_grep`に相当する機能も実装しました。

### 段階的な検索

まず検索パターンを入力し、その後結果をピッカーで表示する方式を採用しました。

```typescript
const searchQuery = await vscode.window.showInputBox({
  prompt: 'Enter search pattern',
  placeHolder: 'Search pattern...'
});

if (searchQuery) {
  exec(`rg "${searchQuery}" --line-number --column`, (error, stdout) => {
    // 結果の処理
  });
}
```

### ジャンプ機能

検索結果を選択すると、該当箇所に直接ジャンプします。

```typescript
quickPick.onDidChangeSelection(selection => {
  if (selection[0]) {
    const item = selection[0] as any;
    vscode.workspace.openTextDocument(item.filePath).then(doc => {
      vscode.window.showTextDocument(doc).then(editor => {
        const position = new vscode.Position(item.line, item.column);
        editor.selection = new vscode.Selection(position, position);
        editor.revealRange(new vscode.Range(position, position));
      });
    });
  }
});
```

## 実際の使用感

開発したカスタム拡張機能を1ヶ月使用した感想です。

### 良くなった点

1. **操作の一貫性** - すべてのファイル操作が統一されたキーバインディングで実行できる
2. **検索速度** - ripgrepによる高速検索が可能
3. **筋肉記憶の維持** - Neovimと同じ操作感で作業できる

### まだ改善が必要な点

1. **プレビュー機能** - リアルタイムプレビューは未実装
2. **カスタマイズ性** - Telescopeほど柔軟なカスタマイズはできない
3. **パフォーマンス** - 大きなプロジェクトでは若干重くなる

## 既存拡張機能との比較

開発前に、既存の拡張機能も検証しました。

### Find It Faster

ripgrepベースの高速検索拡張機能です。速度は優秀ですが、Telescopeのような統一感はありません。

### Quick and Simple Text Selection

マルチカーソル機能に特化した拡張機能です。便利ですが、ファイル検索機能はありません。

結果的に、自分のワークフローに最適化されたカスタム拡張機能が最良の選択でした。

## 今後の改善計画

現在の実装で基本的な要求は満たせていますが、さらなる改善を計画しています。

### プレビュー機能の実装

VSCodeのWebviewAPIを使って、ファイル内容のプレビューを実装予定です。

```typescript
const webviewPanel = vscode.window.createWebviewPanel(
  'filePreview',
  'Preview',
  vscode.ViewColumn.Two,
  {}
);
```

### 設定のカスタマイズ化

ユーザーが自分好みに設定をカスタマイズできるよう、設定項目を増やしていきます。

### パフォーマンスの最適化

大きなプロジェクトでも快適に動作するよう、キャッシュ機能やワーカープロセスの活用を検討しています。

## まとめ

完全にTelescope.nvimを再現することは困難ですが、日常的な使用には十分な機能を実装できました。重要なのは、完璧を求めるよりも、自分のワークフローに最適化された環境を構築することです。

VSCodeの拡張機能開発は思っていたより簡単で、基本的なTypeScriptの知識があれば十分に取り組めます。もし既存の拡張機能で満足できない機能があれば、自作することも検討してみてください。

あなたも自分だけのTelescope風拡張機能を作って、より快適な開発環境を手に入れませんか。

---

*2025年6月 執筆*