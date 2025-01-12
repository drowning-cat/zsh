if [[ -z "$XDG_CURRENT_DESKTOP" ]]; then
  alias ls='eza'
  alias ll='eza --long --all'
  alias lt='eza --tree --level=5'
else
  alias ls='eza --icons auto'
  alias ll='eza --icons auto --long --all'
  alias lt='eza --icons auto --tree --level=5'
fi

-() cd -

alias tx='tmux'
alias tm='tmux'
alias wl='wl-copy'
alias t='trash'
alias q='exit'

alias update='paru -Syyu && flatpack update'

alias v='nvim'
for v in 'vi' 'vm' 'vim'; do alias $v='v'; done
alias svim='sudo -Es nvim'
alias sv='svim'
alias lvim='nvim -c "lua ms = require(\"mini.sessions\"); ms.read(ms.get_latest())"'
alias lv='lvim'

alias v='nvim'
alias vi='v'
alias vim='v'

nvim-open() {
  local open=($(< /dev/stdin))
  if [[ ${#open[@]} -eq 0 ]]; then
    return 1
  fi
  nvim "${open[@]}"
}
alias vu='git diff --name-only --diff-filter=U | nvim-open'
alias vs="git status --short --ignore-submodules | awk '{print \$2}' | nvim-open"
alias vst='git diff --name-only --staged --diff-filter=d | nvim-open'

alias g='git'

alias ga='git add'
alias ga.='git add --all'
alias gap='git add --patch'

alias gb='git branch'
alias gba='git branch --all'
alias gbd='git branch --delete'
alias gbD='git branch --delete --force'
alias gbm='git branch --move'

alias gc='git commit'
alias gc.='git add --all && git commit'
alias gc!='git commit --amend'
alias gc.!='git add --all && git commit --amend'
alias gcn!='git commit --amend --no-edit'
alias gcm='git commit --message'
alias gcm.='git add --all && git commit --message'
alias gcm!='git commit --amend --message'
alias gcm.!='git add --all && git commit --amend --message'
alias gcmn!='git commit --amend --no-edit --message'

alias gcf='git config'

alias gch='git checkout'
alias gcht='git checkout --theirs'
alias gcho='git checkout --ours'
alias gchc='git checkout --conflict=merge'

alias gcl='git clone'

alias gclean!='git clean --force -d'

alias gcp='git cherry-pick'

alias gd='git diff'
alias gdl='git diff @~1'
alias gds='git diff --staged'
alias gdm='git diff $(git-default-branch)'

alias gexport='git archive --format zip --output'

alias ghm='cd "$(git rev-parse --show-toplevel)"'

alias ginit='git init'
alias gi='git init'
alias gi.='git init'

alias gl='git log --oneline'
alias glb='git log --branches --not --remotes --no-walk --oneline'
alias gls='git log --oneline --stat'
alias gln='git log HEAD@{1}..HEAD@{0}' # New, since last pull
alias glw='git whatchanged'

alias gm='git merge'
alias gma='git merge --abort'
alias gmc='git merge --continue'
alias gms='git merge --squash'
alias gmu='git merge upstream/$(git-default-branch)'

alias gmv='git mv'

alias gp='git push'
alias gpd!='git push --delete'
alias gpf!='git push --force-with-lease'
alias gpf!!='git push --force'
alias gpo='git push origin'
alias gpom='git push origin $(git-default-branch)'

alias gpl='git pull'
alias gplu='git pull upstream $(git-default-branch)'
alias gplr='git pull --rebase'
alias gplru='git pull --rebase upstream $(git-default-branch)'
alias gplrs='git pull --rebase --autostash'

alias gP='git pull && git push'

alias grb='git rebase'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbi='git rebase --interactive'
alias grbir='git rebase --interactive --root'
alias grbm='git rebase $(git-default-branch)'
alias grbom='git rebase origin/$(git-default-branch)'
alias grbum='git rebase upstream/$(git-default-branch)'
alias grbms='GIT_SEQUENCE_EDITOR=: git rebase $(git-default-branch) --interactive --autosquash'

alias gr='git reset' # Git reset [h]ead
alias grs!='git reset --soft'
alias grh!='git reset --hard'
alias grhOH!='git reset --hard ORIG_HEAD'
alias grhom!='git fetch && git reset --hard origin/main'
alias grhm!='git reset --hard main'

alias grm!='git rm'
alias grmc='git rm --cached' # Untrack the file, marked as deleted

alias grs='git restore'
alias grss!='git restore --source'
alias grst='git restore --staged'
alias grst.='git restore --staged :/'

alias grt='git remote'
alias grta='git remote add'
alias grts='git remote set-url'
alias grtrn='git remote rename'
alias grtrm='git remote remove'

alias grv='git revert'
alias grva='git revert --abort'

alias gs='git status'
alias gss='git status --short'

alias gsh='git show'
alias gshn='git show --name-only'

alias gst='git stash'
alias gstpo='git stash pop'
alias gstpu='git stash push'
alias gstpum='git stash push -m'
alias gstb='git stash branch'
alias gstd!='git stash drop'
alias gstl='git stash list'

alias gsb='git submodule'
alias gsbu='git submodule update --init --recursive'
alias gsbur='git submodule update --init --recursive --remote'

alias gsw='git switch'
alias gswc='git switch --create'
alias gswm='git switch $(git-default-branch)'
alias gswt='git switch --track'

alias gt='git tag'
alias gta='git tag --annotate'
alias gtd='git tag --delete'
alias gtl='git tag --list'

alias gf='git fetch --all --prune'
alias gft='git fetch --all --prune --tags'

alias gfr='git fetch && git rebase'

alias gFt='git ls-files . --exclude-standard --others' # Untracked files
alias gFm='git diff --name-only --diff-filter=U' # Unmerged files

alias gw='git worktree'
alias gwa='git worktree add'
alias gwl='git worktree list'
alias gwr='git worktree remove'

alias gmain='git-default-branch'

git-default-branch() {
  if ! git rev-parse --is-inside-work-tree &>/dev/null; then
    return 1
  fi
  local local_branch=$(git branch -l 'main' 'master' --format '%(refname:short)')
  if [ -n $local_branch ] && [ $(echo $local_branch | wc -l) = 1 ]; then
    echo -n $local_branch
    return 0
  fi
  local remote_branch=$(git symbolic-ref refs/remotes/origin/HEAD)
  if [ $? = 0 ]; then
    echo -n $remote_branch | sed 's#^refs/remotes/origin/##'
    return 0
  fi
  return 1
}

histignore-git-bang() {
  if [[ $1 =~ ^g[^[:space:]]*! ]]; then
    print -sr -- "#${1%%$'\n'}"
    return 1
  fi
}
add-zsh-hook zshaddhistory histignore-git-bang

