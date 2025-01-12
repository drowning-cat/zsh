source "$ZFOLDER/zshenv"
source "$ZFOLDER/plugins/p10k/instant.zsh"

export EDITOR='nvim'
export VISUAL='nvim'
export MANPAGER='nvim +Man!'
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

autoload -Uz compinit; compinit -C; (compinit &)
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

# if [[ -n $NVIM ]]; then                             # # 3.3
#   bindkey -e                                        # #
# fi                                                  # #

source "$ZFOLDER/plugins/dotfiles.sh"
source "$ZFOLDER/plugins/clear-backbuffer.zsh"
source "$ZFOLDER/plugins/fancy-ctrl-z.zsh"
source "$ZFOLDER/plugins/fzf.zsh"
source "$ZFOLDER/plugins/subdir.zsh"
source "$ZFOLDER/submods/zsh-completions/zsh-completions.plugin.zsh"

bindkey -M menuselect '/' accept-line  # /
bindkey -M menuselect '^Y' accept-line # Ctrl + y

bindkey '^J' menu-complete # Ctrl + j

bindkey -M menuselect '^H' vi-backward-char        # Ctrl + h
bindkey -M menuselect '^J' vi-down-line-or-history # Ctrl + j
bindkey -M menuselect '^K' vi-up-line-or-history   # Ctrl + k
bindkey -M menuselect '^L' vi-forward-char         # Ctrl + l

function ins-newline() LBUFFER+=$'\n'
zle -N ins-newline
bindkey '^[[27;2;13~' ins-newline # Shift + Enter (tmux)
bindkey '^[[13;2u' ins-newline    # Shift + Enter (terminal)

path+=("$HOME/.local/share/fnm")

(( $+commands[keychain] )) && eval "$(keychain --eval --quiet --timeout 60)"

(( $+commands[fnm] )) && eval "$(fnm env --use-on-cd)"
(( $+commands[bob] )) && eval "$(bob complete zsh)"
(( $+commands[gh] )) && eval "$(gh completion -s zsh)"
(( $+commands[zoxide] )) && eval "$(zoxide init zsh)"

source "$ZFOLDER/zalias.zsh"

# End of file
source "$ZFOLDER/plugins/p10k/import.zsh"

