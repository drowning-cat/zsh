@fd() {
  print -rn "fd . --hidden --exclude .git $@ | sed 's|^$HOME|~|;s|^./||'"
}

export FZF_DEFAULT_COMMAND="$(@fd)"
export FZF_CTRL_T_COMMAND="$(@fd --type file)"
export FZF_ALT_C_COMMAND="$(@fd --type directory)"

eval "
  _fzf_compgen_path() {
    $(@fd --type file $1)
  }
  _fzf_compgen_dir() {
    $(@fd --type directory $1)
  }
"

unfunction @fd

export FZF_DEFAULT_OPTS="
  --multi
  --cycle
  --height 85%
  --border sharp
  --layout reverse
  --info inline
  --prompt '∷ '
  --pointer '▶'
  --marker '⇒'
  --color bg+:-1,fg:249,fg+:15,border:240,spinner:0
  --color hl:1,header:12,info:2,pointer:9,marker:12,prompt:8,hl+:9
  --bind tab:down
  --bind shift-tab:up
  --bind ctrl-d:toggle+down
  --bind ctrl-u:toggle+up
  --bind ctrl-space:toggle
  --bind ctrl-y:accept
"
export FZF_CTRL_T_OPTS="--preview '[[ -d {} ]] && tree -C {} || bat --style numbers --color always --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'tree -C {}'"
export FZF_COMPLETION_DIR_COMMANDS="cd pushd rmdir tree ls"
export FZF_COMPLETION_TRIGGER='**'

eval "$(fzf --zsh)"

## Aloxaf/fzf-tab

source "$ZFOLDER/submods/fzf-tab/fzf-tab.zsh"

for m in emacs viins vicmd; do
  bindkey -M "$m" '\t'   fzf-completion   # Tab
  bindkey -M "$m" '^[\t' fzf-tab-complete # Alt + Tab
  bindkey -M "$m" '^_'   fzf-tab-complete # Ctrl + /
done

zstyle ':fzf-tab:*' use-fzf-default-opts yes

zstyle ':fzf-tab:*' continuous-trigger '/,right,ctrl-l'
zstyle ':fzf-tab:*' accept-line 'ctrl-y'
zstyle ':fzf-tab:*' fzf-flags '--height=85%'

## lincheney/fzf-tab-completion

# source "$ZFOLDER/submods/fzf-tab-completion/zsh/fzf-zsh-completion.sh"
#
# fzf_completion_keys=(
#     /:accept:'repeat-fzf-completion'
#     right:accept:'repeat-fzf-completion'
#     ctrl-l:accept:'repeat-fzf-completion'
#     ctrl-y:accept:'zle accept-line'
# )
# zstyle ':completion:*' fzf-completion-keybindings "${fzf_completion_keys[@]}"
# zstyle ':completion::*:cd:*' fzf-completion-keybindings "${fzf_completion_keys[@]}" /:accept:'repeat-fzf-completion'
#
# zle -N fzf-completion fzf_completion
#
# fzf-completion-after-trigger() {
#   local trigger="${FZF_COMPLETION_TRIGGER:-**}"
#   local FZF_COMPLETION_TRIGGER=""
#   if [[ "$LBUFFER" == *"$trigger" ]]; then
#     BUFFER="${BUFFER::-${#trigger}}"
#     bufwas="$BUFFER"
#     fzf-completion
#     if [[ "$bufwas" == "$BUFFER" ]]; then
#       BUFFER="$BUFFER**"
#       CURSOR=$((CURSOR + ${#trigger}))
#     fi
#   else
#     zle complete-word
#   fi
# }
# zle -N fzf-completion-after-trigger
#
# _comp_options+=(globdots)
#
# for m in emacs viins vicmd; do
#   bindkey -M "$m" '\t'   fzf-completion-after-trigger # Tab
#   bindkey -M "$m" '^[\t' fzf-completion               # Alt + Tab
#   bindkey -M "$m" '^_'   fzf-completion               # Ctrl + /
# done

