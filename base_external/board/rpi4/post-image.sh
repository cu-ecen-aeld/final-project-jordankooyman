#!/usr/bin/env bash
set -e

# Copy our custom config.txt into the firmware directory
cp "$BR2_EXTERNAL_SPI_DISPLAY_PATH/board/rpi4/config.txt" "$BINARIES_DIR/rpi-firmware/config.txt"

# Call the standard Buildroot RPi4 post-image script to run genimage
# and assemble the final sdcard.img
"$BR2_EXTERNAL_SPI_DISPLAY_PATH/../buildroot/board/raspberrypi4-64/post-image.sh" "$@"
