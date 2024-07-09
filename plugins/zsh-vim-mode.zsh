# 1 -- keymaps: vim-mode

# Change the cursor between Normal and Insert vim modes:
#   MODE_CURSOR_VIINS='bar'
#   MODE_CURSOR_VICMD='block'
#   MODE_CURSOR_SEARCH='underline'
#   MODE_CURSOR_REPLACE='underline'
#   MODE_CURSOR_VISUAL="$MODE_CURSOR_VICMD"
#   MODE_CURSOR_VLINE="$MODE_CURSOR_VISUAL"

source "$ZFOLDER/submods/zsh-vim-mode/zsh-vim-mode.plugin.zsh"

# 2 -- keymaps: vim-clipboard

ZSH_SYSTEM_CLIPBOARD_DISABLE_DEFAULT_MAPS=false

source "$ZFOLDER/submods/zsh-system-clipboard/zsh-system-clipboard.zsh"

() {
  local binded_keys i parts key cmd keymap
  for keymap in vicmd visual emacs; do
    binded_keys=(${(f)"$(bindkey -M $keymap)"})
    for (( i = 1; i < ${#binded_keys[@]}; ++i )); do
      parts=("${(z)binded_keys[$i]}")
      key="${parts[1]}"
      cmd="${parts[2]}"
      if (( $+functions[zsh-system-clipboard-$keymap-$cmd] )); then
        if [[ "$cmd" == *"yank"* ]]; then
          eval bindkey -M $keymap $key zsh-system-clipboard-$keymap-$cmd
        else
          # Prefix with <space>
          bindkey -ar " "
          eval bindkey -M $keymap \" \"$key zsh-system-clipboard-$keymap-$cmd
        fi
      fi
    done
  done
}

