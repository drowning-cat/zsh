# https://github.com/romkatv/powerlevel10k/issues/2048#issuecomment-1271186812
redraw-prompt() {
  local f=
  for f in chpwd "${chpwd_functions[@]}" precmd "${precmd_functions[@]}"; do
    [[ "${+functions[$f]}" == 0 ]] || "$f" &>/dev/null || true
  done
  p10k display -r
}

