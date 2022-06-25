# Sets less keybindings file.
export LESSKEYIN="/home/sal/.config/lesskey"

# Disables less history
export LESSHISTFILE=-

# Enable less color support
export LESS=" --RAW-CONTROL-CHARS --squeeze-blank-lines "

export MANPAGER="less +Gg"

export LESS_TERMCAP_mb=$'\E[1;31m'     # begin blink
export LESS_TERMCAP_md=$'\E[1;36m'     # begin bold
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;33m'    # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline
# export LESS_TERMCAP_mr=$(tput rev)
# export LESS_TERMCAP_mh=$(tput dim)
# export LESS_TERMCAP_ZN=$(tput ssubm)
# export LESS_TERMCAP_ZV=$(tput rsubm)
# export LESS_TERMCAP_ZO=$(tput ssupm)
# export LESS_TERMCAP_ZW=$(tput rsupm)

# Enable syntax highlighting
if [ -f "/usr/bin/src-hilite-lesspipe.sh" ]; then
	export LESSOPEN="| /usr/bin/src-hilite-lesspipe.sh %s"
fi
