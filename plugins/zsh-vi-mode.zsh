source "$ZFOLDER/submods/zsh-system-clipboard/zsh-system-clipboard.zsh"

zvm_config() {
  ZVM_READKEY_ENGINE=$ZVM_READKEY_ENGINE_ZLE
  ZVM_INIT_MODE=sourcing
  ZVM_LAZY_KEYBINDINGS=false
  ZVM_KEYTIMEOUT=0.1
  ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BLOCK
  ZVM_VI_SURROUND_BINDKEY='s-prefix'
}
source "$ZFOLDER/submods/zsh-vi-mode/zsh-vi-mode.zsh"

zvm_custom_vi_yank_eol() {
  zsh-system-clipboard-vicmd-vi-yank-eol
  zvm_highlight custom $CURSOR $(($CURSOR+$#CUTBUFFER))
  zvm_highlight clear
}
zvm_define_widget zvm_custom_vi_yank_eol
zvm_bindkey vicmd  'Y' zvm_custom_vi_yank_eol
zvm_bindkey visual 'Y' zvm_vi_yank

zvm_custom_clipboard_set() {
  printf '%s' "${1:-$CUTBUFFER}" | zsh-system-clipboard-set
}
zvm_custom_clipboard_get() {
  CUTBUFFER="$(zsh-system-clipboard-get)"
}

local zvm_clipboard_set_widgets=(
  zvm_vi_yank
  # zvm_vi_delete
  # zvm_vi_change
  # zvm_vi_change_eol
  # zvm_backward_kill_region
  # zvm_replace_selection
  # zvm_change_surround_text_object
)
for func in "${zvm_clipboard_set_widgets[@]}"; do
  if [[ $func == zvm_vi_yank ]]; then
    functions[$func]="
      ${functions[$func]}
      if [[ \$mode == \$ZVM_MODE_VISUAL_LINE ]]; then
        zvm_custom_clipboard_set "\$CUTBUFFER\\n"
      else
        zvm_custom_clipboard_set
      fi
    "
  else
    functions[$func]="
      ${functions[$func]}
      zvm_custom_clipboard_set
    "
  fi
done

for func in zvm_vi_put_after zvm_vi_put_before; do
  functions[$func]="
    ${functions[$func]}
    zvm_highlight clear
  "
done

zvm_custom_vi_put_clipboard_after() {
  zvm_custom_clipboard_get
  zvm_vi_put_after
}
zvm_custom_vi_put_clipboard_before() {
  zvm_custom_clipboard_get
  zvm_vi_put_before
}
zvm_custom_vi_replace_selection_with_clipboard() {
  zvm_custom_clipboard_get
  zvm_vi_replace_selection
  zvm_custom_clipboard_set
}

zvm_define_widget zvm_custom_vi_put_clipboard_after
zvm_define_widget zvm_custom_vi_put_clipboard_before
zvm_define_widget zvm_custom_vi_replace_selection_with_clipboard

zvm_bindkey vicmd  ' p' zvm_custom_vi_put_clipboard_after
zvm_bindkey vicmd  ' P' zvm_custom_vi_put_clipboard_before
zvm_bindkey visual ' p' zvm_custom_vi_replace_selection_with_clipboard
zvm_bindkey visual ' P' zvm_custom_vi_replace_selection_with_clipboard

