#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SAVE_DIR="$SCRIPT_DIR/base_external/patches/libgpiod"
if [ ! -d "$SAVE_DIR" ]; then
    echo "ERROR: $SAVE_DIR not found. Run save-libgpiod.sh first."
    exit 1
fi
if [ ! -d "$SCRIPT_DIR/buildroot/package/libgpiod" ]; then
    echo "ERROR: buildroot submodule not initialized. Run: git submodule update --init"
    exit 1
fi
cp "$SAVE_DIR/"* "$SCRIPT_DIR/buildroot/package/libgpiod/"
rm -f "$SCRIPT_DIR/buildroot/package/libgpiod/"*.patch
echo "Restored libgpiod package files to buildroot/package/libgpiod/"
