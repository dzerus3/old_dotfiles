#!/bin/bash

options=(
    "Logout"
    "Shutdown"
    "Reboot"
    "Cancel"
)

selection=$(./sway-menu.sh "Are you sure you want to exit?" "${options[@]}")

case "$selection" in
    Logout)   swaymsg exit         ;;
    Shutdown) doas shutdown -h now ;;
    Reboot)   doas shutdown -r now ;;
esac

