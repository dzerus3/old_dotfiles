# A few common abbreviations
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

# TODO: These break when given a path. Remake info functions?
# List files by size
alias eS='exa --all --long --classify --reverse --color-scale --group-directories-first --color=always --no-permissions --no-time --sort=size | grep -v /'

# List only files, and sort them by extension
alias eX='exa --long --icons --classify --color=always --no-user --no-permissions --sort=extension | grep -v /'

# exa can also replace the tree command, but the performance
# is noticeably worse and tree seems to support colors anyway.
#alias tree="exa --tree"

# Disabled because the same can be achieved with env variables.
#alias bat='bat -pp'

# Easy editing of common files
alias editrc="$EDITOR ~/.config/zsh/.zshrc"
alias editvimrc="$EDITOR ~/.config/nvim/init.lua"

# Dotfile configuration
alias dotfiles="git --git-dir=$HOME/.local/share/dotfiles --work-tree=$HOME"

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

# https://www.reddit.com/r/commandline/comments/p5ibiz/i_keep_forgetting_how_to_extract_tar_or_7z/
extract () {
	if [ -f $1 ] ; then
		case $1 in
			*.tbz2 | *.tar.bz2) tar -xvjf ;;
			*.txz | *.tar.xz)   tar -xvJf ;;
			*.tgz | *.tar.gz)   tar -xvzf ;;
			*.tar | *.cbt)      tar -xvf  ;;
			*.tar.zst)          tar -xvf  ;;
			*.zip | *.cbz)      unzip     ;;
			*.rar | *.cbr)      unrar x   ;;
			*.arj)              unarj x   ;;
			*.ace)              unace x   ;;
			*.bz2)              bunzip2   ;;
			*.xz)               unxz      ;;
			*.gz)               gunzip    ;;
			*.7z)               7za x     ;;
			*.Z)                uncompress;;
			*) echo "Error: failed to extract '$1'" ;;
		esac
	fi
}
