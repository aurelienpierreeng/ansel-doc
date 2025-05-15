---
title: Editing images
date: 2025-05-15
weight: 02
---

## Understanding non-destructive editing

Before diving deeper into how to use the software, we should stop here to explain its general paradigm : non-destructive editing.

Once you [imported](./import.md) images to Ansel, what you really did is only to create an entry for them into the [library](../install/configuration.md) database. The modifications you make on these images are never written to the original images, which are actually never changed. This is a strong design requirement aiming at protecting your input RAW images from any kind of corruption.[^1] Ansel will not even let users change the EXIF date and time in the original files.

[^1]: Except the natural aging of your storage media that may lead to randomly-corrupted bits in the future.

Instead, Ansel writes your image-processing and metadata changes to its library database, and possibly duplicates them to [sidecar XMP files](../views/lighttable/digital-asset-management/sidecar.md). These changes are stored as a list of the [modules](../views/darkroom/modules/_index.md) used and the parameters defined for each module. __Said otherwise, a non-destructive editing is stored only as an history stack of changes, which represents the recipe for building the final image.__

To actually build the final image, you will need to [export](../views/toolboxes/export.md) it to a target file on a target filesystem : this will apply the history stack to the original, input RAW, to create a final file that can be opened in any image viewer.

There are many benefits to working in a non-destructive fashion :

1. the input image stays as safe as possible,
2. you can apply the same history stack to many images (through copy-pasting or creating [styles](../views/toolboxes/styles.md)), therefore editing in batch,
3. you can go back at any point in your history and revert selective changes (same as <kbd>Ctrl</kbd>+<kbd>Z</kbd>, but persisting between reboots), even in some years,
4. you can start from an existing history, duplicate it, and work on a variant while keeping the original untouched,
5. you can share your histories (as XMP files or as styles) with other users.


Because we keep all those history steps, they are automatically saved once applied. You will find no "save" button in Ansel. Here is the summary of the workflow in Ansel:

{{< table >}}

| Step | Action from user perspective | Action from software perspective |
| ---- | ---------------------------- | -------------------------------- |
| 1. Import images | Select input images from the filesystem | Create virgin entries for images in the database |
| 2. Edit images | Apply corrections to an image             | Add editing history entries for this image into the database |
| 3. Export images | Build a final JPG/TIFF/etc. image       | Run a pixel pipeline applying the history onto the input image |

{{< /table >}}

## Editing, retouching, correcting your image

After [import](./import.md), the series of images you imported will be opened in the [lighttable](../views/lighttable/_index.md) view, as a grid of thumbnails. You only have to double-click on any image you want to edit, which will then open the [darkroom](../views/darkroom/_index.md). This view will provide you with image processing [modules](../views/darkroom/modules/_index.md) allowing to apply changes and correction to the appearance of your image.
