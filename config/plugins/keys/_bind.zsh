bind() {
  local OPTIND= mods=() m= skip_empty=
  while getopts ":ameicv!" m; do
    case "$m" in
      a) mods+=('main' 'emacs' 'viins' 'vicmd' 'visual') ;;
      m) mods+=('main')    ;;
      e) mods+=('emacs')   ;;
      i) mods+=('viins')   ;;
      c) mods+=('vicmd')   ;;
      v) mods+=('visual')  ;;
      !) skip_empty='true' ;;
    esac
  done
  shift "$(( OPTIND - 1 ))"
  if [[ -z "$1" ]]; then
    if [[ "$skip_empty" == 'true' ]]; then
      return 0
    else
      >&2 echo "bind: cannot bind to an empty key sequence"
      return 1
    fi
  fi
  for m ("${(u)mods[@]}") bindkey -M "$m" "$@"
}

