#!/bin/sh

set -e

ZSH_CONFIG_FOLDER_DEFAULT="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
ZSH_CONFIG_FOLDER="${1:-$ZSH_CONFIG_FOLDER_DEFAULT}"

FONT_NAME="MesloLGS NF"
TMP_GIT_FOLDER=

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

bold() { tput bold; }
norm() { tput sgr0; }

ask_yes() {
  read -p "`printf "$1"` [Y/n] " yn
  printf "$2" 2>/dev/null
  case "$yn" in
    [Yy]*|"") return 0 ;; *) return 1 ;;
  esac
}

if ! zsh --version &> /dev/null; then
  echo "Error: Install zsh first" >&2
  exit 1
fi

cleanup() {
  if [ -d "$TMP_GIT_FOLDER" ]; then
    rm -rf "$TMP_GIT_FOLDER" && \
    echo "Temporary folder '$TMP_GIT_FOLDER' was deleted"
    br
  fi
}
trap 'heading "Exit cleanup" && cleanup' ERR

if ! grep "^$USER:" /etc/passwd | grep -q "/bin/zsh"; then
  heading "0. Init zsh shell"
    if ask_yes "Change current user's login shell to 'zsh'?" '\n'; then
      chsh -s `which zsh`
      if [ -f "$HOME/.bash_profile" ] ||
         [ -f "$HOME/.bashrc" ] ||
         [ -f "$HOME/.bash_login" ] ||
         [ -f "$HOME/.bash_logout" ]; then
        echo "Consider migrating bash configuration files to zsh:"
        [ -f "$HOME/.bash_profile" ] && echo "  .bash_profile -> .zprofile"
        [ -f "$HOME/.bashrc" ]       && echo "  .bashrc       -> .zshrc"
        [ -f "$HOME/.bash_login" ]   && echo "  .bash_login   -> .zlogin"
        [ -f "$HOME/.bash_logout" ]  && echo "  .bash_logout  -> .zlogout"
        br
      fi
      print_done
    else
      print_skip
    fi
  :
fi

heading "1/5. Cloning git repository as a temporary folder"
  TMP_GIT_FOLDER=`mktemp -d --suffix .zsh.installation`
  git clone --depth 1 --recursive --shallow-submodules \
      https://github.com/drowning-cat/zsh.git "$TMP_GIT_FOLDER"
  br
  print_done
:
wait

heading "2/5. Copying configuration files"
  if [ ! -e "$ZSH_CONFIG_FOLDER" ] || ask_yes "Replace '$ZSH_CONFIG_FOLDER'" '\n'; then
    rm -rf "$ZSH_CONFIG_FOLDER"
    mkdir -p "$ZSH_CONFIG_FOLDER"
    cp -R "$TMP_GIT_FOLDER/config/." "$ZSH_CONFIG_FOLDER"
    print_done
  else
    exit
  fi
:
wait

heading "3/5. Injecting source string to .zshenv"
  source_env_pattern="source [\"']?${ZSH_CONFIG_FOLDER}/zshenv[\"']?"
  inject="source \"${ZSH_CONFIG_FOLDER}/zshenv\""

  if ! grep -Eq "$source_env_pattern" "$HOME/.zshenv" 2>/dev/null; then
    echo "$inject" >> "$HOME/.zshenv"
    print_done
  else
    print_skip
  fi
:
wait

heading "4/5. Installing '$FONT_NAME' font"
  font_src="$TMP_GIT_FOLDER/fonts/$FONT_NAME"
  font_dst="$HOME/.local/share/fonts/$FONT_NAME"

  if [ ! -e "$font_src" ] ||
     [ ! -e "$font_dst" ] || ask_yes "Replace '$font_dst'?" '\n'; then
    mkdir -p "$font_dst"
    cp -Rv "$font_src" "$_"
    br
    echo "Updating font cache..."
    fc-cache -f
    br
    print_done
  else
    print_skip
  fi
:
wait

heading "5/5. Cleaning up temporary files"
  cleanup
  print_done
:
wait

heading "Complete!"
  bold
    echo "Set '$FONT_NAME' font in your terminal of choice"
  norm
  br
:

