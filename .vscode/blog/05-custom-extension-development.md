# VSCode拡張機能を自作してTelescope体験を再現する

既存の拡張機能では満足できない機能がある時、VSCodeでは自分で拡張機能を作成できます。今回は、Telescope.nvimライクなファジーファインダーを実装した経験を通じて、VSCode拡張機能開発の実際を紹介します。

## なぜ自作することにしたのか

VSCodeのデフォルト検索機能や既存の拡張機能を試した結果、Telescopeの体験を完全に再現できませんでした。特に困ったのは以下の点です。

1. **統一されたインターフェース** - 機能ごとに異なるUIが表示される
2. **カスタマイズ性** - 自分のワークフローに合わせた調整ができない  
3. **キーバインディング** - Neovimと同じ操作感で使えない

そこで、必要な機能だけに絞ったカスタム拡張機能の開発を決意しました。

## 開発環境のセットアップ

VSCode拡張機能の開発は、思っていたより簡単に始められます。

### 必要なツール

```bash
npm install -g yo generator-code
yo code
```

対話形式で基本的な構成を生成できます。TypeScriptを選択すれば、型安全な開発が可能です。

### プロジェクト構造

```
telescope-vscode/
├── package.json          # 拡張機能の設定
├── src/
│   └── extension.ts      # メインロジック
├── tsconfig.json         # TypeScript設定
└── README.md
```

シンプルな構成で、学習コストは低く抑えられます。

## 基本機能の実装

### QuickPickの作成

VSCodeのQuickPickAPIを使って、Telescopeライクなインターフェースを作成しました。

```typescript
const quickPick = vscode.window.createQuickPick<TelescopeItem>();
quickPick.placeholder = 'Type to search files...';
quickPick.matchOnDescription = true;
quickPick.matchOnDetail = true;
```

`matchOnDescription`を有効にすることで、ファイルパスでの検索も可能になります。

### ファイル検索の実装

ripgrepを使った高速ファイル検索を実装しました。

```typescript
const ignorePatterns = vscode.workspace.getConfiguration('telescope')
  .get<string[]>('ignorePatterns') || [];
const ignoreArgs = ignorePatterns.map(p => `--glob '!${p}'`).join(' ');

exec(`rg --files ${ignoreArgs}`, { cwd: workspaceFolder.uri.fsPath }, 
  (error, stdout) => {
    if (!error) {
      const files = stdout.split('\n').filter(f => f.trim());
      quickPick.items = files.map(file => ({
        label: path.basename(file),
        description: path.dirname(file),
        filePath: path.join(workspaceFolder.uri.fsPath, file)
      }));
    }
  }
);
```

非同期処理でUIをブロックすることなく、検索結果を表示できます。

## ライブGrep機能の実装

Telescopeの`live_grep`機能も再現しました。

### 段階的な入力処理

まず検索パターンを入力し、その後結果を表示する方式を採用しました。

```typescript
const searchQuery = await vscode.window.showInputBox({
  prompt: 'Enter search pattern',
  placeHolder: 'Search pattern...'
});

if (searchQuery) {
  const quickPick = vscode.window.createQuickPick<GrepItem>();
  exec(`rg "${searchQuery}" --line-number --column`, 
    { cwd: workspaceFolder.uri.fsPath }, (error, stdout) => {
      // 結果処理
    }
  );
}
```

### 結果の構造化

grep結果を構造化して、ジャンプ機能に必要な情報を保持します。

```typescript
const results = stdout.split('\n').filter(line => line.trim());
quickPick.items = results.map(result => {
  const match = result.match(/^(.+?):(\d+):(\d+):(.*)$/);
  if (match) {
    const [, file, line, column, content] = match;
    return {
      label: `${path.basename(file)}:${line}`,
      description: file,
      detail: content.trim(),
      filePath: path.join(workspaceFolder.uri.fsPath, file),
      line: parseInt(line) - 1,
      column: parseInt(column) - 1
    };
  }
  return null;
}).filter(item => item !== null);
```

## ジャンプ機能の実装

検索結果を選択した時の動作も重要です。

```typescript
quickPick.onDidChangeSelection(selection => {
  if (selection[0]) {
    const item = selection[0] as GrepItem;
    vscode.workspace.openTextDocument(item.filePath).then(doc => {
      vscode.window.showTextDocument(doc).then(editor => {
        const position = new vscode.Position(item.line, item.column);
        editor.selection = new vscode.Selection(position, position);
        editor.revealRange(new vscode.Range(position, position));
      });
    });
    quickPick.dispose();
  }
});
```

ファイルを開いて該当行にジャンプし、ハイライトまで行います。

## 動的フィルタリングの実装

入力に応じてリアルタイムでフィルタリングを行う機能も追加しました。

