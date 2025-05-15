---
title: guides & overlays
date: 2022-12-04T02:19:02+01:00
id: guides-overlays
applicable-version: 4.0
tags:
view: darkroom
---

A number of commonly-used compositional guides can be overlaid on your image while you are editing. These can be enabled either globally (all the time) or locally (when certain modules are active).

Other darkroom functionality also draws colored overlay lines on the image (for example, drawn masks). An option is also provided to change the color of those overlays (see below).

## global guides

 Left-click the ![guides-overlays-icon](guides-overlays-icon.jpg) icon in the bottom bar to globally display guide overlays. The overlays will remain switched on until you click the button a second time to switch them off.

 Right-click the icon to show the settings dialog (see below).

## local guides

A more common use is to switch the guides on only when a specific module is activated. The following control is added by default to all modules that crop/distort the image (currently [crop](../darkroom/modules/crop.md), [orientation](../darkroom/modules/orientation.md), [framing](../darkroom/modules/framing.md), [liquify](../darkroom/modules/liquify.md), [lens correction](../darkroom/modules/lens-correction.md), [retouch](../darkroom/modules/retouch.md) and [rotate and perspective](../darkroom/modules/rotate-perspective.md)):

![local-controls](local-controls.jpg)

Tick the box to show guide overlays whenever the module is active. Click the icon on the right to show the settings dialog (see below).

## global guide overlay settings

Please note that, while you can choose to switch guide overlays on and off either globally or locally, the following settings are stored globally and cannot be set independently for each module.

type
: The type of compositional guide lines to display.

flip
: Some guides are asymmetrical. This option allows you to flip such guides horizontally/vertically.

horizontal lines, vertical lines, subdivisions
: When the _grid_ overlay type is selected, set the parameters of the grid.

overlay color
: The color of the overlay lines. Note that this impacts _any_ lines that are drawn directly over the image, for example, drawn masks.

contrast
: The contrast between the lightest and darkest parts of any overlays -- usually, the contrast between the "on" and "off" parts of dashed lines.
