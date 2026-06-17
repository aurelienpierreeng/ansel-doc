---
title: Soft proof
date: 2022-12-04T02:19:02+01:00
lastmod: 2026-06-17
id: soft-proof
tags:
view: darkroom
---

View your image rendered using a selected color profile.

Click the soft-proof icon in the [bottom toolbar](../darkroom/darkroom-view-layout.md#bottom-panel) to activate soft-proof display mode. This lets you preview your image rendered through a printer profile, to see how colors will end up on the final print. A “soft proof” message at the bottom-left of the image confirms you are in soft-proof mode.

Right-click on the icon to open a dialog with the following configuration parameters. For each of these parameters, the list of available profiles is read from `$ANSEL/share/ansel/color/out` and `$HOME/.config/ansel/color/out` (where `$ANSEL` represents Ansel's installation directory and `$HOME` your home directory).

display profile
: Set the color profile for the display. The option “system display profile” is the preferred setting when working with a calibrated display. The profile is taken either from your system's color manager or from your X display server. The method Ansel uses to detect your system display profile can be changed in [preferences > miscellaneous](../../preferences-settings/miscellaneous.md). For more information see the [display profile](../../color-management/display-profile.md) section.


intent
: Set the rendering intent for your display -- only available if rendering with LittleCMS2 is activated. See [rendering intent](../../color-management/rendering-intent.md) for a list of available options. This option appears twice -- once for the "display profile" and once for the "preview display profile".

softproof profile
: Set the color profile for soft proofing. Typically these profiles are supplied by your printer or generated during printer profiling.

histogram profile
: Set the color profile of the histogram. None of the available options are ideal, however, "system display profile" is probably the _least bad_ setting, since all other profiles are derived from the display color space and at least the values will conform to what you see on screen.
