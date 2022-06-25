# Enable colors
autoload -U colors && colors

# enable completion features
autoload -Uz compinit
compinit -d ~/.cache/zcompdump
# Enables menu selection for completion
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' group-name ''
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' rehash true
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# Enables mid-word autocompletion
zstyle ':completion:*' completer _expand _complete
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'

# Sets colors for autocompletion
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

autoload -Uz compinit
zmodload zsh/complist

# Autocompletes hidden files
_comp_options+=(globdots)

# Sets max history size
HISTSIZE=250
SAVEHIST=250

# Moves history file to ~/.cache
HISTFILE=~/.cache/zsh.history

# Sets nvim as default editor
export EDITOR="nvim"

# Enables emacs keybindings
bindkey -e

# Loads plugins
source $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZDOTDIR/plugins/git-prompt.zsh/git-prompt.plugin.zsh

# Loads my external configuration files.
# Basically, if it's not a variable setting or zsh configuration I move it to an external file.
for file in $ZDOTDIR/config/*.sh; do
	source $file
done
source $ZDOTDIR/.zsh_functions

source $ZDOTDIR/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
unix-word-rubout() {
  local WORDCHARS=$'!"#$%&\'()*+,-./:;<=>?@[\\]^_`{|}~'
  zle backward-kill-word
}

zle -N unix-word-rubout
bindkey '^W' unix-word-rubout
