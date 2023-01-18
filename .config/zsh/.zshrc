################################################################
# Generic options
#
# DOCUMENTATION:
#   man zshall, from line 5812 /WORDCHARS
#   $ZDOTDIR/plugins/zsh-autosuggestions/README.md
################################################################

# Sets nvim as pager
if command -v nvim &> /dev/null; then
    # Sets nvim as default editor
    export EDITOR='nvim'
	export MANPAGER='nvim +Man!'
else
    export EDITOR='vim'
	export MANPAGER='less +Gg'
fi

# Enable colors
autoload -U colors && colors

# bat configuration
export BAT_PAGER=
export BAT_STYLE='plain'

# pass configuration
export PASSWORD_STORE_DIR=$XDG_DATA_HOME/pass
export GNUPGHOME="$XDG_CONFIG_HOME"/gnupg

# Allows executing commands from ~/.local/bin
export PATH=$HOME/.local/bin:$PATH

# Cargo automatically installs to ~/.local/bin
export CARGO_INSTALL_ROOT=$HOME/.local

# Includes some characters as parts of words for Ctrl + w
local WORDCHARS=-@$'*?.[]~;!#$%^(){}<>'

# Initializes zoxide
eval "$(zoxide init zsh)"
# Excludes files from zoxide completion
export _ZO_EXCLUDE_DIRS=$HOME:$XDG_CACHE_HOME/*:$ZDOTDIR/plugins/*

################################################################
# History options
#
# DOCUMENTATION:
#   man zshbuiltins, /history /fc
#   man zshall, from line 5375 /HISTFILE
#   man zshall, from line 6312 /APPEND_HISTORY
################################################################

# Sets history to output the last 30 entries
alias history='history -30'

# Uncomment this if you want history to have the same
# default behavior as in bash
#alias history='history 1'

# Moves history file to state directory
export HISTFILE="$XDG_STATE_HOME/zsh.history"

# Sets max history file size
export HISTSIZE=1000000
# Sets max number of history entries to keep in memory
export SAVEHIST=$HISTSIZE

# Treat '!' specially for expansion.
setopt bang_hist
# Store command execution time in history
setopt extended_history
# Don't record the same command run repeatedly.
setopt hist_ignore_dups
# Don't write entries that start with a space
setopt hist_ignore_space
# Hide superfluous blanks before entry.
setopt hist_reduce_blanks
# Do not store the usage of the history command in history
setopt hist_no_store
# Append to history file rather than rewriting it
setopt inc_append_history_time

################################################################
# Completion
# See man zshcompsys
################################################################

autoload -Uz compinit
zmodload zsh/complist

# Moves zcompdump to cache directory
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump"
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/zcompcache"

# Sets types of completion to use
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate

# Enables menu selection for completion
zstyle ':completion:*' menu select

# Disables using deprecated compctl
zstyle ':completion:*' use-compctl false

# Enables completion caching for faster startup
zstyle ':completion:*' use-cache true

# Sets colors for autocompletion options
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Autocompletion options for specific commands
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
zstyle ':completion:*:*:cp:*' file-sort modification
zstyle ':completion:*:*:chown:*' file-list all
zstyle ':completion:*:*:chmod:*' file-list all
# Taken from oh-my-zsh taskwarrior plugin
zstyle ':completion:*:*:task:*' verbose yes
zstyle ':completion:*:*:task:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:*:task:*' group-name ''

# Adds more descriptiveness to completion output
zstyle ':completion:*' verbose true

# Show dotfiles in completion
zstyle ':completion:*' file-patterns '%p(D):globbed-files *(D-/):directories' '*(D):all-files'

# These were generated by compinstall; not certain what they do.
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' glob 1
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' rehash true
zstyle ':completion:*' ignore-parents parent pwd
zstyle ':completion:*' list-suffixes true

################################################################
# Keybindings
# DOCUMENTATION:
#   man zshall, from line 10536 /STANDARD WIDGETS
################################################################

# Enables emacs keybindings
bindkey -e

# Gives tab selection vim navigation
bindkey -M menuselect 'n' vi-backward-char
bindkey -M menuselect 'e' vi-down-line-or-history
bindkey -M menuselect 'i' vi-up-line-or-history
bindkey -M menuselect 'o' vi-forward-char

# Edit command in vim with Ctrl + x
autoload edit-command-line
zle -N edit-command-line
bindkey '^x' edit-command-line

################################################################
# Plugins
################################################################

# If you want plugins to be installed mkdir $ZDOTDIR/plugins
if [ -d $ZDOTDIR/plugins ]; then
	# TODO: Find better way to organize this
	# Rebinds up/down to use substring search
	bindkey '^[[A' history-substring-search-up
	bindkey '^[[B' history-substring-search-down

	source $ZDOTDIR/modules/plugins.zsh

	plugin-load woefe/git-prompt.zsh
	plugin-load zsh-users/zsh-history-substring-search
	plugin-load zdharma-continuum/fast-syntax-highlighting
fi

################################################################
# Abbreviations
################################################################

source $ZDOTDIR/modules/abbreviations.zsh

################################################################
# Custom functions
################################################################

source $ZDOTDIR/modules/custom.zsh

#################################################################
# Command replacements
#################################################################

source $ZDOTDIR/modules/replacements.zsh

################################################################
# less configuration
################################################################

# Sets less keybindings file.
export LESSKEYIN="$XDG_CONFIG_HOME/lesskey"

# Disables less history
export LESSHISTFILE=-

# Enable less color support
#export LESS=' --RAW-CONTROL-CHARS --squeeze-blank-lines '

################################################################
# Prompt
# DOCUMENTATION:
#   $ZDOTDIR/plugins/git-prompt.zsh/examples/default.zsh
#   man zshall, from line 2061 /EXPANSION OF PROMPT
################################################################

source $ZDOTDIR/modules/prompt.zsh

################################################################
# Fortune
################################################################

# My signature fortune | lolcat setup.
if command -v fortune &> /dev/null; then
	if command -v lolcat &> /dev/null; then
		fortune | lolcat
	else
		fortune
	fi
fi
