## Prerequisites:

---

### Installation

#### 1. Run

```shell
sh -c "$(curl -fsSL https://raw.githubusercontent.com/drowning-cat/zsh/main/install.sh) -- $HOME/.config/zsh"
```

#### 2. Set 'MesloLGS NF' font in your terminal of choice.

*Any [Nerd font](https://github.com/ryanoasis/nerd-fonts) is supported.*

---

### Dependencies:

#### [fzf](https://github.com/junegunn/fzf)

<details>
  <summary>Click to expand</summary>

> Fzf is a general-purpose command-line fuzzy finder.

> Trigger search: `vim **` + TAB

| Keystroke  | Description                                                                                                   |
| ---------- | ------------------------------------------------------------------------------------------------------------- |
| `CTRL + t` | Fuzzy find all files and subdirectories of the working directory, and output the selection to STDOUT.         |
| `ALT + c`  | Fuzzy find all subdirectories of the working directory, and run the command “cd” with the output as argument. |
| `CTRL + r` | Fuzzy find through your shell history, and output the selection to STDOUT.                                    |

---

Meta characters table (search syntax):

| Name              | Example                              |
| ----------------- | ------------------------------------ |
| End of line       | `.tex$`                              |
| Beginning of line | `^./explorer`                        |
| The OR operator   | `.xml$ \| .yml$ \| .tex$`            |
| The AND operator  | `.tex$ /headers/`                    |
| The NOT operator  | `.yml$ \| .xml$ \| .tex$ !/headers/` |
| Exact Match       | `'ti`                                |

`~/zsh/config/modules/fzf.zsh`

```shell
File itself
```

`~/zsh/config/zshrc`

```shell
51: source "$ZFOLDER/modules/fzf.zsh"
```

</details>

#### [fd](https://github.com/sharkdp/fd)

<details>
  <summary>Click to expand</summary>

> Better `find`. Used by _fzf_.

`~/zsh/config/modules/fzf.zsh`

```shell
8: export FZF_DEFAULT_COMMAND="fd . --follow --hidden --exclude .git"
```

`~/zsh/config/zshrc`

```shell
30: alias v='fd --type f --hidden --exclude .git | fzf-tmux -p --reverse | xargs -r nvim'
```

</details>

#### tree

<details>
  <summary>Click to expand</summary>

> Recursive directory listing program that produces a depth-indented listing of files.

`~/zsh/config/modules/fzf.zsh`

```shell
24: --preview '[[ -d {} ]] && tree -C {} || bat --style numbers --color always --line-range :500 {}'
...
27: --preview 'tree -C {}'
...
29: export FZF_COMPLETION_DIR_COMMANDS="cd pushd rmdir tree ls"
```

</details>

#### [eza](https://github.com/ogham/exa)

<details>
  <summary>Click to expand</summary>

> Better `ls`. Maintained fork of [exa](https://github.com/ogham/exa).

`~/zsh/config/zshrc`

```shell
24: alias ls='eza --icons'
25: alias ll='eza --icons --long --all'
26: alias lt='eza --icons --tree --level=5'
```

</details>

#### [zoxide](https://github.com/ajeetdsouza/zoxide)

<details>
  <summary>Click to expand</summary>

> Better `cd`.

`~/zsh/config/zshrc`

```shell
60: eval "$(zoxide init zsh)"
```

</details>

#### [_fnm_](https://github.com/Schniz/fnm)

<details>
  <summary>Click to expand</summary>

> Fast Node Manager - faster alternative to [nvm](https://github.com/nvm-sh/nvm).

`~/zsh/config/zshrc`

```shell
58: path+=("$HOME/.local/share/fnm")
...
61: eval "$(fnm env --use-on-cd)"
```

</details>

#### [neovim](https://github.com/neovim/neovim)

<details>
  <summary>Click to expand</summary>

> Better `vim`.

`~/zsh/config/zshrc`

```shell
4: export EDITOR='nvim'
...
29: alias vim='nvim'; alias svim='sudo -Es nvim'
30: alias v='fd --type f --hidden --exclude .git | fzf-tmux -p --reverse | xargs -r nvim'
```

</details>

#### [wl-clipboard](https://github.com/bugaevc/wl-clipboard)

<details>
  <summary>Click to expand</summary>

> Command-line copy/paste utilities for Wayland.

`~/zsh/config/zshrc`

```shell
27: alias wl='wl-copy'
```

</details>

#### [trash-cli](https://github.com/andreafrancia/trash-cli)

<details>
  <summary>Click to expand</summary>

> Alternative to `rm` that uses trash can.

`~/zsh/config/zshrc`

```shell
31: alias t='trash'
```

</details>

#### find & [git](https://git-scm.com/)

<details>
  <summary>Click to expand</summary>

> Git - version control system designed to work with code.

> Find - The find command in UNIX is a command line utility for walking a file hierarchy.

**They are probably already installed in your system.**

`~/zsh/config/scripts/plugins-update.sh`

```shell
5:  for pathname in $(find "$PLUGINS_FOLDER" -name .git); do
6:    cd "$(dirname -- "$pathname")"
7:    git config --get remote.origin.url
8:    git switch master &>/dev/null || git switch main &>/dev/null
9:    git fetch; git reset --hard "@{u}"
10: done
```

</details>

---

### Files:

- File `~/.zshenv` (source to `~/zsh/config/zshenv`) is the entry point to the Zsh configuration.

- Zsh config files are placed in `~/zsh/config/.zdotdir` (can also be defined in the _home_ directory):
  - `.zprofile`
  - `.zshrc`
  - `.zlogin`
  - `.zlogout`

- Zsh history file is located in `$XDG_STATE_HOME`: `~/.local/state/.zsh_history`.

- Zsh cache files are located in `$XDG_CACHE_HOME`: `~/.cache`.

*Install script clones the repository in `~/zsh` by default.*

---

### Uninstall

#### Warning

**Be careful! The script will delete Zsh configuration files such as:**
  - `~/zsh/**/*`
  - `~/.local/state/.zsh_history`

It will also delete cache files:
  - `~/.zcompdump`
  - `~/.zcompcache`
  - `~/.cache/p10k-*`

#### Script

**If you aware what are you doing, then:**

1. Exit all zsh shells except the current one.

2. Run:

```shell
sh -c "$(curl -fsSL https://raw.githubusercontent.com/drowning-cat/zsh/main/delete.sh)" &&\
exit
```

