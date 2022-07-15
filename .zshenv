# Sets XDG folder environments if they are not set already.
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

# Moves zsh config to config folder
export ZDOTDIR=$XDG_CONFIG_HOME/zsh

# Sets nvim as default editor
export EDITOR='nvim'

# Sets nvim as pager
if command -v nvim &> /dev/null; then
	export MANPAGER='nvim +Man!'
else
	export MANPAGER='less +Gg'
fi
