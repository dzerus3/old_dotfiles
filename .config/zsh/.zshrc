################################################################
# Keybindings
#
# DOCUMENTATION:
#   man zshzle /STANDARD WIDGETS
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

#################################################################
# grc
#
# Enables grc support if it is installed.
#################################################################

source $ZDOTDIR/modules/grc.zsh

################################################################
# Abbreviations
#
# NOTE: Should be sourced *after* keybinding definitions.
# Specifically, bindkey -e breaks it.
################################################################

source $ZDOTDIR/modules/abbreviations.zsh

################################################################
# General options
#
# DOCUMENTATION:
#   man zshparam /WORDCHARS
################################################################

# Sets default editor
if command -v nvim &> /dev/null; then
    export EDITOR='nvim'
    abbrev editvimrc="$EDITOR $HOME/.config/nvim/init.lua"
elif command -v vim &> /dev/null; then
    export EDITOR='vim'
    abbrev editvimrc="$EDITOR $HOME/.vimrc"
elif command -v nano &> /dev/null; then
    export EDITOR='nano'
fi

# Enable colors
autoload -U colors && colors

# bat configuration
export BAT_PAGER=
export BAT_STYLE='plain'

# delta configuration
export DELTA_PAGER='less -R'

# pass configuration
export PASSWORD_STORE_DIR=$XDG_DATA_HOME/pass
export GNUPGHOME="$XDG_CONFIG_HOME"/gnupg

# most configuration
export MOST_INITFILE=~/.config/mostkey

# Allows executing commands from .local/bin
export PATH=$HOME/.local/bin:$PATH

# Cargo automatically installs to .local/bin
export CARGO_INSTALL_ROOT=$HOME/.local

# Includes some characters as parts of words for Ctrl + w
local WORDCHARS=-$'*?.[]~;!#$%^(){}<>'

