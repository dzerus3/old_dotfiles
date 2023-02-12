# Prompt variable reference in
ZSH_THEME_GIT_PROMPT_PREFIX=':'
ZSH_THEME_GIT_PROMPT_SUFFIX=
ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg_bold[white]%}"
ZSH_THEME_GIT_PROMPT_SEPARATOR=' '

# Resets prompt
PROMPT=""

# If we're connected to ssh, display hostname
if ((${#SSH_CLIENT[@]})); then
    PROMPT=$PROMPT'($(hostname)) '
fi

# Sets a red and magenta prompt if root, and blue/green otherwise.
if [ $UID -eq 0 ]; then
    PROMPT=$PROMPT"%B%{$fg[red]%}[%{$fg[magenta]%}%B%1~%b%{$reset_color%}"
else
    PROMPT=$PROMPT"%B%{$fg[blue]%}[%{$fg[green]%}%B%1~%b%{$reset_color%}"
fi

# If gitprompt addon is installed, use it
if typeset -f gitprompt > /dev/null; then
    PROMPT=$PROMPT'$(gitprompt)'
fi

# Sets a red and magenta prompt if root, and blue/green otherwise.
if [ $UID -eq 0 ]; then
    PROMPT=$PROMPT"%{$fg[red]%}]%{$reset_color%} "
else
    PROMPT=$PROMPT"%{$fg[blue]%}]%{$reset_color%} "
fi
