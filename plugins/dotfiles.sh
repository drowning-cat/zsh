REMOTE='git@github.com.drowning-cat:drowning-cat/dotfiles.git'

alias dots='git --git-dir $HOME/.dots_git --work-tree $HOME'

dots-diff() {
  [ $# -eq 0 ] && dots diff -R || dots diff "$@"
}
dots-init() {
  git clone --bare "$REMOTE" "$HOME/.dots_git" && {
    dots reset -q --mixed
    dots-diff
    dots config --local status.showUntrackedFiles no
    dots config --local push.autoSetupRemote yes
  }
}
dots-undo() {
  if [ "$1" = '--init' ] && [ ! -d "$HOME/.dots_git" ]; then
    shift 1
    dots-init
  fi
  dots-diff; diff="$(dots-diff)"
  if [ -n "$diff" ]; then
    echo
    echo -n 'Override [Y/n]: '; read input
    case "${input:-Y}" in
      [Yy]*) ;;
      [Nn]*|*) return 1 ;;
    esac
  fi
  dots checkout -f "$@"
}
dots-save() {
  dots add -u
  dots commit -m "$(dots status --porcelain)" && dots push -u
}

# https://stackoverflow.com/questions/9810327/zsh-auto-completion-for-git-takes-significant-amount-of-time-can-i-turn-it-off
__git_files () {
  _wanted files expl 'local files' _files
}

