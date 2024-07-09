source "$ZFOLDER/zshenv"
source "$ZFOLDER/plugins/p10k/instant.zsh"

export EDITOR='nvim'
export KEYTIMEOUT=5

export HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/.zsh_history"
export HISTSIZE=100000000
export SAVEHIST=$HISTSIZE
export HISTORY_IGNORE='(clear)'

export ZCOMPDUMP="${XDG_CACHE_HOME:-$HOME/.cache}/.zcompdump"
export ZCOMPCACHE="${XDG_CACHE_HOME:-$HOME/.cache}/.zcompcache"

setopt no_auto_remove_slash
setopt interactive_comments
setopt glob_dots

setopt share_history
setopt extended_history
setopt hist_find_no_dups
setopt hist_ignore_dups
setopt hist_ignore_space

autoload -Uz compinit; compinit -d "$ZCOMPDUMP"
zmodload zsh/complist

zstyle ':compinstall'  filename "$ZDOTDIR/.zshrc"
zstyle ':completion:*' cache-path "$ZCOMPCACHE"
zstyle ':completion:*' rehash true
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*:-command-:*' tag-order '!parameters'

source "$ZFOLDER/plugins/zsh-autosuggestions.zsh"     # 1
source "$ZFOLDER/plugins/zsh-syntax-highlighting.zsh" # 2
source "$ZFOLDER/plugins/keys/normalize.zsh"          # 3.1
source "$ZFOLDER/plugins/zsh-vi-mode.zsh"             # 3.2

source "$ZFOLDER/submods/zsh-completions/zsh-completions.plugin.zsh"
source "$ZFOLDER/plugins/fzf.zsh"
source "$ZFOLDER/plugins/clear-backbuffer.zsh"
source "$ZFOLDER/plugins/fancy-ctrl-z.zsh"
source "$ZFOLDER/plugins/subdir.zsh"

bindkey -M menuselect '/' accept-line  # /
bindkey -M menuselect '^Y' accept-line # Ctrl + y

path+=("$HOME/.local/share/fnm")

eval "$(fnm env --use-on-cd)"
eval "$(zoxide init zsh)"
eval "$(gh completion -s zsh)"

if [[ -z "$XDG_CURRENT_DESKTOP" ]]; then
  alias ls='eza'
  alias ll='eza --long --all'
  alias lt='eza --tree --level=5'
else
  alias ls='eza --icons auto'
  alias ll='eza --icons auto --long --all'
  alias lt='eza --icons auto --tree --level=5'
fi

alias ch='chezmoi'
alias wl='wl-copy'
alias v='nvim'; alias vi='v'; alias vim='v'
alias svim='sudo -Es nvim'; alias sv='svim'
alias t='trash'
alias g='git'
alias ga='git add -A'
alias gc='git commit'
alias gd='git diff'
alias gl='git log --oneline'
alias gp='git push'
alias gs='git status'
alias :q='exit'
-() cd -

# End of file
source "$ZFOLDER/plugins/p10k/import.zsh"

