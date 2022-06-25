# Sets the prompt
# Note: reference at https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html
ZSH_THEME_GIT_PROMPT_PREFIX=":"
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg_bold[white]%}"
ZSH_THEME_GIT_PROMPT_SEPARATOR=" "

if [ $UID -eq 0 ]; then
	PROMPT='%B%{$fg[red]%}[%{$fg[magenta]%}%B%1~%b%{$reset_color%}$(gitprompt)%{$fg[red]%}]%{$reset_color%} '
else
	PROMPT='%B%{$fg[blue]%}[%{$fg[green]%}%B%1~%b%{$reset_color%}$(gitprompt)%{$fg[blue]%}]%{$reset_color%} '
fi
