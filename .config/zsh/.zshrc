# Enable colors
autoload -U colors && colors

# Enable tab completion TODO REVIEW
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit

# Autocompletes hidden files
_comp_options+=(globdots)

# Sets max history size
HISTSIZE=250
SAVEHIST=250

# Moves history file to ~/.cache
HISTFILE=~/.cache/zsh.history

# Edit command in vim
autoload edit-command-line
zle -N edit-command-line
bindkey '^x' edit-command-line

# Disables automatic paging
unset PAGER

# Sets nvim as default editor
export EDITOR="nvim"

# Loads my external configuration files.
# Basically, if it's not a variable setting or zsh configuration I move it to an external file.
for file in $ZDOTDIR/config/*.sh; do
	source $file
done

# Loads plugins
source $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh

source $ZDOTDIR/.zsh_functions
