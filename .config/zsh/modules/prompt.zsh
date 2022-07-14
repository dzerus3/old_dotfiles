# Don't throw an error if git-prompt plugin is not installed
# TODO: I don't think it actually works correctly
if typeset -f gitprompt > /dev/null; then
	function gitprompt{}
fi

# Prompt variable reference in
ZSH_THEME_GIT_PROMPT_PREFIX=':'
ZSH_THEME_GIT_PROMPT_SUFFIX=
ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg_bold[white]%}"
ZSH_THEME_GIT_PROMPT_SEPARATOR=' '

# Sets a red and magenta prompt if root, and blue/green
# otherwise.
if [ $UID -eq 0 ]; then
	PROMPT='%B%{$fg[red]%}[%{$fg[magenta]%}%B%1~%b%{$reset_color%}$(gitprompt)%{$fg[red]%}]%{$reset_color%} '
else
	PROMPT='%B%{$fg[blue]%}[%{$fg[green]%}%B%1~%b%{$reset_color%}$(gitprompt)%{$fg[blue]%}]%{$reset_color%} '
fi
