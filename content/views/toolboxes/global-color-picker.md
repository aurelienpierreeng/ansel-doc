---
title: Global color picker
date: 2022-12-04T02:19:02+01:00
lastmod: 2026-11-17
id: global-color-picker
tags:
view: darkroom
---

The global color picker samples colors from the current image, displays their values in several color spaces, and lets you store and compare samples from different locations. It is part of the [scopes](scopes.md) module (the _Color picker_ and _Live samples_ sections), in the darkroom [left panel](../darkroom/darkroom-view-layout.md#left-panel).

Activate it with the color-picker button. It keeps sampling until you turn it off or leave the darkroom.

When the focused module displays no color picker of its own, you can also hold <kbd>Ctrl</kbd> (<kbd>⌘</kbd> on macOS) and click or drag in the image: the global picker samples without being turned on, and turns off again when you release the key. [Picking colors on the image](../darkroom/_index.md#picking-colors-on-the-image) describes the gestures and how the picker is chosen.

{{< note >}}
This **global** color picker is distinct from the **local** color pickers found inside many [modules](../darkroom/modules/_index.md) (e.g. [RGB curve](../darkroom/modules/curve.md)), which set that module's parameters. The two do not work in the same color space: the global picker samples at the **end of the preview pipeline** (display space), whereas a local picker reads the input or output of the module it belongs to.
{{< /note >}}

## Controls

Point or area
: With the picker on, click in the image to sample the point under the pointer, or drag to sample a rectangular area. Drag a corner of the rectangle to resize it.

Statistic (mean / min / max)
: For an area, choose whether to display the **mean**, **minimum** or **maximum** channel values of the sampled region. For a point, the three are identical.

Color mode
: Choose the color space in which the sampled values are shown. Values converted to spaces other than the native display space are approximate.

Color swatch
: A patch of the sampled color is shown next to the numerical values; click it to enlarge it. Right-click the numerical values to copy them to the clipboard.

Hover any value for a tooltip with more detail, including RGB and Lab values and an approximate color name.

## Live samples

Press **add** to store the current sample as a _live sample_. Each live sample keeps its own swatch and values (with its own statistic and color mode).

- Live samples are **not locked** by default: they update as you change the edit, which lets you watch how a parameter affects different parts of the image. Click a live sample's swatch to **lock** it (a lock icon appears) so later changes no longer affect it — handy for before/after comparisons.
- Hover a live sample's **delete** button to highlight its region in the preview.

Display samples on image
: Show the live-sample locations on the image and on the [vectorscope](scopes.md#vectorscope).

Restrict scope to selection
: Restrict the [scopes](scopes.md) to only the values inside the picked point/area, to inspect the tones present in that region. When a local color picker is active in a module, this restricts the scope to that module's picked area instead.

Display min/max pixel
: When a module's color picker reads the minimum or the maximum of the area it samples, mark on the image the pixel each of these values comes from. A `+` marks the pixel of the channel the module takes into account, and a smaller `×` the pixels of the channels it does not.
