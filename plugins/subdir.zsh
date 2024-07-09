typeset -g SUBDIR=()
typeset -g SUBDIR_BREAKS=('/' "$HOME")

_subdir.cd() {
  SUBDIR_INNER_CD=true
  builtin cd "$@" || return 1
  unset SUBDIR_INNER_CD

  local precmd=
  for precmd in "$precmd_functions[@]"; do
    $precmd
  done
  zle && zle reset-prompt
}

_subdir.cd.chpwd() {
  if [[ "$SUBDIR_INNER_CD" != true ]]; then
    SUBDIR=()
  fi
}

subdir.prev() {
  local current="${1:-$PWD}"
  local parent=$(dirname "$current")

  local b=
  for b in "$SUBDIR_BREAKS[@]"; do
    if [[ "$b" -ef "$current" ]]; then
      return 0
    fi
  done

  if [[ -d "$parent" ]]; then
    _subdir.cd "$parent"
    SUBDIR=("$current" "$SUBDIR[@]")
  else
    subdir.prev "$parent"
  fi
}

subdir.next() {
  if [[ -d "$SUBDIR[1]" ]]; then
    _subdir.cd "$SUBDIR[1]"
    SUBDIR=("${SUBDIR[@]:1}")
  else
    SUBDIR=()
  fi
}

autoload -U add-zsh-hook
add-zsh-hook chpwd _subdir.cd.chpwd

zle -N subdir.prev
zle -N subdir.next

for i in {1..5}; do
  # alias ..='repeat 1 subdir.prev'
  # alias ...='repeat 2 subdir.prev'
  # ...
  alias $(repeat $((i + 1)) printf '.')="repeat $i subdir.prev"

  # alias ..1='repeat 1 subdir.prev'
  # alias ..2='repeat 2 subdir.prev'
  # ...
  alias ..$i="repeat $i subdir.prev"
done

for m in emacs viins vicmd; do
  bindkey -M $m "${terminfo[kDN5]:-^[[1;5B}" subdir.prev # Ctrl + Down
  bindkey -M $m "${terminfo[kUP5]:-^[[1;5A}" subdir.next # Ctrl + Up
done

