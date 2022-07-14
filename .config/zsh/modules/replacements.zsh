if command -v z > /dev/null; then
	alias cd='echo "You should use z instead of cd."||:'
fi

if command -v doas &> /dev/null; then
	alias sudo='echo "You should use doas instead of sudo."||:'
fi

if command -v exa &> /dev/null; then
	alias ls='echo "You should use exa instead of ls."||:'
fi

if command -v rg &> /dev/null; then
	alias grep='echo "You should use rg instead of grep."||:'
fi

if command -v ss &> /dev/null; then
	alias netstat='echo "You should use ss instead of netstat."||:'
fi

if command -v ip &> /dev/null; then
	alias ifconfig='echo "You should use ip instead of ifconfig."||:'
fi

if command -v dig &> /dev/null; then
	alias nslookup='echo "You should use dig instead of nslookup."||:'
fi

if command -v fd &> /dev/null; then
	alias find='echo "You should use fd instead of find."||:'
fi

if command -v xh &> /dev/null; then
	alias curl='echo "You should use xh instead of curl."||:'
fi

if command -v nvim &> /dev/null; then
	alias vi='echo "You should use nvim instead of vi."||:'
	alias vim='echo "You should use nvim instead of vim."||:'
fi

# TODO: Enabling breaks git-prompt plugin.
#if command -v bat &> /dev/null; then
#	alias cat='echo "You should use bat instead of cat."||:'
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
	unset grc_commands cmd
fi