```typescript
quickPick.onDidChangeValue(value => {
  if (value) {
    const filtered = allItems.filter(item => 
      item.label.toLowerCase().includes(value.toLowerCase()) ||
      item.description?.toLowerCase().includes(value.toLowerCase())
    );
    quickPick.items = filtered;
  } else {
    quickPick.items = allItems;
  }
});
```

検索結果の中からさらに絞り込めるため、大きなプロジェクトでも使いやすくなります。

## 設定機能の実装

ユーザーがカスタマイズできるよう、設定項目も用意しました。

### package.jsonでの設定定義

```json
{
  "contributes": {
    "configuration": {
      "title": "Telescope",
      "properties": {
        "telescope.ignorePatterns": {
          "type": "array",
          "default": [".git", "node_modules", ".vscode"],
          "description": "Patterns to ignore when searching"
        },
        "telescope.useRipgrep": {
          "type": "boolean",
          "default": true,
          "description": "Use ripgrep for searching"
        }
      }
    }
  }
}
```

### 設定値の取得

```typescript
const config = vscode.workspace.getConfiguration('telescope');
const ignorePatterns = config.get<string[]>('ignorePatterns') || [];
const useRipgrep = config.get<boolean>('useRipgrep', true);
```

## 開発中に遭遇した課題

### パフォーマンスの問題

大きなプロジェクトでは、ファイル数が多すぎて表示が重くなる問題がありました。

解決策として、段階的な読み込みを実装しました。

```typescript
const BATCH_SIZE = 100;
let currentIndex = 0;

const loadNextBatch = () => {
  const nextBatch = allFiles.slice(currentIndex, currentIndex + BATCH_SIZE);
  quickPick.items = [...quickPick.items, ...nextBatch];
  currentIndex += BATCH_SIZE;
  
  if (currentIndex < allFiles.length) {
    setTimeout(loadNextBatch, 10);
  }
};
```

### メモリリークの対策

QuickPickのイベントリスナーが原因でメモリリークが発生しました。

```typescript
const disposables: vscode.Disposable[] = [];

disposables.push(
  quickPick.onDidChangeSelection(/* handler */),
  quickPick.onDidChangeValue(/* handler */)
);

quickPick.onDidHide(() => {
  disposables.forEach(d => d.dispose());
});
```

適切なリソース管理により、メモリリークを解決できました。

## テストとデバッグ

### 開発用ホストでのテスト

`F5`キーで開発用VSCodeインスタンスを起動できます。リアルタイムでコードを変更しながら動作確認できるため、開発効率が良好です。

### ログ出力

デバッグには`console.log`が使えます。

```typescript
console.log(`Found ${files.length} files`);
```

出力内容は開発コンソールで確認できます。

## 実際の使用感

2ヶ月間使用した感想です。

### 良かった点

1. **操作の一貫性** - すべての検索機能が同じUIで操作できる
2. **カスタマイズ性** - 自分のワークフローに最適化できる
3. **学習効果** - VSCodeの内部APIを深く理解できた

### 改善が必要な点

1. **プレビュー機能** - まだ実装できていない
2. **パフォーマンス** - 大規模プロジェクトでは重い
3. **エラーハンドリング** - より堅牢な実装が必要

## 今後の改善計画

### プレビュー機能の実装

WebviewAPIを使ったファイルプレビューを検討しています。

```typescript
const panel = vscode.window.createWebviewPanel(
  'filePreview',
  'Preview',
  vscode.ViewColumn.Two,
  { enableScripts: true }
);
```

### パフォーマンス最適化

ワーカープロセスやキャッシュ機能の導入を計画しています。

### コミュニティでの共有

完成度が高まったら、VSCode Marketplaceで公開する予定です。

## 開発を通じて学んだこと

VSCode拡張機能開発は、思っていたより敷居が低く、実用的な成果を得られました。特に以下の点で学びがありました。

1. **APIの充実度** - VSCodeのAPIは良く設計されている
2. **開発体験** - TypeScriptによる型安全な開発が可能
3. **コミュニティ** - 豊富なサンプルコードとドキュメント

もしあなたも既存の拡張機能では満足できない機能があるなら、自作を検討してみてください。きっと想像以上に簡単に実現できるはずです。

## まとめ

カスタム拡張機能により、Telescopeライクな体験をVSCodeで実現できました。完全な再現ではありませんが、日常的な使用には十分な機能を実装できています。

重要なのは、完璧を求めるより、自分のワークフローに最適化された環境を構築することです。VSCode拡張機能開発は、その実現手段として非常に有効でした。

あなたも自分だけの拡張機能を作って、より快適な開発環境を手に入れませんか。

---

*2025年6月 執筆*