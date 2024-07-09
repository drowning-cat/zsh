fancy-ctrl-z () {
  clear; fg
}
zle -N fancy-ctrl-z

for m in emacs viins vicmd; do
  bindkey -M "$m" '^Z' fancy-ctrl-z # Ctrl + z
done

