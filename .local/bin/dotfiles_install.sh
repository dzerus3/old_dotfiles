#!/bin/zsh

# Quit if any command fails
set -e

# Change shell to zsh
chsh -s /bin/zsh

# Necessary for clean installation
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

# Create necessary directories if they don't already exist
mkdir -p $HOME/.config
mkdir -p $HOME/.local/{state,share,bin}
mkdir -p $HOME/pics/{screenshots,wallpapers}

# Create dotfile git directory
git init --bare $HOME/.local/share/dotfiles
# Set dotfile origin to Github
git --git-dir=$HOME/.local/share/dotfiles --work-tree=$HOME\
    remote add origin https://github.com/dzerus3/dotfiles
# Pull in the dotfiles
git --git-dir=$HOME/.local/share/dotfiles --work-tree=$HOME\
    pull origin minimal
# Set Github as upstream
git --git-dir=$HOME/.local/share/dotfiles --work-tree=$HOME\
    branch --set-upstream-to=origin/minimal minimal

echo "Neovim may have given you a treesitter-related error. This is normal."
echo "Installation seems to have finished successfully. Yay."
