#!/bin/bash

if [[ -v PASSWORD_STORE_DIR ]]
then
    location=$PASSWORD_STORE_DIR
else
    location=$HOME/.password-store
fi
cd $location

passwords=()
readarray -d '' passwords < <(find . -type f -not -path '*/\.git*' -not -path '*/\.gpg-id' -print0)

selection=$($HOME/.local/bin/sway/sway-menu.sh "Pick a password:" ${passwords[@]})
pass -c $selection
