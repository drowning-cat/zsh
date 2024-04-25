#!/bin/zsh

SUBMODS_FOLDER="${XDG_CONFIG_HOME:-$HOME/.config}/zsh/submods"

for pathname in $(find "$SUBMODS_FOLDER" -name .git); do
  cd "$(dirname -- "$pathname")"
  git config --get remote.origin.url
  git switch master &>/dev/null || git switch main &>/dev/null
  git fetch; git reset --hard "@{u}"
done

