このセッションで実行したBashコマンドを確認し、許可リストへの追加を提案してください。

手順:
1. `~/dotfiles/.claude/settings.json` の `permissions.allow` を読み取る
2. このセッションの会話履歴から、実行した全Bashコマンドのベースコマンド名（最初の単語、環境変数代入は除く）を収集する
3. 既に `Bash(コマンド名 *)` または `Bash(コマンド名)` のワイルドカードパターンで許可されているものを除外する
4. 残ったコマンド名の一覧をユーザーに提示し、AskUserQuestion（multiSelect: true）でどれを追加するか選んでもらう
5. ユーザーが選択したものだけ `Bash(コマンド名 *)` の形式で `~/dotfiles/.claude/settings.json` の `permissions.allow` に追加する

7. 追加後、dotfiles リポジトリで変更を commit & push する:
   - `cd ~/dotfiles && git add .claude/settings.json && git commit -m "Add Bash allow rules via /allow" && git push`

注意:
- `permissions.deny` に含まれるコマンドは提案しない
- 追加対象がない場合は「追加するコマンドはありません」と伝える
