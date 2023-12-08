source "$ZFOLDER/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"

smart-partial-accept-completion() {
  if [[ -n "$POSTDISPLAY" ]]; then
    zle .forward-word
  else
    zle .forward-char
  fi
}
zle -N smart-partial-accept-completion

ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS+=(smart-partial-accept-completion)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=239'

for m in emacs viins vicmd; do
  bindkey -M "$m" "${terminfo[kcuf1]:-^[[C}" smart-partial-accept-completion # Right
  bindkey -M "$m" "${terminfo[kRIT5]:-^[[1;5C}" autosuggest-accept # Ctrl + Right
done

