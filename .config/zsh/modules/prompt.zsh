# Prompt variable reference in
ZSH_THEME_GIT_PROMPT_PREFIX=':'
ZSH_THEME_GIT_PROMPT_SUFFIX=
ZSH_THEME_GIT_PROMPT_SEPARATOR=
ZSH_THEME_GIT_PROMPT_DETACHED="%{$fg_bold[cyan]%}:"
ZSH_THEME_GIT_PROMPT_BRANCH=  "%{$fg_bold[white]%}"
ZSH_THEME_GIT_PROMPT_UPSTREAM_NO_TRACKING=" %{$fg_bold[red]%}!"
ZSH_THEME_GIT_PROMPT_UPSTREAM_PREFIX=" %{$fg[red]%}(%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_UPSTREAM_SUFFIX="%{$fg[red]%})"
ZSH_THEME_GIT_PROMPT_BEHIND=" ↓"
ZSH_THEME_GIT_PROMPT_AHEAD= " ↑"

ZSH_THEME_GIT_PROMPT_UNMERGED= " %{$fg[red]%}x"
ZSH_THEME_GIT_PROMPT_STAGED=   " %{$fg[green]%}o"
ZSH_THEME_GIT_PROMPT_UNSTAGED= " %{$fg[red]%}+"
ZSH_THEME_GIT_PROMPT_UNTRACKED=" ."
ZSH_THEME_GIT_PROMPT_STASHED=  " %{$fg[blue]%}s"
ZSH_THEME_GIT_PROMPT_CLEAN=

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
