---
title: Install on Linux
date: 2022-12-11
lastmod: 2023-06-16
draft: false
weight: 10
---

## Prerequisites

Install your GPU OpenCL drivers if you have a GPU :
- for __Nvidia__ GPUs, OpenCL support is part of the CUDA proprietary driver and is not available with the open-source _Nouveau_ driver:
	- [add Nvidia's repository to your package manager](https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html#package-manager-installation),
	- [install the CUDA packages](https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html#driver-installation),
	- reboot.
	- __It is highly discouraged to manually install drivers through [runfiles (.run)](https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html#runfile-installation) as it is riddled with problems you will need to manually fix everytime the Linux kernel is updated__.
- for __AMD__ GPUs, the [AMDGPU-Pro](https://www.amd.com/en/support/kb/faq/amdgpu-installation) driver is recommended:
	- [download the relevant driver](https://www.amd.com/en/support),
	- [extract the archive](https://www.amd.com/en/support/kb/faq/amdgpu-installation#faq-Prerequisites),
	- run the installation script:
		- if you want only the OpenCL driver, without video drivers and OpenGL (assuming your system already has some of those working): `./amdgpu-pro-install -y --opencl=pal,legacy --headless`,
		- if you want the complete GPU stack (OpenCL/OpenGL, Vulkan, video drivers): `./amdgpu-pro-install -y --opencl=pal,legacy`è
	- reboot.
- for __Intel__ embedded GPUs, the _Neo_ driver provides support for OpenCL 3.0 on relatevly recent
	- [official driver releases](https://github.com/intel/compute-runtime/releases/latest) contain the Ubuntu `.deb` packages, you need to install `intel-opencl-icd_xxxx.deb`,
	- the safest way is to locate the `intel-opencl-icd` package in your distribution's repository, and install it. It can be part of optional or third-party repositories for distributions leaning a bit too hard toward open-sourcery (Debian/Fedora).


If you don't have a GPU, a manual build is recommended to get the best performance possible (see below).

For a better GUI, install [Roboto fonts](https://fonts.google.com/specimen/Roboto). It is available as a package in most distributions. It has been chosen because it is clean, designed for software GUI and supports 311 languages, including extended Latin, Cyrillic and Greek alphabets.

## AppImage package (recommended)

The Ansel project provides an official AppImage package, built for the stable channel, every night at 00:00 UTC. This is the recommended way of installing Ansel, since it is fresh from the repository, always up-to-date, contains all necessary libraries and dependencies at their proper version, and ships updated lens databases for Lensfun.

The AppImage is build on an Ubuntu 18.04 machine, which is old enough to support most currently-running Linux distributions.

### Prerequisites

- Install [Fuse2](https://docs.appimage.org/user-guide/troubleshooting/fuse.html),
- Ensure your Linux distribution runs at least `libc`/`glibc` version 2.27, that is :
	- Ubuntu ≥ 18.04,
	- Fedora ≥ 28,
	- Debian ≥ Buster,
	- OpenSuse Leap ≥ 15.3.

In practice, most Linux distributions released after 2018 and all distributions released after 2021 are good to go.

### Downloads

- [Get the latest AppImage](https://nightly.link/aurelienpierreeng/ansel/workflows/lin-nightly/master/ansel.stable.AppImage.zip),
- [Find earlier AppImage packages](https://github.com/aurelienpierreeng/ansel/releases/tag/v0.0.0).

This will most likely put the AppImage package into your `~/Downloads` folder, you may want to move it to a dedicated folder like `~/bin`, into your personal directory.[^1]

[^1]: The `~/bin` folder is natively supported by [appimaged](https://github.com/AppImageCommunity/appimaged).

### Run the AppImage

- [Give it execution permission](https://discourse.appimage.org/t/how-to-run-an-appimage/80/4).
- Either double-click on the AppImage file from your file browser or launch `./Ansel-xxxx-x86_64.AppImage` in terminal.

To create a system shortcut and have Ansel accessible from your dash/app menu, you can use [AppImageLauncher](https://assassinate-you.net/posts/2020/09/appimagelauncher-2.2.0-released/), available as `.deb`, `.rpm` and `.AppImage` packages ([download](https://github.com/TheAssassin/AppImageLauncher/releases/tag/v2.2.0)). It will integrate the AppImage with your desktop environment with or without running extra services in background, upon request, and can update the Ansel AppImage.

### Update the AppImage

Automatic updates are not available at this point, you may use [AppImageUpdate](https://github.com/AppImageCommunity/AppImageUpdate) to update the Ansel AppImage. The benefit of this method is to allow incremental updates, avoiding to re-download a ~95 MB file every time.

### Caveats

Though the Lensfun database of lens profiles is stored and up-to-date in the AppImage package, if you [installed a custom Lensfun database](lensfun‑update-data) at some point in your home directory (usually, by running the command `lensfun‑update-data`), this database can take precedence over the one shipped in the AppImage.

If you note that a relatively-new lens supposed to be supported by Lensfun doesn't appear to be supported in the [lens correction module](../modules/processing-modules/lens-correction.md), either run the `lensfun-update-data` command again, or simply delete the local database, usually located in `~/.local/share/lensfun/updates`.

## Packages from Linux distributions repositories

Pre-built packages are provided by third-party maintainers, may not be up-to-date and may be compiled with some optional features disabled and other distro-centric customizations. They are outside of the scope of the Ansel project and no support is offered. They are mentionned here for what they are worth.

 - [Arch Linux Repository (AUR)](https://aur.archlinux.org/packages/ansel-git).

## Building from source code manually

Building manually ensures that the software uses all available optimizations for your particular hardware, while using the pre-built package uses generic optimizations that fit all modern 64 bits architectures. Depending on the modules you use and on your CPU, you may experience a 25-30 % speed-up by using a manual build taylored for your hardware, when not using OpenCL.

When using OpenCL, the GPU code is compiled for your particular hardware whether you use a pre-built package, the AppImage or a manual build, so it will make no difference for OpenCL-ready modules, but not all modules have an OpenCL variant and many parts of the software run on CPU (like the picture codecs).

### Prerequisites

- Install `git` through your package manager,
- In a terminal, run :
```bash
$ git clone --depth 1 https://github.com/aurelienpierreeng/ansel.git
$ cd ansel
$ git submodule init
$ git submodule update
```
- Install the dependency packages (see below).

### Dependencies

The most daunting part of the process is to chase all the dependencies required by the software to build, through the package manager of your distribution. For Ubuntu 18.04, you can launch:

```bash
$ sudo apt-get -y install \
	build-essential \
	appstream-util \
	desktop-file-utils \
	gettext \
	gdb \
	intltool \
	libatk1.0-dev \
	libavifile-0.7-dev \
	libcairo2-dev \
	libcolord-dev \
	libcolord-gtk-dev \
	libcmocka-dev \
	libcups2-dev \
	libcurl4-gnutls-dev \
	libexiv2-dev \
	libimage-exiftool-perl \
	libgdk-pixbuf2.0-dev \
	libglib2.0-dev \
	libgraphicsmagick1-dev \
	libgtk-3-dev \
	libheif-dev \
	libjpeg-dev \
	libjson-glib-dev \
	liblcms2-dev \
	liblensfun-dev \
	liblensfun-bin \
	liblensfun-data-v1 \
	liblensfun1 \
	liblua5.3-dev \
	libgmic-dev \
	libopenexr-dev \
	libopenjp2-7-dev \
	libosmgpsmap-1.0-dev \
	libpango1.0-dev \
	libpng-dev \
	libportmidi-dev \
	libpugixml-dev \
	librsvg2-dev \
	libsaxon-java \
	libsecret-1-dev \
	libsoup2.4-dev \
	libsqlite3-dev \
	libtiff5-dev \
	libwebp-dev \
	libx11-dev \
	libxml2-dev \
	libxml2-utils \
	ninja-build \
	perl \
	po4a \
	python3-jsonschema \
	xsltproc \
	zlib1g-dev
```

For other operating systems, unfortunately the names of packages may change slightly. When you run the build script (see below), if a dependency is not found, the configuration will abort with a message stating which dependency is missing, for example:

```bash
-- Could NOT find WEBP (missing: WEBP_LIBRARY WEBP_INCLUDE_DIR) (Required is at least version "0.3.0")
CMake Error at /usr/share/cmake-3.10/Modules/FindPackageHandleStandardArgs.cmake:137 (message):
Could NOT find LENSFUN (missing: LENSFUN_LIBRARY LENSFUN_INCLUDE_DIR)
```

The first error tells us the WEBP library was found but its version is too old (older than 0.3.0), the second tells us the LENSFUN library is not found at all. You need to use your package manager to find out what package provides the development libraries of these software, which typically have names ending in `-dev` on Ubuntu/Debian and `-devel` on Fedora/RedHat. So we would need to install `lensfun-devel` on Fedora or `liblensfun-dev` on Ubuntu, then retry a compilation.

Note that optional dependencies don't make the script abort when they are not found, but will disable the corresponding features. You need to read the build script output to find out if everything works as you expect it.

{{< warning >}}
Fedora (and possibly other distributions) builds the Exiv2 library (required by Ansel to read image metadata) without the ISOBMFF support. Since Canon CR3 raw files are ISOBMFF containers, this makes Ansel built on Fedora unable to open .CR3 files. You will need to build Exiv2 yourself too (see below).
{{</ warning >}}

### Compile the application

#### Easy way

From the source code directory, you need to invoke the build script as follow:

```bash
$ sh build.sh --install --sudo --clean-all
```

This will:

- cleanup any remnant of a previous Ansel build and installation (avoiding weird corner-cases),
- build the software with the most aggressive level of optimizations for your particular hardware (the produced binary will not be portable to another hardware),
- install the software in `/opt/ansel`
- install a system-wide command `ansel` that can be invoked in a terminal,
- install a system-wide desktop launcher,
- update Lensfun database of lenses profiles.

To enable less-aggressive optimizations (if you discover picture artifacts) and install the software somewhere else, use:

```bash
$ sh build.sh --prefix /opt/YOUR/PATH --build-type RelWithDebInfo --install --sudo --clean-all
```

Invoke `sh build.sh --help` for a complete overview of available options. In most cases, you can skip `--clean-all` for a faster build (so it does not rebuild from scratch), but that can cause inconsistencies sometimes, and spotting those is a lot more time-consuming than simply rebuilding from scratch.

#### Custom way

If you don't have a good reason to do that, don't, and use the previous method.

```bash
$ cd ansel
$ mkdir build
$ cd build
$ export CXXFLAGS="-O3 -fno-strict-aliasing"
$ export CFLAGS="$CXXFLAGS"
$ cmake .. -DCMAKE_INSTALL_PREFIX=/usr -G Ninja -DCMAKE_BUILD_TYPE=Release -DBINARY_PACKAGE_BUILD=ON -DCMAKE_INSTALL_LIBDIR=lib64
$ sudo cmake --build . --target install -- -j 8
```

### Run the self-built application

You can run `ansel` or `/opt/ansel/bin/ansel` from the terminal, or use your applications menu to locate Ansel.

### Update the self-built application

You can run the build script above with the extra argument `--update` like:

```bash
$ sh build.sh --install --sudo --clean-all --update
```

The caveat is this will update the source code except the build script itself, which may cause issues if the build script was modified (but that rarely happens). To overcome this, you can execute the script twice, or update manually with:

```bash
$ cd ansel
$ git pull --recurse-submodules
```

Then run the building script above, same as when you installed.

### Caveats

If you need to build Exiv2 yourself, either because the version provided by your distribution is too old, or it is built without ISOBMFF support and therefore does not support Canon CR3, here is the sequence of commands to input in terminal:

```bash
$ git clone https://github.com/Exiv2/exiv2.git
$ cd exiv2
$ git checkout 0.27-maintenance
$ cmake -B build -G Ninja -DEXIV2_ENABLE_XMP=ON -DEXIV2_ENABLE_BMFF=ON
$ ninja -C build
$ sudo ninja -C build install
```

It appears that most Linux distributions provide outdated Lensfun databases (even though the binary is up-to-date), so you may want to update it: `sudo lensfun-update-data`

## Containers and sandboxes (Docker, Kubernetes, Windows Subsystem for Linux, etc.)

Ansel is a front-end desktop application that needs a CMS (_Color Management System_) having direct access to the GPU (graphic processor).

Indeed, even if you don't use OpenCL hardware acceleration, display color profiles (`.icc` and `.icm`) often contain an "hardware" calibration tagged VCGT (_Video Card Gamma Table_) that typically calibrates the gamma and white point of the screen. This VCGT is directly pushed to a special memory onto the GPU, used to color-correct the whole screen framebuffer, whether or not individual applications are actually color-managed internally.

Internally color-managed applications may then apply a second round of color correction, aiming at converting standard RGB spaces to the display RGB space (typically through a matrix conversion). The correctness of this second round is subjected to the correctness of the first round: the VCGT.

This design is of course terrible, because different parts of the OS (operating system) can compete for access to the VCGT (most obvious example: the redshift apps adjusting the color temperature of your screen depending of the time of day, as to reduce blue light at night and help sleep), and overwrite it at different times, making the VCGT unreliable and unpredictable.

When using containers and sandboxed environments like Docker, or WSL2, there is no way of knowing how the framebuffer will be color-corrected, that is no way of knowing what part of the pipeline (host OS or container) will get the last say over what happens in the VCGT. These systems have been designed to run text-based and server-side applications, image production applications have never been a goal.

__It is highly discouraged to try and run Ansel in Docker/Kubernetes containers or in the Windows Subsystem for Linux as these have no way of ensuring color traceability.__

## 32 bits platforms, Raspberry Pi and non-conventional platforms

Though the support for 32 bits platforms was officially dropped as of Darktable 2.2, some people have reported to be able to install later Darktable versions (so possibly Ansel) on them. Similarly, people have reported successful installations of Darktable on Raspberry Pi which, despite being a 64 bits platform, doesn't nearly have sufficient power to process 24 to 52 Mpx images.

Users are hereby discouraged from trying to install Ansel on anything else than a typical x86_64 desktop computer. Ansel uses heavy image processing and being able to install and start the software on some weak hardware doesn't imply the runtimes will be bearable in a production environment.
