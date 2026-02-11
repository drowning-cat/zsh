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

2. Set `MesloLGS Nerd Font` in your terminal

3. Reboot
