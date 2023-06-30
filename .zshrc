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
# 1行表示
PROMPT="%~ %# "
export PATH="$HOME/.nodenv/bin:$PATH"
eval "$(nodenv init -)"
