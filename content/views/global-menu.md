---
title: Global menu
date: 2026-06-16
weight: 15
draft: false
author: "people"
---

The global menu bar sits at the top-left of the [header](_index.md#header-top-panel) and is available in every view. It gathers the application-wide commands, image operations, history and style management, maintenance tasks, display settings, view switching and help. It is the central reference point of the interface: most commands that are not a per-module setting live here.

{{< note >}}
Coming from Darktable: many commands that were previously buried inside side-panel modules, cryptic icon buttons or undocumented keyboard shortcuts have been collected into this menu. "Modules" that were really just grids of buttons (image actions, view toolbox, selection helpers…) became menu entries.
{{< /note >}}

## Using the menu

- Click a menu title to open it, or press <kbd>Alt</kbd> to reveal the underlined **mnemonic** letters and press one to open the matching menu. Once a menu is open, navigate all menus with the arrow keys and trigger an entry with <kbd>Enter</kbd>.
- Entries that have a default keyboard shortcut show it on their right. All these shortcuts are **defaults that you can change** from _Edit → Keyboard shortcuts…_ (see [shortcuts and keyboard interaction](../getting-started/keyboard.md)).
- Many entries act on the **active images** — that is, the images currently [selected](../getting-started/keyboard.md#thumbtable) in the lighttable or filmstrip. When nothing is selected, those entries are greyed out.

The menus are described below in their bar order.

## File

Image-file and collection operations.

Import… (<kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>I</kbd>)
: Open the [import](../getting-started/import.md) window to add images to the library.

Export… (<kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>E</kbd>)
: Open the [export](toolboxes/export.md) settings to render the selected images to files.

Recent collections
: A submenu listing the collections you have recently browsed; pick one to restore it.

Copy files on disk… / Move files on disk…
: Physically copy or move the selected image files to another folder, updating the library accordingly.

Create a blended HDR
: Merge the selected bracketed exposures into a single high-dynamic-range DNG.

Copy distant images locally / Resynchronize distant images
: Manage [local copies](lighttable/digital-asset-management/local-copies.md) of images stored on removable or network drives.

Remove from library (<kbd>Delete</kbd>)
: Remove the selected images from Ansel's library **without** deleting the files on disk. Available in the lighttable.

Delete from disk (<kbd>Shift</kbd>+<kbd>Delete</kbd>)
: Remove the selected images from the library **and** delete (or trash) the files on disk. Available in the lighttable.

Quit (<kbd>Ctrl</kbd>+<kbd>Q</kbd>)
: Close Ansel.

## Edit

Editing-history management, undo/redo and application settings. See [history copy/paste](lighttable/history-copy-paste.md) and [undo/redo](lighttable/undo-redo.md).

Undo (<kbd>Ctrl</kbd>+<kbd>Z</kbd>) / Redo (<kbd>Ctrl</kbd>+<kbd>Y</kbd>)
: Step backwards/forwards through your most recent actions in the current view.

Copy history (all) (<kbd>Ctrl</kbd>+<kbd>C</kbd>) / Copy history (parts)… (<kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>C</kbd>)
: Copy the whole editing history of the selected image, or pick which modules to copy.

Paste history (all) (<kbd>Ctrl</kbd>+<kbd>V</kbd>) / Paste history (parts)… (<kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>V</kbd>)
: Paste the copied history onto the selected images, either entirely or selectively.

History pasting mode
: How a pasted history combines with the target's existing history:
    - **Prepend** — the copied history is applied _before_ the current one; current edits win conflicts.
    - **Append** — the copied history is applied _after_ the current one; copied edits win conflicts.
    - **Replace** — the current history is discarded and replaced by the copied one.

Nodes pasting mode → Copy module order
: When enabled, pasting also transfers the module (pixelpipe node) order along with the settings.

Ask merge settings before paste
: When enabled, a dialog asks how to merge the histories each time you paste, instead of using the modes above silently.

Load history from XMP…
: Apply an editing history read from an external XMP sidecar file to the selected images.

Create new history (<kbd>Ctrl</kbd>+<kbd>N</kbd>)
: Create a fresh, empty duplicate of the selected image to start a new edit.

Duplicate existing history (<kbd>Ctrl</kbd>+<kbd>D</kbd>)
: Create a duplicate of the selected image that carries over its current edit.

Compress history
: Collapse the history stack to the minimum set of states producing the current result.

Delete history
: Discard the editing history of the selected images, resetting them.

Preferences…
: Open the [preferences & settings](../preferences-settings/_index.md) window.

Keyboard shortcuts…
: Open the [shortcuts](../getting-started/keyboard.md#finding-default-shortcuts-setting-new-ones) window, which both lists and lets you edit every shortcut.

## Selection

Batch selection helpers that work on the current collection. Selecting from the thumbnail grid is described in [shortcuts and keyboard interaction](../getting-started/keyboard.md#thumbtable).

Select all (<kbd>Ctrl</kbd>+<kbd>A</kbd>)
: Select every image in the current collection.

Clear selection (<kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>A</kbd>)
: Deselect everything.

Invert selection (<kbd>Ctrl</kbd>+<kbd>I</kbd>)
: Select the images that are not currently selected, and vice-versa.

Scroll back to selection
: Scroll the grid to bring the selected image(s) into view.

## Image

Per-image metadata and grouping actions, applied to the selected images.

Rotate
: **90° counter-clockwise**, **90° clockwise**, or **Reset rotation**. This sets the image orientation flag.

Color labels
: Toggle a color label: **Red** (<kbd>F1</kbd>), **Yellow** (<kbd>F2</kbd>), **Green** (<kbd>F3</kbd>), **Blue** (<kbd>F4</kbd>), **Purple** (<kbd>F5</kbd>), or **Clear labels** (<kbd>F6</kbd>).

Ratings
: Set a star rating: **Reject** (<kbd>R</kbd>), **★** (<kbd>1</kbd>) … **★★★★★** (<kbd>5</kbd>), or **Clear rating** (<kbd>0</kbd>).

Reload EXIF from file
: Re-read the EXIF metadata from the original files, discarding any cached values.

Group images (<kbd>Ctrl</kbd>+<kbd>G</kbd>) / Ungroup images (<kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>G</kbd>)
: Combine the selected images into a [group](lighttable/digital-asset-management/grouping.md), or break the group apart.

## Styles

Apply and manage [styles](toolboxes/styles.md) — named, reusable sets of module settings.

(list of styles)
: Each available style is listed; click it to apply it to the selected images. Hovering a style name previews it on the current image.

History pasting mode / Nodes pasting mode / Ask merge settings before apply
: Control how a style merges with the target's existing history, exactly like the equivalent options in the _Edit_ menu.

Create new style…
: Create a style from the editing history of the selected image.

Manage styles…
: Open the style manager to rename, edit, import, export or delete styles.

## Run

Background and maintenance tasks.

Clear darkroom pipeline caches
: Free the cached intermediate pipeline results, forcing a full recompute on the next edit.

Preload selected thumbnails in cache
: Pre-render the thumbnails of the selected images into the on-disk cache, up to a chosen resolution (from _360×225 px_ up to _8K_, or _for current grid size_). Runs as a background task.

Purge selected thumbnails from cache
: Delete the cached thumbnails of the selected images from disk, so they are regenerated next time.

Defragment the library
: Optimize the library database file.

Backup the library
: Make a backup copy of the library database.

Resynchronize library and XMP
: Scan for XMP sidecars that changed outside Ansel and reconcile them with the library.

Save selected developments to XMP
: Write the editing history of the selected images to their XMP sidecar files.

Resynchronize database with distant XMP for local copies
: Reconcile the library with the XMP sidecars of images held as local copies.

{{< note >}}
Coming from Darktable: preloading and purging the thumbnail cache used to be possible only through hidden shell scripts. They are now first-class menu commands, and the choice between processing the RAW or using an embedded JPEG (in the _Display_ menu) can be changed at runtime instead of only in the preferences.
{{< /note >}}

## Display

View-level display settings. These are detailed in the [views overview](_index.md#display-menu).

Monitor color profile / Monitor color intent
: The display [color-management](../color-management/_index.md) profile and rendering intent (_Perceptual_, _Relative colorimetric_, _Absolute colorimetric_).

Panels
: Individually toggle the **Top** (<kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>T</kbd>), **Left** (<kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>L</kbd>), **Right** (<kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>R</kbd>) and **Filmstrip** (<kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>F</kbd>) panels.

Thumbnail overlays
: When the badges drawn over thumbnails are shown: **Always hide** (<kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>H</kbd>), **Show on hover**, or **Always show** (<kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>O</kbd>).

Thumbnail source
: How thumbnails are generated: **Always process the RAW**, **Use embedded JPG if unedited**, or **Always use embedded JPG**.

Collapse grouped images / Show group borders (<kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>P</kbd>)
: Control the display of [grouped images](lighttable/digital-asset-management/grouping.md).

Full screen (<kbd>F11</kbd>)
: Toggle fullscreen mode. (To toggle all panels at once, use <kbd>Shift</kbd>+<kbd>F11</kbd>.)

## Ateliers

The view switcher. It lists every available view and switches to the one you pick (the current view is greyed out):

- **Lighttable** (<kbd>Escape</kbd>)
- **Darkroom** (<kbd>Enter</kbd> — opens the selected image)
- **Studio capture** — to survey and import new image automatically to see them directly into darktable
- **Map**, **Print**, **Slideshow** (when enabled in the [preferences](../preferences-settings/other-views.md))

## Help

Documentation and support links.

Online documentation
: Open this documentation website.

Ask a question
: Open the Ansel search engine.

Join the support chat / Join the support forum
: Open the community chat and forum.

Open contextual help
: Turn the cursor into a help probe; click a control to open the relevant documentation page.

Search actions… (<kbd>Ctrl</kbd>+<kbd>P</kbd>)
: Open the [global action search](../getting-started/keyboard.md#vimkey-like-global-action-search).

About
: Show the version and credits dialog.
