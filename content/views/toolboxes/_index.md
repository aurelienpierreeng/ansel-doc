---
title: Toolboxes
date: 2022-12-04T02:19:02+01:00
lastmod: 2026-06-16
id: utility-modules
draft: false
author: "people"
weight: 40
alias:
  - Modules/utility-modules/
---

A _toolbox_ is a collapsible tool docked in one of the side panels. Unlike the [darkroom processing modules](../darkroom/modules/_index.md), toolboxes do not modify pixels — they help you browse, organize, inspect, export and annotate images, or assess the picture being edited.

Each view shows only the toolboxes relevant to its task, so the same panel position can hold different tools depending on whether you are in the lighttable, the darkroom, the map or the print view.

{{< note >}}
Coming from Darktable: many tools that used to be toolbox "modules" are now [global menu](../global-menu.md) entries instead, because a grid of buttons is really just a menu in disguise. In particular, _history stack_ copy/paste, _styles_ management, _selection_ helpers, _image_ actions and the maintenance commands now live in the menu bar. The toolboxes below are the ones that remain genuine docked panels.
{{< /note >}}

## Working with toolboxes

- Click a toolbox header to expand or collapse it.
- A toolbox can be expanded and focused directly through the [global action search](../../getting-started/keyboard.md#vimkey-like-global-action-search) (<kbd>Ctrl</kbd>+<kbd>P</kbd>) or an assigned shortcut; triggering its focusing action again collapses it.
- Drag the inner border of a panel to resize it; panel visibility and size are remembered per view.

## Lighttable toolboxes

Left panel:

- [Library](collections.md) — build the current collection from folders, tags or arbitrary queries.
- [Metadata editor](metadata-editor.md) — edit title, description, creator and other text metadata.
- [Tagging](tagging.md) — attach and manage keyword tags.
- [Geotagging](geotagging.md) — attach GPS coordinates, including from a GPX track.
- [Image information](image-information.md) — EXIF/IPTC data of the highlighted image.
- [Notes](notes.md) — free-text notes attached to an image.

Second top row:

- [Collection filters](collections.md) — rating, color label, edited status, text search and _restrict to selection_ (see the [lighttable view](../lighttable/_index.md)).
- Display options — columns, zoom and overlays (see the [lighttable view](../lighttable/_index.md#lighttable-display)).

Reached from the menu bar:

- [Export](export.md) — render the selected images to files (_File → Export…_).

## Darkroom toolboxes

Left panel:

- [Navigation](navigation.md) — pan and zoom the center image from a thumbnail overview.
- [Scopes](scopes.md) — histogram, waveform and vectorscope, including the [global color picker](global-color-picker.md).
- [Snapshots](snapshots.md) — freeze and compare edit states.
- [Duplicate manager](duplicate-manager.md) — manage the versions of the current image.
- [Mask manager](mask-manager.md) — list and edit the [drawn shapes](../darkroom/masking-and-blending/masks/drawn.md) used by masks.
- [History of changes](history-stack.md) — step through, compress or reset the editing history.
- [Image information](image-information.md) and [Notes](notes.md).

Right panel:

- The [image-processing modules](../darkroom/modules/_index.md), in their [workflow tabs](../darkroom/darkroom-view-layout.md#module-workflow-tabs).

Bottom toolbar (visual assessment):

- [Styles](styles.md), [Color assessment](color-assessment.md), [Raw overexposed](raw-overexposed.md), [Clipping](clipping.md), [Soft proofing](soft-proof.md), [Gamut check](gamut.md), [Guides & overlays](guides-overlays.md), [Focus peaking](focus-peaking.md).

## Filmstrip

The [filmstrip](filmstrip.md) (<kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>F</kbd>) is an optional bottom panel available in the darkroom, map and print views. It shows the current collection's thumbnails for quick navigation without returning to the lighttable.

## Map toolboxes

- [Find location](find-location.md) and [Locations](locations.md) — search places and manage location tags.
- [Geotagging](geotagging.md) and [Map settings](map-settings.md).

## Print toolboxes

- [Print settings](print-settings.md) — page setup, printer, profile and layout for the [print view](../print/_index.md).

## Other

- [Lua scripts installer](lua-scripts-installer.md) — manage optional Lua extensions.
