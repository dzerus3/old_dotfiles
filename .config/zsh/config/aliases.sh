# A few contractions for commonly used commands
alias cls='clear'
alias md='mkdir'
alias q='exit'

# sudo aliases
alias please='doas'
alias sudo='doas'

# Dotfile configuration
alias dotfiles='/usr/bin/git --git-dir=$HOME/.local/share/dotfiles --work-tree=$HOME'

# Disables colors for grep and ls
# This is because I only use ls and grep with scripts, and use exa and rg otherwise
if command -v exa &> /dev/null; then
	alias ls='ls --color=none'
fi

if command -v rg &> /dev/null; then
	alias grep='grep --color=none'
	alias fgrep='grep -F --color=none'
	alias egrep='grep -E --color=none'
fi

# Enables colors for diff and ip
alias diff='diff --color=auto'
alias ip='ip --color=auto'

# Use nvim whenever possible. I also use a symlink.
if command -v nvim &> /dev/null; then
	alias nv='nvim'
	alias vi='nvim'
	alias vim='nvim'
fi

# Uncomment if you would like to silently replace cat with bat
#alias cat='bat --style=plain --pager=""'

# Easy editing of common files
alias editrc='nvim ~/.config/zsh/.zshrc'
alias editvimrc='nvim ~/.config/nvim/init.vim'

# Aliases for yt-dlp
alias yt-music='yt-dlp --extract-audio --audio-format opus --yes-playlist -o "%(track)s__%(artist)s__%(album)s__%(release_year)s.%(ext)s"'
alias yt-audiobook='yt-dlp --extract-audio --audio-format mp3 --yes-playlist -o "%(title)s.%(ext)s"'
