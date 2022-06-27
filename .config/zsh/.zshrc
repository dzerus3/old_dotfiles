######################################################
# Generic optoins
######################################################

# Enable colors
autoload -U colors && colors

# Sets max history size
export HISTSIZE=250
export SAVEHIST=250

# Moves history file to ~/.cache
export HISTFILE=~/.cache/zsh.history

# Sets nvim as default editor
export EDITOR="nvim"

# bat configuration options
export BAT_PAGER=""
export BAT_STYLE="plain"

######################################################
# Completion
######################################################

autoload -Uz compinit

# Moves zcompdump to ~/.cache
compinit -d ~/.cache/zcompdump

# Enables menu selection for completion
zstyle ':completion:*:*:*:*:*' menu select

zstyle ':completion:*' group-name ''
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' rehash true
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# Makes it so Ctrl + w stops at each part of a filesystem path
# but does not stop at the - in command line arguments
#local WORDCHARS=$'!"#$%&\'()*+,-.;<=>?[\\]^_`{|}~'
local WORDCHARS=$'*?-.[]~:;!#$%^(){}<>'

# Enables mid-word autocompletion
zstyle ':completion:*' completer _expand _complete
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'

# Sets colors for autocompletion
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

autoload -Uz compinit
zmodload zsh/complist

# Autocompletes hidden files
_comp_options+=(globdots)

#######################################################
# Plugins
######################################################

# If plugin directory exists, load plugins. This is a
# compromise between not having a plugin manager, and
# not having it throw errors when plugins are not
# installed.
#
# This is not the most elegant solution, sure, but I
# prefer this over using a package manager.
if [ -d "$ZDOTDIR/plugins" ]; then
	source $ZDOTDIR/plugins/git-prompt.zsh/git-prompt.plugin.zsh
	source $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
	source $ZDOTDIR/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
fi

######################################################
# Aliases
######################################################

# A few contractions for commonly used commands
alias cls='clear'
alias md='mkdir'
alias q='exit'

# Enables colors for diff if GNU coreutils are installed
ls   --version | grep GNU > /dev/null && alias ls='ls --color=auto'
grep --version | grep GNU > /dev/null && alias grep='grep --color=auto'
diff --version | grep GNU > /dev/null && alias diff='diff --color=auto'

# Easy editing of common files
alias editrc='$EDITOR ~/.config/zsh/.zshrc'
alias editvimrc='$EDITOR ~/.config/nvim/init.vim'

# Dotfile configuration
alias dotfiles='/usr/bin/git --git-dir=$HOME/.local/share/dotfiles --work-tree=$HOME'

# Aliases for yt-dlp
if command -v yt-dlp &> /dev/null; then
	alias yt-music='yt-dlp --extract-audio --audio-format opus --yes-playlist -o "%(track)s__%(artist)s__%(album)s__%(release_year)s.%(ext)s"'
	alias yt-audiobook='yt-dlp --extract-audio --audio-format mp3 --yes-playlist -o "%(title)s.%(ext)s"'
fi

######################################################
# Custom functions
######################################################

# Find files containing string
find-files-with() {
    find . -type f -print | xargs grep $1
}

isitup() {
	# I'm not sure why the lookaround is included in the results, but hey, it works.
    curl -s "https://isitup.org/$1" | grep -P "(?<=<title>).*(?=<\/title>)" | cut -c 8- | rev | cut -c 9- | rev
}

rawurlencode() {
  local string="${@}"
  local strlen=${#string}
  local encoded=""
  local pos c o

  for (( pos=0 ; pos<strlen ; pos++ )); do
     c=${string:$pos:1}
     case "$c" in
        [-_.~a-zA-Z0-9] ) o="${c}" ;;
        * )               printf -v o '%%%02x' "'$c"
     esac
     encoded+="${o}"
  done
  echo "${encoded}"
}

######################################################
# Keybindings
######################################################

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

# Ctrl + e/i moves to beginning/end of line
# Mapping Ctrl + i seems also to rebind tab...
#
# Disabling because breaks autocompletion, and I
# didn't find a way to fix it with alacritty
#bindkey '^e' beginning-of-line
#bindkey '^i' end-of-line

