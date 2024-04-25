#!/bin/sh

ZSH_CONFIG_FOLDER_DEFAULT="${ZFOLDER:-${XDG_CONFIG_HOME:-$HOME/.config}/zsh}"
ZSH_CONFIG_FOLDER="${1:-$ZSH_CONFIG_FOLDER_DEFAULT}"

FONT_NAME="MesloLGS NF"

hr() { echo "-------------------------------------------------"; }
br() { echo; }
heading() {
  br
  hr
  echo "$1"
  hr
  br
}
print_done() { echo "Done"; }
print_skip() { echo "Skip section"; }
print_no_tasks() { echo "Nothing to do"; }

wait() { sleep '0.5s'; }

ask_yes() {
  read -p "`printf "$1"` [Y/n] " yn
  printf "$2" 2>/dev/null
  case "$yn" in
    [Yy]*|"") return 0 ;; *) return 1 ;;
  esac
}

ask_no() {
  read -p "`printf "$1"` [y/N] " yn
  printf "$2" 2>/dev/null
  case "$yn" in
    [Yy]*) return 0 ;; ""|*) return 1 ;;
  esac
}

remove() {
  ask_func="$1"
  pathname="$2"
  ask_func_append="$3"

  if [ ! -e "$pathname" ]; then
    return 1
  fi

  if "$ask_func" "Remove '$pathname'?" "$ask_func_append"; then
    rm -rf "$pathname"
  else
    return 2
  fi
}

heading "1/5. Remove entry point from '~/.zshenv' file"
  source_env_pattern="source [\"']?${ZSH_CONFIG_FOLDER}/zshenv[\"']?"
  grepped_line=`grep -En "$source_env_pattern" "$HOME/.zshenv" 2>/dev/null`

  if [ "$?" -eq 0 ]; then
    if ask_yes "Remove Lines from file '$HOME/.zshenv':\n$grepped_line" '\n'; then
      sed -Ei "\|$source_env_pattern|d" "$HOME/.zshenv"
      print_done
    else
      print_skip
    fi
  else
    print_no_tasks
  fi
:
wait

heading "2/5. Remove configuration folder"
  pathname="$ZSH_CONFIG_FOLDER"

  if [ -e "$pathname" ]; then
    remove ask_yes "$pathname" '\n' && print_done || print_skip
  else
    print_no_tasks
  fi
:
wait

heading "3/5. Remove history"
  pathname="${HISTFILE:-${XDG_STATE_HOME:-$HOME/.local/state}/.zsh_history}"

  if [ -e "$pathname" ]; then
    remove ask_no "$pathname" '\n' && print_done || print_skip
  else
    print_no_tasks
  fi
:
wait

heading "4/5. Remove '$FONT_NAME' font"
  pathname="$HOME/.local/share/fonts/$FONT_NAME"

  if [ -e "$pathname" ]; then
    remove ask_no "$pathname" '\n' && print_done || print_skip
  else
    print_no_tasks
  fi
:
wait

heading "5/5. Remove cache files"
  are_no_tasks=true

  for pathname in \
    "${ZCOMPCACHE:-${XDG_CACHE_HOME:-$HOME/.cache}/.zcompcache}" \
    "${ZCOMPDUMP:-${XDG_CACHE_HOME:-$HOME/.cache}/.zcompdump}" \
    "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-"*; do
    remove ask_yes "$pathname" && [ ! "$?" -eq 1 ] && are_no_tasks=false
  done

  br

  if [ "$are_no_tasks" = false ]; then
    print_done
  else
    print_no_tasks
  fi
:

br
hr
br
echo "Press any key to exit..."
read -rsn1 && exit

