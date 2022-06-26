# A few contractions for commonly used commands
alias cls='clear'
alias md='mkdir'
alias q='exit'

# Enables colors for diff
# Disabled because it breaks on systems without GNU coreutils
# alias ls='ls --color=auto'
# alias grep='grep --color=auto'
# alias diff='diff --color=auto'

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
