#!/bin/bash

# Power Profile Switching Script for Waybar
# Save this as ~/.config/waybar/scripts/power-profile.sh and make it executable

# Check if power profiles daemon is available
if ! command -v powerprofilesctl &>/dev/null; then
  echo "powerprofilesctl not found"
  exit 1
fi

# Get current profile
current_profile=$(powerprofilesctl get 2>/dev/null || echo "balanced")

# Cycle through profiles: performance -> balanced -> power-saver -> performance
case $current_profile in
"performance")
  new_profile="balanced"
  icon="⚡"
  ;;
"balanced")
  new_profile="power-saver"
  icon="🔋"
  ;;
"power-saver" | *)
  new_profile="performance"
  icon="🚀"
  ;;
esac

# Set new profile
if powerprofilesctl set "$new_profile" 2>/dev/null; then
  # Send notification
  if command -v notify-send &>/dev/null; then
    notify-send -t 2000 -i "power-profile-$new_profile" \
      "Power Profile" \
      "$icon Profile changed to: $new_profile"
  fi
  echo "$new_profile"
else
  echo "Failed to change profile"
  exit 1
fi
