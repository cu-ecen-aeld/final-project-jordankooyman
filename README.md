# ECEN 5713 Final Project -- ILI9488 SPI Display Driver on Buildroot

**Author:** Jordan Kooyman

**Course:** ECEN 5713 - Advanced Embedded Software Development, Spring 2026

**Institution:** University of Colorado Boulder

## Quick Links

- **Project Overview:** [Wiki - Project Overview](https://github.com/cu-ecen-aeld/final-project-jordankooyman/wiki/Project-Overview)
- **Schedule & Issues:** [Wiki - Schedule](https://github.com/cu-ecen-aeld/final-project-jordankooyman/wiki/Schedule)
- **LD7138 Source Code:** [ld7138-userspace-driver repository](https://github.com/jordankooyman/ld7138-userspace-driver)
- **ILI9488 Source Code:** [ili9488-userspace-driver repository](https://github.com/jordankooyman/ili9488-userspace-driver)
- **Project Board:** [Sprint Schedule](https://github.com/users/jordankooyman/projects/1)

---

## Overview

This project implements a userspace SPI display driver for the ILI9488 LCD controller running on a Raspberry Pi 4B under a custom Buildroot Linux image. The driver communicates with the display over SPI using the kernel's `spidev` interface, with GPIO handled through `libgpiod` v2.

The original target for this project was the LDT LD7138 128x64 OLED display. Sprint 1 was spent on hardware bring-up for that display, which proved extremely difficult due to the near-total absence of available documentation and datasheet clarity on the initialization sequence. Significant debugging work was done and documented to expand the available knowledge base on that controller, but with two sprints remaining and a working demo required, the project pivoted to the ILI9488, which has broad community support and clear documentation. The LD7138 work is still counted as part of the project.

## Hardware

- **Platform:** Raspberry Pi 4 Model B (BCM2711, aarch64)
- **Display:** 3.5 inch LCD with ILI9488 driver IC
- **SPI device:** `/dev/spidev0.0`
- **GPIO:** Reset line controlled via `libgpiod`

Wiring details are documented in `docs/wiring.md` in the ILI9488 or LD7138 repositories.

[PLACEHOLDER: add wiring diagram or pin table here if desired]

## Repository Structure
final-project-jordankooyman/
├── base_external/               # Buildroot external tree
│   ├── board/rpi4/              # Boot config, cmdline, post-image script
│   ├── configs/                 # Buildroot defconfig
│   ├── package/ili9488/         # Custom Buildroot package for the driver
│   ├── patches/libgpiod/        # libgpiod v2 package files (overrides v1)
│   └── rootfs_overlay/          # Files copied into the rootfs at build time
│       └── etc/
│           ├── init.d/S99ili9488  # Autostart script for the demo
│           └── inittab
├── build.sh                     # Full build script (submodule init + make)
├── clean.sh                     # Clean build output
├── restore-libgpiod.sh          # Copies libgpiod v2 files into buildroot tree
├── save-libgpiod.sh             # Saves current libgpiod files back to patches/
├── shared.sh                    # Common variables used by build scripts
└── README.md

## Build System

The image is built with Buildroot 2024.02.13 using an external tree (`base_external`). The Buildroot submodule is pinned to the `2024.02.13` tag. One manual workaround is required: Buildroot 2024.02 ships libgpiod v1.6.4, but this project needs v2. The package files have been manually updated and saved to `base_external/patches/libgpiod/`. The build script handles restoring them automatically.

### Building
```bash
git clone https://github.com/cu-ecen-aeld/final-project-jordankooyman.git
cd final-project-jordankooyman
git submodule update --init
./build.sh
```

The build script will initialize the submodule, restore the libgpiod v2 package files, apply the defconfig, and run `make`. The finished image is at `buildroot/output/images/sdcard.img`.

Build time on a modern machine with a warm cache is roughly [PLACEHOLDER: fill in approximate build time]. A cold build with no cached downloads takes longer due to fetching the kernel tarball and toolchain.

### Flashing

Flash with Balena Etcher on Windows or `dd` on Linux:
```bash
sudo dd if=buildroot/output/images/sdcard.img of=/dev/sdX bs=4M status=progress && sync
```

No manual edits to the SD card are needed after flashing. All configuration is applied at build time by `post-image.sh` and the rootfs overlay.

### Serial Console

If you need a login prompt over serial during development:

- Connect a USB-to-TTL adapter to Pi header pins 6 (GND), 8 (TX), 10 (RX)
- 115200 baud, 8N1, no flow control
- The console is on `ttyS0` (the mini UART, not the PL011)

## Runtime Behavior

On boot the system starts the ILI9488 demo automatically via `/etc/init.d/S99ili9488`. The demo [PLACEHOLDER: describe what the demo does -- color fill, pattern, image, etc.].

SSH is available via Dropbear. The root password is `root`. Ethernet will attempt DHCP on `eth0` at boot. WiFi is not included in this image.

## Development Notes

- Initial driver development was done on Raspberry Pi OS for fast iteration before moving to Buildroot
- libgpiod v2 API is used throughout; v1 is not compatible with this codebase
- `spidev` is enabled via `dtparam=spi=on` in `config.txt`; this is present in the source tree and applied automatically at build time
- The Buildroot defconfig does not include wpa_supplicant or any wireless packages

[PLACEHOLDER: add any notes about driver architecture, known limitations, or next steps here]

## AI Assistance Disclosure

AI tools (Claude by Anthropic) were used during debugging, documentation drafting, and build system troubleshooting.

Links to AI chatbot conversations used in developing this document:

| Date | Tool | Topic / Link |
|------|------|-------------|
| 2026-03-06 | Claude (claude.ai) | Initial readme write - [https://claude.ai/share/a267eef2-ef16-4761-8308-0fcea6868335](https://claude.ai/share/a267eef2-ef16-4761-8308-0fcea6868335) |
| 2026-04-02 | Claude (claude.ai) | Initial Buildroot setup and debugging | [https://claude.ai/share/30d3d80e-4795-430b-9278-814be31f25f6](https://claude.ai/share/30d3d80e-4795-430b-9278-814be31f25f6)
| 2026-04-03 | Claude (claude.ai) | Continued Buildroot debugging | [https://claude.ai/share/7f38c970-0998-4f8d-87c0-b5c361285498}](https://claude.ai/share/7f38c970-0998-4f8d-87c0-b5c361285498)
| 2026-04-06 | Claude (claude.ai) | Finished Buildroot debugging and readme update | [https://claude.ai/share/e93e1767-dc2a-484a-8f0f-29c3b7d0ae48](https://claude.ai/share/e93e1767-dc2a-484a-8f0f-29c3b7d0ae48)
| | | |
