#!/bin/bash

# Single hyprctl call to get all data at once
data=$(hyprctl workspaces -j)
active=$(hyprctl activeworkspace -j | jq -r '.id')

# App class to icon mapping
declare -A app_icons=(
  ["Google-chrome"]=""
  ["google-chrome"]=""
  ["Chrome"]=""
  ["Chromium"]=""
  ["Brave"]=""
  ["brave-browser"]=""
  ["firefox"]=""
  ["Firefox"]=""
  ["ghostty"]="󰊠"
  ["Ghostty"]="󰊠"
  ["Alacritty"]=""
  ["alacritty"]=""
  ["Code"]=""
  ["code"]=""
  ["discord"]=""
  ["Discord"]=""
  ["Spotify"]=""
  ["spotify"]=""
  ["Steam"]=""
  ["steam"]=""
  ["nvim"]=""
  ["Neovim"]=""
  ["Zed"]="󰲋"
  ["zed"]="󰲋"
)

output=""

# Process workspaces 1-5
for ws in {1..5}; do
  # Check if workspace exists and has windows
  has_windows=$(echo "$data" | jq -r --arg ws "$ws" '.[] | select(.id == ($ws | tonumber)) | .windows // 0')

  if [[ "$has_windows" -gt 0 ]]; then
    # Get unique app classes for this workspace
    apps=$(hyprctl clients -j | jq -r --arg ws "$ws" '.[] | select(.workspace.id == ($ws | tonumber)) | .class' | sort -u)

    # Convert to icons
    icons=""
    while read -r app; do
      [[ -z "$app" ]] && continue
      icon="${app_icons[$app]}"
      [[ -n "$icon" ]] && icons+="$icon"
    done <<<"$apps"

    # Format workspace
    if [[ "$ws" == "$active" ]]; then
      output+="[$ws$icons] "
    else
      output+="$ws$icons "
    fi
  else
    # Empty workspace
    if [[ "$ws" == "$active" ]]; then
      output+="[$ws] "
    else
      output+="$ws "
    fi
  fi
done

# Clean output and format as JSON
output=$(echo "$output" | sed 's/ $//')
echo "{\"text\":\"$output\"}"
