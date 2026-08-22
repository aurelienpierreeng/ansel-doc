---
title: Install on Windows
date: 2022-12-11
lastmod: 2026-02-16
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
- Step 3:  Using the UCRT64 terminal - Clone the Ansel git repository (in this example into `~/ansel`):
  ```bash
  $ cd ~
  $ git clone --depth 1 https://github.com/aurelienpierreeng/ansel.git
  $ cd ansel
  $ git submodule init
  $ git submodule update
  ```
- Step 4:  Using the UCRT64 terminal - Install all build dependencies using the script from the repository:
  ```bash
  $ ./packaging/install-deps-windows-msys2.sh
  ```
- Step 5:  Using the UCRT64 terminal - Update your lensfun database:
  ```bash
  $ lensfun-update-data
  ```

{{< note >}}
MSYS will initialize a personal Unix-like `/home` folder, by default located in `C:\\msys64\home\USERNAME` where `USERNAME` is your current Windows username. If your username contains non-latin characters, like accentuated letters, the clashes between Windows encoding and Linux encoding will make the compilation fail on directory pathes issues. In that case, create a new directory in `C:\\msys64\home\USERNAME_WITHOUT_ACCENTS`, and in the MSYS terminal, do `cd /home/USERNAME_WITHOUT_ACCENT`.
{{</ note >}}

- Step 6:  Using a text editor, eg. MS Notepad - Modify the `.bash_profile` file in your `$HOME` directory and add the following lines:
  ```bash
  # Added as per http://wiki.gimp.org/wiki/Hacking:Building/Windows
  export PREFIX="/ucrt64"
  export LD_LIBRARY_PATH="$PREFIX/lib:$LD_LIBRARY_PATH"
  export PATH="$PREFIX/bin:$PATH"
  ```
- Step 7:  By default CMake will only use one core during the build process. To speed things up, using a text editor, eg. MS Notepad, you might wish to add a line like:
  ```bash
  export CMAKE_BUILD_PARALLEL_LEVEL="8"
  ```
  to your `~/.bash_profile` file. This would use 8 cores.
  
- Step 8:  Using the UCRT64 terminal - Execute the following command to activate profile changes:
  ```bash
  $ . .bash_profile
  ```
- Step 9:  Using the UCRT64 terminal - Build and install Ansel:
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

## Building with AddressSanitizer (ASan)

