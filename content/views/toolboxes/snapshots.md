---
title: Snapshots
date: 2022-12-04T02:19:02+01:00
lastmod: 2026-06-17
id: snapshots
tags:
view: darkroom
---

Store snapshots of the center image and compare them against the current edit.

A snapshot is a frozen bitmap of the darkroom center view, taken at any point during editing and later overlaid onto the current view for a side-by-side comparison while you tune a module. It can also be combined with the [history of changes](history-stack.md) to compare a snapshot against different stages of development.

## Taking and comparing snapshots

Click **take snapshot** to capture the current center view. Each snapshot is listed above the button; its name reflects the module selected in the history and its position at the time it was taken.

Click a snapshot's name to display it: this splits the view between the saved snapshot and the current image. Drag the split line to move it. Hover the split line to reveal a small rotation icon at its center; click it to rotate the split orientation (the snapshot and current image cycle between top/bottom/left/right). An arrow marked **S** always indicates which side is the snapshot.

Click the snapshot name again to hide the overlay and return to editing. Use the module's reset button to clear all snapshots.

{{< note >}}
Snapshots are kept for the duration of your Ansel session, so you can also use them to compare against a duplicate edit of the same image: take a snapshot, switch to the other version, and enable the snapshot overlay as usual.
{{< /note >}}
