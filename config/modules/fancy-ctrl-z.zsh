# https://github.com/mdumitru/fancy-ctrl-z
fancy-ctrl-z() {
  if [[ -z "$#BUFFER" ]]; then
    BUFFER="fg"
    zle accept-line -w
  else
    zle push-input -w
    zle clear-screen -w
  fi
}
zle -N fancy-ctrl-z

for m in emacs viins vicmd; do
  bindkey -M "$m" '^z' fancy-ctrl-z # Ctrl + z
done

