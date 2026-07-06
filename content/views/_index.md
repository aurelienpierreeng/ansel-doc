---
title: Views
date: 2022-12-04T02:19:02+01:00
lastmod: 2026-06-16
draft: false
weight: 20
author: "people"
---

Ansel separates its functionality into several _views_, each dedicated to one task:

[Lighttable](lighttable/_index.md)
: Manage, sort, cull and tag your image collection. This is the default view, loaded at startup, and you can return to it from anywhere by pressing <kbd>Escape</kbd>.

[Darkroom](darkroom/_index.md)
: Develop a single image. Open it from the lighttable by double-clicking a thumbnail, or by selecting a picture and pressing <kbd>Enter</kbd>.

[Map](map/_index.md)
: Show geo-tagged images on a map and geo-tag new images manually. Hidden by default; enable it in the [preferences](../preferences-settings/other-views.md).

[Print](print/_index.md)
: Send images to a printer. Hidden by default; enable it in the [preferences](../preferences-settings/other-views.md). Not available on Windows, as it relies on [CUPS](http://www.cups.org/).

[Studio Capture](studio-capture/_index.md)
: Dedicated view for tethered shooting sessions.

[Slideshow](slideshow/_index.md)
: Display images full-screen as a slideshow, processing them on the fly. Hidden by default; enable it in the [preferences](../preferences-settings/other-views.md).

You switch views from the **Ateliers** menu in the top menu bar, which lists every available view and the shortcut to reach it (the current view is greyed out). The darkroom is the exception: because it needs an image to open, you enter it from a lighttable or filmstrip thumbnail, not from the menu.

## Window layout

Every view shares the same window frame: a central work area surrounded by panels. The visibility and size of each panel are remembered independently for each view.

### Header (top panel)

The header runs along the top of the window and is common to all views. From left to right it contains:

The [global menu](global-menu.md) bar
: **File · Edit · Selection · Image · Styles · Run · Display · Ateliers · Help**. This menu bar is the backbone of the interface: it gathers application-wide commands, image operations, view switching and help. Each menu has a keyboard mnemonic — press <kbd>Alt</kbd> to underline the mnemonic letters, then press one to open that menu, and navigate the open menus with the arrow keys.

_Search actions…_ button
: Opens the [global action search](../getting-started/keyboard.md#vimkey-like-global-action-search) (default <kbd>Ctrl</kbd>+<kbd>P</kbd>), from which any action can be found and triggered by name, whether or not it has a shortcut.

Message area
: On the right, a text area where some modules display hints and status messages.

Window buttons
: A _Go back to lighttable_ button (home icon), plus the minimize and close buttons for the window.

The header can be shown and hidden with <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>T</kbd>.

{{< note >}}
Coming from Darktable: the view switcher, the preferences button, the context-help button and the shortcut-mapping button that used to live in the top toolbar are now reached from the global menu (_Ateliers_, _Edit → Preferences…_, _Help → Open contextual help_ and _Edit → Keyboard shortcuts…_ respectively). The separate top toolbar no longer exists.
{{< /note >}}

### Second top row

Directly below the header, the lighttable shows a single toolbar that combines the [collection filters](toolboxes/collections.md) (rating, color label, edited status, text search, _restrict to selection_) on one side and the [display options](lighttable/_index.md) (columns, zoom, overlays) on the other. Other views leave this row empty.

### Left panel

Shown and hidden with <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>L</kbd>. It hosts the view's [toolboxes](toolboxes/_index.md):

- **In lighttable**: the _Library_ collection builder and import/export tools.
- **In darkroom**: peripheral tools about the picture being edited — navigation, snapshots, color pickers, image information, mask manager, etc.

### Right panel

Shown and hidden with <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>R</kbd>. Used only in the **darkroom** (and map/print), where it holds the image-processing modules and the scopes. The lighttable has no right panel.

### Bottom panel (filmstrip)

Shown and hidden with <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>F</kbd>. Available in the **darkroom**, **map** and **print** views, where it displays the [filmstrip](toolboxes/filmstrip.md): a horizontal strip of the current collection's thumbnails for quick navigation without leaving the view. The lighttable has no filmstrip, since it already shows the whole collection.

### Resizing and global layout

- Drag the inner border of the left, right or filmstrip panels to resize them.
- <kbd>Shift</kbd>+<kbd>F11</kbd> toggles the visibility of all panels at once, expanding the work area to fill the window.
- <kbd>F11</kbd> toggles fullscreen mode.

All these layout commands are also available from the **Display** menu, under _Panels_ and _Full screen_.

## Display menu

The **Display** menu collects the view-level display settings that previously lived in scattered toolbars:

- _Panels_ — individually toggle the top, left, right and filmstrip panels.
- _Thumbnail overlays_ — choose whether thumbnail badges (rating, labels, metadata) are _always hidden_, _shown on hover_ or _always shown_.
- _Thumbnail source_ — choose how thumbnails are generated: _always process the RAW_, _use the embedded JPEG if the image is unedited_, or _always use the embedded JPEG_. This can be changed at runtime.
- _Collapse grouped images_ and _Show group borders_ — control how [grouped images](lighttable/digital-asset-management/grouping.md) are displayed.
- _Monitor color profile_ / _Monitor color intent_ — the display [color management](../color-management/_index.md) settings.
- _Full screen_.

See the [global menu reference](global-menu.md) for the complete list of menus and their entries.
