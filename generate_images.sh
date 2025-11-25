#!/usr/bin/env bash

# Generate synesthesia images for each tone
# Theta_core: Blue gradient (calming)
# Theta_harm: Green pattern (harmonic)
# Pink_noise: Gray static (neutral)

convert -size 1920x1080 xc:blue assets/theta_core.jpg
convert -size 1920x1080 xc:green assets/theta_harm.jpg
convert -size 1920x1080 xc:gray -noise 2 assets/pink_noise.jpg

echo "Images generated: assets/theta_core.jpg, assets/theta_harm.jpg, assets/pink_noise.jpg"