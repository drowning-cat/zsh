# https://unix.stackexchange.com/a/531178/246718
clear-screen-and-scrollback() {
  clear && echo -ne '\e[3J'
  zle && zle .reset-prompt && zle -R
}
zle -N clear-screen-and-scrollback

for m in emacs viins vicmd; do
  bindkey -M "$m" '^L' clear-screen-and-scrollback                     # Ctrl + l
  bindkey -M "$m" "${terminfo[kf1]:-^[OP}" clear-screen-and-scrollback # F1
done