# Use Alt + e/i to move through history
bindkey '^[e' down-history
bindkey '^[i' up-history

######################################################
# less configuration
######################################################

# Sets less keybindings file.
export LESSKEYIN="/home/sal/.config/lesskey"

# Disables less history
export LESSHISTFILE=-

# Enable less color support
export LESS=" --RAW-CONTROL-CHARS --squeeze-blank-lines "

export MANPAGER="less +Gg"

# Disabled because it doesn't work on my setup
#export LESS_TERMCAP_mb=$'\E[1;31m'     # begin blink
#export LESS_TERMCAP_md=$'\E[1;36m'     # begin bold
#export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
#export LESS_TERMCAP_so=$'\E[01;33m'    # begin reverse video
#export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
#export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
#export LESS_TERMCAP_ue=$'\E[0m'        # reset underline
#export LESS_TERMCAP_mr=$(tput rev)
#export LESS_TERMCAP_mh=$(tput dim)
#export LESS_TERMCAP_ZN=$(tput ssubm)
#export LESS_TERMCAP_ZV=$(tput rsubm)
#export LESS_TERMCAP_ZO=$(tput ssupm)
#export LESS_TERMCAP_ZW=$(tput rsupm)

# Enable syntax highlighting for less
if [ -f "/usr/bin/src-hilite-lesspipe.sh" ]; then
	export LESSOPEN="| /usr/bin/src-hilite-lesspipe.sh %s"
fi

#######################################################
# Command replacements
#######################################################

# Replaces sudo with doas when possible
if command -v doas &> /dev/null; then
	alias please='doas'
	alias sudo='doas'
fi

# Replaces ls with exa when possible
if command -v exa &> /dev/null; then
	alias ls='exa'
fi

# Replaces grep with ripgrep when possible
if command -v rg &> /dev/null; then
	alias grep='rg'
fi

# Replace vim with nvim when possible
if command -v nvim &> /dev/null; then
	alias nv='nvim'
	alias vi='nvim'
	alias vim='nvim'
fi

# Replaces cat with bat
if command -v bat &> /dev/null; then
	alias cat='bat --style=plain --pager=""'
fi

# Replaces traceroute with mtr
if command -v mtr &> /dev/null; then
	alias traceroute='mtr'
fi

# Replaces netstat with ss
if command -v ss &> /dev/null; then
	alias netstat='ss'
fi

# Replaces ifconfig with ip
# Also enables colors for ip
if command -v ip &> /dev/null; then
	alias ip='ip --color=auto'
	alias ifconfig='ip'
fi

######################################################
# Prompt
######################################################

# Don't throw an error if git-prompt plugin is not
# installed
if typeset -f gitprompt > /dev/null; then
	function gitprompt{}
fi

# Note: reference at https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html
ZSH_THEME_GIT_PROMPT_PREFIX=":"
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg_bold[white]%}"
ZSH_THEME_GIT_PROMPT_SEPARATOR=" "

if [ $UID -eq 0 ]; then
	PROMPT='%B%{$fg[red]%}[%{$fg[magenta]%}%B%1~%b%{$reset_color%}$(gitprompt)%{$fg[red]%}]%{$reset_color%} '
else
	PROMPT='%B%{$fg[blue]%}[%{$fg[green]%}%B%1~%b%{$reset_color%}$(gitprompt)%{$fg[blue]%}]%{$reset_color%} '
fi

######################################################
# Fortune
######################################################

# My signature fortune | lolcat setup. Tries to run
# without breaking anything if neither is installed.
if command -v fortune &> /dev/null; then
	if command -v lolcat &> /dev/null; then
		fortune | lolcat
	else
		fortune
	fi
fi

######################################################
# tmux config
######################################################

# Opens in tmux, provided tmux is installed and is not
# already launched.
# https://unix.stackexchange.com/questions/43601/how-can-i-set-my-default-shell-to-start-up-tmux
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
	exec tmux
fi
