bindkey -M menuselect '/' accept-line  # /
bindkey -M menuselect '^Y' accept-line # Ctrl + y

bindkey '^J' menu-complete # Ctrl + j

bindkey -M menuselect '^H' vi-backward-char        # Ctrl + h
bindkey -M menuselect '^J' vi-down-line-or-history # Ctrl + j
bindkey -M menuselect '^K' vi-up-line-or-history   # Ctrl + k
bindkey -M menuselect '^L' vi-forward-char         # Ctrl + l

## Insert new line

ins-newline() { LBUFFER+=$'\n' }
zle -N ins-newline
bindkey '^[[27;2;13~' ins-newline # Shift + Enter (tmux)
bindkey '^[[13;2u' ins-newline    # Shift + Enter (terminal)

## Kill WORD

backward-kill-space-word() {
  local WORDCHARS=''
  zle backward-kill-word
}
zle -N backward-kill-space-word
bindkey '^[w' backward-kill-space-word # Alt + w

## Toggleable `Ctrl + z`

fancy-ctrl-z () { clear; fg }
zle -N fancy-ctrl-z
for m in emacs viins vicmd; do
  bindkey -M $m '^Z' fancy-ctrl-z # Ctrl + z
done

## Clear screen and scrollback

clear-hard() {
  clear && echo -ne '^[[3J'
  zle && zle .reset-prompt && zle -R
}
zle -N clear-hard
for m in emacs viins vicmd; do
  bindkey -M $m '^L' clear-hard # Ctrl + l
  bindkey -M $m "${terminfo[kf1]:-^[OP}" clear-hard # F1
done

