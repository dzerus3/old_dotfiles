################################################################
# Generic optoins
#
# DOCUMENTATION:
#   man zshall, from line 5812 /WORDCHARS
################################################################

# Enable colors
autoload -U colors && colors

# Sets nvim as default editor
export EDITOR="nvim"

# bat configuration options
export BAT_PAGER=""
export BAT_STYLE="plain"

#local WORDCHARS=$'!"#$%&\'()*+,-.;<=>?[\\]^_`{|}~'
local WORDCHARS=$'*?-.[]~:;!#$%^(){}<>'

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

# Moves history file to ~/.cache
export HISTFILE=~/.cache/zsh.history

# Sets max history file size
export HISTSIZE=1000
# Sets max number of history entries to keep in memory
export SAVEHIST=1000

# Treat '!' specially for expansion.
setopt bang_hist
# Don't record the same command run repeatedly.
setopt hist_ignore_dups
# Don't write entries that start with a space
setopt hist_ignore_space
# Hide superfluous blanks before entry.
setopt hist_reduce_blanks
# Do not store the usage of the history command in history
setopt hist_no_store
# Share history between every shell session.
setopt share_history

################################################################
# Completion
################################################################

# Enables menu selection for completion
autoload -Uz compinit
zmodload zsh/complist
zstyle ':completion:*:*:*:*:*' menu select

# Moves zcompdump to ~/.cache
compinit -d ~/.cache/zcompdump

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

# If plugin directory exists, load plugins. This is a compromise
# between not having a plugin manager, and not having it throw
# errors when plugins are not installed.
if [ -d "$ZDOTDIR/plugins" ]; then
	source $ZDOTDIR/plugins/git-prompt.zsh/git-prompt.plugin.zsh
	source $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
	source $ZDOTDIR/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
fi

################################################################
# Aliases
################################################################

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
alias yt-music='yt-dlp --extract-audio --audio-format opus --yes-playlist -o "%(track)s__%(artist)s__%(album)s__%(release_year)s.%(ext)s"'
alias yt-audiobook='yt-dlp --extract-audio --audio-format mp3 --yes-playlist -o "%(title)s.%(ext)s"'

################################################################
# Custom functions
################################################################

# Find files containing string
find-files-with() {
    find . -type f -print | xargs grep $1
}

isitup() {
	# I'm not sure why the lookaround is included in the results,
	# but hey, it works.
    curl -s "https://isitup.org/$1" | grep -P "(?<=<title>).*(?=<\/title>)" | cut -c 8- | rev | cut -c 9- | rev
}

getpublicip() {
	curl https://ifconfig.me/; echo
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

# Ctrl + e/i moves to beginning/end of line
# Mapping Ctrl + i seems also to rebind tab...
#
# Disabling because breaks autocompletion, and I didn't find a
# way to fix it with alacritty
#bindkey '^e' beginning-of-line
#bindkey '^i' end-of-line

# Use Alt + e/i to move through history
bindkey '^[e' down-history
bindkey '^[i' up-history

################################################################
# less configuration
################################################################

# Sets less keybindings file.
export LESSKEYIN="/home/sal/.config/lesskey"

# Disables less history
export LESSHISTFILE=-

# Enable less color support
export LESS=" --RAW-CONTROL-CHARS --squeeze-blank-lines "

# Enables progress report in less
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

#################################################################
# Command replacements
#################################################################

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

# Replaces ifconfig with ip and enables colors for ip
if command -v ip &> /dev/null; then
	alias ip='ip --color=auto'
	alias ifconfig='ip'
fi

# Replaces nslookup with dig
if command -v dig &> /dev/null; then
	alias nslookup='dig'
fi

################################################################
# Prompt
# DOCUMENTATION:
#   $ZDOTDIR/plugins/git-prompt.zsh/examples/default.zsh
#   man zshall, from line 2061 /EXPANSION OF PROMPT
################################################################

# Don't throw an error if git-prompt plugin is not installed
if typeset -f gitprompt > /dev/null; then
	function gitprompt{}
fi

# Prompt variable reference in
ZSH_THEME_GIT_PROMPT_PREFIX=":"
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg_bold[white]%}"
ZSH_THEME_GIT_PROMPT_SEPARATOR=" "

# Sets a red and magenta prompt if root, and blue/green
# otherwise.
if [ $UID -eq 0 ]; then
	PROMPT='%B%{$fg[red]%}[%{$fg[magenta]%}%B%1~%b%{$reset_color%}$(gitprompt)%{$fg[red]%}]%{$reset_color%} '
else
	PROMPT='%B%{$fg[blue]%}[%{$fg[green]%}%B%1~%b%{$reset_color%}$(gitprompt)%{$fg[blue]%}]%{$reset_color%} '
fi

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

# Opens in tmux, provided tmux is installed and is not already
# launched.
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
	exec tmux
fi
