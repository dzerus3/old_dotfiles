# Sets the prompt
if [ $UID -eq 0 ]
then
    PS1="%B%{$fg[red]%}[%{$fg[magenta]%}%B%c/%b%{$reset_color%}%{$fg[red]%}]%{$reset_color%} "
else
    PS1="%B%{$fg[blue]%}[%{$fg[green]%}%B%c/%b%{$reset_color%}%{$fg[blue]%}]%{$reset_color%} "
fi
