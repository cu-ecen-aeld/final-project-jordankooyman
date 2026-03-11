# AESD Final Project - LD7138 OLED Display User Space Driver

**Author:** [Jordan Kooyman](https://github.com/jordankooyman)

**Course:** ECEN 5713 - Advanced Embedded Software Development -- Spring 2026

**Institution:** University of Colorado Boulder

## Project Overview

This repository contains the Buildroot configuration and build system for a userspace display library targeting the **LDT LD7138** 128x128 pixel 65K-color OLED display controller. The library enables a Raspberry Pi 4 Model B to drive the LD7138 over SPI using Linux's `spidev` kernel driver and `libgpiod` for GPIO control.

**For complete project details, see the [Project Overview Wiki Page](https://github.com/cu-ecen-aeld/final-project-jordankooyman/wiki/Project-Overview)**

**For sprint schedule and task tracking, see the [Schedule Wiki Page](https://github.com/cu-ecen-aeld/final-project-jordankooyman/wiki/Schedule)**

## Quick Links

- **Project Overview:** [Wiki - Project Overview](https://github.com/cu-ecen-aeld/final-project-jordankooyman/wiki/Project-Overview)
- **Schedule & Issues:** [Wiki - Schedule](https://github.com/cu-ecen-aeld/final-project-jordankooyman/wiki/Schedule)
- **Library Source Code:** [ld7138-userspace-driver repository](https://github.com/jordankooyman/ld7138-userspace-driver)
- **Project Board:** [Sprint Schedule](https://github.com/users/jordankooyman/projects/1)

## Repository Structure (To Be Updated)

```
final-project-jordankooyman/
├── README.md                    # This file
├── buildroot-external/          # Buildroot external tree
│   ├── Config.in
│   ├── external.mk
│   └── package/
│       └── ld7138/              # LD7138 library package
│           ├── Config.in
│           └── ld7138.mk
└── docs/
    └── wiring.md                # RPi4B GPIO pin mapping
```

## Hardware

- **Platform:** Raspberry Pi 4 Model B
- **Display:** LDT LD7138 OLED Controller (128x128 RGB, 65K color)
- **Interface:** SPI (via `/dev/spidev0.0`) + GPIO (A0, RSTB via `libgpiod`)

## Build System

This project uses **Buildroot** to create a minimal embedded Linux image for the Raspberry Pi 4B. The LD7138 userspace library is built and deployed via a custom Buildroot external package.

### Building the Image (To Be Updated)

```bash
# Clone this repository
git clone https://github.com/cu-ecen-aeld/final-project-assignment-jordankooyman.git
cd final-project-assignment-jordankooyman

# Download Buildroot (specify version used)
wget https://buildroot.org/downloads/buildroot-2024.02.tar.gz
tar -xzf buildroot-2024.02.tar.gz
cd buildroot-2024.02

# Configure for Raspberry Pi 4 64-bit
make raspberrypi4_64_defconfig

# Point to external tree
export BR2_EXTERNAL=../buildroot-external

# Enable LD7138 package in menuconfig
make menuconfig
# Navigate to: External options → ld7138 library and demo

# Build
make -j$(nproc)

# Image output: output/images/sdcard.img
```

### Flashing to SD Card (To Be Updated)

```bash
# Linux:
sudo dd if=output/images/sdcard.img of=/dev/sdX bs=4M status=progress && sync

# macOS:
sudo dd if=output/images/sdcard.img of=/dev/rdiskN bs=4m && sync
```

## Development

Initial development is performed on **Raspberry Pi OS** for rapid iteration before migrating to Buildroot.

## Architecture (To Be Updated)

The library is split into three layers:

1. **Graphics Layer** (`ld7138_gfx.c`) - Software framebuffer and drawing primitives
2. **HAL Layer** (`ld7138_hal.c`) - LD7138-specific command encoding and initialization
3. **SPI/GPIO Abstraction** (`ld7138_spi_linux.c`) - Platform-specific `spidev` and `libgpiod` calls

See the [System Architecture Diagram](../../wiki/Project-Overview#system-architecture-diagram) in the Project Overview.

## AI Assistance Disclosure

AI tools (Claude by Anthropic) were used in planning and drafting project documentation. See the [AI Assistance Log](https://github.com/cu-ecen-aeld/final-project-jordankooyman/wiki/Project-Overview#ai-assistance-log) for details.

---

**Status:** Sprint 1 - In Progress  
**Last Updated:** March 9, 2026
