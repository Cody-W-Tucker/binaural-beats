#!/usr/bin/env bash

# Convert audio to video with static background image
# Usage: ./convert_audio_to_video.sh input.wav output.mp4 [background.jpg]

input="assets/$1"
output="assets/$2"
bg="${3:-assets/background.jpg}"  # default background if not provided

if [ ! -f "$input" ]; then
  echo "Error: Input audio file '$input' not found."
  exit 1
fi

if [ ! -f "$bg" ]; then
  echo "Error: Background image '$bg' not found."
  exit 1
fi

ffmpeg -loop 1 -i "$bg" -i "$input" -c:v h264_nvenc -preset slow -tune stillimage -c:a aac -b:a 192k -pix_fmt yuv420p -shortest "$output"

echo "Video created: $output"