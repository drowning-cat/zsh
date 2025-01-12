## Install

1. Run script

   <details open><summary>Arch</summary>

   ```sh
   paru -S --needed --skipreview --noconfirm\
     zsh eza fzf fd tree ttf-meslo-nerd\
     keychain neovim zoxide github-cli wl-clipboard tmux trash-cli\
     fnm-bin
   git clone --recurse-submodules https://github.com/drowning-cat/zsh "${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
   ln -sf "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/zshenv" "$HOME/.zshenv"
   chsh -s $(which zsh)
   ```

   </details>

   <details><summary>Ubuntu</summary>

   ```sh
   # Install related packages
   sudo apt update
   sudo apt install -y zsh eza fzf fd-find tree  # Essential
   sudo apt install -y keychain neovim zoxide gh wl-clipboard tmux trash-cli # Optional, aliases
   curl -fsSL https://fnm.vercel.app/install | bash
   # Setup configuration files
   git clone --recurse-submodules https://github.com/drowning-cat/zsh "${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
   ln -sf "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/zshenv" "$HOME/.zshenv"
   # Install "MesloLGS Nerd Font"
   mkdir -p "${XDG_DATA_HOME:-$HOME/.local/share}/fonts"
   cp -r "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/other/fonts/MesloLGS NF" "${XDG_DATA_HOME:-$HOME/.local/share}/fonts/MesloLGS Nerd Font"
   fc-cache -f
   # Caution! Change the login shell to zsh
   chsh -s $(which zsh)
   # Alternatively, you can use zsh only as an interactive shell
   # ~/.bashrc
   # [ -x /bin/zsh ] && SHELL=/bin/zsh exec zsh
   ```

   </details>

2. Set `MesloLGS Nerd Font` in your terminal

3. Reboot

## Dependencies

### [eza](https://github.com/ogham/eza)

<details><summary>Click</summary>

> []()

