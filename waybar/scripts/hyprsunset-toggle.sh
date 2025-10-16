#!/bin/bash

ON_TEMP=4000
OFF_TEMP=6000

CURRENT_TEMP=$(hyprctl hyprsunset temperature 2>/dev/null | grep -oE '[0-9]+')
# Immediately output icon based on new state
if [[ "$CURRENT_TEMP" == "$OFF_TEMP" ]]; then
  echo "" # Moon icon
else
  echo "" # Sunset icon
fi
