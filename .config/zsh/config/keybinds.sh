# Gives tab selection vim navigation
bindkey -M menuselect 'n' vi-backward-char
bindkey -M menuselect 'e' vi-down-line-or-history
bindkey -M menuselect 'i' vi-up-line-or-history
bindkey -M menuselect 'o' vi-forward-char

# Edit command in vim with Ctrl + x
autoload edit-command-line
zle -N edit-command-line
bindkey '^x' edit-command-line

# Ctrl + o/n moves forward/backward by one word
bindkey '^[o' forward-word
bindkey '^[n' backward-word

# Alt + o/n moves to beginning/end of line
bindkey '^n' beginning-of-line
bindkey '^o' end-of-line

# Use Alt + e/i to move through history
bindkey '^[e' down-history
bindkey '^[i' up-history