> `eza` is a modern, maintained replacement for the venerable file-listing
> command-line program `ls`. It uses colours to distinguish file types and
> metadata. It knows about symlinks, extended attributes, and Git. And it’s
> small, fast, and just one single binary. It is a maintained fork of
> [exa](https://github.com/ogham/exa).

`~/.config/zsh/zalias.zsh`

```sh #link ~/.config/zsh/zalias.zsh
1: if [[ -z "$XDG_CURRENT_DESKTOP" ]]; then
2:   alias ls='eza'
3:   alias ll='eza --long --all'
4:   alias lt='eza --tree --level=5'
5: else
6:   alias ls='eza --icons auto'
7:   alias ll='eza --icons auto --long --all'
8:   alias lt='eza --icons auto --tree --level=5'
9: fi
```

</details>

### [fzf](https://github.com/junegunn/fzf)

<details open><summary>Click</summary>

> []()

> Fzf is a general-purpose command-line fuzzy finder.

> Trigger search: `vim **` + TAB

| Key Combination                    | Description                                                                                                   |
| ---------------------------------- | ------------------------------------------------------------------------------------------------------------- |
| `Ctrl + t`                         | Fuzzy find all files and subdirectories of the working directory, and output the selection to STDOUT.         |
| `Alt + c`                          | Fuzzy find all subdirectories of the working directory, and run the command “cd” with the output as argument. |
| `Ctrl + r`                         | Fuzzy find through your shell history, and output the selection to STDOUT.                                    |
| <code>Alt + \`</code>, `Alt + Tab` | (External plugin) Trigger fuzzy find for zsh's default completion selection menu with fzf                     |

Meta characters table (search syntax):

| Name              | Example                              |
| ----------------- | ------------------------------------ |
| End of line       | `.tex$`                              |
| Beginning of line | `^./explorer`                        |
| The OR operator   | `.xml$ \| .yml$ \| .tex$`            |
| The AND operator  | `.tex$ /headers/`                    |
| The NOT operator  | `.yml$ \| .xml$ \| .tex$ !/headers/` |
| Exact Match       | `'ti`                                |

`~/.config/zsh/plugins/fzf.zsh`

```
File itself
```

`~/.config/zsh/zshrc`

```sh #link ~/.config/zsh/zshrc
49: source "$ZFOLDER/plugins/fzf.zsh"
```

</details>

### [fd](https://github.com/sharkdp/fd)

<details><summary>Click</summary>

> []()

> `fd` is a program to find entries in your filesystem. It is a simple, fast and
> user-friendly alternative to `find`. While it does not aim to support all of
> `find` powerful functionality, it provides sensible (opinionated) defaults for
> a majority of use cases. Used by _fzf_.

`~/.config/zsh/plugins/fzf.zsh`

```sh #link ~/.config/zsh/plugins/fzf.zsh
1: @fd() {
2:   print -rn "fd . --hidden --exclude .git $@ | sed 's|^$HOME|~|;s|^./||'"
3: }
```

</details>

### tree

<details><summary>Click</summary>

> []()

> Recursive directory listing program that produces a depth-indented listing of
> files.

`~/.config/zsh/plugins/fzf.zsh`

```sh #link ~/.config/zsh/plugins/fzf.zsh
35: export FZF_CTRL_T_OPTS="--preview '[[ -d {} ]] && tree -C {} || bat --style numbers --color always --line-range :500 {}'"
36: export FZF_ALT_C_OPTS="--preview 'tree -C {}'"
37: export FZF_COMPLETION_DIR_COMMANDS="cd pushd rmdir tree ls"
```

</details>

### [keychain](https://github.com/funtoo/keychain)

<details><summary>Click</summary>

> []()

> Keychain helps you to manage `SSH` and `GPG` keys in a convenient and secure
> manner. It acts as a frontend to `ssh-agent` and `ssh-add`, but allows you to
> easily have one long running `ssh-agent` process per system.

`~/.config/zsh/zshrc`

```sh #link ~/.config/zsh/zshrc
70: (( $+commands[keychain] )) && eval "$(keychain --eval --quiet --timeout 60)"
```

</details>

### [neovim](https://github.com/neovim/neovim)

<details><summary>Click</summary>

> []()

> Modern version of `vim`.

`~/.config/zsh/zshrc`

```sh #link ~/.config/zsh/zshrc
4: export EDITOR='nvim'
```

`~/.config/zsh/zalias.zsh`

```sh #link ~/.config/zsh/zalias.zsh
21: alias v='nvim'
22: for v in 'vi' 'vm' 'vim'; do alias $v='v'; done
23: alias svim='sudo -Es nvim'
24: alias sv='svim'
25: alias lvim='nvim -c "lua require(\"persistence\").load()"'
26: alias lv='lvim'
```

</details>

### [zoxide](https://github.com/ajeetdsouza/zoxide)

<details><summary>Click</summary>

> []()

> `zoxide` is a smarter `cd` command, inspired by `z` and autojump. It remembers
> which directories you use most frequently, so you can "jump" to them in just a
> few keystrokes. `zoxide` works on all major shells.

`~/.config/zsh/zshrc`

```sh #link ~/.config/zsh/zshrc
74: (( $+commands[zoxide] )) && eval "$(zoxide init zsh)"
```

</details>

### [github-cli](https://github.com/cli/cli)

<details><summary>Click</summary>

> []()

> `github-cli` is GitHub on the command line. It brings pull requests, issues,
> and other GitHub concepts to the terminal next to where you are already
> working with git and your code.

`~/.config/zsh/zshrc`

```sh #link ~/.config/zsh/zshrc
73: (( $+commands[gh] )) && eval "$(gh completion -s zsh)"
```

</details>

### [wl-clipboard](https://github.com/bugaevc/wl-clipboard)

<details><summary>Click</summary>

> []()

> Command-line copy/paste utilities for Wayland.

`~/.config/zsh/zalias.zsh`

```sh #link ~/.config/zsh/zalias.zsh
15: alias wl='wl-copy'
```

</details>

### [tmux](https://github.com/tmux/tmux)

<details><summary>Click</summary>

> []()

> Tmux is a terminal multiplexer: it enables a number of terminals to be
> created, accessed, and controlled from a single screen. It may be detached
> from a screen and continue running in the background, then later reattached.

`~/.config/zsh/zalias.zsh`

```sh #link ~/.config/zsh/zalias.zsh
13: alias tx='tmux'
14: alias tm='tmux'
```

</details>

### [trash-cli](https://github.com/andreafrancia/trash-cli)

<details><summary>Click</summary>

> []()

> Alternative to `rm` that uses trash can.

`~/.config/zsh/zalias.zsh`

```sh #link ~/.config/zsh/zalias.zsh
16: alias t='trash'
```

</details>

### [_fnm_](https://github.com/Schniz/fnm)

<details><summary>Click</summary>

> []()

> Fast Node Manager - faster alternative to
> [<abbr title="node version manager">nvm</abbr>](https://github.com/nvm-sh/nvm).

`~/.config/zsh/zshrc`

```sh #link ~/.config/zsh/zshrc
68: path+=("$HOME/.local/share/fnm")
...
72: (( $+commands[fnm] )) && eval "$(fnm env --use-on-cd)"
```

</details>

## Files

- File `~/.zshenv` (symlink to `$XDG_CONFIG_HOME/zsh/zshenv`) is the entry point
  to the configuration.
- zsh config files are placed in `$XDG_CONFIG_HOME/zsh/.zdotdir/` (zsh
  configuration files in the _home_ directory are also sourced):
  - `.zprofile`
  - `.zshrc`
  - `.zlogin`
  - `.zlogout`
- zsh history file is located in `$XDG_STATE_HOME/.zsh_history`.
- zsh cache files are located in `$XDG_CACHE_HOME`.

### XDG Base Directory

| XDG directory      | Default path     |
| ------------------ | ---------------- |
| `$XDG_CONFIG_HOME` | `~/.config`      |
| `$XDG_STATE_HOME`  | `~/.local/state` |
| `XDG_CACHE_HOME`   | `~/.cache`       |

## Scripts

### Update submodules

```sh
git submodule update --recursive --remote
```

### Delete configuration

<details><summary>Click</summary>

#### Remove main configuration files

```sh
rm -rf "${ZFOLDER:-${XDG_CONFIG_HOME:-$HOME/.config}/zsh}/"
rm "$HOME/.zshenv"
```

#### Remove other .z-files

```sh
rm "$HOME/.zprofile"
rm "$HOME/.zshrc"
rm "$HOME/.zlogin"
rm "$HOME/.zlogout"
```

#### Remove the history file

```sh
rm "${XDG_STATE_HOME:-$HOME/.local/state}/.zsh_history"
```

#### Remove `MesloLGS Nerd Font` font

```sh
rm -rf "$HOME/.local/share/fonts/MesloLGS Nerd Font/"
```

#### Remove cache files

```sh
for pathname in \
  "${ZCOMPCACHE:-${XDG_CACHE_HOME:-$HOME/.cache}/.zcompcache}" \
  "${ZCOMPDUMP:-${XDG_CACHE_HOME:-$HOME/.cache}/.zcompdump}" \
  "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-"*; do
  rm -rf "$pathname"
done
```

#### Change login shell back to Bash

```sh
chsh -s /bin/bash
```

#### Uninstall dependencies

##### Arch

```sh
paru -Rns zsh eza fzf fd tree ttf-meslo-nerd keychain neovim zoxide github-cli chezmoi wl-clipboard tmux trash-cli fnm-bin
```

##### Ubuntu

<details><summary>Click</summary>

```sh
sudo apt-get purge --auto-remove zsh eza fzf fd-find tree keychain neovim zoxide gh chezmoi wl-clipboard tmux trash-cli
```

_Remove [fnm](https://github.com/Schniz/fnm?tab=readme-ov-file#removing)
manually:_

```sh
rm -rf ".fnm/"
```

</details>

</details>

## Key combinations

| Key Combination                    | Command                           | Description                                |
| ---------------------------------- | --------------------------------- | ------------------------------------------ |
| `Ctrl + l`, `F1`                   | `clear-screen-and-scrollback`     | Clears screen and scrollback               |
| `Ctrl + z`                         | `fancy-ctrl-z`                    | Collapse/expand terminal                   |
| `Ctrl + Down`                      | `subdir.prev`                     | Moves to the parent subdirectory           |
| `Ctrl + Up`                        | `subdir.next`                     | Moves back to the child subdirectory       |
| `Right`                            | `smart-partial-accept-completion` | Partially accepts completion               |
| `Ctrl + Right`, `Ctrl + Space`     | `autosuggest-accept`              | Accepts autosuggestion                     |
| `Ctrl + y`                         | `autosuggest-execute`             | Executes the autosuggestion                |
| `Ctrl + n`                         | `expand-or-complete`              | Expands or completes the command           |
| `Ctrl + p`                         | `reverse-menu-complete`           | Completes in reverse order through options |
| `Ctrl + t`                         | -                                 | Fuzzy search for a file                    |
| `Alt + c`                          | -                                 | Fuzzy search for a directory               |
| `Ctrl + r`                         | -                                 | Fuzzy search history                       |
| <code>Alt + \`</code>, `Alt + Tab` | `fzf-tab-complete`                | Fuzzy autocomplemete                       |

| Alias                                         | Command                                    |
| --------------------------------------------- | ------------------------------------------ |
| `..`, `...`, `....`, `..1`, `..2`, `..3` etc. | `subdir.prev`                              |
| `ls`                                          | `eza --icons`                              |
| `ll`                                          | `eza --icons --long --all`                 |
| `lt`                                          | `eza --icons --tree --level=5`             |
| `-`                                           | `cd -`                                     |
| `ch`                                          | `chezmoi`                                  |
| `wl`                                          | `wl-copy`                                  |
| `t`                                           | `trash`                                    |
| `q`                                           | `exit`                                     |
| `v`, `vi`, `vim`                              | `nvim`                                     |
| `svim`, `sv`                                  | `sudo -Es nvim`                            |
| `lvim`, `lv`                                  | `vim -c "normal '\''0"` (last opened file) |
| `g`                                           | `git`, `...`                               |

The full list of aliases can be found in `$ZFOLDER/zalias.zsh`.
