#!/usr/bin/env bash

# Generate synesthesia video with alternating blue/green colors at 4 Hz (every 0.25s)
# Loops a 0.5s segment for 30 min, synced to SYNESTHESIA_DEPRIVATION.wav
# Usage: ./generate_synesthesia_video.sh [output.mp4]

output="assets/${1:-synesthesia_video.mp4}"
input="assets/SYNESTHESIA_DEPRIVATION.wav"

if [ ! -f "$input" ]; then
  echo "Error: Input audio '$input' not found."
  exit 1
fi

# Create short alternating segment (0.5s: blue 0.25s + green 0.25s)
echo "Creating short alternating video segment..."
ffmpeg -y -f lavfi -i "color=size=1920x1080:c=blue:d=0.25[color1]; color=size=1920x1080:c=green:d=0.25[color2]; [color1][color2]concat=n=2:v=1:a=0" -c:v libx264 -pix_fmt yuv420p assets/short_alternating.mp4

# Loop segment and mux with audio for full 30 min
echo "Looping segment and adding audio..."
ffmpeg -y -stream_loop -1 -i assets/short_alternating.mp4 -i "$input" -c:v copy -c:a aac -b:a 192k -shortest -t 1800 "$output"

# Cleanup intermediate file
rm -f assets/short_alternating.mp4

echo "Synesthesia video created: $output"