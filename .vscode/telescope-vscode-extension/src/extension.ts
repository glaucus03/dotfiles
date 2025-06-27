import * as vscode from 'vscode';
import * as path from 'path';
import { exec } from 'child_process';

// カスタムQuickPickアイテム
interface TelescopeItem extends vscode.QuickPickItem {
    filePath: string;
    preview?: string;
}

// Telescopeライクなファイル検索
async function telescopeFindFiles(context: vscode.ExtensionContext) {
    const workspaceFolder = vscode.workspace.workspaceFolders?.[0];
    if (!workspaceFolder) {
        vscode.window.showErrorMessage('No workspace folder open');
        return;
    }

    const quickPick = vscode.window.createQuickPick<TelescopeItem>();
    quickPick.placeholder = 'Type to search files...';
    quickPick.matchOnDescription = true;
    quickPick.matchOnDetail = true;

    // ripgrepを使用してファイルリストを取得
    const ignorePatterns = vscode.workspace.getConfiguration('telescope').get<string[]>('ignorePatterns') || [];
    const ignoreArgs = ignorePatterns.map(p => `--glob '!${p}'`).join(' ');
    
    exec(`rg --files ${ignoreArgs}`, { cwd: workspaceFolder.uri.fsPath }, (error, stdout) => {
        if (error) {
            // フォールバック: VSCodeのファイル検索APIを使用
            vscode.workspace.findFiles('**/*', `{${ignorePatterns.join(',')}}`).then(files => {
                quickPick.items = files.map(file => ({
                    label: path.basename(file.fsPath),
                    description: path.relative(workspaceFolder.uri.fsPath, path.dirname(file.fsPath)),
                    filePath: file.fsPath
                }));
            });
        } else {
            const files = stdout.split('\n').filter(f => f.trim());
            quickPick.items = files.map(file => ({
                label: path.basename(file),
                description: path.dirname(file),
                filePath: path.join(workspaceFolder.uri.fsPath, file)
            }));
        }
    });

    // ファイル選択時の処理
    quickPick.onDidChangeSelection(selection => {
        if (selection[0]) {
            vscode.workspace.openTextDocument(selection[0].filePath).then(doc => {
                vscode.window.showTextDocument(doc);
            });
            quickPick.dispose();
        }
    });

    // 動的フィルタリング
    quickPick.onDidChangeValue(value => {
        if (value) {
            // フィルタリングロジック（簡易版）
            const filtered = quickPick.items.filter(item => 
                item.label.toLowerCase().includes(value.toLowerCase()) ||
                item.description?.toLowerCase().includes(value.toLowerCase())
            );
            quickPick.items = filtered;
        }
    });

    quickPick.show();
}

// Telescopeライクなgrep検索
async function telescopeLiveGrep(context: vscode.ExtensionContext) {
    const workspaceFolder = vscode.workspace.workspaceFolders?.[0];
    if (!workspaceFolder) {
        vscode.window.showErrorMessage('No workspace folder open');
        return;
    }

    const searchQuery = await vscode.window.showInputBox({
        prompt: 'Enter search pattern',
        placeHolder: 'Search pattern...'
    });

    if (!searchQuery) {
        return;
    }

    const quickPick = vscode.window.createQuickPick<TelescopeItem>();
    quickPick.placeholder = 'Search results...';

    // ripgrepを使用して検索
    exec(`rg "${searchQuery}" --line-number --column`, { cwd: workspaceFolder.uri.fsPath }, (error, stdout) => {
        if (error) {
            vscode.window.showErrorMessage('No results found');
            return;
        }

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
        }).filter((item): item is TelescopeItem & { line: number, column: number } => item !== null);
    });

    // 結果選択時の処理
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
            quickPick.dispose();
        }
    });

    quickPick.show();
}

// カレントディレクトリでの検索
async function telescopeFindInCurrentDirectory(context: vscode.ExtensionContext) {
    const activeEditor = vscode.window.activeTextEditor;
    if (!activeEditor) {
        vscode.window.showErrorMessage('No active editor');
        return;
    }

    const currentDir = path.dirname(activeEditor.document.uri.fsPath);
    const quickPick = vscode.window.createQuickPick<TelescopeItem>();
    quickPick.placeholder = `Search in ${path.basename(currentDir)}...`;

    // 現在のディレクトリ内のファイルを検索
    exec(`rg --files`, { cwd: currentDir }, (error, stdout) => {
        if (error) {
            vscode.window.showErrorMessage('Error searching files');
            return;
        }

        const files = stdout.split('\n').filter(f => f.trim());
        quickPick.items = files.map(file => ({
            label: file,
            filePath: path.join(currentDir, file)
        }));
    });

    quickPick.onDidChangeSelection(selection => {
        if (selection[0]) {
            vscode.workspace.openTextDocument(selection[0].filePath).then(doc => {
                vscode.window.showTextDocument(doc);
            });
            quickPick.dispose();
        }
    });

    quickPick.show();
}

// 拡張機能の有効化
export function activate(context: vscode.ExtensionContext) {
    // コマンドの登録
    context.subscriptions.push(
        vscode.commands.registerCommand('telescope.findFiles', () => telescopeFindFiles(context)),
        vscode.commands.registerCommand('telescope.liveGrep', () => telescopeLiveGrep(context)),
        vscode.commands.registerCommand('telescope.findInCurrentDirectory', () => telescopeFindInCurrentDirectory(context))
    );
}

export function deactivate() {}