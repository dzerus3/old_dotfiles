#!/bin/zsh

# Necessary for clean installation
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

mkdir -p $HOME/.config
mkdir -p $HOME/.local/state
mkdir -p $HOME/.local/share
mkdir -p $HOME/.local/bin

git init --bare $HOME/.local/share/dotfiles
git --git-dir=$HOME/.local/share/dotfiles --work-tree=$HOME\
    remote add origin https://github.com/dzerus3/dotfiles
git --git-dir=$HOME/.local/share/dotfiles --work-tree=$HOME\
    pull origin master

echo "Enabling plugins..."

# Creates zsh plugins folder (zsh will auto install them from there)
mkdir -p $HOME/.config/zsh/plugins

# Installs Packer (neovim package manager)
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
    $HOME/.local/share/nvim/site/pack/packer/start/packer.nvim

# Disables neovim plugins temporarily
sed -i '1i\
    vim.g.disableplugins = 1
' $XDG_CONFIG_HOME/nvim/init.lua

# Runs PackerSync to get all other plugins installed
nvim -c "PackerSync" $(mktemp)

# Re-enable neovim plugins
sed '1d' $XDG_CONFIG_HOME/nvim/init.lua > $XDG_CONFIG_HOME/nvim/tmp.lua
mv $XDG_CONFIG_HOME/nvim/tmp.lua $XDG_CONFIG_HOME/nvim/init.lua

echo "Installation seems to have finished successfully. Yay."
