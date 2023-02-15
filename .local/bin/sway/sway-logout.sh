#!/bin/bash
# See also https://github.com/jluttine/rofi-power-menu/blob/master/rofi-power-menu

options=(
    "⍈ (L)ogout"
    "⏻ (S)hutdown"
    "⏼ (R)eboot"
    "⏾ (Su)spend"
    "⨯ (C)ancel"
)

selection=$(
    printf '%s\n' "${options[@]}" | \
    wofi --dmenu --cache-file /dev/null \
         --height 225 --width 100 --prompt "Exit Sway?"
)

# Note: User needs permission in /etc/doas.conf
case "$selection" in
    "⍈ (L)ogout")   swaymsg exit         ;;
    "⏻ (S)hutdown") doas -n shutdown -h now ;;
    "⏼ (R)eboot")   doas -n shutdown -r now ;;
    "⏾ (Su)spend")  doas -n s2ram           ;;
esac

