#!/bin/bash

options=(
    "(L)ogout"
    "(S)hutdown"
    "(R)eboot"
    "(Su)spend"
    "(C)ancel"
)

selection=$($HOME/.local/bin/sway/sway-menu.sh "Exit?" "${options[@]}")

# Note: User needs permission in /etc/doas.conf
case "$selection" in
    Logout)   swaymsg exit         ;;
    Shutdown) doas shutdown -h now ;;
    Reboot)   doas shutdown -r now ;;
    Suspend)  doas s2ram           ;;
esac

