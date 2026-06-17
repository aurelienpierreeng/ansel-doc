---
title: Image grouping
date: 2022-12-04T02:19:02+01:00
lastmod: 2026-06-17
id: grouping
draft: false
weight: 50
author: "people"
---

Grouping images helps to improve the structure and clarity of your image collection when displayed in the lighttable view.

You can combine images into a group by selecting them and using the global menu _Image_ 🡒 _Group images_ (<kbd>Ctrl</kbd>+<kbd>G</kbd>). Likewise, remove selected images from a group with _Image_ 🡒 _Ungroup images_ (<kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>G</kbd>).

Duplicated images are automatically grouped together. Similarly, if you import multiple images from the same directory, having the same base name, but different extensions (eg. `IMG_1234.CR2` and `IMG_1234.JPG`), those images automatically form a group.

Images that are members of a group are denoted by a group icon on their thumbnail.

Whether groups are collapsed is controlled from the global menu _Display_ 🡒 _Collapse grouped images_. When this is off, all images are displayed as individual thumbnails. When it is on, each group is represented by a single thumbnail (the group leader). Press the group icon on a group leader's thumbnail to expand that group (press again to collapse); expanding another group collapses the first.

A group can be outlined by a frame around its member thumbnails, enabled with _Display_ 🡒 _Show group borders_ (<kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>P</kbd>). The border becomes more visible when you hover over one of the group's images.

You can define which image is considered to be the group leader by clicking on the group icon of the desired image while that group is expanded. The group icon is shown only if grouping mode is enabled, so to change the group leader, you need to first enable grouping, expand the appropriate group and finally click the group icon of the desired "group leader" image. The current group leader is shown in a tooltip when you hover over the group icon of an image.

If you collapse an image group and then enter darkroom mode (e.g. by double-clicking on the thumbnail), the group leader image will be opened for developing.

Image groups are also a convenient way to protect an existing history stack against unintentional changes. If you have just finalized an image and want to protect its current version, select the image, duplicate it with _Edit_ 🡒 _Duplicate existing history_ (<kbd>Ctrl</kbd>+<kbd>D</kbd>), and make sure grouping is collapsed. Now, whenever you open the image group again in the darkroom, only the group leader will be altered, and the underlying duplicate remains unchanged.

---

**Note:** “duplicating images” only generates a copy of an image's history stack, stored in another small XMP file. There is still only one raw file.

---
