export FZF_DEFAULT_COMMAND="fd . --hidden --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND --type file"
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND --type directory"
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

_fzf_compgen_path() {
  eval "$FZF_CTRL_T_COMMAND '$1'"
}

_fzf_compgen_dir() {
  eval "$FZF_ALT_C_COMMAND '$1'"
}

eval "$(fzf --zsh)"

