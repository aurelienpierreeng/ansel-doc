---
title: Darkroom
date: 2022-12-04T02:19:02+01:00
id: darkroom
weight: 50
draft: false
---

Control functionality in the [darkroom](../views/darkroom/_index.md) view and associated modules.

## General

{{< note >}}
Pen pressure mapping and brush-stroke smoothing for [drawn mask](../views/darkroom/masking-and-blending/masks/drawn.md) brushes are set from the collapsible "Brush options" section directly inside a module's masking & blending panel, next to the brush shape tool.
{{< /note >}}

Invert the direction of the mouse vertical scroll
: By default, scrolling your mouse up increases the value of sliders and of shape parameters in [drawn masks](../views/darkroom/masking-and-blending/masks/drawn.md) alike. Enable this if your OS/desktop environment is configured to scroll the view instead of the content, so that scrolling yields the value you expect (default off). Does not affect horizontal scrolling.

Invert the direction of the mouse horizontal scroll
: The horizontal counterpart of the setting above, inverted independently (default off).

Pattern for the image information line
: Set the information to be displayed in the image information line, at the right of the top-most toolbar. You can use any variables in the [variables](..//variables.md) section as well as `$(NL)` for a new line. You can also include [formatting](..//variables.md#formatting) (bold, italic, colors etc).

Border around image in darkroom mode
: Display the center image in darkroom mode with an outside border of the given number of pixels (default 20).

Show loading screen between images
: Show gray loading screen when navigating between images in the darkroom. Switch this option off to just show a simple toast message and leave the previous image in place until the next image is loaded. Note that switching this option off can be very useful to quickly compare duplicate images, however, there might be issues with long loading times (leading you to think the next image has already loaded) and you may observe visual artifacts while the next image is loading (default on).

## Modules

Display of individual color channels
: Control how individual color channels are displayed when activated in the [parametric masks](../views/darkroom/masking-and-blending/masks/parametric.md) feature. You can choose between “false color” and “gray scale” (default "false color").

Hide built-in presets for processing modules
: If enabled, only user-defined presets will be shown in the presets menu for processing modules -- built-in presets will be hidden (default off).

Show the guides widget in modules UI
: Enable this to show the local [guides & overlays](../views/toolboxes/guides-overlays.md#local-guides) interface directly within the UI of the modules that support it (default on).

Show right-side buttons in processing module headers
: Choose whether to show the four buttons (mask indicator, multi-instance menu, reset, presets menu) on the right-hand-side of the module header for processing modules. These buttons will always appear when the mouse is over the module. At other times they will be shown or hidden according to this preference selection:
: - _always_: always show all buttons
: - _active_: only show the buttons when the mouse is over the module
: - _dim_: buttons are dimmed when mouse is not over the module
: - _auto_: hide the buttons when the panel is narrow
: - _fade_: fade out all buttons when the panel narrows
: - _fit_: hide all the buttons if the module name doesn't fit
: - _smooth_: fade out all buttons in one header simultaneously
: - _glide_: gradually hide individual buttons as needed
: (default _always_)

Prompt for name on addition of new instance
: If enabled, when creating a new instance of a processing module, a prompt will be immediately displayed allowing you to set a name for the new instance (default on).
