#!/bin/bash

# Loops through all but the first option passed (that's the
# prompt) and pipes that in newline-separated format (that's
# what the echo is for) to wofi.
for buffer in "${@:2}"
do
    echo $buffer
done | wofi -i -d -H 200 -W 100 -p $1
