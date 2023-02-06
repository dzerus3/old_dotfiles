#!/bin/bash

# Adds style to command
menu_style=(
    --tf "#5D8CAE"
    --nb "#272727"
    --nf "#c0c0c0"
    --hb "#1a6b3c"
    --hf "#FFFFFF"
    --fn "Deja Vu Sans Mono 10"
)

# Adds other arguments
arguments="-i"

# Adds argument for message
message="-p $1"

# Loops through all but the first option passed (that's the
# message) and pipes that in newline-separated format (that's
# what the echo is for) to bemenu.
for buffer in "${@:2}"
do
    echo $buffer
done | bemenu "${menu_style[@]}" "${arguments}" "${message}"
