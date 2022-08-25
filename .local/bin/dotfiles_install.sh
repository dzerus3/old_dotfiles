#!/usr/bin/zsh

mkdir -p $HOME/.config
mkdir -p $HOME/.local/state
mkdir -p $HOME/.local/share
mkdir -p $HOME/.local/bin

git init --bare $HOME/.local/share/dotfiles
git --git-dir=$HOME/.local/share/dotfiles --work-tree=$HOME\
	remote add origin https://github.com/dzerus3/dotfiles
git --git-dir=$HOME/.local/share/dotfiles --work-tree=$HOME\
	pull origin master

if [ "$1" == "noplugins" ]; then
	echo "Not enabling plugins."
else
	echo "Enabling plugins..."

	mkdir -p $HOME/.config/zsh/plugins
	git clone --depth 1 https://github.com/wbthomason/packer.nvim\
		$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim
fi
