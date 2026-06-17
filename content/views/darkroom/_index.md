---
title: Darkroom
date: 2022-12-04T02:19:02+01:00
lastmod: 2026-06-16
id: darkroom
weight: 30
draft: false
author: "people"
aliases:
  - ../darkroom
---

The darkroom view is where you develop a single image. The center area shows the picture currently being edited; the [left panel](darkroom-view-layout.md#left-panel) holds peripheral tools (navigation, scopes, snapshots, history…), and the [right panel](darkroom-view-layout.md#right-panel) holds the image-processing modules.

Open the darkroom from the [lighttable](../lighttable/_index.md) by double-clicking a thumbnail, or by selecting an image and pressing <kbd>Enter</kbd>. Return to the lighttable with <kbd>Escape</kbd> (or the home button in the header). You can switch to another image without leaving the darkroom by enabling the [filmstrip](../toolboxes/filmstrip.md) (<kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>F</kbd>) and clicking a thumbnail in it.

How an image is processed is the subject of the [pixelpipe](pixelpipe/_index.md) and [modules](modules/_index.md) sections; this page and the [darkroom layout](darkroom-view-layout.md) page cover the view itself.

## Zoom and pan

Middle-click the center area to cycle between **fit to screen**, **1:1** and **2:1**.

Scroll with the mouse wheel to zoom between fit-to-screen and 1:1. Hold <kbd>Ctrl</kbd> while scrolling to extend the range from 2:1 up to 1:10. When zoomed in past the window, drag the image to pan.

## Working with modules

The image-processing modules in the right panel are organized into [workflow tabs](darkroom-view-layout.md#module-workflow-tabs) that follow the order of the pixelpipe. The recommended way to edit is to move through the tabs from left to right, and through each module stack from bottom to top.

Modules and their controls are fully navigable from the keyboard, and any module or control can be reached directly through the [global action search](../../getting-started/keyboard.md#vimkey-like-global-action-search) (<kbd>Ctrl</kbd>+<kbd>P</kbd>) or an [assigned shortcut](../../getting-started/keyboard.md#darkroom). The [anatomy of a module](pixelpipe/the-anatomy-of-a-module.md) page explains the common module controls (enable, reset, presets, multiple instances, masking & blending).

## On-image overlays and assessment

The [bottom toolbar](darkroom-view-layout.md#bottom-panel) gives quick access to the visual assessment overlays: ISO 12646 [color assessment](../toolboxes/color-assessment.md), [raw overexposed](../toolboxes/raw-overexposed.md) and [clipping](../toolboxes/clipping.md) warnings, [soft-proofing](../toolboxes/soft-proof.md), [gamut checking](../toolboxes/gamut.md), and [guides & overlays](../toolboxes/guides-overlays.md). The quick-access [styles](../toolboxes/styles.md) menu is also there.
