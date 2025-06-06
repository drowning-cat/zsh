source "$ZFOLDER/plugins/p10k/redraw.zsh"
source "$ZFOLDER/submods/powerlevel10k/powerlevel10k.zsh-theme"

if [[ -z "$XDG_CURRENT_DESKTOP" ]]; then
  source "${0:A:h}/_variations/p10k-portable.zsh"
  typeset -g POWERLEVEL9K_DIR_FOREGROUND=2
  typeset -g POWERLEVEL9K_DIR_SHORTENED_FOREGROUND=2
  typeset -g POWERLEVEL9K_DIR_ANCHOR_FOREGROUND=2
else
  source "${0:A:h}/_variations/p10k-lean.zsh"
  typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND=76
  typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND=196
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIINS_CONTENT_EXPANSION='λ'
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VICMD_CONTENT_EXPANSION='Σ'
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIVIS_CONTENT_EXPANSION='V'
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIOWR_CONTENT_EXPANSION='▶'
  typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()
fi

