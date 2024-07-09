## TL;DR Install

### 1. Run

<details open>
  <summary>Arch</summary>

```sh
paru -S --needed --skipreview --noconfirm zsh fzf fd tree eza zoxide neovim wl-clipboard trash-cli github-cli keychain fnm-bin ttf-meslo-nerd
git clone --recurse-submodules https://github.com/drowning-cat/zsh "${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
ln -sf "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/zshenv" "$HOME/.zshenv"
chsh -s $(which)
```

</details>

<details>
  <summary>Ubuntu</summary>

```sh
sudo apt update
sudo apt install -y zsh fzf fd-find tree eza zoxide neovim wl-clipboard trash-cli gh keychain
curl -fsSL https://fnm.vercel.app/install | bash
git clone --recurse-submodules https://github.com/drowning-cat/zsh "${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
ln -sf "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/zshenv" "$HOME/.zshenv"
mkdir -p "${XDG_DATA_HOME:-$HOME/.local/share}/fonts"
cp -r "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/other/fonts/MesloLGS NF" "${XDG_DATA_HOME:-$HOME/.local/share}/fonts/MesloLGS NF"
fc-cache -f
chsh -s $(which)
```

</details>

### 2. Set `MesloLGS NF` in your terminal

### 3. Reboot

## Detailed Installation Process

<details>
  <summary>Click to expand</summary>

### 1. Install dependencies

#### Install packages for **Arch**

```sh
paru -S --needed --skipreview --noconfirm\
  zsh fzf fd tree eza zoxide neovim wl-clipboard trash-cli github-cli keychain fnm-bin ttf-meslo-nerd
```

