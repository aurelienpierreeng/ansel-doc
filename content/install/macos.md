---
title: Install on Mac OS
date: 2022-12-11
lastmod: 2026-02-16
draft: false
weight: 30
---

## Build from source (Homebrew, recommended)

This method is derived from the repository scripts in `packaging/macosx/`.

### Prerequisites

- Install Xcode Command Line Tools:
  ```bash
  xcode-select --install
  ```
- Install Homebrew from https://brew.sh/ (use the default prefix: `/opt/homebrew` on Apple Silicon, `/usr/local` on Intel).

### Steps

1. Clone the repository and submodules:
   ```bash
   git clone --depth 1 https://github.com/aurelienpierreeng/ansel.git
   cd ansel
   git submodule init
   git submodule update
   ```
2. Install build dependencies:
   ```bash
   ./packaging/macosx/1_install_hb_dependencies.sh
   ```
   This is the canonical dependency list used by CI and packaging.
3. Build and install into the local `install/` directory:
   ```bash
   ./packaging/macosx/2_build_hb_ansel_custom.sh
   ```
   Edit `packaging/macosx/2_build_hb_ansel_custom.sh` if you need custom CMake options.
4. (Optional) Create a macOS application bundle (can be signed if you have a Developer ID):
   ```bash
   export CODECERT="your.developer@apple.id"   # optional
   ./packaging/macosx/3_make_hb_ansel_package.sh
   ```
   The bundle is generated at `install/package/Ansel.app`.
5. (Optional) Generate a DMG image from the bundle:
   ```bash
   ./packaging/macosx/4_make_hb_ansel_dmg.sh
   ```
   The output is `Ansel-<version>-<arch>.dmg` in the `install/` directory.

### Running the build

- Development install (after step 3):
  ```bash
  ./install/bin/ansel
  ```
- From the app bundle (after step 4):
  ```bash
  ./install/package/Ansel.app/Contents/MacOS/ansel --configdir ~/.config/ansel --cachedir ~/.cache/ansel/
  ```

### Notes and limitations

- The DMG is not notarized. If Gatekeeper blocks it, remove the quarantine attribute:
  ```bash
  xattr -d com.apple.quarantine Ansel-*.dmg
  ```
- The DMG is only guaranteed to run on the same macOS version it was built on.
- Homebrew package versions define the library versions bundled into the app.

## MacPorts method (legacy, Intel-only)

A legacy Intel-only method using MacPorts exists in `packaging/macosx/BUILD.txt`. It includes custom patches for `exiv2`, `gnutls`, and `gtk-osx-application`, and uses `gtk-mac-bundler` to produce a DMG. Use this only if you specifically need a MacPorts-based build.
