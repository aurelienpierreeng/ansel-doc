---
title: Shape manager
date: 2022-12-04T02:19:02+01:00
lastmod: 2026-09-12
id: shape-manager
aliases:
  - ../toolboxes/mask-manager
tags:
view: darkroom
---

The shape manager is a separate, floating window where you draw, name, group and delete the shapes an image is masked with, and decide which modules each of them applies to. Open or close it from its toggle button in the darkroom [bottom toolbar](../darkroom/darkroom-view-layout.md#bottom-panel).

It works on the same shapes as the per-module [masking & blending](../darkroom/masking-and-blending/_index.md) controls, in the _Drawn_ tab of the [left panel](../darkroom/darkroom-view-layout.md#left-panel): a shape drawn here is the same object a module's [drawn mask](../darkroom/masking-and-blending/masks/drawn.md) is built from, and vice-versa. What this window adds is the view across modules — every shape the image carries on one side, every group a module draws with on the other. It is from there that a shape is reused, or handed to a second module, without visiting each module in turn.

The window stays on top of the main window without taking focus, so you can keep drawing on the canvas while it is open. Move and resize it wherever suits your screen: it reopens where you left it, and each list keeps the height you dragged it to.

The shape manager works in the darkroom only. Leave it open while you switch to another view and its lists empty, the whole window greying out until you come back to the darkroom.

## One shape, several uses

A shape exists only once, and several groups can use it at the same time: the row naming it in a group is a use of the shape, not a copy of it.

What defines the shape — its position, its size, its outline — belongs to the shape itself and so holds everywhere: change it from one module and it changes in all the others. What describes a use — the _set operator_, the _polarity_, the _opacity_ and the order of application — belongs to the group and commits no one else.

Every action on this page reads that way:

- Attaching and grouping add a use. Nothing is moved or copied: the shape stays in the groups already using it.
- Detaching removes one use, and the shape survives with all the others.
- Deleting ends the shape, and all of its uses go with it.
- **Duplicate shape** is the only entry that really makes a second shape, independent of the first.

## The shape manager window

{{< figure src="views/toolboxes/shape_manager/shape-manager-window.en.png" alt="The shape manager window: the shape buttons and the All shapes and Module groups lists" class="align-left borderless framed tight" />}}

The window offers the shape buttons and two lists. The lists answer two different questions, and a shape a module uses appears in both — once as itself in _All shapes_, once as a member of that module's group in _Module groups_.

{{< param-table >}}
| **Shape buttons** {{< icon src="icon/icon-shapes.png" >}} <div>The five drawing tools — _Circle_, _Ellipse_, _Polygon_, _Brush_ and _Gradient_. See [creating a shape](#creating-a-shape).</div> |

| **All shapes** <div>The image's inventory: every shape and every group drawn on this image, whether or not a module uses it. The groups modules draw with come first, in pipeline order, as single rows that do not expand; a rule separates them from the groups no module uses yet and from every individual shape.</div> |

| **Module groups** <div>The groups the pipeline actually draws with: one row per module carrying a drawn mask, with the shapes it is built from nested inside it. Groups come in the order the [_Pipeline_ tab](../darkroom/darkroom-view-layout.md#module-workflow-tabs) lists modules in — and the list follows along when modules are reordered.</div> |
{{< /param-table >}}

Each new shape gets an automatic name made of its type (_brush_, _circle_, _ellipse_, _polygon_, _gradient_) and an incrementing number, and a group created for a module is named `Group <module name>`, after the module it serves. Double-click a top-level name in either list to rename it — meaningful names help a lot when reusing a shape across several modules. Press <kbd>Enter</kbd> to keep the new name or <kbd>Escape</kbd> to restore the previous one.

### Rows

A row carries some or all of the following, depending on the shape and on where the row sits.

**Indications**:
{{< param-table >}}
| {{< icon src="masks_union.jpg" alt="" >}} **Set operator**<div>How this row combines with the result built from the rows applied before it — [Union, Intersection, Difference or Exclusion](../darkroom/masking-and-blending/masks/set-operators.md). Never on the first row of a group, which has nothing before it to combine with.</div> |

| {{< icon src="icon/icon-polarity.png" alt="" >}} **Polarity**<div>**Invert shape** is on for this row: everything its shape does not enclose is selected instead.</div> |

| **Name**<div>The shape's or group's own name, the same on every row naming it.</div> |

| **Opacity**<div>Follows the name, as a percentage, and only when it is not 100%.</div> |

| {{< icon src="icon/icon-paperclip.png" alt="" >}} **Attached**<div>This shape or group is attached to at least one group. Hovering the icon lists them, one per line. Visible only on a top-level row.</div> |
{{< /param-table >}}

**Buttons**:
{{< param-table >}}
| {{< icon src="icon/icon-plus.png" alt="" >}} **Attach**<div>Attaches this row to the group selected in the _Module groups_ list. Only in the _All shapes_ list, and greyed out when it can do nothing — see [attaching to the selected group](#attaching-to-the-selected-group).</div> |

| {{< icon src="icon/icon-minus.png" alt="" >}} **Detach**<div>Detaches this shape from the group it sits in, on a row nested under a group. The shape itself is kept and stays available for reuse.</div> |

| {{< icon src="icon/icon-list.png" alt="" >}} **Module group management**<div>Opens the [module chooser](#the-module-chooser), which manages every module using this shape or group at once. Only in the _All shapes_ list.</div> |

| {{< icon src="icon/icon-trash.png" alt="" >}} **Delete**<div>Deletes this shape or group outright, on a top-level row. It is removed from every group holding it and from the list of shapes.</div> |
{{< /param-table >}}

### Selection

{{< figure src="views/toolboxes/shape_manager/shape-manager-selecting.en.png" alt="Several rows selected at the same level of the same group" class="align-left borderless framed" />}}

- <kbd class="mouse">Click</kbd> a row to display just that shape, or that whole group, on the canvas with its editing controls. This is the reliable way to grab one shape among many overlapping ones, and it works the other way round too: select a shape on the canvas, or in a module's _Drawn_ tab, and its row is highlighted here.
- <kbd>Ctrl</kbd>+<kbd class="mouse">click</kbd> (<kbd>⌘</kbd>+<kbd class="mouse">click</kbd> on macOS) adds a row to the selection or takes it back out.
- <kbd>Shift</kbd>+<kbd class="mouse">click</kbd> extends the selection to the row you click.
- <kbd class="mouse">Click</kbd> empty space to select nothing, which hides the shapes again.

{{< note >}}
Only rows that are peers — at the same level, and under the same group — can be selected together, so anything that does not qualify drops out of the selection.
{{< /note >}}

## Creating a shape

Click one of the five shape buttons and draw on the canvas, exactly as you would from a module's [_Drawn_ tab](../darkroom/masking-and-blending/masks/drawn.md#creating-a-shape) — the same creation mode, the same gestures, the same parameters. A shape drawn from these buttons belongs to no module: it lands in the _All shapes_ list, ready to be given to whichever modules you decide on afterwards.

To draw straight into an existing group instead, <kbd class="mouse">right-click</kbd> its row in the _Module groups_ list and pick a shape from **Add new shape …**. The shape is added to that group as soon as you finish drawing it.

## Attach a shape in a module

Attaching a shape to a module means adding it to the group that module draws with — one more [use](#one-shape-several-uses), which cannot disturb the modules already applying it.

A group cannot take a shape it already holds, at any depth: whatever would attach it there is greyed out for as long as it is in the group, directly or in one of the groups it contains.

There are two ways to do it, and they differ in what they act on.

### Attaching to the selected group

Select a group in the _Module groups_ list, then click {{< icon src="icon/icon-plus.png" alt="Plus" >}} on any row of the _All shapes_ list. The shape is attached to that group, applied last, combined with **Union**. Selecting a shape nested inside a group works too: the {{< icon src="icon/icon-plus.png" alt="Plus" >}} always attaches to the group that row belongs to.

### The module chooser

- <kbd class="mouse">Click</kbd> {{< icon src="icon/icon-list.png" alt="List" >}} on a row of the _All shapes_ list to open **Modules using this shape** — a window listing every module that can carry a drawn mask, disabled ones included. A module is ticked when the shape sits directly in its group.

{{< figure src="views/toolboxes/shape_manager/shape-manager-module-chooser.en.png" alt="The Modules using this shape window, with a tick box per module" style="width:50%" class="align-left borderless framed" />}}

- Tick a module to attach the shape, untick one to detach.
- Press **Apply** to save changes.

Once applied, a ticked module that has no group yet is given one, named after it, and the shape is put inside it; a module whose group is left empty by an untick loses it.

A box that could change nothing is greyed out, with the reason on its row: the shape already reaches the module through a nested group, attaching it would put the module's mask inside itself, or the group on offer brings no shape the module does not already apply.

{{< note >}}
Ticking one module and unticking another in the same pass is fine — the removals are applied first, so the two cannot collide. Only the boxes you actually moved are acted on, so a shape a module already carries is never rewritten.
{{< /note >}}

## Building a group

A group is a container holding shapes and other groups, in order. It is a recipe rather than a picture: what a module renders from its group is its [drawn mask](../darkroom/masking-and-blending/masks/drawn.md), and the mask the module finally blends with is built from that. The shape manager stays on the recipe side — it lists groups and the shapes in them, never masks. Hence the two lists: _All shapes_ holds every group the image carries, _Module groups_ only those a module draws with.

Groups come from two places:
- A module builds its own the first time you give it a shape, and names it after itself, `Group <module name>` — rename the module and the group follows.
- The ones you build yourself, with **New group from selection**, are named `Group <number>` and serve no module: they wait in the _All shapes_ list until you hand one to a module, which then renders it like any other shape. A group can serve several modules at once, and a module's own group can sit inside another group.

A group applies its shapes in list order: each one combines with the result of those before it through one of four [set operators](../darkroom/masking-and-blending/masks/set-operators.md). Order changes the result, which is what **Move up** and **Move down** in the context menu are for.

### Grouping shapes

Select the rows to group — one or several, in either list — and <kbd class="mouse">right-click</kbd> one of them.

{{< param-table >}}
| **New group from selection**<div>Gathers the selection into a new group named `Group <number>`, each member combined with **Union** by default. The group joins the _All shapes_ list, among the groups no module uses yet. Name it after what it gathers: that is what will tell it apart from the other `Group <number>`.</div> |

| **Attach to the group**<div>Lists every group of the image, module groups included, and attaches the selection to the one you pick, applied last, each member combined with **Union**. A group that can take none of the selection — it already holds the whole of it, at any depth, or it sits inside a selected group — is listed greyed rather than left out, so you can see where the shapes already are; picking a group that can take part of the selection attaches that part only. The selected groups themselves are not listed, nor are the groups a retouching module such as [_retouch_](../darkroom/modules/retouch.md) keeps for itself.</div> |
{{< /param-table >}}

A new group changes nothing in the image until a module uses it.
Nesting a group inside another attaches all of its shapes at once: add one to the nested group and every module using the holding group applies it straight away.

A shape can only repeat within a group through a nested group: the group refuses a shape it already holds, but accepts a group bringing it new ones, even if one of them is already there. In the _Module groups_ list, every application after the first has its name struck through and is marked _Already in '<group>'_, naming the group that holds that first application. It is a remark, not a warning: **Union** and **Intersection** give the same result the second time, but **Difference** and **Exclusion** compound, so a repeat can be exactly what you want.

## Detaching and deleting shapes

Where the row sits decides which of the two you are offered — a row nested under a group is one use of a shape, a top-level row is the shape itself — so the two are never on offer at once.

### Detaching a shape from a group

{{< param-table >}}
| {{< icon src="icon/icon-minus.png" alt="Minus" >}}, or **Remove shape from mask**<div>On a row nested under a group. Takes the shape out of that group and no other: the shape survives, still listed in _All shapes_ and still applied by every other module using it.</div> |
{{< /param-table >}}

### Deleting a shape or a group

{{< param-table >}}
| {{< icon src="icon/icon-trash.png" alt="Trash" >}}, or **Delete shape** / **Delete group**<div>On a top-level row. Deletes it for good: it is dropped from every group holding it and from the list of shapes, so every module applying it loses it at once. The _trash_ asks for confirmation first, unless you turn that off — see [Preferences > Security](../../preferences-settings/security.md).</div> |

| **Delete unused shapes**<div>Sweeps the image clean of every shape no group currently holds, in one go.</div> |
{{< /param-table >}}

Either way, a group left empty is deleted with its last member, and the group holding that one goes too if that empties it. A module left without a group has no drawn mask until you give it a shape again.

{{< note >}}
Ansel keeps every shape ever defined for an image until you explicitly remove it. If you export with the development history, all defined shapes are written to the XMP. A very long list of shapes can exceed the size limit of some file formats and make XMP writing fail on export — prune unused shapes when in doubt.
{{< /note >}}

## The context menu

<kbd class="mouse">Right-click</kbd> a row, or the empty space no row occupies, in either list. There is no single menu: it is assembled from the sections below, each separated from the next by a rule. A section you do not see is one whose question does not arise for the row you clicked.

Selecting several rows drops whatever only makes sense one row at a time: the parameter sliders, the four set operators, **Duplicate shape**, and the two entries a group opens with. The rest acts on the whole selection.

Rows deeper than the second level — the shapes of a group nested inside another group — are offered neither the combining and reordering entries nor **Remove shape from mask**: they belong to the nested group, not to the one whose row you opened. Open the menu on the row where they sit directly under their own group instead: under that group's row in the _All shapes_ list, or under its module's row in _Module groups_.

### Adjusting, combining and ordering

{{< figure src="views/toolboxes/shape_manager/shape-manager-context-menu.en.png" alt="The context menu opened on a shape sitting in a group" class="align-left borderless framed tight" />}}

On a single shape, and only while a group holds it: these sliders read and write the shape's row in a group, so a shape no group holds yet is offered none of them. On a top-level row they act through the first group holding the shape, which matters for **Opacity** — a property of the row rather than of the shape itself.

{{< param-table >}}
| **Parameter sliders**<div>**Size** and **Opacity** on every shape, **Fading** on all but a Gradient, which carries a **Curvature** instead, and **Rotation** on an Ellipse and on a Gradient. They set the shape's [parameters](../darkroom/masking-and-blending/masks/drawn.md#shape-parameters) precisely — the values the [mouse wheel](../darkroom/masking-and-blending/masks/drawn.md#mouse-wheel) reaches on the canvas — without selecting the shape there first.</div> |
{{< /param-table >}}

On a row sitting in a group, a shape or a nested group alike: these entries set how the row combines with the ones applied before it, and where it comes in that order.

{{< param-table >}}
| **Operation** | **Invert shape**<div>Inverts the polarity of each selected row within that group: everything it does not enclose is selected instead.</div> |
| | **Union** / **Intersection** / **Difference** / **Exclusion**<div>The [set operator](../darkroom/masking-and-blending/masks/set-operators.md) combining the row with the result built from the rows before it. On a single row only, combining being a question with no answer for several shapes at once.</div> |
{{< /param-table >}}

{{< param-table >}}
| **Move up** / **down**<div>Moves the selection within the group, which changes what it covers.</div> |
{{< /param-table >}}

### Adding to a group

{{< figure src="views/toolboxes/shape_manager/shape-manager-context-menu-group.en.png" alt="The context menu opened on a group row of the All shapes list" class="align-left borderless framed tight" />}}

These two entries appear on a group, wherever it sits. Empty space offers only the first, and what it draws there belongs to no group — see [creating a shape](#creating-a-shape).

{{< param-table >}}
| **Add new shape …**<div>Draws a new shape — _Brush_, _Circle_, _Ellipse_, _Polygon_ or _Gradient_ — straight into this group, as soon as you finish drawing it.</div> |
| **Attach shape …**<div>Lists the image's existing shapes and groups, each followed by the other modules already applying it, and attaches the one you pick to this group. Anything the group cannot take — it already holds it, at any depth, or the group would end up inside itself — is listed greyed rather than left out.</div> |
{{< /param-table >}}

### Grouping the selection

On any selection, one row or several, wherever the rows sit.

{{< param-table >}}
| **New group from selection** / **Attach to the group**<div>Puts the selected rows in a new group, or in an existing one — see [grouping shapes](#grouping-shapes).</div> |
{{< /param-table >}}

### Duplicating, detaching and deleting

These entries come last, and there the two levels part ways: a top-level row is the shape, a row inside a group is one use of it — see [detaching and deleting shapes](#detaching-and-deleting-shapes).

{{< param-table >}}
| **Duplicate shape**<div>On a single top-level shape. Makes an independent copy of it, belonging to no group; give it to modules as you would any other shape.</div> |
| **Delete shape** / **Delete group**<div>On top-level rows. Deletes the selection for good — **Delete group** when it is a single group, **Delete shape** otherwise.</div> |
| **Remove shape from mask**<div>On rows inside a group. Takes them out of that group without deleting them — they stay in _All shapes_, available to reuse elsewhere.</div> |
| **Delete unused shapes**<div>On every row and on empty space alike. Sweeps the image clean of every shape no group currently holds.</div> |
{{< /param-table >}}