<details>
  <summary>or using <b>pacman</b></summary>

  ```sh
  sudo pacman -S zsh fzf fd tree eza zoxide neovim wl-clipboard trash-cli github-cli keychain
  ```

  _[fnm requires manual installation](https://github.com/Schniz/fnm?tab=readme-ov-file#using-a-script-macoslinux)._

</details>

#### Install packages for **Ubuntu**

<details>
  <summary>Click to expand</summary>

  ```sh
  sudo apt install zsh fzf fd-find tree eza zoxide neovim wl-clipboard trash-cli gh keychain
  ```

  _[fnm requires manual installation](https://github.com/Schniz/fnm?tab=readme-ov-file#using-a-script-macoslinux)._

</details>

### 2. Set up zsh configuration

```sh
git clone --recurse-submodules https://github.com/drowning-cat/zsh "${XDG_CONFIG_HOME:-$HOME/.config}/zsh" &&\
ln -sf "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/zshenv" "$HOME/.zshenv"
```

### 3. Install `MesloLGS NF` font

_Skip this step if `ttf-meslo-nerd` is installed (_Arch repository: Extra_)._

```sh
mkdir -p "${XDG_DATA_HOME:-$HOME/.local/share}/fonts" &&\
cp -r "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/other/fonts/MesloLGS NF" "${XDG_DATA_HOME:-$HOME/.local/share}/fonts/MesloLGS NF" &&\
fc-cache -f
```

> [!CAUTION]
> Do not forget to set `MesloLGS NF` in your terminal of choice.

_Any [Nerd font](https://github.com/ryanoasis/nerd-fonts) is supported._

### 4. Make zsh your user's default shell

If necessary, migrate your Bash configuration files to zsh. You can read this arcticle: [The right way to migrate your bash_profile to zsh](https://carlosroso.com/the-right-way-to-migrate-your-bash-profile-to-zsh).

```sh
sudo chsh --shell $(which) $USER
```

### 5. Reboot your system

```sh
sudo reboot
```

</details>

## Dependencies

### [fzf](https://github.com/junegunn/fzf)

<details>
  <summary>Click to expand</summary>

> Fzf is a general-purpose command-line fuzzy finder.

> Trigger search: `vim **` + TAB

| Key Combination | Description                                                                                                   |
|-----------------|---------------------------------------------------------------------------------------------------------------|
| `CTRL + t`      | Fuzzy find all files and subdirectories of the working directory, and output the selection to STDOUT.         |
| `ALT + c`       | Fuzzy find all subdirectories of the working directory, and run the command “cd” with the output as argument. |
| `CTRL + r`      | Fuzzy find through your shell history, and output the selection to STDOUT.                                    |

Meta characters table (search syntax):

| Name              | Example                              |
|-------------------|--------------------------------------|
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
41: source "$ZFOLDER/plugins/fzf.zsh"
```

</details>

### [fd](https://github.com/sharkdp/fd)

<details>
  <summary>Click to expand</summary>

> `fd` is a program to find entries in your filesystem. It is a simple, fast and user-friendly alternative to `find`. While it does not aim to support all of `find` powerful functionality, it provides sensible (opinionated) defaults for a majority of use cases. Used by _fzf_.

`~/.config/zsh/plugins/fzf.zsh`

```sh #link ~/.config/zsh/plugins/fzf.zsh
1: @fd() {
2:   print -rn "fd . --hidden --exclude .git $@ | sed 's|^$HOME|~|;s|^./||'"
3: }
```

</details>

### tree

<details>
  <summary>Click to expand</summary>

> Recursive directory listing program that produces a depth-indented listing of files.

`~/.config/zsh/plugins/fzf.zsh`

```sh #link ~/.config/zsh/plugins/fzf.zsh
35: export FZF_CTRL_T_OPTS="--preview '[[ -d {} ]] && tree -C {} || bat --style numbers --color always --line-range :500 {}'"
36: export FZF_ALT_C_OPTS="--preview 'tree -C {}'"
37: export FZF_COMPLETION_DIR_COMMANDS="cd pushd rmdir tree ls"
```

</details>

### [eza](https://github.com/ogham/eza)

<details>
  <summary>Click to expand</summary>

> `eza` is a modern, maintained replacement for the venerable file-listing command-line program `ls`. It uses colours to distinguish file types and metadata. It knows about symlinks, extended attributes, and Git. And it’s small, fast, and just one single binary. It is a maintained fork of [exa](https://github.com/ogham/exa).

`~/.config/zsh/zshrc`

```sh #link ~/.config/zsh/zshrc
60: alias ls='eza --icons auto'
61: alias ll='eza --icons auto --long --all'
62: alias lt='eza --icons auto --tree --level=5'
```

</details>

### [zoxide](https://github.com/ajeetdsouza/zoxide)

<details>
  <summary>Click to expand</summary>

> `zoxide` is a smarter `cd` command, inspired by `z` and autojump. It remembers which directories you use most frequently, so you can "jump" to them in just a few keystrokes. `zoxide` works on all major shells.

`~/.config/zsh/zshrc`

```sh #link ~/.config/zsh/zshrc
52: eval "$(zoxide init zsh)"
```

</details>

### [_fnm_](https://github.com/Schniz/fnm)

<details>
  <summary>Click to expand</summary>

> Fast Node Manager - faster alternative to [<abbr title="node version manager">nvm</abbr>](https://github.com/nvm-sh/nvm).

`~/.config/zsh/zshrc`

```sh #link ~/.config/zsh/zshrc
49: path+=("$HOME/.local/share/fnm")
...
51: eval "$(fnm env --use-on-cd)"
```

</details>

### [github-cli](https://github.com/cli/cli)

<details>
  <summary>Click to expand</summary>

> `github-cli` is GitHub on the command line. It brings pull requests, issues, and other GitHub concepts to the terminal next to where you are already working with git and your code.

`~/.config/zsh/zshrc`

```sh #link ~/.config/zsh/zshrc
53: eval "$(gh completion -s zsh)"
```

</details>

### [keychain](https://github.com/funtoo/keychain)

<details>
  <summary>Click to expand</summary>

> Keychain helps you to manage `SSH` and `GPG` keys in a convenient and secure manner. It acts as a frontend to `ssh-agent` and `ssh-add`, but allows you to easily have one long running `ssh-agent` process per system.

`~/.config/zsh/zprofile`

```sh #link ~/.config/zsh/zprofile
1: eval "$(keychain --eval --quiet --timeout 60)"
```

</details>

### [neovim](https://github.com/neovim/neovim)

<details>
  <summary>Click to expand</summary>

> Modern version of `vim`.

`~/.config/zsh/zshrc`

```sh #link ~/.config/zsh/zshrc
4: export EDITOR='nvim'
...
67: alias v='nvim'; alias vi='v'; alias vim='v'
68: alias svim='sudo -Es nvim'; alias sv='svim'
```

</details>

### [chezmoi](https://github.com/twpayne/chezmoi)

<details>
  <summary>Click to expand</summary>

> Chezmoi helps you manage your personal configuration files (dotfiles, like ~/.gitconfig) across multiple machines.

`~/.config/zsh/zshrc`

```sh #link ~/.config/zsh/zshrc
65: alias ch='chezmoi'
```

</details>

### [wl-clipboard](https://github.com/bugaevc/wl-clipboard)

<details>
  <summary>Click to expand</summary>

> Command-line copy/paste utilities for Wayland.

`~/.config/zsh/zshrc`

```sh #link ~/.config/zsh/zshrc
66: alias wl='wl-copy'
```

</details>

### [trash-cli](https://github.com/andreafrancia/trash-cli)

<details>
  <summary>Click to expand</summary>

> Alternative to `rm` that uses trash can.

`~/.config/zsh/zshrc`

```sh #link ~/.config/zsh/zshrc
69: alias t='trash'
```

</details>

## Files

- File `~/.zshenv` (symlink to `$XDG_CONFIG_HOME/zsh/zshenv`) is the entry point to the configuration.
- zsh config files are placed in `$XDG_CONFIG_HOME/zsh/.zdotdir/` (zsh configuration files in the _home_ directory are also sourced):
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

<details>
  <summary>Click to expand</summary>

#### Remove main configuration files

```sh
rm -rf "${ZFOLDER:-${XDG_CONFIG_HOME:-$HOME/.config}/zsh}/"
rm "$HOME/.zshenv"
```

#### Remove other .z-files

```sh
rm .zprofile
rm .zshrc
rm .zlogin
rm .zlogout
```

#### Remove the history file

```sh
rm "${HISTFILE:-${XDG_STATE_HOME:-$HOME/.local/state}/.zsh_history}"
```

#### Remove `MesloLGS NF` font

```sh
rm -rf "$HOME/.local/share/fonts/MesloLGS NF/"
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

#### Uninstall dependencies

##### Arch

###### using `paru`

```sh
paru -Rns zsh fzf fd tree eza zoxide neovim wl-clipboard trash-cli github-cli keychain fnm
```

<details>
  <summary>or using <code>pacman</code></summary>

  ```sh
  sudo pacman -Rns zsh fzf fd tree eza zoxide neovim wl-clipboard trash-cli github-cli keychain
  ```

  _Remove [fnm](https://github.com/Schniz/fnm?tab=readme-ov-file#removing) manually:_

  ```sh
  rm -rf ".fnm/"
  ```

</details>

##### Ubuntu

<details>
  <summary>Click to expand</summary>

```sh
sudo apt-get purge --auto-remove zsh fzf fd-find tree eza zoxide neovim wl-clipboard trash-cli gh keychain
```

_Remove [fnm](https://github.com/Schniz/fnm?tab=readme-ov-file#removing) manually:_

```sh
rm -rf ".fnm/"
```

</details>

</details>

## Key combinations and aliases

| Key Combination                | Command                           | Description                                |
|--------------------------------|-----------------------------------|--------------------------------------------|
| `Ctrl + l`, `F1`               | `clear-screen-and-scrollback`     | Clears screen and scrollback               |
| `Ctrl + z`                     | `fancy-ctrl-z`                    | Collapse/expand terminal                   |
| `Ctrl + Down`                  | `subdir.prev`                     | Moves to the parent subdirectory           |
| `Ctrl + Up`                    | `subdir.next`                     | Moves back to the child subdirectory       |
| `Right`                        | `smart-partial-accept-completion` | Partially accepts completion               |
| `Ctrl + Right`, `Ctrl + Space` | `autosuggest-accept`              | Accepts autosuggestion                     |
| `Ctrl + y`                     | `autosuggest-execute`             | Executes the autosuggestion                |
| `Ctrl + n`                     | `expand-or-complete`              | Expands or completes the command           |
| `Ctrl + p`                     | `reverse-menu-complete`           | Completes in reverse order through options |

| Alias                                         | Command                                            |
|-----------------------------------------------|----------------------------------------------------|
| `..`, `...`, `....`, `..1`, `..2`, `..3` etc. | `subdir.prev`                                      |
| `ls`             | `eza --icons`                                                                   |
| `ll`             | `eza --icons --long --all`                                                      |
| `lt`             | `eza --icons --tree --level=5`                                                  |
| `ch`             | `chezmoi`                                                                       |
| `wl`             | `wl-copy`                                                                       |
| `v`, `vi`, `vim` | `nvim`                                                                          |
| `svim`, `sv`     | `sudo -Es nvim`                                                                 |
| `t`              | `trash`                                                                         |
| `g`              | `git`                                                                           |
| `ga`             | `git add -A`                                                                    |
| `gc`             | `git commit`                                                                    |
| `gd`             | `git diff`                                                                      |
| `gl`             | `git log --oneline`                                                             |
| `gp`             | `git push`                                                                      |
| `gs`             | `git status`                                                                    |
| `:q`             | `exit`                                                                          |
| `-`              | `cd -`                                                                          |

_Only the explicitly defined key combinations and aliases are listed here._
