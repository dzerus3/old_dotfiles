# Sets less keybindings file.
export LESSKEYIN="/home/sal/.config/lesskey"

# Disables less history
export LESSHISTFILE=-

# Enable less color support
export LESS=' -R '

# Enable syntax highlighting
if [ -f "/usr/bin/src-hilite-lesspipe.sh" ]; then
	export LESSOPEN="| /usr/bin/src-hilite-lesspipe.sh %s"
fi
