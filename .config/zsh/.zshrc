################################################################
# Generic options
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
# See man zshcompsys
################################################################

autoload -Uz compinit
zmodload zsh/complist

# Moves zcompdump to cache directory
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump"

# Sets types of completion to use
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate

# Enables menu selection for completion if at least 4 matches
zstyle ':completion:*' menu select

# Disables using deprecated compctl
zstyle ':completion:*' use-compctl false

# Sets colors for autocompletion options
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Sets autocompletion options for kill command
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# Adds more descriptiveness to completion output
zstyle ':completion:*' verbose true

# Show dotfiles in completion
zstyle ':completion:*' file-patterns '%p(D):globbed-files *(D-/):directories' '*(D):all-files'

# These were generated by compinstall, and I'm not certain what
# they do.
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} r:|[._-]=** r:|=**' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' glob 1
zstyle ':completion:*' squeeze-slashes true
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

# Alt + o/n moves one character forward/back
bindkey '^[o' forward-char
bindkey '^[n' backward-char

# Alt + O/N moves forward/backward by one word
bindkey '^[O' forward-word
bindkey '^[N' backward-word

# Ctrl + n/o moves to beginning/end of line
bindkey '^n' beginning-of-line
bindkey '^o' end-of-line

# Use Alt + e/i to move through history
bindkey '^[e' history-substring-search-down
bindkey '^[i' history-substring-search-up

################################################################
# Plugins
################################################################

# If you want plugins to be installed mkdir $ZDOTDIR/plugins
if [ -d $ZDOTDIR/plugins ]; then
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
export LESS=' --RAW-CONTROL-CHARS --squeeze-blank-lines '

################################################################
# Prompt
# DOCUMENTATION:
#   $ZDOTDIR/plugins/git-prompt.zsh/examples/default.zsh
#   man zshall, from line 2061 /EXPANSION OF PROMPT
################################################################

# Sets cursor shape to be a beam, matching nvim
# Already set in kitty config
#_fix_cursor() {
#   echo -ne '\e[5 q'
#}
#precmd_functions+=(_fix_cursor)

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
