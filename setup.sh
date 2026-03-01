#!/bin/bash
set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"

# シンボリックリンクを作成する関数
link_file() {
    local src="$1"
    local dst="$2"

    if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
        echo "  Already linked: $(basename "$src")"
        return
    fi

    if [ -e "$dst" ] || [ -L "$dst" ]; then
        mkdir -p "$BACKUP_DIR"
        echo "  Backing up: $dst"
        mv "$dst" "$BACKUP_DIR/"
    fi

    echo "  Linking: $(basename "$src")"
    ln -sf "$src" "$dst"
}

# ============================================
# 各ステップを関数化
# ============================================

step_brew() {
    echo "[brew] Checking Homebrew..."
    if ! command -v brew &> /dev/null; then
        echo "  Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        eval "$(/opt/homebrew/bin/brew shellenv)"
        echo "  Done!"
    else
        echo "  Homebrew already installed"
    fi
}

step_packages() {
    echo "[packages] Installing packages from Brewfile..."
    brew bundle install --file="$DOTFILES_DIR/Brewfile" --verbose
    echo "  Done!"
}

step_shell() {
    echo "[shell] Linking shell config files..."
    link_file "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
    link_file "$DOTFILES_DIR/.zprofile" "$HOME/.zprofile"
    link_file "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"
}

step_config() {
    echo "[config] Linking .config files..."
    mkdir -p "$HOME/.config/karabiner"
    mkdir -p "$HOME/.config/git"
    mkdir -p "$HOME/.config/gh"
    link_file "$DOTFILES_DIR/.config/karabiner/karabiner.json" "$HOME/.config/karabiner/karabiner.json"
    link_file "$DOTFILES_DIR/.config/git/ignore" "$HOME/.config/git/ignore"
    link_file "$DOTFILES_DIR/.config/gh/config.yml" "$HOME/.config/gh/config.yml"
}

step_hammerspoon() {
    echo "[hammerspoon] Linking Hammerspoon config..."
    link_file "$DOTFILES_DIR/.hammerspoon" "$HOME/.hammerspoon"
}

step_cursor() {
    echo "[cursor] Linking Cursor config..."
    mkdir -p "$HOME/Library/Application Support/Cursor/User"
    link_file "$DOTFILES_DIR/.cursor/settings.json" "$HOME/Library/Application Support/Cursor/User/settings.json"
    link_file "$DOTFILES_DIR/.cursor/keybindings.json" "$HOME/Library/Application Support/Cursor/User/keybindings.json"
}

step_antigravity() {
    echo "[antigravity] Linking Antigravity config..."
    mkdir -p "$HOME/Library/Application Support/Antigravity/User"
    link_file "$DOTFILES_DIR/.antigravity/settings.json" "$HOME/Library/Application Support/Antigravity/User/settings.json"
    link_file "$DOTFILES_DIR/.antigravity/keybindings.json" "$HOME/Library/Application Support/Antigravity/User/keybindings.json"
}

step_nodenv() {
    echo "[nodenv] Setting up nodenv..."
    if command -v nodenv &> /dev/null; then
        nodenv init - || true
        echo "  Done!"
    else
        echo "  nodenv not installed, skipping"
    fi
}

step_git() {
    echo "[git] Git user config..."
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
}

step_claude() {
    echo "[claude] Linking Claude Code config..."
    mkdir -p "$HOME/.claude/hooks"
    link_file "$DOTFILES_DIR/.claude/settings.json" "$HOME/.claude/settings.json"
    link_file "$DOTFILES_DIR/.claude/hooks/auto-allow-bash.sh" "$HOME/.claude/hooks/auto-allow-bash.sh"
}

# ============================================
# 全ステップ実行
# ============================================

ALL_STEPS=(brew packages shell config hammerspoon cursor antigravity nodenv git claude)

run_all() {
    echo "============================================"
    echo "        Dotfiles Setup Script"
    echo "============================================"
    echo ""
    echo "Dotfiles directory: $DOTFILES_DIR"
    echo ""

    local total=${#ALL_STEPS[@]}
    local i=1
    for step in "${ALL_STEPS[@]}"; do
        echo ""
        "step_$step"
        ((i++))
    done

    echo ""
    echo "============================================"
    echo "        Setup Complete!"
    echo "============================================"
    echo ""
    echo "Next steps:"
    echo "  1. Restart terminal or run: source ~/.zshrc"
    echo "  2. Login to apps: 1Password, Chrome, Slack, etc."
    echo "  3. Run: gh auth login"
    echo "  4. Run: gcloud auth login"
    echo ""
}

# ============================================
# エントリーポイント
# ============================================

if [ $# -eq 0 ]; then
    run_all
else
    for arg in "$@"; do
        found=false
        for step in "${ALL_STEPS[@]}"; do
            if [ "$arg" = "$step" ]; then
                "step_$step"
                found=true
                break
            fi
        done
        if [ "$found" = false ]; then
            echo "Unknown step: $arg"
            echo "Available: ${ALL_STEPS[*]}"
            exit 1
        fi
    done
fi
