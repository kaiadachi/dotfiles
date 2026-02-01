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
# -------------------------------------------------
# -------------------------------------------------
# プラグイン有効化
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#source ~/git-prompt.sh
# -------------------------------------------------
alias distinct='awk '\''!a[$0]++'\'
# -------------------------------------------------
# pecoの活用1
# ctrl + r で過去に実行したコマンドを選択できるようにする。
function peco-select-history() {
    BUFFER=$(\history -n -r 1 | distinct | peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle reset-prompt
}
zle -N peco-select-history
bindkey '^r' peco-select-history
# 色を使用出来るようにする
autoload -Uz colors
colors
# 改変箇所_1
# 時間表記の追加
setopt extended_history
alias history='history -t "%F %T"'
# プロンプト
# git
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{magenta}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{yellow}+"
zstyle ':vcs_info:*' formats "%F{cyan}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }
# プロンプトカスタマイズ
PROMPT='[%B%F{red}%n@%m%f%b:%F{green}%~%f]%F{cyan}$vcs_info_msg_0_%f
%F{yellow}$%f '
export PATH="$HOME/.nodenv/bin:$PATH"
eval "$(nodenv init -)"

# Google Cloud SDK
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi

export JAVA_HOME=$(/usr/libexec/java_home -v1.8)

export PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
export PUPPETEER_EXECUTABLE_PATH=`which chromium`

[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path zsh)"

# Antigravity
export PATH="$HOME/.antigravity/antigravity/bin:$PATH"
