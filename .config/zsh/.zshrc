################################################################
# Generic optoins
#
# DOCUMENTATION:
#   man zshall, from line 5812 /WORDCHARS
#   $ZDOTDIR/plugins/zsh-autosuggestions/README.md
################################################################

# Enable colors
autoload -U colors && colors

# Sets XDG folder environments if they are not set already. They
# should probably be set in /etc/zsh/zshenv or in ~/.zshenv.
# https://unix.stackexchange.com/questions/71253/what-should-shouldnt-go-in-zshenv-zshrc-zlogin-zprofile-zlogout
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

# Sets nvim as default editor
export EDITOR='nvim'

# Sets vimrc location to be XDG-compliant
export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC'

# bat configuration options
export BAT_PAGER=
export BAT_STYLE='plain'

# Excludes some characters from being counted as parts of words
# so that Ctrl + w works better
#local WORDCHARS=$'!"#$%&\'()*+,-.;<=>?[\\]^_`{|}~'
local WORDCHARS=$'*?-.[]~:;!#$%^(){}<>'

# Sets zsh autocomplete plugins to suggest items based on all
# completion strategies
ZSH_AUTOSUGGEST_STRATEGY=(history completion match_prev_cmd)

# Moves ZSHZ data to data directory
ZSHZ_DATA="$XDG_DATA_HOME/z.db"

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

if [ -d $ZDOTDIR/plugins ]; then
	# Respectfully stolen from
	# https://github.com/mattmc3/zsh_unplugged
	function plugin-load {
		local repo plugin_name plugin_dir initfile initfiles
		ZPLUGINDIR=${ZPLUGINDIR:-${ZDOTDIR:-$HOME/.config/zsh}/plugins}
		for repo in $@; do
			plugin_name=${repo:t}
			plugin_dir=$ZPLUGINDIR/$plugin_name
			initfile=$plugin_dir/$plugin_name.plugin.zsh
			if [[ ! -d $plugin_dir ]]; then
				echo "Cloning $repo"
				git clone -q --depth 1 --recursive --shallow-submodules https://github.com/$repo $plugin_dir
			fi
			if [[ ! -e $initfile ]]; then
				initfiles=($plugin_dir/*.plugin.{z,}sh(N) $plugin_dir/*.{z,}sh{-theme,}(N))
				[[ ${#initfiles[@]} -gt 0 ]] || { echo >&2 "Plugin has no init file '$repo'." && continue }
				ln -sf "${initfiles[1]}" "$initfile"
			fi
			fpath+=$plugin_dir
			(( $+functions[zsh-defer] )) && zsh-defer . $initfile || . $initfile
		done
	}

	function plugin-update {
		ZPLUGINDIR=${ZPLUGINDIR:-$HOME/.config/zsh/plugins}
		for d in $ZPLUGINDIR/*/.git(/); do
			echo "Updating ${d:h:t}..."
			command git -C "${d:h}" pull --ff --recurse-submodules --depth 1 --rebase --autostash
		done
	}

	function plugin-compile {
		ZPLUGINDIR=${ZPLUGINDIR:-$HOME/.config/zsh/plugins}
		autoload -U zrecompile
		local f
		for f in $ZPLUGINDIR/**/*.zsh{,-theme}(N); do
			zrecompile -pq "$f"
		done
	}

	plugin-load woefe/git-prompt.zsh
	plugin-load zsh-users/zsh-autosuggestions
	plugin-load agkozak/zsh-z
	plugin-load zdharma-continuum/fast-syntax-highlighting
fi

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
    curl -s "https://isitup.org/$1" | grep -P '(?<=<title>).*(?=<\/title>)' | cut -c 8- | rev | cut -c 9- | rev
}

