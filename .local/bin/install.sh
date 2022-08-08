git init --bare $HOME/.local/share/dotfiles
git --git-dir=$HOME/.local/share/dotfiles --work-tree=$HOME\
	remote add origin https://github.com/dzerus3/dotfiles
git --git-dir=$HOME/.local/share/dotfiles --work-tree=$HOME\
	pull origin master

if [ "$1" == "plugins" ]; then
	echo "Enabling plugins..."
	mkdir $HOME/.config/zsh/plugins
	git clone --depth 1 https://github.com/wbthomason/packer.nvim\
		~/.local/share/nvim/site/pack/packer/start/packer.nvim
else
	echo "Not enabling plugins. If you want those, run install.sh plugins."
fi
