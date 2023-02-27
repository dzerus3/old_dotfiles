#!/bin/bash
# See also https://github.com/jluttine/rofi-power-menu/blob/master/rofi-power-menu

options=(
    "⍈  Logout"
    "⏻  Shutdown"
    "⏼  Reboot"
    "⏾  Suspend"
    "⨯  Cancel"
)

selection=$(
    printf '%s\n' "${options[@]}" | \
    wofi --dmenu --cache-file /dev/null \
         --height 225 --width 300 --prompt "$(uptime -p)"
)

# Note: User needs permission in /etc/doas.conf
case "$selection" in
    "⍈  Logout")   swaymsg exit         ;;
    "⏻  Shutdown") doas -n shutdown -h now ;;
    "⏼  Reboot")   doas -n shutdown -r now ;;
    "⏾  Suspend")  doas -n s2ram           ;;
esac

