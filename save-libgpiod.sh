#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SAVE_DIR="$SCRIPT_DIR/base_external/patches/libgpiod"
mkdir -p "$SAVE_DIR"
cp "$SCRIPT_DIR/buildroot/package/libgpiod/"* "$SAVE_DIR/"
echo "Saved libgpiod package files to $SAVE_DIR"
