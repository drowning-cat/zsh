source "$ZFOLDER/plugins/powerlevel10k/powerlevel10k.zsh-theme"

underline() {
  echo "`tput smul`$1`tput rmul`"
}

if [[ -z "$XDG_CURRENT_DESKTOP" ]]; then
  source "${0:A:h}/variations/p10k-portable.zsh"
else
  source "${0:A:h}/variations/p10k-lean.zsh"
  declare -g POWERLEVEL9K_PROMPT_CHAR_OK_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND=76
  declare -g POWERLEVEL9K_PROMPT_CHAR_ERROR_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND=196
  declare -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIINS_CONTENT_EXPANSION='λ'
  declare -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VICMD_CONTENT_EXPANSION=`underline λ`
  declare -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIVIS_CONTENT_EXPANSION='V'
  declare -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIOWR_CONTENT_EXPANSION='▶'
fi

