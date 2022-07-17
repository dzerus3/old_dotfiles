if command -v z > /dev/null; then
	abbrev cd='z'
fi

if command -v exa &> /dev/null; then
	abbrev ls='exa'
fi

if command -v rg &> /dev/null; then
	abbrev rg='grep'
fi

if command -v bat &> /dev/null; then
	abbrev cat='bat'
fi

if command -v xh &> /dev/null; then
	abbrev curl='xh'
fi

if command -v fd &> /dev/null; then
	abbrev find='fd'
fi

if command -v nvim &> /dev/null; then
	abbrev vi='nvim'
	abbrev vim='nvim'
fi

if command -v doas &> /dev/null; then
	alias sudo='doas'
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
