---
title: Darkroom view layout
date: 2022-12-04T02:19:02+01:00
lastmod: 2026-06-16
id: the-darkroom-view
weight: 20
draft: false
---

The darkroom surrounds the center image with a left panel of peripheral tools, a right panel of image-processing modules, and a bottom toolbar of visual-assessment overlays. An optional [filmstrip](../../views/toolboxes/filmstrip.md) (<kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>F</kbd>) can be shown along the bottom for quick navigation through the current collection.

## Left panel

Shown and hidden with <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>L</kbd>. It holds the peripheral tools that support editing (but do not themselves process pixels):

[Navigation](../../views/toolboxes/navigation.md)
: Navigate and zoom the center view via a thumbnail overview. Sits at the top of the panel.

[Scopes](../../views/toolboxes/scopes.md)
: A graphical depiction of the image's tones and colors (histogram, waveform, vectorscope…). The [global color picker](../../views/toolboxes/global-color-picker.md), used to sample colors from the image, is part of this module.

[Snapshots](../../views/toolboxes/snapshots.md)
: Take and compare snapshots against the current edit.

[Duplicate manager](../../views/toolboxes/duplicate-manager.md)
: View and manage the duplicates (versions) of the current image.

[Mask manager](../../views/toolboxes/mask-manager.md)
: View and edit the [drawn shapes](masking-and-blending/masks/drawn.md) used by masks.

[History of changes](../../views/toolboxes/history-stack.md)
: The editing history of the current image, where you can step back to any previous state, compress or reset the history.

[Image information](../../views/toolboxes/image-information.md)
: Display EXIF and IPTC information about the current image.

[Notes](../../views/toolboxes/notes.md)
: Free-text notes attached to the image.

{{< note >}}
Coming from Darktable: the _metadata_ and _tags_ editors are no longer duplicated in the darkroom. Metadata handling now belongs to the [lighttable](../lighttable/_index.md); the darkroom is dedicated to editing.
{{< /note >}}

## Right panel

Shown and hidden with <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>R</kbd>. It is dedicated to the [image-processing modules](../../views/darkroom/modules/_index.md): the workflow tabs sit at the top, and the modules themselves fill the rest of the panel.

To inspect or rearrange the order in which modules are applied, see [the pixelpipe and module order](pixelpipe/the-pixelpipe-and-module-order.md).

## Module workflow tabs

The processing modules are grouped into tabs that follow the pixelpipe, so that editing from left to right (across tabs) and bottom to top (within a tab) walks you through a sound workflow. Hover a tab label for its description.

Pipeline
: Lists every module that is currently **enabled**, in the reverse order of application in the pixelpipe (last-applied on top). This is your overview of what the image actually does.

Basic
: Modules that adjust brightness, contrast and dynamic range, work with film scans, and perform color-grading.

Repair
: Modules that repair and reconstruct noisy or missing pixels.

Sharpness
: Modules that manipulate local contrast, sharpness and blur.

Effects
: Modules applying special effects.

Technics
: Technical modules that can be ignored in most situations.

All
: Every module available in the software.

{{< note >}}
Coming from Darktable: the icon-labelled module groups and the user-customizable group editor are gone. Tabs are named in words, fixed, and ordered to match the pipeline. The "favourite modules" tab is replaced by the ability to jump directly to any module through a shortcut or the [action search](../../getting-started/keyboard.md#vimkey-like-global-action-search).
{{< /note >}}

### Navigating tabs and modules

With the mouse
: Click a visible tab; click the arrows to reveal hidden tabs; right-click a tab for the full list; or scroll over the tab bar to cycle. Scroll the panel to move through modules; unfolding a module scrolls it into view.

With the keyboard
: <kbd>Ctrl</kbd>+<kbd>Tab</kbd> / <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>Tab</kbd> move to the next/previous tab (cycling at the ends). <kbd>Page Down</kbd> / <kbd>Page Up</kbd> expand and focus the next/previous module in the current tab. <kbd>Ctrl</kbd>+<kbd>Down</kbd> / <kbd>Ctrl</kbd>+<kbd>Up</kbd> move focus between a module's controls.

The complete keyboard model — focusing a module or control, then editing it — is in [shortcuts and keyboard interaction](../../getting-started/keyboard.md#darkroom).

### Reordering modules

Hold <kbd>Ctrl</kbd>+<kbd>Shift</kbd> and drag a module by its header to move it. Be aware that this changes the **order of the modules in the pixelpipe**, not just their position on screen — it is best done from the _Pipeline_ or _All_ tab, where you can see the whole pipeline. See [the pixelpipe and module order](pixelpipe/the-pixelpipe-and-module-order.md).

## Bottom panel

A toolbar of visual-assessment overlays. From left to right:

[Styles](../../views/toolboxes/styles.md)
: Quick-access styles menu. Hover a style name to preview it on the current image.

[Color assessment](../../views/toolboxes/color-assessment.md)
: Toggle the ISO 12646 color-assessment view (neutral surround and reference frame).

[Raw overexposed](../../views/toolboxes/raw-overexposed.md)
: Toggle raw-overexposure indicators (right-click for options).

[Clipping](../../views/toolboxes/clipping.md)
: Toggle output clipping warnings (right-click for options).

[Soft proofing](../../views/toolboxes/soft-proof.md)
: Toggle soft-proofing (right-click for options).

[Gamut check](../../views/toolboxes/gamut.md)
: Toggle gamut checking (right-click for options).

[Guides & overlays](../../views/toolboxes/guides-overlays.md)
: Left-click to toggle the guide overlays; right-click to change the guide settings, including the color of all on-image drawing (masks, crop guides, etc.).

Pipeline node graph
: Open the [module-order graph](pixelpipe/the-pixelpipe-and-module-order.md#changing-module-order) — a left-to-right view of the pixelpipe where you can inspect and rearrange the order in which modules are applied.

Autoset
: Run [autoset](_index.md#autoset-auto-developing-an-image) on the chosen modules: each capable module computes its own settings from the image content. Right-click to pick which modules participate.
