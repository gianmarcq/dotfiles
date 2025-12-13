#!/bin/bash

print_status() {
    layout=$(swaymsg -t get_inputs | awk -F'[()]' '/xkb_active_layout_name/ { sub(/, with.*/, "", $2); print $2; exit }')
    datetime=$(date +'%Y-%m-%d %X')

    echo "$layout $datetime"
}

(
    while true; do echo "tick"; sleep 1; done &
    swaymsg -m -t subscribe '["input"]'
) | \
while read -r event; do
    print_status
done
