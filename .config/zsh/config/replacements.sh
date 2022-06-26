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
