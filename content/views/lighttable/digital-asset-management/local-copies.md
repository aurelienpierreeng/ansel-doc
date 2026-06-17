---
title: Local copies
date: 2022-12-04T02:19:02+01:00
lastmod: 2026-06-17
id: local-copies
weight: 30
draft: false
author: "people"
---

Many users have huge image collections stored on extra hard drives in their desktop computer, or on an external storage medium (RAID NAS, external hard drives etc.).

It is a common requirement to develop a number of images while travelling using a laptop and then later synchronize them back to the original storage medium. However, copying images manually from the main storage to the laptop and back is cumbersome and prone to errors. The “local copies” feature of Ansel has been designed to directly support these use cases.

Create local copies of the selected images from the global menu _File_ 🡒 _Copy distant images locally_. Local copies are always used when present, giving continued access to images even if the external storage is no longer connected. Later, when your primary storage medium has been reconnected, re-synchronize the XMP sidecar files back to it (and delete the local copies) with _File_ 🡒 _Resynchronize distant images_.

For safety reasons, if local copies exist and the external storage is available, the local XMP sidecars are automatically synchronized at start up.

Local copies are stored within the `$HOME/.cache/ansel` directory and named `img-<SIGNATURE>.<EXT>` (where `SIGNATURE` is a hash signature (MD5) of the full pathname, and `EXT` is the original filename extension).

Local copies can be identified in the lighttable view by a white marker on the top right of the thumbnail. In addition, all local copies carry the `darktable|local-copy` tag to allow them to be easily selected.
