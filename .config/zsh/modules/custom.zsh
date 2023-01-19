# A few common abbreviations
abbrev cls='clear'
abbrev md='mkdir'

abbrev nv='nvim'

abbrev e='exa'
abbrev el='exa -l'
abbrev ea='exa -a'
abbrev eal='exa -al'
abbrev ela='exa -la'
abbrev eld='exa -ld'
abbrev edl='exa -dl'

if command -v task &> /dev/null; then
    abbrev tadd='task add'
    abbrev tann='task annotate'
    abbrev tmod='task modify'
    abbrev tall='task all'
    abbrev tsta='task start'
    abbrev tlist='task list'
    abbrev tdone='task done'
    abbrev tmodlast='task modify $(task +LATEST uuids)'
    abbrev tdep='task add dep:$(task +LATEST uuids)'
fi

# Enables colors for diff if GNU coreutils are installed
ls   --version | grep GNU > /dev/null && alias ls='ls --color=auto'
grep --version | grep GNU > /dev/null && alias grep='grep --color=auto'
diff --version | grep GNU > /dev/null && alias diff='diff --color=auto'
alias ip='ip --color=auto'

alias exa='exa --group --git --group-directories-first'

# exa, but exclude directories
ef(){
	exa $@ --classify --color=always | grep -v /
}

# List with permissions only
alias eP='exa --no-time --long --no-filesize'

# List by modified date
alias eM='exa --no-permissions --no-user --no-filesize --long --sort=modified'

# List files by extension
alias eX='ef --icons --sort=extension'

# Easy editing of common files
abbrev editrc="$EDITOR ~/.config/zsh/.zshrc"
abbrev editvimrc="$EDITOR ~/.config/nvim/init.lua"

# Dotfile configuration
abbrev dot='dotfiles'
alias dotfiles="git --git-dir=$HOME/.local/share/dotfiles --work-tree=$HOME"

# Aliases for yt-dlp
alias yt-music='yt-dlp --extract-audio --audio-format opus --yes-playlist -o "%(track)s__%(artist)s__%(album)s__%(release_year)s.%(ext)s"'
alias yt-audiobook='yt-dlp --extract-audio --audio-format mp3 --yes-playlist -o "%(title)s.%(ext)s"'

alias wget="wget --hsts-file $XDG_CACHE_HOME/wget-hsts"

open(){
    nohup xdg-open $1 > /dev/null &
}

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
