---
title: Duplicate manager
date: 2022-12-04T02:19:02+01:00
lastmod: 2026-06-17
id: duplicate-manager
tags:
view: darkroom
---

View and switch between the versions (duplicates) of the current image. Every version shares the same underlying file but keeps its own independent editing history, stored in its own XMP sidecar, so each can be edited without affecting the others.

In the darkroom [left panel](../darkroom/darkroom-view-layout.md#left-panel), the duplicate manager lists each version of the current image with a preview thumbnail and a version number:

- **Press and hold** a thumbnail to preview that version in the center view.
- **Double-click** a thumbnail to switch to that version and edit it.

## Creating versions

New versions are created from the [global menu](../global-menu.md), so they also work on a lighttable selection:

- _Edit → Create new history_ (<kbd>Ctrl</kbd>+<kbd>N</kbd>) makes a **virgin** version, with an empty history.
- _Edit → Duplicate existing history_ (<kbd>Ctrl</kbd>+<kbd>D</kbd>) makes an **exact duplicate** of the current edit.

A version's description is stored in the _version name_ metadata field, which you can edit from the [metadata editor](metadata-editor.md) in the lighttable.
