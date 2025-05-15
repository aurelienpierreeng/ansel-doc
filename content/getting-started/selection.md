---
title: Image selection
date: 2025-05-15
weight: 05
---

Ansel allows batch-applying editing histories (through copy-pasting, or through styles) or metadata. The target images for those batch-operations are _selected_ images. But even single-image operations (like opening in [darkroom](../views/darkroom/_index.md) to edit, or editing metadata, copy/pasting, etc.) use selections.

Selections are particular objects in Ansel, because :

1. they are remembered between reboots and kept constant during view changes,
2. they are necessarily a subset of the current filtered collection (as displayed in the [lighttable](../views/lighttable/)),
3. they can be set only from the [lighttable](../views/lighttable/) view (no selection can be performed or used from the [filmstrip](../views/toolboxes/filmstrip.md)),
4. they can be turned into a collection themselves, by using the _Restrict to selection_ button in the include/filter toolbar of the [lighttable](../views/lighttable/).

Selected images will appear highlighted in the lighttable and filmstrip. Because selections are used to perform (possibly harmful) _write_ operations, Ansel forces "hard" interactions (pressing on an hardware button) to define them. These allowed interactions are :

- <kbd>Left click</kbd> or <kbd>Space</kbd> : to select a single image,
- <kbd>Ctrl</kbd>+<kbd>Left click</kbd> or <kbd>Ctrl</kbd>+<kbd>Space</kbd> : to add/remove an image to the current selection (toggle),
- <kbd>Shift</kbd>+<kbd>Left click</kbd> or <kbd>Shift</kbd>+<kbd>Space</kbd> : to extend the selection range from the nearest-selected image to the current image,
- Global menu 🡒 _Selection_ : to select all/none images from the current collection, or invert the current selection. Associated keyboard shortcuts will be shown in the menu entries.

A selection will be needed to perform any property editing, even on a single image, among the following :

- applying star ratings, or rejecting,
- applying color labels,
- applying tags, title, copyright or any metadata,
- changing GPS coordinates or time zone.

Unlike Darktable, Ansel doesn't implicitely treats the hovered image as a part of any selection, which prevents unpredictable and often unwanted changes on random images when the mouse cursor is left dangling on the thumbnail grid.

If you scrolled far away from the selection and lost it, the global menu _Selection_ 🡒 _Scroll back to selection_ will realign the view on the thumbnail grid to the start of your selection.

A message sitting on the right of the top-most toolbar will tell how many images are selected among how many in the current collection, and, if there is only one selected, will tell the image index after the `#` symbol. This index will match the `#` numbers in the background of the lighttable thumbnails, and is referred to the current collection.
