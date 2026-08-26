---
title: Shape manager
date: 2022-12-04T02:19:02+01:00
lastmod: 2026-08-23
id: shape-manager
aliases:
  - ../toolboxes/mask-manager
tags:
view: darkroom
---

The shape manager is a separate, floating window that creates, renames, edits, groups and deletes the drawn shapes used by masks. Open or close it from its toggle button in the darkroom [bottom toolbar](../darkroom/darkroom-view-layout.md#bottom-panel). It stays on top of the main window without stealing focus, so you can keep drawing on the canvas while it's open, and you're free to move it wherever suits your screen.

It shares its shape system with the per-module [masking & blending](../darkroom/masking-and-blending/_index.md) controls (found in the _Masking & Blending_ tool of the [left panel](../darkroom/darkroom-view-layout.md#left-panel), for whichever module currently has focus): a shape drawn here is the same object a module can use as a mask, and vice-versa.

The top row of buttons creates new shapes — the same Brush, Circle, Ellipse, Polygon and Gradient tools as the [drawn mask](../darkroom/masking-and-blending/masks/drawn.md) interface. Below them is a list of every mask and shape defined for the current image. You can also right-click empty space in that list and choose **Add new shape …** to create a standalone shape directly here, without going through a module.

Groups of shapes that form a module's mask appear with a heading of the form `Mask <module name>`, with their component shapes nested below. After the groups comes a list of every individual shape that exists for the image but isn't (yet) part of any mask. A marker to the right of a shape name indicates that it is in use by a mask.

## Shapes

Each new shape gets an automatic name made of its type (_brush_, _circle_, _ellipse_, _polygon_, _gradient_) and an incrementing number. Double-click a name to rename it — meaningful names help a lot when reusing a selection across masks.

- <kbd class="mouse">Click</kbd> a shape name to display just that shape and its controls on the canvas. This is the reliable way to grab one shape among many overlapping ones. Selecting a shape on the canvas from within a module's mask controls likewise highlights it here.
- <kbd class="mouse">Right-click</kbd> a top-level shape name (one not nested in a group) for **Duplicate shape**, **Delete shape**, and **Cleanup unused shapes** (removes every shape in the list that no mask currently uses). The same menu also exposes the shape's size, feathering, rotation and opacity as sliders you can adjust right there, without selecting it on the canvas first.

{{< note >}}
Ansel keeps every shape ever defined for an image until you explicitly remove it. If you export with the development history, all defined shapes are written to the XMP. A very long list of shapes can exceed the size limit of some file formats and make XMP writing fail on export — prune unused shapes when in doubt.
{{< /note >}}

## Masks and groups

A mask is a group of shapes applied in list order (top to bottom), each combining with the running mask through one of four [set operators](#set-operators). Because order matters, shapes can be moved up and down the list.

<kbd class="mouse">Click</kbd> a group name to expand it and show its shapes (also drawn on the image). Showing a mask from within a module expands the matching group here.

<kbd class="mouse">Right-click</kbd> a group name for:

{{< param-table margin-left="1rem" >}}
| **Add new shape …**<div>Creates a shape and adds it directly into this group.</div> |
| **Add shape …**<div>Adds one of the image's existing, currently-unused shapes into this group.</div> |
| **Cleanup unused shapes**<div>Removes every shape in the list that no mask currently uses.</div> |
| **Delete mask**<div>Removes the whole group.</div> |
{{< /param-table >}}

<kbd class="mouse">Right-click</kbd> a shape inside a group to control its contribution:

{{< param-table margin-left="1rem" >}}
| **Operation** | **Invert shape**<div>Inverts the polarity of the shape.</div> |
| | **Union** / **Intersection** / **Difference** / **Exclusion**<div>The [set operator](#set-operators) combining this shape with the preceding mask. Only offered when exactly one shape is selected.</div> |
{{< /param-table >}}

{{< param-table margin-left="1rem" >}}
| **Move up** / **Move down**<div>Reorders the shape within the group.</div> |
| **Remove shape from mask**<div>Takes the shape out of the group without deleting the shape itself — it remains in the image's shape list, available to reuse elsewhere.</div> |
{{< /param-table >}}

To build your own group, select several shapes, right-click and choose **Group the forms**.

## Set operators

Set operators define how each shape combines with the mask built from the shapes above it, taking a pixel to be "selected" when its opacity is greater than zero. The examples below combine a Gradient with a Polygon, showing the effect of each operator applied to the Polygon:

{{< gallery cols="2" >}}
{{< figure src="mask-manager_ex1.jpg" caption="A gradient shape" />}}
{{< figure src="mask-manager_ex2.jpg" caption="A polygon shape" />}}
{{< /gallery >}}

{{< param-table image-height="9rem" >}}
| {{< icon src="masks_union.jpg" alt="" >}} **Union**<div>The default. The result selects pixels that are in the existing mask **or** in the added shape (the maximum value is taken where they overlap).</div> | ![](mask-manager_ex3.jpg) |
| {{< icon src="masks_intersection.jpg" alt="" >}} **Intersection**<div>The result selects only pixels that are in **both** the existing mask **and** the added shape (the minimum value is taken where they overlap) — useful to "imprint" one shape onto another.</div> | ![](mask-manager_ex4.jpg) |
| {{< icon src="masks_difference.jpg" alt="" >}} **Difference**<div>The result keeps pixels that are in the existing mask but **not** in the added shape — useful to cut a region out of a selection.</div> | ![](mask-manager_ex5.jpg) |
| {{< icon src="masks_exclusion.jpg" alt="" >}} **Exclusion**<div>The result selects pixels that are in the existing mask **or** the added shape but **not both** (an exclusive or).</div> | ![](mask-manager_ex6.jpg) |
{{< /param-table >}}
