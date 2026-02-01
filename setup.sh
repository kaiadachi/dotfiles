#!/bin/bash
set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"

echo "============================================"
echo "        Dotfiles Setup Script"
echo "============================================"
echo ""
echo "Dotfiles directory: $DOTFILES_DIR"
echo ""

# バックアップディレクトリ作成
mkdir -p "$BACKUP_DIR"

# シンボリックリンクを作成する関数
link_file() {
    local src="$1"
    local dst="$2"

    # 既に正しいシンボリックリンクならスキップ
    if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
        echo "  Already linked: $(basename "$src")"
        return
    fi

    if [ -e "$dst" ] || [ -L "$dst" ]; then
        echo "  Backing up: $dst"
        mv "$dst" "$BACKUP_DIR/"
    fi

    echo "  Linking: $(basename "$src")"
    ln -sf "$src" "$dst"
}

# ============================================
# Step 1: Homebrew
# ============================================
echo "[1/9] Checking Homebrew..."
if ! command -v brew &> /dev/null; then
    echo "  Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
    echo "  Done!"
else
    echo "  Homebrew already installed"
fi

# ============================================
# Step 2: Install packages from Brewfile
# ============================================
echo ""
echo "[2/9] Installing packages from Brewfile..."
echo ""
brew bundle install --file="$DOTFILES_DIR/Brewfile" --verbose
echo ""
echo "  Brewfile installation complete!"

# ============================================
# Step 3: Shell config files
# ============================================
echo ""
echo "[3/9] Linking shell config files..."
link_file "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
link_file "$DOTFILES_DIR/.zprofile" "$HOME/.zprofile"
link_file "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"

# ============================================
# Step 4: .config directory
# ============================================
echo ""
echo "[4/9] Linking .config files..."
mkdir -p "$HOME/.config/karabiner"
mkdir -p "$HOME/.config/git"
mkdir -p "$HOME/.config/gh"

link_file "$DOTFILES_DIR/.config/karabiner/karabiner.json" "$HOME/.config/karabiner/karabiner.json"
link_file "$DOTFILES_DIR/.config/git/ignore" "$HOME/.config/git/ignore"
link_file "$DOTFILES_DIR/.config/gh/config.yml" "$HOME/.config/gh/config.yml"

# ============================================
# Step 5: Hammerspoon
# ============================================
echo ""
echo "[5/9] Linking Hammerspoon config..."
link_file "$DOTFILES_DIR/.hammerspoon" "$HOME/.hammerspoon"

# ============================================
# Step 6: Cursor
# ============================================
echo ""
echo "[6/9] Linking Cursor config..."
mkdir -p "$HOME/Library/Application Support/Cursor/User"
link_file "$DOTFILES_DIR/.cursor/settings.json" "$HOME/Library/Application Support/Cursor/User/settings.json"
link_file "$DOTFILES_DIR/.cursor/keybindings.json" "$HOME/Library/Application Support/Cursor/User/keybindings.json"

# ============================================
# Step 7: Antigravity
# ============================================
echo ""
echo "[7/9] Linking Antigravity config..."
mkdir -p "$HOME/Library/Application Support/Antigravity/User"
link_file "$DOTFILES_DIR/.antigravity/settings.json" "$HOME/Library/Application Support/Antigravity/User/settings.json"
link_file "$DOTFILES_DIR/.antigravity/keybindings.json" "$HOME/Library/Application Support/Antigravity/User/keybindings.json"

# ============================================
# Step 8: nodenv
# ============================================
echo ""
echo "[8/9] Setting up nodenv..."
if command -v nodenv &> /dev/null; then
    nodenv init - || true
    echo "  Done!"
else
    echo "  nodenv not installed, skipping"
fi

# ============================================
# Step 9: Git user config
# ============================================
echo ""
echo "[9/9] Git user config..."
if [ ! -f "$HOME/.gitconfig.local" ]; then
    echo "  Setting up git user config..."
    read -p "  Enter your git user name: " git_name
    read -p "  Enter your git email: " git_email
    cat > "$HOME/.gitconfig.local" << EOF
[user]
	name = $git_name
	email = $git_email
EOF
    echo "  Created ~/.gitconfig.local"
else
    echo "  ~/.gitconfig.local already exists, skipping"
fi

# ============================================
# Complete!
# ============================================
echo ""
echo "============================================"
echo "        Setup Complete!"
echo "============================================"
echo ""
echo "Backup files: $BACKUP_DIR"
echo ""
echo "Next steps:"
echo "  1. Restart terminal or run: source ~/.zshrc"
echo "  2. Login to apps: 1Password, Chrome, Slack, etc."
echo "  3. Run: gh auth login"
echo "  4. Run: gcloud auth login"
echo ""
