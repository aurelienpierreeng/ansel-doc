---
title: Possible problems & solutions
date: 2022-12-04T02:19:02+01:00
id: problems-solutions
weight: 50
draft: false
author: "people"
---

Ansel will detect OpenCL run-time errors automatically. On detecting an error, it will then reprocess everything on the CPU. While this will slow down processing it should not affect the end result.

There can be various reasons why OpenCL might fail during the initialization phase. OpenCL depends on hardware requirements and on the presence of certain drivers and libraries. In addition all these have to fit in terms of maker, model and revision number. If anything does not fit (e.g. your graphics driver -- loaded as a kernel module -- does not match the version of your `libOpenCL.so`) OpenCL support will likely not be available.

In this case, the best thing to do is start Ansel from a console with `Ansel -d opencl`.

This will give additional debugging output about the initialization and use of OpenCL. First, if you find a line that starts with `[opencl_init] FINALLY ...` that should tell you whether OpenCL support is available for you or not. If initialization failed, look at the messages above for anything that reads like `could not be detected` or `could not be created`. Check if there is a hint about where it failed.

Here are a few cases that have been observed in the past:

- Ansel states that no OpenCL aware graphics card is detected or that the available memory on your GPU is too low and the device is discarded. In that case you might need to buy a new card if you really want OpenCL support.

- Ansel finds your `libOpenCL.so` but then tell you that it couldn't get a platform. NVIDIA drivers will often give error code -1001 in this case. This happens because `libOpenCL.so` is only a wrapper library. For the real work further vendor-specific libraries need to be loaded. This has failed for some reason. There is a structure of files in `/etc/OpenCL` on your system that `libOpenCL.so` consults to find these libraries. See if you can find something fishy in there and try to fix it. Often the required libraries cannot be found by your system's dynamic loader. Giving full path names might help.

- Ansel states that a context could not be created. This often indicates a version mismatch between the loaded graphics driver and libOpenCL. Check if you have left-over kernel modules or graphics libraries from an older installation and take appropriate action. When in doubt, perform a clean reinstall of your graphics driver. Sometimes, immediately after a driver update, the loaded kernel driver does not match the newly installed libraries. In this case reboot your system before trying again.

- Ansel crashes during startup. This can happen if your OpenCL setup is completely broken or if your driver/library contains a severe bug. If you can't fix it, you can still use Ansel with option `--disable-opencl`, which will skip the entire OpenCL initialization step.

- Ansel fails to compile its OpenCL source files at run-time. In this case you will see a number of error messages looking like typical compiler errors. This could indicate an incompatibility between your OpenCL implementation and Ansel's interpretation of the standard. In that case please raise an issue on [github](https://github.com/darktable-org/darktable/issues/new/choose) and we will try to assist. Please also report if you see significant differences between CPU and GPU processing of an image.

## When the GPU result differs from the CPU result

The cases above are about OpenCL failing to start. A rarer and more confusing situation is
OpenCL starting perfectly and then producing *different pixels* from the CPU. Ansel computes the
same thing either way, so a visible difference means something below Ansel is not doing the
arithmetic it claims.

The usual culprit is the accuracy of the graphics driver's own math library. Ansel used to ask
its kernels to be compiled with `-cl-unsafe-math-optimizations`, an option that allows a driver
to substitute an approximate implementation for any standard mathematical function. Most drivers
do this harmlessly. Some do not: on Intel integrated graphics, that option makes `erf()` return
exactly zero for small arguments and `pow()` wrong by tens of percent, which visibly corrupted
the [AI raw denoise](../../../views/darkroom/modules/ai-raw-denoise.md) module and,
to a lesser degree, anything using gamma curves.

Current versions no longer request that option, for any vendor. **However, updating Ansel is not
enough to fix an affected installation.** The kernel compilation options are stored per device in
`Anselrc`, written the first time a device is seen and never overwritten afterwards, so an old
setting survives an upgrade. Look for:

```
cldevice_v4/<number>/<device-name>/building=...
```

If the value still contains `-cl-fast-relaxed-math` or `-cl-unsafe-math-optimizations`, replace
it with:

```
cldevice_v4/<number>/<device-name>/building=-cl-mad-enable -cl-no-signed-zeros
```

then delete the compiled kernel cache so the kernels are rebuilt with the new options:

```
rm -rf ~/.cache/ansel/cached_kernels_for_*
```

Deleting the whole `building` line works too — Ansel will rewrite it with its current default.

Two tools help you decide whether this applies to you. `tools/opencl-math-accuracy.c` in the
Ansel sources is a small standalone program (it does not link against Ansel) that scores every
OpenCL device on your machine, under every combination of compilation options, against a
high-precision reference, and prints the exact `Anselrc` line for any device that needs one. And
[`Ansel-nn-parity`](../../../cli/ansel-nn-parity.md) checks the neural denoiser
specifically, telling you whether the CPU, the GPU or neither is the one disagreeing.

A few on-CPU implementations of OpenCL also exist, coming as drivers provided by INTEL or AMD. We have observed that they do not provide any speed gain versus our hand-optimized CPU code. Therefore Ansel simply discards these devices by default. This behavior can be changed by setting the configuration variable `opencl_use_cpu_devices` (in `$HOME/.config/Anselrc`) to `TRUE`.
