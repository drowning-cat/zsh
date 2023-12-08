#!/bin/zsh

PLUGINS_FOLDER="${ZFOLDER:-$HOME/zsh/config}/plugins"

for pathname in $(find "$PLUGINS_FOLDER" -name .git); do
  cd "$(dirname -- "$pathname")"
  git config --get remote.origin.url
  git switch master &>/dev/null || git switch main &>/dev/null
  git fetch; git reset --hard "@{u}"
done

