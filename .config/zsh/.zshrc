################################################################
# Generic optoins
#
# DOCUMENTATION:
#   man zshall, from line 5812 /WORDCHARS
#   $ZDOTDIR/plugins/zsh-autosuggestions/README.md
################################################################

# Enable colors
autoload -U colors && colors

# bat configuration
export BAT_PAGER=
export BAT_STYLE='plain'

# nnn configuration
# https://www.ditig.com/256-colors-cheat-sheet
BLK="E4" CHR="E4" DIR="04" EXE="02" REG="00" HARDLINK="00" SYMLINK="06" MISSING="00" ORPHAN="09" FIFO="F5" SOCK="F5" OTHER="01"
export NNN_FCOLORS="$BLK$CHR$DIR$EXE$REG$HARDLINK$SYMLINK$MISSING$ORPHAN$FIFO$SOCK$OTHER"
export NNN_COLORS='#07a0221b'
export NNN_ARCHIVE="\\.(7z|bz2|gz|tar|tgz|zip|rar)$"
export NNN_FIFO=/tmp/nnn.fifo

# Excludes some characters from being counted as parts of words
# so that Ctrl + w works better
local WORDCHARS=$'*?-.[]~:;!#$%^(){}<>'

# Sets zsh autocomplete plugins to suggest items based on all
# completion strategies
ZSH_AUTOSUGGEST_STRATEGY=(history completion match_prev_cmd)

# Initializes zoxide
eval "$(zoxide init zsh)"

# Excludes .cache and ~ from zoxide completion
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
################################################################

# Enables menu selection for completion
autoload -Uz compinit
zmodload zsh/complist
zstyle ':completion:*:*:*:*:*' menu select

# Moves zcompdump to cache directory
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump"

# These were pulled from Kali's default zshrc.
# TODO: Investigate what exactly these do
zstyle ':completion:*' group-name ''
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' rehash true
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

# Enables mid-word autocompletion
zstyle ':completion:*' completer _expand _complete
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'

# Sets colors for autocompletion
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Sets autocompletion options for kill command
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# Autocompletes hidden files
# TODO: Investigate what other options there are
_comp_options+=(globdots)

################################################################
# Plugins
################################################################

# If you want plugins to be installed mkdir $ZDOTDIR/plugins
if [ -d $ZDOTDIR/plugins ]; then
	source $ZDOTDIR/modules/plugins.zsh

	plugin-load woefe/git-prompt.zsh
	plugin-load zsh-users/zsh-autosuggestions
	plugin-load zdharma-continuum/fast-syntax-highlighting
fi

################################################################
# Custom functions
################################################################

source $ZDOTDIR/modules/custom.zsh

#################################################################
# Command replacements
#################################################################

source $ZDOTDIR/modules/replacements.zsh

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
#autoload edit-command-line
#zle -N edit-command-line
#bindkey '^x' edit-command-line

# Ctrl + o/n moves one character forward/back
bindkey '^o' forward-char
bindkey '^n' backward-char

# Alt + o/n moves forward/backward by one word
bindkey '^[o' forward-word
bindkey '^[n' backward-word

#bindkey '^e' beginning-of-line
#bindkey '^i' end-of-line

# Use Alt + e/i to move through history
bindkey '^[e' down-history
bindkey '^[i' up-history

################################################################
# less configuration
################################################################

# Sets less keybindings file.
export LESSKEYIN="$XDG_CONFIG_HOME/lesskey"

# Disables less history
export LESSHISTFILE=-

# Enable less color support
export LESS=' --RAW-CONTROL-CHARS --squeeze-blank-lines '

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

# My signature fortune | lolcat setup. Tries to run without
# breaking anything if neither is installed.
if command -v fortune &> /dev/null; then
	if command -v lolcat &> /dev/null; then
		fortune | lolcat
	else
		fortune
	fi
fi

################################################################
# tmux config
################################################################

# Opens tmux if it is necessary
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
	exec tmux
fi
