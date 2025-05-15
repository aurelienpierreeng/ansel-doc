---
title: lighttable
date: 2022-12-04T02:19:02+01:00
lastmod: 2023-10-12
id: lighttable
weight: 40
draft: false
---

Control functionality in the [lighttable](../views/lighttable/_index.md) view and modules.

## general

hide built-in presets for utility modules
: If enabled, only user-defined presets will be shown in presets menu for utility modules -- built-in presets will be hidden (default off).

show image time with milliseconds
: Choose whether to include milliseconds when displaying time values (default off). If set, milliseconds are shown in the [image information](../views/toolboxes/image-information.md) module and can also be used in the [geotagging](../views/toolboxes/geotagging.md) module.

## thumbnails

use raw file instead of embedded JPEG from size
: When generating thumbnails for images that have not yet been processed in the darkroom, if the thumbnail size is greater than this value, generate it by processing the raw image data. If the thumbnail is below this size, use the JPEG preview image embedded in the raw file. Once an image has been processed in the darkroom, thumbnails will always be generated from raw data (you can revert back to the JPEG preview by discarding history). To render thumbnails with the best quality choose "always".

high quality processing from size
: If the thumbnail size is greater than this value and is being generated from raw data, it will be processed using the full quality rendering path, which is better but slower (default 720p). To render thumbnails with the best quality, choose "always".

delimiters for size categories
: Size categories are used to allow different thumbnail overlays to be shown depending on the thumbnail size. A pipe delimited set of values defines at what image sizes the category changes. The default value of "120|400" means that there will be 3 categories of thumbnail: 0-120px, 120-400px and >400px.
