---
name: sync-permissions
description: Sync session-level permissions to dotfiles settings and push
disable-model-invocation: true
allowed-tools: Read, Bash, Edit
---

セッション中に `~/.claude/settings.local.json` に追加されたツール許可を、dotfiles管理の `~/dotfiles/.claude/settings.json` にマージしてpushする。

## 手順

1. `~/.claude/settings.local.json` の `permissions.allow` を読む
2. `~/dotfiles/.claude/settings.json` の `permissions.allow` を読む
3. `settings.local.json` にあって `settings.json` にないエントリを特定する
4. 差分がなければ「同期するものはありません」と報告して終了する
5. 差分があれば、追加するエントリ一覧をユーザーに表示して確認を取る
6. 確認後、`~/dotfiles/.claude/settings.json` の `permissions.allow` に追加する
7. `settings.local.json` からマージ済みのエントリを削除する（dotfilesに移動したため不要）
8. dotfilesリポジトリで変更をcommit & pushする:
   ```
   cd ~/dotfiles && git add .claude/settings.json && git commit -m "chore: sync claude permissions" && git push
   ```

## 注意事項
- ワイルドカード（`mcp__xxx__*`）はそのまま追加する
- `permissions.deny` は対象外（allowのみ）
- pushに失敗した場合はエラーを報告する
