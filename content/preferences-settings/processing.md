---
title: processing
date: 2022-12-04T02:19:02+01:00
lastmod: 2023-10-12
id: processing
weight: 70
draft: false
---

Control how images are processed.

## image processing

always use LittleCMS 2 to apply output color profile
: If this option is activated, Ansel will use the LittleCMS 2 system library to apply the output color profile instead of its own internal routines. This is significantly slower than the default but might give more accurate results in some cases.

: If the given ICC is LUT-based or contains both a LUT and a matrix, Ansel will use LittleCMS 2 to render the colors regardless of this parameter's value (default off).

pixel interpolator (warp)
: The pixel interpolator used for rotation, lens correction, liquify, crop and final scaling.

: Whenever we scale or distort an image we have to choose a pixel interpolation algorithm (see [wikipedia](https://en.wikipedia.org/wiki/Image_scaling) for details). For warping modules, Ansel offers bilinear, bicubic or lanczos2. In general, bicubic is a safe option for most cases and is the default value.

pixel interpolator (scaling)
: The pixel interpolator used for scaling. The same options are provided as for the warp modules, but with the addition of lanczos3.

: lanczos3 can cause pixel overshoots leading to artefacts but sometimes gives a more crisp visual appearance. This option is therefore only provided for transforming (scaling) algorithms and is the default value.

3D lut root folder
: Define the root folder (and sub-folders) containing Lut files used by the [_lut 3D_](../views/darkroom/modules/lut-3D.md) module


## CPU, GPU, Memory

### Settings

CPU cores
: Number of CPU cores (physical and virtual) in use. `-1` will use all detected cores (physical and virtual). Depending on your hardware, you may want to try setting this value equal to the number of physical cores of your CPU, which may speed-up memory I/O, since memory transfer usually is our bottleneck in image processing. This will be irrelevant for most users, aside from debugging issues. This value does not affect modules using OpenCL when OpenCL is enabled.

Background workers
: Number of background threads used to process thumbnail rendering pipelines, import, export, etc. Increasing this value will not increase memory usage proportionnaly, because only one pipeline at a time is allowed to run, but it may help hiding filesystem I/O latencies when loading image files. The maximum value here is defined by your operating system, and is typically 1024 or 2048.

Memory headroom for OS/applications (MiB)
: This is the amount of RAM space that Ansel will __never use__, and leave to the operating system and other applications. To set it, you can reboot your computer and open a system monitoring application, then measure how much RAM space the idle OS is using. If you like to play videos or music in background, while retouching in Ansel, you will need to plan for this too and include the RAM usage of your player into this headroom. __Setting this value too low will result in crashes of the application__ because the OS will kill the Ansel process when it reaches RAM saturation.

Memory reserved for lighttable thumbnail cache (MiB)
: This is the amount of RAM space that Ansel will allocate to rendered thumbnails displayed in the [lighttable](../views/lighttable/_index.md) and [filmstrip](../views/toolboxes/filmstrip.md). You should set this value according to the typical number of images you have in a folder and how large they appear in the lighttable :
    - a 360×225 px image uses 0.35 MiB,
    - a 720×450 px image uses 1.24 MiB,
    - a 1440×900 px image uses 5 MiB,
    - a 6000×4000 px image uses 92 MiB
: The default value of 1000 MiB can hold 2800 small thumbnails, or 805 medium thumbnails, or 200 large thumbnails, or 10 images at 24 Mpx full resolution (for full-resolution preview in lighttable).

Maximum RAW resolution to edit
: Set this value to the resolution of your best camera. Ansel will then reserve at all time a sufficient RAM space to hold 4 internal full-resolution buffers, which will be enough to avoid tiling in most modules using intermediate copies (when not using OpenCL).

{{< warning >}}
Ansel uses the total memory available on the system, subtracts the headroom size, the thumbnail cache size, the size of the 4 full-resolution RAW buffers and uses what remains for its pixelpipe cache. This cache is used to store the intermediate output of modules, as to prevent recomputing when not necessary. It will make Ansel RAM consumption increase a lot, which is no issue. The cache will be automatically shrunk if the application has trouble allocating new buffers. However, the operating system will not shrink it itself, so the _memory headroom_ needs to be properly set.
{{< /warning >}}

{{< note >}}
The pixel pipeline cache can be manually emptied using the global menu _Run_ → _Clear pipeline caches_.
{{< /note >}}

Pipe recompute timeout
: When doing value changes on sliders and comboxes, in darkroom [modules](../views/darkroom/modules/_index.md), the changes are sent to the pixel pipeline to re-render the output once every _N_ milliseconds. _N_ is the _pipe recompute timeout_. It will ensure that intermediate value changes (when dragging a cursor) don't trigger a new (computationnaly-expensive) recomputation, at the expense of making the GUI feel more or less _laggy_ or _responsive_. Powerful hardware can tolerate values as low as 50 ms, but weak hardware (or battery mode) may benefit from values as high as 200 ms to spare useless intermediate recomputations.

Enable disk backend for thumbnail cache
: Saves rendered [lighttable](../views/lighttable/_index.md) thumbnails to the disk cache, in the current user's home folder. This will prevent recomputing them on the next startup, but may create privacy issues if you are editing private pictures on a publicly shared computer.

Activate OpenCL support
: Process darkroom [modules](../views/darkroom/modules/_index.md) that support it on the GPU using OpenCL. This option will be available only if an OpenCL driver and device were found on your system.

GPU vRAM headroom (MiB)
: Amount of video RAM that Ansel will __never use__ on the GPU, and leave to other applications using hardware graphics acceleration (OpenGL, Vulkan, VDPAU, CUDA, etc.).

System library with OpenCL runtime
: Ansel will typically detect automatically the OpenCL drivers on your system, so you can leave this option empty. But if you have several conflicting OpenCL libraries, or your runtime is installed in an unusual place, you can define here the path to the OpenCL runtime to load.

### Testing your configuration

- To diagnose OpenCL issues, start `ansel -d opencl`
- To benchmark performance and test different memory configurations, start `ansel -d perf`,
- To diagnose memory and cache size issues, start `ansel -d memory -d cache -d pipe`

## Libraw

Ansel uses the Rawspeed library by default to decode raw image files. Rawspeed is flawlessly integrated in Ansel, but does not support Canon `.CR3` files yet. For this reason, a basic support of Libraw has been implemented such that owners of recent Canon cameras can still decode their files. Libraw also tends to support new formats faster than Rawspeed.

The options of this section allow users to force the use of Libraw for any picture they want, using rules based on file extension and camera/vendor EXIF metadata. The feature is brittle and unsafe in general because we don't check and sanitize every possible flavour of encoding.

Supported files
:  * Canon `.CR3`

Files that seem to be working
:   * Olympus `.ORF`
    * Hasselblad `.3FR`
    * Nikon `.NEF` __non-compressed__

Files that definitely don't work and make the software crash
:   * Nikon sRAW and compressed `.NEF`
    * Phase One `.IIQ`

{{< warning >}}
The library used to decode files is remembered at the application level, globally, not for each file. Editing pictures decoded by Libraw may not produce the exact same result if you revert to Rawspeed in the future. You should really stick to Rawspeed whenever possible.

You are strongly advised to save any edited picture to 16 bits TIFF at full resolution using Rec2020 linear color space as an archival backup of your work, and not rely on the consistency of the non-destructive editing result in the future.
{{</ warning >}}

Raw file extensions to load through Libraw
: case-insensitive, coma-separated list of the file extensions. Default : `cr3`.

Camera models to load through Libraw
: case-insensitive, coma-separated list of the camera models as they appear in the [_Display metadata_](../views/toolboxes/image-information.md) module, under the _model_ field. You may have to enable this field using the preferences of the module if it does not appear in the widget.

Camera makers to load through Libraw
: case-insensitive, coma-separated list of the camera manufacturers as they appear in the [_Display metadata_](../views/toolboxes/image-information.md) module, under the _maker_ field. You may have to enable this field using the preferences of the module if it does not appear in the widget.

{{< note >}}
For Canon files using the `.CR3` format, the _model_ and _maker_ metadata are not decoded properly and left blank. You have to filter them mandatorily by file extension.
{{</ note >}}

To debug this feature : 

1. Start Ansel in command line using `ansel -d imageio`. For each loaded image, it will tell which library was used to decode it,
1. If the settings you input make the software crash at startup, remove the `libraw/extensions`, `libraw/models`, `libraw/makers` configuration keys in the `anselrc` configuration file, located in `~./config/ansel` folder on Linux and Mac, or `APPDATA\.config\ansel` on Windows.
