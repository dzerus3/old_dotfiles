#!/bin/bash

options=(
    "Logout"
    "Shutdown"
    "Reboot"
    "Cancel"
)

selection=$($HOME/.local/bin/sway/sway-menu.sh "Are you sure you want to exit?" "${options[@]}")

# Note: User needs permission in /etc/doas.conf
case "$selection" in
    Logout)   swaymsg exit         ;;
    Shutdown) doas shutdown -h now ;;
    Reboot)   doas shutdown -r now ;;
esac

