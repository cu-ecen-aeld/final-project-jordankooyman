# AESD Final Project - SPI Display User Space Driver

**Author:** [Jordan Kooyman](https://github.com/jordankooyman)

**Course:** ECEN 5713 - Advanced Embedded Software Development -- Spring 2026

**Institution:** University of Colorado Boulder

## Project Overview

This repository contains the Buildroot configuration and build system for a userspace display library targeting the ~~**LDT LD7138** 128x128 pixel 65K-color OLED~~ ILI9488 display controller. The library enables a Raspberry Pi 4 Model B to drive the display over SPI using Linux's `spidev` kernel driver and `libgpiod` for GPIO control.

LD7138 driver was the original target for this project, but due to the lack of available documentation and difficulty in board bring-up, this project has pivoted to using a different SPI-interfaced display with the ILI9488 driver. The work put towards the LD7138 is still being considered part of this project, most of sprint 1, and extensive documentation has been produced to expand the available knowledge base on this display, but to ensure a project can be completed in the remaining 2 sprints with something to demo, the fallback plan has been invoked.

**For complete project details, see the [Project Overview Wiki Page](https://github.com/cu-ecen-aeld/final-project-jordankooyman/wiki/Project-Overview)**

**For sprint schedule and task tracking, see the [Schedule Wiki Page](https://github.com/cu-ecen-aeld/final-project-jordankooyman/wiki/Schedule)**

## Quick Links

- **Project Overview:** [Wiki - Project Overview](https://github.com/cu-ecen-aeld/final-project-jordankooyman/wiki/Project-Overview)
- **Schedule & Issues:** [Wiki - Schedule](https://github.com/cu-ecen-aeld/final-project-jordankooyman/wiki/Schedule)
- **LD7138 Source Code:** [ld7138-userspace-driver repository](https://github.com/jordankooyman/ld7138-userspace-driver)
- **ILI9488 Source Code:** [ili9488-userspace-driver repository](https://github.com/jordankooyman/ili9488-userspace-driver)
- **Project Board:** [Sprint Schedule](https://github.com/users/jordankooyman/projects/1)

## Repository Structure (To Be Updated)

```
final-project-jordankooyman/
├── README.md                    # This file
├── buildroot-external/          # Buildroot external tree
│   ├── Config.in
│   ├── external.mk
│   └── package/
│       └── ili9488/              # ILI9488 library package
│           ├── Config.in
│           └── ili9488.mk
└── docs/
    └── wiring.md                # RPi4B GPIO pin mapping
```

## Hardware

- **Platform:** Raspberry Pi 4 Model B
- **Display:** ~~Transparent OLED with LDT LD7138 OLED Controller~~ 3.5" LCD with ILI9488 Driver IC
- **Interface:** SPI (via `/dev/spidev0.0`) + GPIO (Reset via `libgpiod`)

## Build System

This project uses **Buildroot** to create a minimal embedded Linux image for the Raspberry Pi 4B. The ILI9488 userspace library is built and deployed via a custom Buildroot external package.

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
```

## Development

Initial development is performed on **Raspberry Pi OS** for rapid iteration before migrating to Buildroot.

## Architecture (To Be Updated)

The library is split into three layers:

1. **Graphics Layer** (`ili9488_gfx.c`) - Software framebuffer and drawing primitives
2. **HAL Layer** (`ili9488_hal.c`) - LD7138-specific command encoding and initialization
3. **SPI/GPIO Abstraction** (`ili9488_spi_linux.c`) - Platform-specific `spidev` and `libgpiod` calls

See the [System Architecture Diagram](../../wiki/Project-Overview#system-architecture-diagram) in the Project Overview.

## AI Assistance Disclosure

AI tools (Claude by Anthropic) were used in planning and drafting project documentation. See the [AI Assistance Log](https://github.com/cu-ecen-aeld/final-project-jordankooyman/wiki/Project-Overview#ai-assistance-log) for details.
