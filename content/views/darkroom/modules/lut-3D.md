---
title: Lut 3D
date: 2022-12-04T02:19:02+01:00
id: lut-3d
applicable-version: 3.6
tags:
working-color-space: RGB
view: darkroom
masking: true
---

Transform RGB values with a 3D LUT file.

A 3D LUT is a tridimensional table that is used to transform a given RGB value into another RGB value. It is normally used for film simulation and color grading.

This module accepts `.cube`, `.3dl` and `.png` (haldclut) files. Uncompressed 3D LUT data is not saved in the database or the XMP file, but is instead saved to the 3D LUT file path inside the 3D LUT root folder. It is therefore important to back up your 3D LUT folder properly -- sharing an image with its XMP is pointless if the recipient doesn't also have the same 3D LUT file in their own 3D LUT folder.

The compressed G'MIC format `.gmz` **is no longer supported**. If you have `.gmz` files, see [Converting `.gmz` files](#converting-gmz-files) below.

---

**Note**: the module clips all values outside of the range [0,1]. You may have to reduce the range of the input before applying.

---

## Usage

LUTs are most commonly used in Ansel for color grading or film look simulation. For this reason, by default, the module is placed after the [_filmic_](./filmic.md) module in the pixelpipe and should be applied to a neutral image (without first applying a specific look). While you can find hundreds of free LUTs on the internet, you should note that not all of them are compatible with the Ansel environment and workflow -- incompatible LUTs will not produce the advertised look. To limit the risk, a color grading LUT should have been created to work with one of the available "application color spaces" (see below), for both the input and the output of the module.

Camera log LUTs (as F-log or S-Log3) are different to color-grading and film-look-simulation LUTs, and are intended to convert the camera log raw data into something (linear raw data or other color space) that Ansel is able to understand. In this case the _lut 3D_ module should be manually placed between the [_demosaic_](./demosaic) and [_input color profile_](./input-color-profile.md) modules. Once you have done this, you can no longer choose an "application color space". The "input profile" of input color profile module should be aligned with the output of the LUT. _Please note that this use case has not yet been tested._

## Module controls

file selection
: Choose the 3D LUT file to use. File selection is inactive if the 3D LUT root folder has not been defined in [preferences > processing](../../../preferences-settings/processing.md).

application color space
: A 3D LUT is defined relative to a specific color space. Choose the color space for which the selected 3D LUT file has been built. Cube files are usually related to REC.709 while most others are related to sRGB.

interpolation
: This defines how to calculate output colors when input colors are not exactly on a node of the RGB cube described by the 3D LUT. There are three interpolation methods available: tetrahedral (default), trilinear and pyramid. Usually you won't see any difference between interpolation methods except with smaller sized LUTs.

## Converting `.gmz` files

### What changed, and why

Ansel used to read `.gmz`, G'MIC's own compressed LUT container. Support for it has been removed, along with the G'MIC dependency itself.

The reason is proportion. Ansel called exactly three functions from G'MIC — read a `.gmz`, decompress its keypoints, cache the result — and linking those three functions meant linking all of G'MIC: a 7.4 MB shared library that in turn pulls in around fifty more, among them libcurl, OpenSSL, libssh, LDAP, Kerberos and SASL — a complete HTTP and TLS stack, in a photo editor — plus an X11 display stack and G'MIC's own private copies of libpng, libjpeg, libtiff, OpenEXR, WebP and FFTW, duplicating decoders Ansel already links directly. G'MIC also required Ansel to raise the stack size of *every* thread it creates to 2 MiB, and it published its own OpenMP thread count process-wide, which silently overrode Ansel's "CPU cores" preference for anyone who set it.

That was the cost. The benefit, measured over 61 days of anonymous usage statistics: the whole 3D LUT module accounts for 0.2 % of module activations, and `.gmz` is only a fraction of that — most people who use LUTs use `.cube`.

Nor is `.gmz` merely a container that could have been parsed in a few lines. Its keypoints are reconstructed either by a dense radial-basis-function solve or by a multiscale diffusion PDE, both written in G'MIC's own scripting language. Reimplementing and then maintaining two numerical solvers in Ansel, forever, to read a format that ships alongside a `.cube` equivalent, is not a trade worth making.

So the format is deprecated, and converting is a one-off.

### The easy way: download the `.cube` version

Most `.gmz` files in circulation are the G'MIC film-emulation CLUT collections, and **the same collections are published as `.cube`**. Before converting anything, check whether the pack you use offers a `.cube` download — for most people that is the whole procedure.

### Converting with the G'MIC command line

G'MIC's own command-line tool reads `.gmz` and writes `.cube`. Install it:

| Platform | Command |
|---|---|
| Debian / Ubuntu | `sudo apt install gmic` |
| Fedora | `sudo dnf install gmic` |
| Arch | `sudo pacman -S gmic` |
| macOS (Homebrew) | `brew install gmic` |
| Windows | Binaries from [gmic.eu](https://gmic.eu/download.html) |

A `.gmz` can hold a single LUT or a whole library of them, each with a name. This command converts **every** LUT in the file, one `.cube` per LUT, keeping the original names:

```sh
mkdir -p converted
gmic input.gmz foreach { nm={n} decompress_clut 33,33,33 output_cube converted/$nm.cube }
```

Reading it left to right: load the `.gmz`; for each LUT it contains, remember the LUT's name, decompress its keypoints into a 33×33×33 cube, and write that cube out under the remembered name. Capturing `{n}` *before* `decompress_clut` matters — the decompression step replaces the image name with an internal expression, so a naive `output_cube {n}.cube` produces files called things like `(256;0^256;255^256;1).cube`.

`33,33,33` is the output resolution, and 33 is the conventional size for a `.cube`. You can ask for more (`65,65,65`) at the cost of a much larger file and a slower conversion; the keypoints hold no more detail either way, so this only changes how finely the reconstruction is sampled.

For a single-LUT file where you do not care about the name, the short form is enough:

```sh
gmic input.gmz decompress_clut 33,33,33 output_cube output.cube
```

Decompression is not instant — it is solving a scattered-data interpolation problem — so expect a few seconds per LUT.

### Converting with the GIMP plugin

If you would rather not use a terminal, the G'MIC-Qt plugin for GIMP can do it: open the `.gmz`, and in the CLUT filters set the output mode to *Save CLUT as .cube or .png File*.

### Afterwards, in Ansel

Put the converted `.cube` files in your 3D LUT root folder (set in [preferences > processing](../../../preferences-settings/processing.md)), then select the LUT again in the module. The result is identical: the `.cube` holds the same reconstructed LUT that Ansel used to compute from the `.gmz` on every load, so this is also slightly faster to open.

Existing edits that referenced a `.gmz` **will not be silently altered**. Ansel detects them and applies no LUT at all, rather than guessing; in the darkroom you get a dialog naming the file, and elsewhere a line in the log identifying the image. Those edits need the LUT re-selected once, pointing at the converted `.cube`.

This applies as well to edits made with a much older version, which stored the compressed LUT data *inside* the edit rather than referencing a file. Ansel recognises those too, and the remedy is the same.