if command -v zoxide &> /dev/null; then
    # Initializes zoxide
    eval "$(zoxide init --cmd cd zsh)"
    # Excludes files from zoxide completion
    export _ZO_EXCLUDE_DIRS=$HOME:$XDG_CACHE_HOME/*:$ZDOTDIR/plugins/*
    export _ZO_DATA_DIR=$XDG_STATE_HOME
fi

################################################################
# History options
#
# DOCUMENTATION:
#   man zshbuiltins /history /fc
#   man zshparam /HISTFILE
#   man zshoptions /APPEND_HISTORY
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
#
# See man zshcompsys
################################################################

autoload -Uz compinit
zmodload zsh/complist

# Moves zcompdump to cache directory
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump"

# Sets types of completion to use
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate

# Enables menu selection for completion
zstyle ':completion:*' menu select

# Disables using deprecated compctl
zstyle ':completion:*' use-compctl false

# Enables completion caching for faster startup
zstyle ':completion:*' use-cache true
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/zcompcache"

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
# Plugins
################################################################

# If you don't want plugins, don't create $ZDOTDIR/plugins
if [ -d $ZDOTDIR/plugins ]; then
    source $ZDOTDIR/modules/plugins.zsh

    # A portable alternative to zoxide
    #plugin-load skywind3000/z.lua

    # Allows displaying git status as part of prompt
    plugin-load woefe/git-prompt.zsh
    # Makes history searching more intelligent
    plugin-load zsh-users/zsh-history-substring-search
    # Enables syntax highlighting in the shell
    plugin-load zdharma-continuum/fast-syntax-highlighting

    # Rebinds up/down to use substring search
    bindkey '^[[A' history-substring-search-up
    bindkey '^[[B' history-substring-search-down
fi

################################################################
# Custom functions
################################################################

# Enables colors if GNU coreutils are installed
ls   --version | grep GNU > /dev/null && alias ls='ls --color=auto'
grep --version | grep GNU > /dev/null && alias grep='grep --color=auto'
diff --version | grep GNU > /dev/null && alias diff='diff --color=auto'
alias ip='ip --color=auto'

abbrev cls='clear'
abbrev md='mkdir'

abbrev l='ls'
abbrev ll='ls -l'
abbrev la='ls -a'
abbrev lal='ls -al'
abbrev lla='ls -la'
abbrev lld='ls -ld'
abbrev ldl='ls -dl'

if command -v nvim &> /dev/null; then
    abbrev nv='nvim'
fi

# Dotfile configuration
alias dotfiles="git --git-dir=$HOME/.local/share/dotfiles --work-tree=$HOME"
alias datafiles="git --git-dir=$HOME/.local/share/datafiles --work-tree=$HOME"
abbrev dot='dotfiles'
abbrev data='datafiles'

# Easy editing of common files
abbrev editrc="$EDITOR $HOME/.config/zsh/.zshrc"

if command -v task &> /dev/null; then
    abbrev t='task'
    abbrev ta='task add'
    abbrev td='task done'
    abbrev tmodlast='task modify $(task +LATEST uuids)'
    abbrev tdep='task add dep:$(task +LATEST uuids)'
fi

if command -v buku &> /dev/null; then
    abbrev b='buku'
    abbrev ba='buku --add'
    abbrev buku-backup='buku -e ~/.local/share/buku/bookmarks.md'
fi

if command -v yt-dlp &> /dev/null; then
    abbrev yt-music='yt-dlp --extract-audio --audio-format opus --yes-playlist -o "%(track)s__%(artist)s__%(album)s__%(release_year)s.%(ext)s"'
    abbrev yt-audiobook='yt-dlp --extract-audio --audio-format mp3 --yes-playlist -o "%(title)s.%(ext)s"'
fi

alias wget="wget --hsts-file $XDG_CACHE_HOME/wget-hsts"

open(){
    nohup xdg-open $1 > /dev/null &
}

isitup() {
    # I'm not sure why the lookaround is included in the results,
    # but hey, it works.
    curl -s "https://isitup.org/$1" | grep -P '(?<=<title>).*(?=<\/title>)' | cut -c 8- | rev | cut -c 9- | rev
}

################################################################
# less configuration
################################################################

# Sets less keybindings file.
export LESSKEYIN="$XDG_CONFIG_HOME/lesskey"

# Disables less history
export LESSHISTFILE=-

# Enable less color support
export LESS='-ix8RmPm'
export MANPAGER='less -ix8RmPm'

################################################################
# Prompt
#
# DOCUMENTATION:
#   $ZDOTDIR/plugins/git-prompt.zsh/examples/default.zsh
#   man zshmisc /EXPANSION OF PROMPT
################################################################

# Makes prompt more font-compatible
ZSH_THEME_GIT_PROMPT_PREFIX=':'
ZSH_THEME_GIT_PROMPT_SUFFIX=
ZSH_THEME_GIT_PROMPT_SEPARATOR=
ZSH_THEME_GIT_PROMPT_DETACHED="%{$fg_bold[cyan]%}:"
ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg_bold[white]%}"
ZSH_THEME_GIT_PROMPT_UPSTREAM_NO_TRACKING=" %{$fg_bold[red]%}!"
ZSH_THEME_GIT_PROMPT_UPSTREAM_PREFIX=" %{$fg[red]%}(%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_UPSTREAM_SUFFIX="%{$fg[red]%})"
ZSH_THEME_GIT_PROMPT_BEHIND=" ↓"
ZSH_THEME_GIT_PROMPT_AHEAD=" ↑"
ZSH_THEME_GIT_PROMPT_UNMERGED=" %{$fg[red]%}x"
ZSH_THEME_GIT_PROMPT_STAGED=" %{$fg[green]%}o"
ZSH_THEME_GIT_PROMPT_UNSTAGED=" %{$fg[red]%}+"
ZSH_THEME_GIT_PROMPT_UNTRACKED=" ."
ZSH_THEME_GIT_PROMPT_STASHED=" %{$fg[blue]%}s"
ZSH_THEME_GIT_PROMPT_CLEAN=

# Resets any existing prompt
PROMPT=""

# If we're connected to ssh, displays hostname
if ((${#SSH_CLIENT[@]})); then
    PROMPT=$PROMPT"($(hostname)) "
fi

# Sets a red and magenta prompt if root, and blue/green otherwise.
if [ $UID -eq 0 ]; then
    PROMPT=$PROMPT"%B%{$fg[red]%}[%{$fg[magenta]%}%B%1~%b%{$reset_color%}"
else
    PROMPT=$PROMPT"%B%{$fg[blue]%}[%{$fg[green]%}%B%1~%b%{$reset_color%}"
fi

# If gitprompt addon is installed, uses it
if typeset -f gitprompt > /dev/null; then
    PROMPT=$PROMPT'$(gitprompt)'
fi

# Sets a red and magenta prompt if root, and blue/green otherwise.
if [ $UID -eq 0 ]; then
    PROMPT=$PROMPT"%{$fg[red]%}]%{$reset_color%} "
else
    PROMPT=$PROMPT"%{$fg[blue]%}]%{$reset_color%} "
fi

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
