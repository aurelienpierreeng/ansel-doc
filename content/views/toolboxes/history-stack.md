---
title: History stack
date: 2022-12-04T02:19:02+01:00
lastmod: 2026-06-17
id: history-stack
tags:
view: darkroom
---

The **History of changes** module, in the darkroom [left panel](../darkroom/darkroom-view-layout.md#left-panel), shows and lets you navigate the [history stack](../darkroom/pixelpipe/history-stack.md) of the current image.

It lists every change of state — a module being enabled, disabled, moved, or having a parameter changed — for the current image, newest at the top. Each entry is one user change, so a module can appear several times.

## Navigating the history

- **Click** an entry to return the image to that point in its history.
- **<kbd>Shift</kbd>+click** an entry to expand the corresponding module in the right-hand panel **without** changing the current edit — useful for inspecting a step.
- **Hover** an entry for a tooltip listing exactly what changed in that step compared to the previous one, which helps track down unintended adjustments.

The selected history state is remembered: it is safe to quit, leave the darkroom or switch image after stepping back, and you will return to the same state.

{{< warning >}}
If you select an earlier entry and then make a new change, every step **above** the selected one is discarded. It is easy to lose work this way — <kbd>Ctrl</kbd>+<kbd>Z</kbd> can usually undo it.
{{< /warning >}}

## Compressing, resetting and reusing

These operations now live in the [global menu](../global-menu.md), so they work on the whole selection and not just the open image:

- **Compress history** (_Edit → Compress history_) collapses the stack to the shortest sequence reproducing the current image.
- **Delete history** (_Edit → Delete history_) discards the stack and resets the image.
- **Create a style** (_Styles → Create new style…_) turns the current history into a reusable [style](styles.md).
- **Copy / paste history** (_Edit → Copy history / Paste history_) transfers an edit to other images. See [copy and paste history](../lighttable/history-copy-paste.md) for how the merge works.
