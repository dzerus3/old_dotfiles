# Gives tab selection vim navigation
bindkey -M menuselect 'n' vi-backward-char
bindkey -M menuselect 'e' vi-down-line-or-history
bindkey -M menuselect 'i' vi-up-line-or-history
bindkey -M menuselect 'o' vi-forward-char

# Edit command in vim with Ctrl + x
# autoload edit-command-line
# zle -N edit-command-line
# bindkey '^x' edit-command-line

# Ctrl + o/n moves one character forward/back
bindkey '^o' forward-char
bindkey '^n' backward-char

# Alt + o/n moves forward/backward by one word
bindkey '^[o' forward-word
bindkey '^[n' backward-word

# Ctrl + e/i moves to beginning/end of line
# Mapping Ctrl + i seems also to rebind tab...
# Disabling because breaks autocompletion, and I didn't find a way to fix it with alacritty
# bindkey '^e' beginning-of-line
# bindkey '^i' end-of-line

# Use Alt + e/i to move through history
bindkey '^[e' down-history
bindkey '^[i' up-history