[AddressSanitizer](https://github.com/google/sanitizers/wiki/AddressSanitizer) is a compiler instrumentation that catches memory bugs (use-after-free, heap buffer overflows, double-free, etc.) at the exact moment they happen, with the offending line of code and both the allocation and the faulty-access call stacks. This is invaluable for chasing a crash that otherwise only shows up much later, or not at all, in a normal build — typically, a heap corruption that Windows only notices (and reports as an opaque address) the next time it happens to touch the damaged memory, long after the actual bug.

This is a debug build, meant for hunting a specific bug, not for daily use: keep it in its own prefix, separate from your normal install.

### 1. Install a suitable Clang toolchain

MSYS2's own UCRT64 Clang does not ship an ASan runtime for the `x86_64-w64-mingw32` target (only `builtins`/`fuzzer`/`profile` are provided, no `asan_*`). [llvm-mingw](https://github.com/mstorsjo/llvm-mingw) is a separate, prebuilt Clang distribution that does include it.

- Download the latest `llvm-mingw-<date>-ucrt-x86_64.zip` from the [llvm-mingw releases page](https://github.com/mstorsjo/llvm-mingw/releases).
- Extract it under `/opt`, e.g. so that `/opt/llvm-mingw-<date>-ucrt-x86_64/bin/clang++.exe` exists.

{{< note >}}
This is a separate toolchain from the one used for a normal build: it is only ever referenced explicitly, below, through `CC`/`CXX`, so it cannot affect a normal build.
{{</ note >}}

### 2. Create the compiler wrappers

llvm-mingw's Clang bundles its own libc++, which is what its ASan runtime is built to work with — but it does not know about MSYS2's own layout, and mixing it with MSYS2's headers/libraries (unavoidable, since Ansel links against MSYS2-built GTK, glib, etc.) causes two separate problems: a `<math.h>`/`isnan`/`signbit` macro clash against libc++'s own headers, and llvm-mingw's Clang defaulting to a C++ standard library (libc++) that is not the one the rest of the build actually links against (MSYS2's own libstdc++). Two small wrapper scripts route it to MSYS2's libstdc++ instead, and add the search paths llvm-mingw has no reason to know about on its own.

Adjust the GCC version in the paths below (`15.2.0`) to whatever `ls /ucrt64/include/c++/` reports on your system.

Create `/opt/llvm-mingw-<date>-ucrt-x86_64/bin/clang-mingwlib.cmd`:

```bat
@echo off
REM C compiler wrapper: makes bare -lname libraries that live under MSYS2 ucrt64's lib
REM dir (e.g. -lexchndl, DrMingw's crash handler) resolvable, since llvm-mingw's own
REM clang.exe has no reason to know that directory exists otherwise.
"%~dp0clang.exe" -L C:/msys64/ucrt64/lib -Wno-unused-command-line-argument %*
```

Create `/opt/llvm-mingw-<date>-ucrt-x86_64/bin/clang++-libstdcxx.cmd`:

```bat
@echo off
REM C++ compiler wrapper: use MSYS2 ucrt64's libstdc++ instead of llvm-mingw's bundled
REM libc++ (which clashes with mingw-w64's macro-based isnan/signbit in <math.h> once
REM GTK/glib's own -I flags pull that math.h in ahead of libc++'s own). The -Wno-*
REM flags silence GCC-only header attributes/extensions/builtins Clang either doesn't
REM know or evaluates differently -- harmless as plain warnings, but this build uses
REM CMAKE_BUILD_TYPE=Debug, which turns on -Werror.
"%~dp0clang++.exe" -stdlib=libstdc++ ^
  -isystem C:/msys64/ucrt64/include/c++/15.2.0 ^
  -isystem C:/msys64/ucrt64/include/c++/15.2.0/x86_64-w64-mingw32 ^
  -L C:/msys64/ucrt64/lib ^
  -Wno-invalid-constexpr -Wno-unused-command-line-argument ^
  -Wno-unknown-attributes -Wno-keyword-compat -Wno-deprecated-builtins ^
  -Wno-inline-namespace-reopened-noninline -Wno-unknown-warning-option -Wno-user-defined-literals ^
  %*
```

### 3. Build

Using the UCRT64 terminal, from the Ansel source directory:

```bash
$ export CC=/opt/llvm-mingw-<date>-ucrt-x86_64/bin/clang-mingwlib.cmd
$ export CXX=/opt/llvm-mingw-<date>-ucrt-x86_64/bin/clang++-libstdcxx.cmd
$ export CFLAGS="-fsanitize=address -fno-omit-frame-pointer"
$ export CXXFLAGS="-fsanitize=address -fno-omit-frame-pointer"
$ export LDFLAGS="-fsanitize=address"
$ mkdir build_asan
$ cd build_asan
$ cmake -G Ninja -DCMAKE_BUILD_TYPE=Debug -DBINARY_PACKAGE_BUILD=OFF -DCMAKE_INSTALL_PREFIX=/opt/ansel_asan ../.
$ cmake --build .
$ cmake --install .
```

{{< warning >}}
Use `-DCMAKE_BUILD_TYPE=Debug`, not `Release`/`RelWithDebInfo`. The latter enable LTO (`-flto=thin`), which produces bitcode-only `.obj` files this cross-compiler setup cannot reliably link. Debug is also the generally-recommended build type for sanitizers regardless: no optimizer reordering to fight with when reading a stack trace.
{{</ warning >}}

### 4. Copy the ASan runtime DLLs

`ansel.exe` ends up dynamically linked against six DLLs that are not on `PATH` by default. Copy them next to the installed binaries:

```bash
$ cp /opt/llvm-mingw-<date>-ucrt-x86_64/bin/libclang_rt.asan_dynamic-x86_64.dll /opt/ansel_asan/bin/
$ cp /opt/llvm-mingw-<date>-ucrt-x86_64/bin/libc++.dll /opt/ansel_asan/bin/
$ cp /opt/llvm-mingw-<date>-ucrt-x86_64/bin/libunwind.dll /opt/ansel_asan/bin/
$ cp /ucrt64/bin/libstdc++-6.dll /opt/ansel_asan/bin/
$ cp /ucrt64/bin/libgcc_s_seh-1.dll /opt/ansel_asan/bin/
$ cp /ucrt64/bin/libwinpthread-1.dll /opt/ansel_asan/bin/
```

The first three are llvm-mingw's own ASan/libc++/unwind runtimes (the ASan runtime itself depends on `libc++.dll` even though Ansel's own code is built against libstdc++, and Clang defaults to llvm-mingw's own libunwind for exception handling); the last three are libstdc++'s own dependencies.

### 5. Run

```bash
$ ASAN_OPTIONS="alloc_dealloc_mismatch=0:allocator_may_return_null=1:detect_leaks=0:halt_on_error=0" /opt/ansel_asan/bin/ansel.exe --cachedir /opt/ansel_asan_cache --configdir "$HOME/.config/ansel_asan"
```

Reproduce whatever you are chasing, then close Ansel normally. If ASan catches anything, its report is printed directly to the terminal — redirect it to a file (`> ansel_asan.log 2>&1`) if you want to keep a copy.

{{< note >}}
GTK and glib are precompiled MSYS2 DLLs, not built with ASan. A pointer crossing that boundary (allocated on one side, freed on the other) trips a `bad-free` that has nothing to do with whatever you are actually chasing — this fires right at startup, from glib's own type system init, before any Ansel code runs. `halt_on_error=0` logs it and keeps going instead of aborting there; `alloc_dealloc_mismatch=0` and `allocator_may_return_null=1` suppress the same class of cross-allocator false positive elsewhere. This is a limitation of instrumenting one executable in a process otherwise made of non-instrumented DLLs, not a bug in Ansel.
{{</ note >}}

## VS Code setup

To make debugging easier with VS Code, you can use the UCRT64 terminal within the program, which is better suited than the standard Windows terminal. For example, you can use GDB and simply `Ctrl + click` on relevant lines in the debugger output to jump directly to the corresponding line in the code editor.

- To add UCRT64 terminal:
  - Open settings.json
  - Insert this code in the line before the last `}` :

    {{< warning >}} The preceding item must end with a `,` {{</ warning >}}

    ```json 
    "terminal.integrated.profiles.windows": {
      "UCRT64": {
        "path": "C:\\MSYS2\\usr\\bin\\bash.exe",
        "env": {
            "MSYSTEM": "UCRT64",
            "CHERE_INVOKING": "1"},
        "args": [ "--login", "-i"],
      }
    }
    ```

- To make it the default terminal in VS Code:
  - Insert this code in the line before the last `}` :

  {{< warning >}} The preceding item must end with a `,` {{</ warning >}}

  ```json
  "terminal.integrated.defaultProfile.windows": "UCRT64"
  ```

## Caveats

### Starting in command line (with arguments)

In some situations, you will need to start Ansel in command line, with arguments modifying its default behaviour, to test or debug issues:

1. If you built yourself, start the MSYS2 MINGW64 terminal (from the applications menu), and execute `/opt/ansel/bin/ansel.exe`,
2. If you installed from the EXE package, open the Windows terminal (`cmd.exe`) and execute `"C:\Programs Files\ansel\bin\ansel"` (assuming you installed Ansel in the default directory, suggested by the installer).

For example, if you note issues with OpenCL, you could start Ansel with OpenCL entirely disabled using `"C:\Programs Files\ansel\bin\ansel" --disable-opencl`.

The caveat though is the debugging commands (`-d OPTION`) don't output messages to the terminal, as they do on Unix, because of issues with Windows. Instead, the output will be written in an `ansel-log.txt` text file, in your cache directory. Start the help of the software ( runing `"C:\Programs Files\ansel\bin\ansel" -h`), and the last line should tell you where the file will be located after the line `note: debug log and output will be written to this file: PATH`. Typically, it should be `C:\Users\USERNAME\AppData\Local\Microsoft\Windows\INetCache\ansel` on Windows 10.

### OpenCL

Darktable blacklists all Intel OpenCL drivers to prevent issues, because of an history of bad drivers. In practice, since Intel Neo, things are better and reasonably-old Intel platforms are well supported, so the blacklist is removed on Ansel. OpenCL issues (typically: black images) are still regularly reported with brand-new hardware.

If you find yourself in this situation, you have several mitigation options:

0. Try to install a newer or an older version of your GPU driver.
1. If you have a discrete GPU (Nvidia or AMD), you can disable the Intel embedded GPU:
    1. By entirely removing the Intel OpenCL driver (use your software manager to locate it), so Ansel uses only your discrete driver,
    2. By disabling the Intel GPU from within Ansel: open Preferences → Processing → CPU / GPU / memory, find that GPU's section, and switch off its "Enable" checkbox. This only affects that device — your discrete GPU (or the CPU path) keeps working normally, and no file needs editing.
2. Try to change the build options for OpenCL kernels — this one has no equivalent in Preferences yet, so it still needs the config file:
    - Locate the `anselrc` text file on your system (typically in `C:\Users\USERNAME\AppData\Local\ansel`),
    - Open it and locate the line starting with `cldevice_v4/N/YOUR_DEVICE/building=`, where `N` is a small index and `YOUR_DEVICE` is the name of your GPU as reported by its driver. The default value is `-cl-mad-enable -cl-no-signed-zeros`; yours may differ if you already changed it,
    - Clear the building options, so you get `cldevice_v4/N/YOUR_DEVICE/building=` (nothing after `=`)
3. If you don't have a discrete GPU and the Intel one is your only one:
    1. Start the application with OpenCL disabled at all with `COMMAND --disable-opencl` (see the previous section for the actual system command to run, depending on your installation)
    2. Disable the Intel GPU from Preferences (see point 1.2. above)


### Memory allocation

Ansel uses virtual memory pre-allocation for fast memory access. Virtual memory needs to be enabled on your system and the pagefile size required by Ansel should be available on your system. If, at startup, you see errors like :

```bash
couldn't alloc map (VirtualAlloc error 1455)
ERROR: can't init pixelpipe cache, aborting.
```

it means the system refused to allocate the requested memory. This can happen on gamers PC where performance optimizations have been made.

#### Diagnose 

Open Task Manager → Performance → Memory and check `Committed: X / Limit`. `X` is the currently-used virtual memory. If it is close to `Limit` you will have to close applications using it.

#### Fix 

The first approach is to enable or increase the virtual memory on your system. Go to System Properties → Advanced → Performance → Virtual Memory and set pagefile to system managed or several GB.

If this is not enough, the second approach is to reduce Ansel memory consumption. `memory_os_headroom` can be adjusted directly from Preferences → Processing → CPU / GPU / memory, without editing any file. `host_memory_limit` has no equivalent in Preferences yet, so it still needs the config file: open `C:\%LOCALAPPDATA%\ansel\anselrc` with a text editor and locate the lines :

```
host_memory_limit=-1
...
memory_os_headroom=25000
```

When set to `-1` or `0`, `host_memory_limit` detects all the RAM available on your system and will allocate to Ansel `host_memory_limit - memory_os_headroom`. Values are in MiB. To manually control this, you can set `host_memory_limit=4000` (4 GiB) as a starting point, then try allocating more if that works.

{{< note >}}
`memory_os_headroom` is clamped between 1024 (1 GiB) and a third of the RAM Ansel detects: setting it to `0` will not actually leave zero headroom, it will floor to 1024. If you need to go below that, lowering `host_memory_limit` itself is the only way.
{{</ note >}}