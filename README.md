# dotfiles

macOS の開発環境セットアップ用 dotfiles

## 含まれる設定

- **Brewfile** - アプリケーション・CLIツール一覧
- **.zshrc / .zprofile** - シェル設定
- **.gitconfig** - Git設定
- **.config/karabiner/** - Karabiner-Elements（Cmd単押しで英数/かな切替）
- **.config/gh/** - GitHub CLI設定
- **.config/git/ignore** - グローバル gitignore
- **.hammerspoon/** - ウィンドウ管理（ShiftIt）

## セットアップ

```bash
git clone https://github.com/kaiadachi/dotfiles.git ~/dotfiles
cd ~/dotfiles
./setup.sh
```

## setup.sh が行うこと

1. Homebrew のインストール（未インストールの場合）
2. Brewfile からアプリ・CLIツールを一括インストール
3. 設定ファイルをシンボリックリンクで配置
4. 既存ファイルは `~/.dotfiles_backup/` に自動バックアップ

## 手動設定が必要なもの

- 1Password: ログイン
- Google Chrome: ログイン・拡張機能
- Slack: ワークスペース追加
- Docker: ログイン
- JetBrains Toolbox: IDE インストール
- gh: `gh auth login`
- gcloud: `gcloud auth login`
