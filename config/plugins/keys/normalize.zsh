source "${0:A:h}/_keys.zsh"
source "${0:A:h}/_bind.zsh"

() {
  local NO_UNBIND=('-' '=' '/' '_' '+' '?')
  local keyname= keyseq= u=

  unbound-key() { zle undefined-key }
  zle -N unbound-key

  for keyname keyseq in "${(@kv)keys}"; do
    for u in "$NO_UNBIND[@]"; do
      [[ "$keyseq"  == "$u" ]] ||
      [[ "$keyname" == "$u" ]] ||
      [[ "$keyname" == *"-$u" ]] && continue 2
    done
    bind -a "$keyseq" unbound-key
  done

  for key in 'e' 't' 'y' 'o' 'p' 'a' 'x' 'v' 'b' 'n' ']'; do
    bind -a "^$key"  unbound-key
  done

  autoload -Uz up-line-or-beginning-search
  autoload -Uz down-line-or-beginning-search
  zle -N up-line-or-beginning-search
  zle -N down-line-or-beginning-search

  bind -cv "$keys[Backspace]" vi-backward-char
  bind -ei "$keys[Backspace]" backward-delete-char
  bind -cv "$keys[Delete]"    vi-forward-char
  bind -ei "$keys[Delete]"    delete-char
  bind -a  "$keys[Home]"      beginning-of-line
  bind -a  "$keys[End]"       end-of-line
  bind -a  "$keys[Insert]"    overwrite-mode
  bind -a  "$keys[Up]"        up-line-or-beginning-search
  bind -a  "$keys[Down]"      down-line-or-beginning-search
  bind -a  "$keys[Right]"     forward-char
  bind -a  "$keys[Left]"      backward-char
  bind -a  "$keys[PageUp]"    beginning-of-buffer-or-history
  bind -a  "$keys[PageDown]"  end-of-buffer-or-history
  bind -ei "$keys[Tab]"       complete-word
  bind -ei "$keys[Shift-Tab]" reverse-menu-complete
}

