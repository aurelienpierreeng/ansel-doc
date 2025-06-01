---
title: Install on Windows
date: 2022-12-11
lastmod: 2023-06-22
draft: false
weight: 20
---

## Prerequisites

Install your OpenCL GPU drivers if you have a GPU.

On Windows 11, it seems that the system OpenCL drivers for Intel embedded GPU cause issues (black images), especially with newer generation CPU. You may want to [remove Windows drivers](https://community.intel.com/t5/OpenCL-for-CPU/uninstall-Intel-OpenCL/m-p/1134032#M5756) and [install Intel ones](https://www.intel.com/content/www/us/en/developer/articles/tool/opencl-drivers.html#proc-graph-section).

See the [caveats section below](#caveats) for more details.

## EXE package (recommended)

The Ansel project provides an official `.exe` package, built for the stable, pre-release and experimental channels. This is the recommended way of installing Ansel, since it is fresh from the repository, always up-to-date and ships updated lens databases for Lensfun.

### Downloads

- [Get the latest EXE package](https://nightly.link/aurelienpierreeng/ansel/workflows/win-nightly/master/ansel.stable.win64.zip)
- [Find earlier EXE packages](https://github.com/aurelienpierreeng/ansel/releases/tag/v0.0.0).

## Building from source code manually

- Step 1:  Install MSYS2 (instructions and prerequisites can be found on the official website: https://www.msys2.org)
- Step 2:  Using the MSYS terminal - Update the base system until no further updates are available by repeating:
  ```bash
  $ pacman -Syu
  ```
- Step 3:  Using the MSYS terminal - Install x64 developer tools, x86_64 toolchain and git:
  ```bash
  $ pacman -S --needed base-devel intltool git
  $ pacman -S --needed mingw-w64-ucrt-x86_64-{toolchain,cmake,ninja,nsis,autotools}
- Step 4:  Using the MSYS terminal - Install required libraries and dependencies for Ansel:
  ```bash
  $ pacman -S --needed mingw-w64-ucrt-x86_64-{exiv2,lcms2,lensfun,dbus-glib,openexr,sqlite3,libxslt,libsoup,libavif,libheif,libwebp,libsecret,lua,graphicsmagick,openjpeg2,gtk3,pugixml,libexif,osm-gps-map,drmingw,gettext,python3,iso-codes,python-jsonschema,python-setuptools}
  ```
- Step 5:  (Optional)  Using the MSYS terminal - Install optional libraries and dependencies:

  - for cLUT
    ```bash
    $ pacman -S --needed mingw-w64-ucrt-x86_64-gmic
    ```
  - if you plan and developing, install the unit-tests library
    ```bash
    $ pacman -S --needed mingw-w64-ucrt-x86_64-cmocka
    ```
- Step 6:  Using the UCRT64 terminal - Update your lensfun database:
  ```bash
  $ lensfun-update-data
  ```

{{< note >}}
MSYS will initialize a personal Unix-like `/home` folder, by default located in `C:\\msys64\home\USERNAME` where `USERNAME` is your current Windows username. If your username contains non-latin characters, like accentuated letters, the clashes between Windows encoding and Linux encoding will make the compilation fail on directory pathes issues. In that case, create a new directory in `C:\\msys64\home\USERNAME_WITHOUT_ACCENTS`, and in the MSYS terminal, do `cd /home/USERNAME_WITHOUT_ACCENT`.
{{</ note >}}

- Step 7:  Using a text editor, eg. MS Notepad - Modify the `.bash_profile` file in your `$HOME` directory and add the following lines:
  ```bash
  # Added as per http://wiki.gimp.org/wiki/Hacking:Building/Windows
  export PREFIX="/ucrt64"
  export LD_LIBRARY_PATH="$PREFIX/lib:$LD_LIBRARY_PATH"
  export PATH="$PREFIX/bin:$PATH"
  ```
- Step 8:  By default CMake will only use one core during the build process. To speed thingsup, using a text editor, eg. MS Notepad, you might wish to add a line like:
  ```bash
  export CMAKE_BUILD_PARALLEL_LEVEL="8"
  ```
  to your `~/.bash_profile` file. This would use 8 cores.
- Step 9:  Using the UCRT64 terminal - Execute the following command to activate profile changes:
  ```bash
  $ . .bash_profile
  ```
- Step 10:  Using the UCRT64 terminal - Clone the Ansel git repository (in this example into `~/ansel`):
  ```bash
  $ cd ~
  $ git clone --depth 1 https://github.com/aurelienpierreeng/ansel.git
  $ cd ansel
  $ git submodule init
  $ git submodule update
  ```
- Step 11:  Using the UCRT64 terminal - Build and install Ansel:
  - Variant 1: __with all contextual optimizations enabled for your hardware__:
    ```bash
    $ mkdir build
    $ cd build
    $ cmake -G Ninja -DCMAKE_BUILD_TYPE=Release -DBINARY_PACKAGE_BUILD=OFF -DCMAKE_INSTALL_PREFIX=/opt/ansel ../.
    $ cmake --build .
    $ cmake --install .
    ```
    After this, Ansel will be installed in `/opt/ansel` directory and can be started by typing `/opt/ansel/bin/ansel.exe` in MSYS2 UCRT64 terminal.
  - Variant 2: __with only generic optimizations and producing an installable EXE package__:
    ```bash
    $ mkdir build
    $ cd build
    $ cmake -G Ninja -DCMAKE_BUILD_TYPE=Release -DBINARY_PACKAGE_BUILD=ON -DCMAKE_INSTALL_PREFIX=/opt/ansel ../.
    $ cmake --build . --target package
    $ cmake --install .
    ```
    After this, you will need to double-click and install the `ansel.exe` found in the `build/bin` folder. This package will be portable and be installable on other platforms.

## Caveats

### Starting in command line (with arguments)

In some situations, you will need to start Ansel in command line, with arguments modifying its default behaviour, to test or debug issues:

1. if you built yourself, start the MSYS2 MINGW64 terminal (from the applications menu), and execute `/opt/ansel/bin/ansel.exe`,
2. if you installed from the EXE package, open the Windows terminal (`cmd.exe`) and execute `"C:\Programs Files\ansel\bin\ansel"` (assuming you installed Ansel in the default directory, suggested by the installer).

For example, if you note issues with OpenCL, you could start Ansel with OpenCL entirely disabled using `"C:\Programs Files\ansel\bin\ansel" --disable-opencl`.

The caveat though is the debugging commands (`-d OPTION`) don't output messages to the terminal, as they do on Unix, because of issues with Windows. Instead, the output will be written in an `ansel-log.txt` text file, in your cache directory. Start the help of the software ( runing `"C:\Programs Files\ansel\bin\ansel" -h`), and the last line should tell you where the file will be located after the line `note: debug log and output will be written to this file: PATH`. Typically, it should be `C:\Users\USERNAME\AppData\Local\Microsoft\Windows\INetCache\ansel` on Windows 10.

### OpenCL

Darktable blacklists all Intel OpenCL drivers to prevent issues, because of an history of bad drivers. In practice, since Intel Neo, things are better and reasonably-old Intel platforms are well supported, so the blacklist is removed on Ansel. OpenCL issues (typically: black images) are still regularly reported with brand-new hardware.

If you find yourself in this situation, you have several mitigation options:

0. Try to install a newer or an older version of your GPU driver.
1. If you have a discrete GPU (Nvidia or AMD), you can disable the Intel embedded GPU:
    1. by entirely removing the Intel OpenCL driver (use your software manager to locate it), so Ansel uses only your discrete driver,
    2. by entirely disabling the Intel GPU in Ansel config:
        - locate the `anselrc` text file on your system (typically in `C:\Users\USERNAME\AppData\Local\ansel`),
        - open it and locate the line `cldevice_v4_YOUR_DEVICE=0 250 0 16 16 128 0 0 0.053989` where `YOUR_DEVICE` is the name of your GPU (possibly associated with a driver version),
        - on that line, change the 8th (penultimate) digit from `0` to `1`, so you get `cldevice_v4_YOUR_DEVICE=0 250 0 16 16 128 0 1 0.053989`,
2. Try to change the build options for OpenCL kernels:
    - locate the `anselrc` text file on your system (typically in `C:\Users\USERNAME\AppData\Local\ansel`),
    - open it and locate the line `cldevice_v4_YOUR_DEVICE_building=-cl-fast-relaxed-math` where `YOUR_DEVICE` is the name of your GPU (possibly associated with a driver version), and the options after `=` may be different from this example,
    - clear the building options, so you get `cldevice_v4_YOUR_DEVICE_building=` (nothing after `=`)
3. If you don't have a discrete GPU and the Intel one is your only one:
    1. start the application with OpenCL disabled at all with `COMMAND --disable-opencl` (see the previous section for the actual system command to run, depending on your installation)
    2. disable the Intel GPU in Ansel config (see point 1.2. above)
