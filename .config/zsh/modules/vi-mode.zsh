# vi mode
# Largely borrowed from Luke Smith's zshrc
bindkey -v
export KEYTIMEOUT=1

# Disables annoying special characters
bindkey -r "^A"
bindkey -r "^B"
bindkey -r "^F"
bindkey -r "^H"
bindkey -r "^J"
bindkey -r "^K"
bindkey -r "^P"
bindkey -r "^U"
bindkey -r "^W"

# Rebinds vi mode bindings to fit Colemak
# Key reference at man zshzle line 948
bindkey -a 'n' backward-char
bindkey -a 'e' down-history
bindkey -a 'i' up-history
bindkey -a 'o' forward-char
bindkey -a 'l' vi-insert
bindkey -a 'L' vi-insert-bol

# Reimplements Esc - . functionality
bindkey -a -s '.' 'i$yiwep'

# Extends vi keybindings to tab select
bindkey -M menuselect 'n' vi-backward-char
bindkey -M menuselect 'e' vi-down-line-or-history
bindkey -M menuselect 'i' vi-up-line-or-history
bindkey -M menuselect 'o' vi-forward-char
bindkey -M vicmd 'E' history-substring-search-down
bindkey -M vicmd 'I' history-substring-search-up
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}

# initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
zle-line-init() {
    zle -K viins
    echo -ne "\e[5 q"
}

zle -N zle-line-init
zle -N zle-keymap-select

# Use beam shape cursor on startup.
echo -ne '\e[5 q'

# Use beam shape cursor for each new prompt.
preexec() { echo -ne '\e[5 q' ;}

# Space in normal mode to edit current line in editor buffer
autoload edit-command-line
zle -N edit-command-line
bindkey -M vicmd ' ' edit-command-line

# Gives tab selection vim navigation
bindkey -M menuselect 'n' vi-backward-char
bindkey -M menuselect 'e' vi-down-line-or-history
bindkey -M menuselect 'i' vi-up-line-or-history
bindkey -M menuselect 'o' vi-forward-char