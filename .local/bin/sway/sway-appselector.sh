#!/bin/bash

# # Adds style to command
# menu_style=(
#     --tf "#5D8CAE"
#     --nb "#272727"
#     --nf "#c0c0c0"
#     --hb "#1a6b3c"
#     --hf "#FFFFFF"
#     --fn "Deja Vu Sans Mono 10"
# )

# # Adds other arguments
# arguments="-i"

# command="bemenu ${menu_style[@]} ${arguments}"
# echo $command

# j4-dmenu-desktop --dmenu="$command" --term='kitty'
j4-dmenu-desktop --dmenu='bemenu --tf "#5D8CAE" --nb "#272727" --nf "#c0c0c0" --hb "#1a6b3c" --hf "#FFFFFF" -i --fn "Deja Vu Sans Mono 10"' --term='kitty'