getpublicip() {
	curl https://ifconfig.me/; echo
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
export LESSKEYIN='/home/sal/.config/lesskey'

# Disables less history
export LESSHISTFILE=-

# Enable less color support
export LESS=' --RAW-CONTROL-CHARS --squeeze-blank-lines '

# Enables progress report in less
export MANPAGER='less +Gg'

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
if [ -f '/usr/bin/src-hilite-lesspipe.sh' ]; then
	export LESSOPEN='| /usr/bin/src-hilite-lesspipe.sh %s'
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
alias ip='ip --color=auto'

alias nv='nvim'

alias exa='exa --classify --group --git --group-directories-first'
alias e='exa'

# List files by creation date
alias eC='exa --long --sort=created'

# List files by modified date
alias eM='exa --long --sort=modified'

# List files by size
alias eS='exa --all --long --classify --reverse --color-scale --group-directories-first --color=always --no-permissions --no-time --sort=size | grep -v /'

# List only files, and sort them by extension
alias eX='exa --long --icons --classify --color=always --no-user --no-permissions --sort=extension | grep -v /'

# exa can also replace the tree command, but the performance
# is noticeably worse and tree seems to support colors anyway.
#alias tree="exa --tree"

alias bat='bat -pp'

# Easy editing of common files
alias editrc="$EDITOR ~/.config/zsh/.zshrc"
alias editvimrc="$EDITOR ~/.config/nvim/init.vim"

# Dotfile configuration
alias dotfiles="/usr/bin/git --git-dir=$HOME/.local/share/dotfiles --work-tree=$HOME"

# Aliases for yt-dlp
alias yt-music='yt-dlp --extract-audio --audio-format opus --yes-playlist -o "%(track)s__%(artist)s__%(album)s__%(release_year)s.%(ext)s"'
alias yt-audiobook='yt-dlp --extract-audio --audio-format mp3 --yes-playlist -o "%(title)s.%(ext)s"'

# TODO See also
# https://www.freecodecamp.org/news/tmux-in-practice-integration-with-system-clipboard-bcd72c62ff7b/
# https://unix.stackexchange.com/questions/211817/copy-the-contents-of-a-file-into-the-clipboard-without-displaying-its-contents/211826#211826
# https://github.com/zshzoo/copier/blob/main/copier.zsh
if command -v wl-copy &> /dev/null; then
	alias copy='wl-copy'
elif command -v xcopy &> /dev/null; then
	alias copy='xcopy'
fi

#################################################################
# Command replacements
#################################################################

if typeset -f zshz > /dev/null; then
	# alias cd='zshz 2>&1'
	alias cd='echo "You should use z instead of cd."'
fi

if command -v doas &> /dev/null; then
	alias sudo='echo "You should use doas instead of sudo."'
fi

if command -v exa &> /dev/null; then
	alias ls='echo "You should use exa instead of ls."'
fi

if command -v rg &> /dev/null; then
	alias grep='echo "You should use rg instead of grep."'
fi

if command -v ss &> /dev/null; then
	alias netstat='echo "You should use ss instead of netstat."'
fi

if command -v ip &> /dev/null; then
	alias ifconfig='echo "You should use ip instead of ifconfig."'
fi

if command -v dig &> /dev/null; then
	alias nslookup='echo "You should use dig instead of nslookup."'
fi

if command -v fd &> /dev/null; then
	alias find='echo "You should use fd instead of find."'
fi

# Disabled because cat is still used for scripting.
#if command -v bat &> /dev/null; then
#	alias cat='echo "You should use bat instead of cat."'
#fi

# Enables grc support if it is installed. Taken from grc's zsh
# plugin at https://github.com/garabik/grc/blob/master/grc.zsh
if command -v grc &> /dev/null; then
	grc_commands=(
		blkid df dig du env fdisk findmnt free getfacl id
		iptables iwconfig last lsblk lsmod lsof mount ping
		ps sensors ss stat traceroute vmstat whois fdisk
	)
	# Set alias for available commands.
	for cmd in $grc_commands ; do
		if (( $+commands[$cmd] )) ; then
			$cmd() {
			grc --colour=auto ${commands[$0]} "$@"
		}
		fi
	done

	# Clean up variables
	unset cmds cmd
fi

################################################################
# Prompt
# DOCUMENTATION:
#   $ZDOTDIR/plugins/git-prompt.zsh/examples/default.zsh
#   man zshall, from line 2061 /EXPANSION OF PROMPT
################################################################

# Don't throw an error if git-prompt plugin is not installed
# FIXME: I don't think it actually works correctly
if typeset -f gitprompt > /dev/null; then
	function gitprompt{}
fi

# Prompt variable reference in
ZSH_THEME_GIT_PROMPT_PREFIX=':'
ZSH_THEME_GIT_PROMPT_SUFFIX=
ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg_bold[white]%}"
ZSH_THEME_GIT_PROMPT_SEPARATOR=' '

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
