# vi mode
# Borrowed from Luke Smith's zshrc
bindkey -v
export KEYTIMEOUT=1

# Rebinds vi mode bindings to fit Colemak
# Key reference at http://bolyai.cs.elte.hu/zsh-manual/zsh_14.html
bindkey -a 'n' backward-char
bindkey -a 'e' down-history
bindkey -a 'i' up-history
bindkey -a 'o' forward-char
bindkey -a 't' vi-insert

# Reimplements Esc - . functionality with Ctrl + l
bindkey -a 'h' insert-last-word
bindkey '^u' backward-kill-line

# Extends vi keybindings to tab select
bindkey -M menuselect 'n' vi-backward-char
bindkey -M menuselect 'e' vi-down-line-or-history
bindkey -M menuselect 'i' vi-up-line-or-history
bindkey -M menuselect 'o' vi-forward-char
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
