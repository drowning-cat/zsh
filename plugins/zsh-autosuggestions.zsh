source "$ZFOLDER/submods/zsh-autosuggestions/zsh-autosuggestions.zsh"

WORDCHARS=${WORDCHARS//[\/_-]/}

smart-partial-accept-completion() {
  if [[ -n "$POSTDISPLAY" ]]; then
    zle .forward-word
  else
    zle .forward-char
  fi
}
zle -N smart-partial-accept-completion

ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS+=(smart-partial-accept-completion vi-forward-char)
ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=(${(@)ZSH_AUTOSUGGEST_ACCEPT_WIDGETS:#vi-forward-char})

if [[ -z "$XDG_CURRENT_DESKTOP" ]]; then
  ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=3'
else
  ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=239'
fi

_zsh-autosuggestions-bindings-setup() {
  for m in emacs viins vicmd; do
    bindkey -M $m "${terminfo[kcuf1]:-^[[C}" smart-partial-accept-completion # Right
    bindkey -M $m "${terminfo[kRIT5]:-^[[1;5C}"\
                       autosuggest-accept # Ctrl + Right
    bindkey -M $m '^ ' autosuggest-accept # Ctrl + Space
  done

  bindkey -M vicmd 'L' autosuggest-accept # L

  bindkey '^Y' autosuggest-execute   # Ctrl + y
  bindkey '^N' expand-or-complete    # Ctrl + n
  bindkey '^P' reverse-menu-complete # Ctrl + p

  bindkey '^U' undefined-key      # Ctrl + u
  bindkey '^X' backward-kill-line # Ctrl + x
}

zvm_after_init_commands+=(_zsh-autosuggestions-bindings-setup)

_zsh-autosuggestions-bindings-setup

