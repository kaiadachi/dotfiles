#!/bin/bash
set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"

echo "=== Dotfiles Setup ==="
echo "Dotfiles directory: $DOTFILES_DIR"

# バックアップディレクトリ作成
mkdir -p "$BACKUP_DIR"

# シンボリックリンクを作成する関数
link_file() {
    local src="$1"
    local dst="$2"

    if [ -e "$dst" ] || [ -L "$dst" ]; then
        echo "Backing up: $dst -> $BACKUP_DIR/"
        mv "$dst" "$BACKUP_DIR/"
    fi

    echo "Linking: $src -> $dst"
    ln -sf "$src" "$dst"
}

# 1. Homebrew インストール確認
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# 2. Brewfile からパッケージインストール
echo ""
echo "=== Installing packages from Brewfile ==="
brew bundle install --file="$DOTFILES_DIR/Brewfile" || true

# 3. シェル設定ファイルのリンク
echo ""
echo "=== Linking shell config files ==="
link_file "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
link_file "$DOTFILES_DIR/.zprofile" "$HOME/.zprofile"
link_file "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"

# 4. .config ディレクトリの設定
echo ""
echo "=== Linking .config files ==="
mkdir -p "$HOME/.config/karabiner"
mkdir -p "$HOME/.config/git"
mkdir -p "$HOME/.config/gh"

link_file "$DOTFILES_DIR/.config/karabiner/karabiner.json" "$HOME/.config/karabiner/karabiner.json"
link_file "$DOTFILES_DIR/.config/git/ignore" "$HOME/.config/git/ignore"
link_file "$DOTFILES_DIR/.config/gh/config.yml" "$HOME/.config/gh/config.yml"

# 5. Hammerspoon 設定
echo ""
echo "=== Linking Hammerspoon config ==="
link_file "$DOTFILES_DIR/.hammerspoon" "$HOME/.hammerspoon"

# 6. nodenv セットアップ
if command -v nodenv &> /dev/null; then
    echo ""
    echo "=== Setting up nodenv ==="
    nodenv init - || true
fi

echo ""
echo "=== Setup complete! ==="
echo "Backup files are stored in: $BACKUP_DIR"
echo ""
echo "Please restart your terminal or run: source ~/.zshrc"
