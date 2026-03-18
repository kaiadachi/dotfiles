このセッションで使用したツールを確認し、許可リストへの追加を提案してください。

手順:
1. `~/dotfiles/.claude/settings.json` の `permissions.allow` を読み取る
2. このセッションの会話履歴から、使用した全ツールを収集する:
   - **Bashコマンド**: ベースコマンド名（最初の単語、環境変数代入は除く）→ `Bash(コマンド名 *)` 形式
   - **MCPツール**: `mcp__サーバー名__ツール名` → `mcp__サーバー名__*` のワイルドカード形式で提案
   - **その他のツール**: Read, Write, Edit, Glob, Grep, Agent, WebFetch, WebSearch など
3. 既に許可リストに含まれているもの（ワイルドカード `*` を含むパターンもマッチ判定）を除外する
4. 残ったツールの一覧をユーザーに提示し、AskUserQuestion（multiSelect: true）でどれを追加するか選んでもらう
5. ユーザーが選択したものを `~/dotfiles/.claude/settings.json` の `permissions.allow` に追加する
6. 追加後、dotfiles リポジトリで変更を commit & push する:
   - `cd ~/dotfiles && git add .claude/settings.json && git commit -m "Add allow rules via /allow" && git push`

注意:
- `permissions.deny` に含まれるコマンドは提案しない
- MCPツールは個別ではなくサーバー単位のワイルドカード（`mcp__サーバー名__*`）で提案する
- 追加対象がない場合は「追加するツールはありません」と伝える
