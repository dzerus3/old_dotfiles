#!/bin/bash
# Draws on https://dev.to/mafflerbach/use-pass-and-rofi-to-get-a-fancy-password-manager-2k37

prefix=${PASSWORD_STORE_DIR-~/.password-store}
password_files=( "$prefix/**/*.gpg" )
password_files=( "${password_files[@]#"$prefix"/}" )
password_files=( "${password_files[@]%.gpg}" )

selection=$(
    printf '%s\n' "${password_files[@]}" | \
    wofi -d --height 225 --width 500 --prompt "Pick a password"
)
echo $selection
[[ -n $selection ]] || exit

pass -c "$selection"
