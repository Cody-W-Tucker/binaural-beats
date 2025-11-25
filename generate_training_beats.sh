#!/usr/bin/env bash
# Synesthesia Deprivation Stack – 30 min blindfold session (FIXED CHANNELS)
# Requires: sox   (brew install sox  /  sudo apt install sox)

make_beats() {
  local name=$1 base=$2 beat=$3 vol=$4 dur=$5
  local right_freq=$(echo "$base + $beat + 0.15" | bc -l)  # tiny detune
  # ---- LEFT CHANNEL (mono) ----
  sox -n -c 1 assets/left.wav synth "$dur" sin "$base" vol "$vol"
  # ---- RIGHT CHANNEL (mono) ----
  sox -n -c 1 assets/right.wav synth "$dur" sin "$right_freq" vol "$vol"
  # ---- MERGE to STEREO ----
  sox -M assets/left.wav assets/right.wav "assets/$name.wav" fade t 5 "$((dur - 10))" 5
  rm -f assets/left.wav assets/right.wav
}

# 1. Core theta (4 Hz on 136 Hz)
make_beats theta_core 136 4.0 0.85 1800

# 2. Harmonic alpha-theta (8 Hz on 272 Hz)
make_beats theta_harm 272 8.0 0.55 1800

# 3. Pink-noise mask (STEREO, low level)
sox -n -c 2 assets/pink_mask.wav synth 1800 pinknoise vol 0.30

# 4. Final MIX (all files are now 2-channel stereo)
sox -m assets/theta_core.wav assets/theta_harm.wav assets/pink_mask.wav assets/SYNESTHESIA_DEPRIVATION.wav

# Cleanup
rm -f assets/theta_core.wav assets/theta_harm.wav assets/pink_mask.wav

echo "File ready: assets/SYNESTHESIA_DEPRIVATION.wav (30 min)"
echo "   • Blindfold + dark room"
echo "   • Headphones (check L/R balance!)"
echo "   • Journal any color/shape/taste after 15–20 min"
