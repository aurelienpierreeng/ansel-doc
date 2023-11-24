---
title: darkroom
date: 2022-12-04T02:19:02+01:00
id: darkroom
weight: 50
draft: false
---

Control functionality in the [darkroom](../views/darkroom/_index.md) view and associated modules.

## general

pen pressure control for brush masks
: Controls how the pressure reading of a graphics tablet impacts newly generated [drawn mask](../views/darkroom/masking-and-blending/masks/drawn.md) brush strokes. You can control the brush width, hardness and opacity. “Absolute” control means that the pressure reading directly defines the attribute with a value between 0% and 100%. “Relative” means that the pressure reading adjusts the attribute between zero and the pre-defined default value (default off).

smoothing of brush strokes
: Sets the level for smoothing of [drawn mask](../views/darkroom/masking-and-blending/masks/drawn.md) brush strokes. Stronger smoothing leads to fewer nodes and easier editing at the expense of lower accuracy.

scroll down to increase mask parameters
: By default, scrolling your mouse up increases the value of the relevant shape parameters in [drawn masks](../views/darkroom/masking-and-blending/masks/drawn.md). Set this preference to reverse the behavior (default off).

pattern for the image information line
: Set the information to be displayed in the [image information line](../modules/utility-modules/darkroom/image-info-line.md). You can use any variables in the [variables](../special-topics/variables.md) section as well as `$(NL)` for a new line. You can also include [formatting](../special-topics/variables.md#formatting) (bold, italic, colors etc).

position of the image information line
: Choose the darkroom panel in which the [image information line](../modules/utility-modules/darkroom/image-info-line.md) is displayed. Choose between “top left” “top right” “top center” “bottom” and “hidden” (default "bottom").

border around image in darkroom mode
: Display the center image in darkroom mode with an outside border of the given number of pixels (default 20).

show loading screen between images
: Show gray loading screen when navigating between images in the darkroom. Switch this option off to just show a simple toast message and leave the previous image in place until the next image is loaded. Note that switching this option off can be very useful to quickly compare duplicate images, however, there might be issues with long loading times (leading you to think the next image has already loaded) and you may observe visual artifacts while the next image is loading (default on).

## modules

display of individual color channels
: Control how individual color channels are displayed when activated in the [parametric masks](../views/darkroom/masking-and-blending/masks/parametric.md) feature. You can choose between “false color” and “gray scale” (default "false color").

hide built-in presets for processing modules
: If enabled, only user-defined presets will be shown in the presets menu for processing modules -- built-in presets will be hidden (default off).

show the guides widget in modules UI
: Enable this to show the local [guides & overlays](../modules/utility-modules/darkroom/guides-overlays.md#local-guides) interface directly within the UI of the modules that support it (default on).

show right-side buttons in processing module headers
: Choose whether to show the four buttons (mask indicator, multi-instance menu, reset, presets menu) on the right-hand-side of the [module header](../views/darkroom/processing-modules/module-header.md) for processing modules. These buttons will always appear when the mouse is over the module. At other times they will be shown or hidden according to this preference selection:
: - _always_: always show all buttons
: - _active_: only show the buttons when the mouse is over the module
: - _dim_: buttons are dimmed when mouse is not over the module
: - _auto_: hide the buttons when the panel is narrow
: - _fade_: fade out all buttons when the panel narrows
: - _fit_: hide all the buttons if the module name doesn't fit
: - _smooth_: fade out all buttons in one header simultaneously
: - _glide_: gradually hide individual buttons as needed
: (default _always_)

prompt for name on addition of new instance
: If enabled, when creating a new instance of a processing module, a prompt will be immediately displayed allowing you to set a name for the new instance (default on).
