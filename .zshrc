# History設定
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt share_history
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt print_eight_bit

# 色を使用出来るようにする
autoload -Uz colors
colors

# 時間表記の追加
setopt extended_history
alias history='history -t "%F %T"'

# プロンプト (git)
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{magenta}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{yellow}+"
zstyle ':vcs_info:*' formats "%F{cyan}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }
PROMPT='[%B%F{red}%n@%m%f%b:%F{green}%~%f]%F{cyan}$vcs_info_msg_0_%f
%F{yellow}$%f '

# -------------------------------------------------
# zsh plugins (require brew)
# -------------------------------------------------
if command -v brew &> /dev/null; then
    BREW_PREFIX=$(brew --prefix)
    [ -f "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ] && source "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
    [ -f "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ] && source "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

# -------------------------------------------------
# peco history search (ctrl + r)
# -------------------------------------------------
if command -v peco &> /dev/null; then
    alias distinct='awk '\''!a[$0]++'\'
    function peco-select-history() {
        BUFFER=$(\history -n -r 1 | distinct | peco --query "$LBUFFER")
        CURSOR=$#BUFFER
        zle reset-prompt
    }
    zle -N peco-select-history
    bindkey '^r' peco-select-history
fi

# -------------------------------------------------
# nodenv
# -------------------------------------------------
if [ -d "$HOME/.nodenv" ]; then
    export PATH="$HOME/.nodenv/bin:$PATH"
    eval "$(nodenv init -)"
fi

# -------------------------------------------------
# Google Cloud SDK
# -------------------------------------------------
[ -f "$HOME/google-cloud-sdk/path.zsh.inc" ] && . "$HOME/google-cloud-sdk/path.zsh.inc"
[ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ] && . "$HOME/google-cloud-sdk/completion.zsh.inc"

# -------------------------------------------------
# Java
# -------------------------------------------------
if /usr/libexec/java_home &> /dev/null; then
    export JAVA_HOME=$(/usr/libexec/java_home)
fi

# -------------------------------------------------
# Other tools
# -------------------------------------------------
# Puppeteer
export PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
command -v chromium &> /dev/null && export PUPPETEER_EXECUTABLE_PATH=$(which chromium)

# Kiro
[[ "$TERM_PROGRAM" == "kiro" ]] && command -v kiro &> /dev/null && . "$(kiro --locate-shell-integration-path zsh)"

# Antigravity
[ -d "$HOME/.antigravity" ] && export PATH="$HOME/.antigravity/antigravity/bin:$PATH"
