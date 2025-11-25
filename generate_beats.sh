#!/usr/bin/env bash

make_beats() {
  local name=$1 base=$2 beat=$3 vol=$4 dur=$5
  sox -n assets/left.wav synth "$dur" sin "$base"
  sox -n assets/right.wav synth "$dur" sin "$(echo "$base + $beat + 0.15" | bc)"
  sox -M assets/left.wav assets/right.wav assets/temp.wav vol "$vol"
  sox assets/temp.wav assets/smooth.wav fade t 5 "$(echo "$dur - 10" | bc)" 5
  sox -m assets/smooth.wav "assets/${name}".wav
  rm assets/left.wav assets/right.wav assets/temp.wav assets/smooth.wav
}

make_beats theta 136 4.5 0.9 300
make_beats alpha 130 10 0.8 300
make_beats gamma 136 40 0.7 300

sox assets/theta.wav assets/alpha.wav assets/gamma.wav assets/meditation.wav
