#!/bin/zsh

if (( $+commands[keychain] )); then
  eval "$(keychain --eval --quiet --timeout 60)"
fi

