---
title: Drawn masks
date: 2022-12-04T02:19:02+01:00
lastmod: 2026-08-29
id: drawn
weight: 20
draft: false
---

A drawn mask builds the per-pixel opacity handed to [blending](../_index.md) from shapes you draw directly on the image, so a module's effect lands exactly where you place them.

Shapes are stored internally as vectors, rendered at whatever resolution the pixelpipe needs, and expressed in the coordinate system of the original image. A shape therefore keeps covering the same part of the picture no matter what you change elsewhere in the edit -- with one visual side effect worth knowing about, see [shape distortions](#shape-distortions) below. Once drawn, a shape can be adjusted, removed, or reused by any other module.

Drawn masks are handled from the _Drawn_ tab of the _Masking & Blending_ tool, in the darkroom [left panel](../../darkroom-view-layout.md#left-panel), for whichever module currently has focus. The tab works alongside the [_Parametric_](./parametric.md) and [_Raster_](./raster.md) ones, since any combination of masking methods can be active at once (see [combining masks](../_index.md#combining-masks)).

Blending has to be enabled for the module before any of it responds: the checkbox above the row of tabs, reading _Enable in_ followed by the module's name, is what arms the tool, and everything below it stays grayed out until you check it.

## The Drawn panel

{{< figure src="mask/drawn/mask-drawn.en.png" class="align-left borderless framed" />}}

{{< param-table >}}
| **Disable**<div>Turns drawn masking back off when you want it out of the way; the shapes stay attached and come back with it.</div> |
| **Mask name**<div>A text field naming this module's mask. It starts out showing `Mask <module name>` as a placeholder; type your own name and press <kbd>Enter</kbd> to replace it. Meaningful names pay off as soon as several modules carry masks.</div> |
| {{< icon src="icon/icon-polarity.png" >}} **Polarity**<div>Reverses the polarity of the whole drawn mask. A circle, by default, restricts the module to the area inside it; flipping the polarity applies the module everywhere _except_ inside that circle.</div> |
| {{< icon src="icon/icon-edit-shape.png" >}} **Show and edit mask elements**<div>Displays the mask's shapes on the canvas so you can edit them.<br>
<kbd>Ctrl</kbd>+<kbd class="mouse">click</kbd> (<kbd>⌘</kbd>+<kbd class="mouse">click</kbd> on macOS) enters _restricted_ edit mode instead, in which a shape's overall position and size are locked -- neither dragging nor scrolling over it moves or resizes it -- and only its individual nodes and segments respond. This is the safe way to fine-tune Polygon and Brush shapes.</div> |
| **Shape list**<div>The shapes making up this module's mask, described in [the shape lists](#the-shape-lists) below.</div> |
| **Attach shapes**<div>Switches the list above to every shape defined for the image, so you can attach or detach them. See [reusing a shape](#reusing-a-shape).</div> |
| **Shape buttons** {{< icon src="icon/icon-shapes.png" >}} <div>Five buttons at the bottom right create a new shape: Circle, Ellipse, Polygon, Brush and Gradient. See [creating a shape](#creating-a-shape).</div> |
| **Mouse wheel**<div>A second collapsible section, holding the grid that decides which property of a shape each wheel combination edits. It is shared by every mask of every module -- see [the mouse wheel](#the-mouse-wheel).</div> |
{{< /param-table >}}

{{< param-table >}}
| **Brush options** | **Brush strokes smoothing** (_low_, _medium_ or _high_)<div>how many nodes the conversion produces -- more smoothing means fewer nodes, which eases later editing at the expense of accuracy</div> |
| | **Pen pressure mapping** <div>applies a graphics tablet's recorded pressure to the brush's width, hardness or opacity. _Relative_ scales the attribute between zero and its default value, _absolute_ maps pressure straight onto the 0% to 100% range</div> |
{{< /param-table >}}

## The shape lists

{{< gallery cols="2" >}}
{{< figure src="mask/drawn/mask-drawn-shape-list.en.png" caption="The shape list." class="framed" />}}
{{< figure src="mask/drawn/mask-drawn-shape-list-all.en.png" caption="The all shape list." class="framed" />}}
{{< /gallery >}}


The panel has two lists that share the same slot; the _Attach shapes_ button picks which one is showing.

The **Shape list** is the default view and holds the shapes this module's mask is built from, applied in list order from top to bottom. Each row carries, from left to right: the [set operator](../../../toolboxes/shape-manager.md#set-operators) combining that shape with the ones above it, an icon if its polarity is inverted, its name, an _unlink_ icon that detaches the shape from this mask while keeping it available elsewhere, and a _trash_ icon that deletes the shape outright. Right-clicking a row opens the shape-level part of [the context menu](#the-context-menu) — its parameter sliders, the **Operation** submenu and **Move Up** / **Move Down** — which is handy for a shape that is hard to reach on the canvas, or hidden behind others.

The **All-shapes list**, shown while _Attach shapes_ is pressed, lists every shape defined for the current image. A checkbox on each row attaches it to this module's mask or detaches it, and its name can be edited in place by double-clicking.
{{< figure src="mask/drawn/mask-drawn-shape-list-all2.en.png" class="align-left borderless framed" />}}
A row reading `Already in <group>` is greyed out because the shape is part of a group that is itself already attached, so it is spoken for. Right-clicking a row here offers only **Duplicate** and **Rename**.

## The mouse wheel

{{< param-table image-height="13rem" >}}
| ![](mask/drawn/mask-drawn-wheel.en.png?class=framed) | Turning the wheel with the pointer over a shape edits one of its properties, and which combination edits which property is your call. The _Mouse wheel_ collapsible section, at the bottom of the _Drawn_ tab beside _Brush options_, holds a grid with one row per wheel combination and one column per property it can reach; ticking a cell maps that row to that property. No combination carries a meaning of its own, so any of them can be pointed at any property, or at none.|
{{< /param-table >}}

Out of the box, the rows are mapped like this: 

{{< table >}}
| Wheel combination | Default property |
| --- | --- |
| <kbd class="mouse">Scroll</kbd> | Size / Fade |
| <kbd>Shift</kbd>+<kbd class="mouse">scroll</kbd> | Hardness / Curvature |
| <kbd>Ctrl</kbd>+<kbd class="mouse">scroll</kbd> (<kbd>⌘</kbd>+<kbd class="mouse">scroll</kbd> on macOS) | Opacity |
| <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd class="mouse">scroll</kbd> (<kbd>⌘</kbd>+<kbd>Shift</kbd>+<kbd class="mouse">scroll</kbd> on macOS) | Rotation |
{{< /table >}}

The columns are the properties themselves:

{{< param-table >}}
| **Size / Fade**<div>The size of the shape, and for a Gradient the extent of its fade -- the value the context menu calls _Size_, or _Fade_ on a Gradient.</div> |
| **Hardness / Curvature**<div>The width of the feathering, and for a Gradient the curvature of its line -- the context menu's _Fading_, or _Curvature_ on a Gradient.</div> |
| **Opacity**<div>How strongly the shape contributes to the mask.</div> |
| **Rotation**<div>The orientation of an Ellipse or of a Gradient.</div> |
| **Nothing**<div>Unmaps the row: that combination is then ignored over a shape.</div> |
{{< /param-table >}}

Two columns carry two names because a Gradient spells those properties its own way, exactly as [the context menu](#over-the-shape-itself) renames the matching sliders. One cell covers both vocabularies.

The grid is application-wide. Which property the wheel edits is a habit of yours rather than a property of one shape or of the module owning the mask, so a change made from one module's _Drawn_ tab applies to every mask of every module, and it is remembered between sessions.

A shape only answers for the properties it actually has. A Circle, a Polygon and a Brush have no rotation, so a combination mapped to _Rotation_ does nothing over them, just like a row set to _Nothing_.

{{< note >}}
Because the mapping is yours to set, the lists below name the property each shape reads, not the keys that reach it: read _Size_ as "whichever combination is mapped to _Size_" -- <kbd class="mouse">scroll</kbd> alone, unless you changed it.
{{< /note >}}

## Shapes

Five shapes are available. The wheel acts in creation as well as in edit mode, wherever the pointer sits over the shape.<br>

### Shape actions

{{< param-table indent="0" >}}
| **Circle** | <div>A disc with a soft edge, placed with a single click.</div> |
| | <div>
- _Size_: diameter
- _Hardness_: width of the feathering
</div> |

| **Ellipse** | <div>Behaves like the Circle, with four nodes on its outline to stretch it.</div> |
| | <div>
- _Size_, _Hardness_: as for the Circle
- _Rotation_: turns the ellipse in precise increments
- <kbd class="mouse">Drag</kbd> a node: eccentricity
- <kbd class="mouse">Drag</kbd> the border ring: rotation, with no modifier needed
- <kbd>Shift</kbd>+<kbd class="mouse">click</kbd> inside the shape: switches the feathering between equidistant and proportional decay
</div> |

| **Polygon** | <div>A free-form outline through three or more nodes, joined by smooth curves by default.</div> |
| | While creating:
<div>
- <kbd class="mouse">Click</kbd>: adds a node
- <kbd>Ctrl</kbd>+<kbd class="mouse">click</kbd> (<kbd>⌘</kbd>+<kbd class="mouse">click</kbd> on macOS): adds a sharp corner instead
- <kbd>Backspace</kbd>: removes the node you just placed
- <kbd class="mouse">Click</kbd> near the first node, or <kbd>Enter</kbd>: closes the shape
</div> | |
| | While editing:
<div>
- <kbd class="mouse">Drag</kbd> a node or a segment: reshapes the outline
- <kbd class="mouse">Click</kbd> a node: reveals its curvature handle, which can then be dragged
- <kbd class="mouse">Drag</kbd> a control point on the border: adjusts the feathering around that part only
- _Size_: resizes the shape
- _Hardness_: border width, from anywhere inside the shape
- _Size_ and _Hardness_ act on the selected node alone when one is selected, and on every node otherwise
</div> | |

| **Brush** | <div>A painted stroke, converted into connected nodes when you release the button; those nodes are then edited exactly like a Polygon's.</div> |
| | <div>
- <kbd class="mouse">Left-click</kbd> and <kbd class="mouse">drag</kbd>: paints the stroke
- _Size_ while drawing: brush size
- Once the stroke is painted, _Size_ and _Hardness_ act on its nodes exactly like a Polygon's: the selected node alone when one is selected, every node otherwise
</div> |

| **Gradient** | <div>A linear gradient running from a line you place to the edge of the image. A single click places the 50% opacity line, and dotted lines mark where the opacity reaches 100% and 0%. Each new gradient reuses the extent, curvature and rotation of the last one you placed or edited.</div> |
| | <div>
- _Size_, the gradient's _Fade_: extent, the distance between the two dotted lines
- _Hardness_, the gradient's _Curvature_: bends the line into a curve
- _Rotation_: turns the gradient in precise increments
- <kbd class="mouse">Double-click</kbd>: resets the curvature
- <kbd class="mouse">Drag</kbd> the pivot at the center of the line: rotation
- <kbd>Shift</kbd>+<kbd class="mouse">click</kbd>, while still in creation mode: switches the opacity transition between a _linear_ ramp and a _sigmoidal_ (S-curve) one, which concentrates the transition closer to the center line. The choice sticks for the gradients you create afterwards
</div> |
{{< /param-table >}}

{{< note >}}
Depending on the module and the image, a gradient can provoke banding artifacts. Activating the [_dithering_](../../modules/dithering.md) module alleviates this.
{{< /note >}}

### Anatomy of a shape

Every editing gesture acts on whatever sits under the pointer, so the elements a shape is made of are worth naming apart. Which of them a shape has depends on its type: a Circle has none of them, a Gradient has a pivot instead, an Ellipse carries four nodes, and a Polygon and a Brush carry all of them.

The nodes of the shape under the pointer are drawn along with its two lines, and the two kinds of handle appear on one node at a time -- the one you last clicked. The hint at the right of the title bar names the element the pointer is over and what a drag there will do.

{{< param-table image-height="5rem" gutter="0rem" image-crop="square" >}}
| **Lines** | **Solid** (shape) ![](mask/drawn/mask-drawn-shape-anat-line.png) | <div>The solid line, the outline proper: on a Circle, an Ellipse and a Polygon it encloses the area the mask covers at full strength, and the feathering starts there. A Brush draws it down the middle of its stroke instead, and a Gradient draws it as the 50% opacity line you placed.</div> | 
| | **Dashed** (border)![](mask/drawn/mask-drawn-shape-anat-border.png) | <div>The dashed line running alongside the shape line, marking the far end of the feathering: the mask fades from full strength at the shape line to nothing here, and the distance between the two is what _Hardness_ -- the context menu's **Fading** -- sets. A Gradient has two of them, one where the opacity reaches 100% and one where it reaches 0%, spaced by its _Fade_. It is part of the shape rather than a handle, so dragging it moves the whole shape -- except on an Ellipse, where it is the ring that rotates the shape.</div> |
| | **Dotted** (guide) ![](mask/drawn/mask-drawn-shape-anat-dotted.png) | <div>A guide rather than a part of the shape. A dotted line is drawn while a gesture is under way, to show where it is heading, and it contributes nothing to the mask: no opacity of its own, and nothing to grab or drag. A Polygon draw the stretch running from the last node you placed to the pointer this way while you create them, and a Gradient draws its axis right across the image while you turn it. Each goes as soon as the gesture ends.</div> |
{{< /param-table >}}

{{< param-table image-height="5rem" image-crop="square" >}}
| **Arrow** ![](mask/drawn/mask-drawn-shape-anat-arrow.png) | <div>The tie between a clone or heal shape and its _source_ -- the patch of the image it copies its pixels from -- and so [_retouch_](../../modules/retouch.md) shapes only. It runs from the source to the shape and its head points at the shape, which is what tells you which way the pixels travel. It lights up while the source is under the pointer, where <kbd class="mouse">drag</kbd> moves the sampled area without moving the shape itself. Where the two overlap there is no room for the shaft, so only the head is drawn, halfway between them. Being a guide, it is dotted and adds nothing to the mask.</div> |
{{< /param-table >}}

What follows applies mainly to **Polygon** and **Brush** shapes:

{{< param-table image-height="5rem" image-crop="square" >}}
| **Nodes** ![](mask/drawn/mask-drawn-shape-anat-nodes.png) | <div>A point the outline runs through, drawn round where the outline curves through it and square where it turns a corner -- a _cusp_. <kbd class="mouse">click</kbd> it to select it, which is what reveals its handles. <kbd class="mouse">Drag</kbd> one to move it.</div> | 

| **Segments** ![](mask/drawn/mask-drawn-shape-anat-segments.png) | <div>The stretch of outline between two consecutive nodes. Its shape is not its own: each of the two nodes it joins lends it one curvature handle, and so it leaves a round node on a curve and a cusp node in a straight line. Between two round nodes it curves along its whole length, between two cusps it runs dead straight, and between one of each it does both -- curved at the round end, straightening into the cusp.<br>
__Polygon and Brush only__: <kbd class="mouse">Drag</kbd> a segment to move both of those nodes together, which slides it without changing its curve, and <kbd>Ctrl</kbd>+<kbd class="mouse">click</kbd> (<kbd>⌘</kbd>+<kbd class="mouse">click</kbd> on macOS) to insert a node into it. </div> |
{{< /param-table >}}

{{< param-table image-height="5rem" gutter="0rem" image-crop="square" >}}
| **Handle** | **Curvature** ![](mask/drawn/mask-drawn-shape-anat-handle-curve.png) | <div>A small round handle joined to its node by a line, setting the direction and the strength of the curve running through that node, and so bending the two segments that meet there at once. There is one per node, not one per segment: both sides are derived from it symmetrically, which is what keeps the outline smooth across the node. It belongs to the nodes of a Polygon and of a Brush, shows on the selected node only, and a cusp node has none until it is switched back to a round one. <kbd class="mouse">Drag</kbd> it to bend the outline; **Reset round node** in [the context menu](#over-a-node) discards it and restores the automatically computed curve.</div> |

| | **Hardness** ![](mask/drawn/mask-drawn-shape-handle-border.png) | <div>A small square handle sitting on the border line, on the axis running outwards from its node; dragging it slides along that axis and sets the border of that one node instead of the whole shape's -- how wide the feathering is there on a Polygon, how wide the stroke is there on a Brush. Like the curvature handle it belongs to the nodes of a Polygon and of a Brush, and shows on the selected node only.</div> |

{{< /param-table >}}

## Creating a shape

Click one of the five shape buttons to enter creation mode for that shape. The mouse cursor turns into a cross over the image, confirming that the next click will place a shape rather than interact with the picture.

{{< note >}}
Creation mode then stays active: as soon as one shape is finished, another of the same type begins, so you can place several in a row without going back to the button.
{{< /note >}}

Two shapes depart from that cursor. The Brush hides the cursor entirely and draws its own filled circle instead, showing the current brush size and hardness at the pointer. The Polygon switches to a pointing hand as you come back within reach of your first node, telling you that clicking there will close the outline.

To leave creation mode, click the shape's button again, press <kbd>Escape</kbd>, or right-click the canvas and choose **Done shape creation**. Any of these drops you into edit mode with the shapes you have placed.

The [wheel](#the-mouse-wheel) adjustments made on a shape being created also update the _defaults_ for that shape type, which the next shape you create will start from.

{{< note >}}
Scrolling up increases the value being adjusted. [Preferences > Invert the direction of the mouse vertical scroll](../../../../preferences-settings/darkroom.md) reverses this -- a general scroll-direction setting that affects every slider in Ansel, not just masks.
{{< /note >}}

## Editing a shape

The {{< icon src="icon/icon-edit-shape.png" alt="Show and edit mask elements" >}} button displays the mask's shapes on the canvas.<br>
<br>
<kbd class="mouse">Click</kbd> on a shape on the canvas to select it -- it is highlighted in the [shape list](#the-shape-lists) at the same time. Selection works both ways: click an entry in the list and the view centers on the matching shape.
You can then <kbd class="mouse">Click</kbd> on any of [the elements](#anatomy-of-a-shape) the shape can contain.

<kbd class="mouse">Drag</kbd> a shape to move it as a whole, or one of its elements -- segment, node or handle -- to reshape it.

The wheel edits whichever property you mapped it to in [the mouse wheel](#the-mouse-wheel) grid -- by default the shape's size, its feathering with <kbd>Shift</kbd>, and its opacity with <kbd>Ctrl</kbd>.

For per-shape parameters, <kbd class="mouse">right-click</kbd> on the shape and work from [the context menu](#the-context-menu).

## Removing a shape

There are two distinct outcomes, and the menu keeps them apart:

- **Remove shape from mask** detaches the shape from this module's mask. The shape survives, still listed for the image and still usable by other modules — this is what the _unlink_ icon in the Shape list does too.
- **Delete shape** removes it altogether, everywhere it was used. The _trash_ icon in the lists does the same.

With the pointer over one of a Polygon's or Brush's nodes, the menu offers **Delete node** instead, which removes that single node rather than the shape.

## Reusing a shape

A shape is a single object shared by every mask that uses it: edit it in one module and every other module using it follows.

Press **Attach shapes** to swap the panel's list for every shape defined on the image, then tick a shape's checkbox to add it to the current module's mask, or untick it to detach it. Shapes greyed out as **_Already in '&lt;group&gt;'_** are reached through a group that is itself attached.

The [shape manager](../../../toolboxes/shape-manager.md) covers the same shapes from a separate window, where they can also be grouped, reordered and renamed across all modules at once.

## The context menu

{{< param-table image-height="13rem" >}}
| ![](mask/drawn/mask-drawn-contextmenu.en.png?class=framed) | Right-clicking on the canvas opens a menu headed by the shape's name. What follows depends on one thing: what sits under the pointer. There are four cases.<br>
<br>
The same menu is reachable without the canvas: right-clicking a row in the panel's [Shape list](#the-shape-lists) opens its shape-level part, described under [over the shape itself](#over-the-shape-itself) below, minus the removal entries — the row's own _unlink_ and _trash_ icons cover those.|
{{< /param-table >}}

### While creating a shape

{{< param-table >}}
| **Close path** (or <kbd>Enter</kbd>)<div>Closes the outline, once at least three nodes are placed. Polygon only.</div> |
| **Remove last point** (or <kbd>Backspace</kbd>)<div>Deletes the node you just placed. Polygon only.</div> |
| **Done shape creation** (or <kbd>Escape</kbd>)<div>Leaves creation mode.</div> |
{{< /param-table >}}

### Over the shape itself

The menu opens with sliders for the shape's parameters. Which ones depends on the shape:

{{< table >}}
| Shape | Sliders |
| --- | --- |
| Circle, Polygon, Brush | **Size**, **Fading**, **Opacity** |
| Ellipse | **Size**, **Fading**, **Rotation**, **Opacity** |
| Gradient | **Curvature**, **Fade**, **Rotation**, **Opacity** |
{{< /table >}}

They set the same values [the mouse wheel](#the-mouse-wheel) reaches directly on the canvas, listed per shape under [Shapes](#shapes) below; the menu is simply the precise way in. **Opacity** is how strongly this one shape contributes to the mask.

{{< param-table >}}
| **Operation** | **Invert**<div>Inverts this shape's polarity within the mask.</div> |
| | **Union**, **Intersection**, **Difference**, **Exclusion**<div>How this shape combines with the ones above it in the mask. See [set operators](../../../toolboxes/shape-manager.md#set-operators).</div> |
{{< /param-table >}}

{{< param-table >}}
| **Move up** / **Move down**<div>Reorders the shape within the mask.</div> |
| **Remove shape from mask** (or <kbd>Delete</kbd>)<div>Detaches it, leaving it available to other modules.</div> |
| **Delete shape**<div>Deletes it for good.</div> |
{{< /param-table >}}

### Over a node

Polygon and Brush only. The parameter sliders appear as above, followed by the entries below. The **Operation** submenu and the reordering entries are not offered here, and **Delete node** takes the place of **Remove shape from mask** and **Delete shape** — so a slip of the mouse deletes a node, never the whole shape.

{{< param-table >}}
| **Switch to round node** / **cusp node** (or <kbd>Ctrl</kbd>+<kbd class="mouse">click</kbd>) (<kbd>⌘</kbd>+<kbd class="mouse">click</kbd> on macOS)<div>Turns a corner into a smooth curve, or the reverse.</div> |
| **Reset round node**<div>Discards curvature handles you dragged by hand and restores the automatically computed curve.</div> |
| **Delete node** (or <kbd>Delete</kbd>)<div>Removes that node only, leaving the rest of the shape.</div> |
{{< /param-table >}}

### Over a segment

Polygon and Brush only. This adds one entry to the shape-level ones (**Operation**, **Remove shape from mask** and **Delete shape**); the parameter sliders and the reordering entries are not shown.

{{< param-table >}}
| **Add a node here** (or <kbd>Ctrl</kbd>+<kbd class="mouse">click</kbd>) (<kbd>⌘</kbd>+<kbd class="mouse">click</kbd> on macOS)<div>Inserts a node at that point of the outline.</div> |
{{< /param-table >}}

## Shape distortions

Because a shape is stored in the coordinate system of the original image, it travels up the pixelpipe before the module uses it and draws it on screen. Any distorting module active in between -- [_lens correction_](../../modules/lens-correction.md) or [_rotate and perspective_](../../modules/rotate-perspective.md), for instance -- therefore distorts the shape too, on screen and in the exported image alike: circles can render as ellipses, and gradient lines can end up curved.

To draw a shape that follows the subject accurately despite this, prefer a Polygon over a Circle or an Ellipse, since its extra nodes let you compensate for the distortion. For a Gradient, bending its line counteracts the simpler distortion that lens correction introduces.

## Panning and zooming

Mouse actions over a shape, or over its nodes and handles, apply to that shape. Away from it, dragging and scrolling pan and zoom the center view as usual, so there is no need to leave creation or edit mode to reposition the canvas.

On a zoomed-in image, dragging a shape towards the edge of the viewport pans the view in that direction on its own, and keeps panning while you hold the pointer there, so a shape can be moved past the visible area without interrupting the drag. The pan accelerates the closer to the edge you get. It also works while placing a new shape, but not while painting a Brush stroke, where dragging is the drawing action itself.
