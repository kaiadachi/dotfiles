このセッションでユーザーに許可を求めたツール呼び出しを確認し、許可リストへの追加を提案してください。

手順:
1. `~/dotfiles/.claude/settings.json` の `permissions.allow` と `permissions.deny` を読み取る
2. このセッションの会話履歴から、**ユーザーに許可確認が表示されたツール呼び出し**を全て収集する（自動許可されたものは除く）:
   - **Bashコマンド**: → `Bash(コマンド名 *)` 形式で提案
   - **MCPツール**: → `mcp__サーバー名__*` のワイルドカード形式で提案
   - **その他ツール**: Read, Write, Edit, Glob, Grep, Agent, WebFetch, WebSearch, Skill など → そのまま提案
3. 既に許可リストに含まれているもの（ワイルドカード `*` パターンもマッチ判定）を除外する
4. `permissions.deny` に含まれるものは提案しない
5. 残ったツールの一覧をユーザーに提示し、AskUserQuestion（multiSelect: true）でどれを追加するか選んでもらう
6. ユーザーが選択したものを `~/dotfiles/.claude/settings.json` の `permissions.allow` に追加する
7. 追加後、dotfiles リポジトリで変更を commit & push する:
   - `cd ~/dotfiles && git add .claude/settings.json && git commit -m "Add allow rules via /allow" && git push`

注意:
- 許可確認が表示されなかった（自動許可された）ツールは対象外
- MCPツールは個別ではなくサーバー単位のワイルドカード（`mcp__サーバー名__*`）で提案する
- 追加対象がない場合は「追加するツールはありません」と伝える
