# https://unix.stackexchange.com/a/531178/246718
clear-screen-and-scrollback() {
  clear && echo -ne '\e[3J'
  zle && zle .reset-prompt && zle -R
}
zle -N clear-screen-and-scrollback

for m in emacs viins vicmd; do
  bindkey -M "$m" '^[l' clear-screen-and-scrollback # Alt + l
done

