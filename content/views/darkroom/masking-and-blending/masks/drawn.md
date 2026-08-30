---
title: Drawn masks
date: 2022-12-04T02:19:02+01:00
lastmod: 2026-08-30
id: drawn
weight: 20
draft: false
---

A drawn mask builds the per-pixel opacity handed to [blending](../_index.md) from shapes you draw directly on the image, so a module's effect lands exactly where you place them.

Shapes are stored internally as vectors, rendered at whatever resolution the pixelpipe needs, and expressed in the coordinate system of the original image. A shape therefore keeps covering the same part of the picture no matter what you change elsewhere in the edit -- with one visual side effect worth knowing about, see [shape distortions](#shape-distortions) below. Once drawn, a shape can be adjusted, removed, or reused by any other module.

Drawn masks are handled from the _Drawn_ tab of the _Masking & Blending_ tool, in the darkroom [left panel](../../darkroom-view-layout.md#left-panel), for whichever module currently has focus. The tab works alongside the [_Parametric_](./parametric.md) and [_Raster_](./raster.md) ones, since any combination of masking methods can be active at once (see [combining masks](../_index.md#combining-masks)).

Blending has to be enabled for the module before any of it responds: the checkbox above the row of tabs, reading _Enable in_ followed by the module's name, is what arms the tool, and everything below it stays grayed out until you check it.

## The Drawn panel

{{< figure src="mask/drawn/mask-drawn.en.png" class="align-left borderless framed tight" />}}

{{< param-table >}}
| **Disable**<div>Turns drawn masking back off when you want it out of the way; the shapes stay attached and come back with it.</div> |
| **Mask name**<div>A text field naming this module's mask. It starts out showing `Mask <module name>` as a placeholder; type your own name and press <kbd>Enter</kbd> to replace it. Meaningful names pay off as soon as several modules carry masks.</div> |
| {{< icon src="icon/icon-polarity.png" >}} **Polarity**<div>Reverses the polarity of the whole drawn mask. A circle, by default, restricts the module to the area inside it; flipping the polarity applies the module everywhere _except_ inside that circle.</div> |
| {{< icon src="icon/icon-edit-shape.png" >}} **Show and edit mask elements**<div>Displays the mask's shapes on the canvas so you can edit them.<br>
<kbd>Ctrl</kbd>+<kbd class="mouse">click</kbd> (<kbd>⌘</kbd>+<kbd class="mouse">click</kbd> on macOS) enters _restricted_ edit mode instead, in which a shape's overall position and size are locked -- neither dragging nor scrolling over it moves or resizes it -- and only its individual nodes and segments respond. This is the safe way to fine-tune Polygon and Brush shapes.</div> |
| **Shape list**<div>The shapes making up this module's mask, described in [the shape lists](#the-shape-lists) below.</div> |
| **Attach shapes**<div>Switches the list above to every shape defined for the image, so you can attach or detach them. See [reusing a shape](#reusing-a-shape).</div> |
| **Shape buttons** {{< icon src="icon/icon-shapes.png" >}} <div>Five buttons at the bottom right create a new shape: Circle, Ellipse, Polygon, Brush and Gradient. See [creating a shape](#creating-a-shape).</div> |
| **Mouse wheel**<div>A collapsible section holding the grid that decides which parameter of a shape each wheel combination edits. It is shared by every mask of every module -- see [mouse wheel](#mouse-wheel).</div> |
| **Brush options**<div>The collapsible section below it, holding the two settings that govern painted strokes -- see [brush options](#brush-options).</div> |
{{< /param-table >}}

### The shape lists

The panel has two lists that share the same slot; the _Attach shapes_ button picks which one is showing.

{{< param-table image-height="7rem" >}}
| **Shape list** ![](mask/drawn/mask-drawn-shape-list.en.png?class=framed) | <div>The default view, holding the shapes this module's mask is built from, applied in list order from top to bottom.<br>
Each row carries, from left to right:
- the [set operator](../../../toolboxes/shape-manager.md#set-operators) combining that shape with the ones above it, with an icon if **Invert** is on,
- the shape's name,
- an _unlink_ icon that detaches the shape from this mask while keeping it available elsewhere,
- and a _trash_ icon that deletes the shape outright.

Right-clicking a row opens the shape-level part of [the context menu](#the-context-menu) — its parameter sliders, the **Operation** submenu and **Move Up** / **Move Down** — which is handy for a shape that is hard to reach on the canvas, or hidden behind others.</div> |
{{< /param-table >}}

{{< param-table image-height="9rem" >}}
| **All-shapes list** ![](mask/drawn/mask-drawn-shape-list-all.en.png?class=framed) | <div>Shown while _Attach shapes_ is pressed, it lists every shape defined for the current image.<br>
A checkbox on each row attaches it to this module's mask or detaches it, and its name can be edited in place by double-clicking.</div> |
{{< /param-table >}}

### Mouse wheel

{{< param-table image-height="11rem" >}}
| ![](mask/drawn/mask-drawn-wheel.en.png?class=framed) | Turning the wheel with the pointer over a shape edits one of its parameters, and which combination edits which parameter is your call. The _Mouse wheel_ collapsible section, at the bottom of the _Drawn_ tab beside _Brush options_, holds a grid with one row per wheel combination and one column per parameter it can reach; ticking a cell maps that row to that parameter. No combination carries a meaning of its own, so any of them can be pointed at any parameter, or at none.|
{{< /param-table >}}

There is one column per parameter -- _Size_, _Fading / Curvature_, _Opacity_ and _Rotation_, all described under [shape parameters](#shape-parameters) -- and a last one, _Nothing_, which unmaps the row so that combination is ignored over a shape. The column named twice is a single cell to tick: it edits the fading of a shape that has one, and the curvature of a Gradient.

The grid is application-wide. Which parameter the wheel edits is a habit of yours rather than a property of one shape or of the module owning the mask, so a change made from one module's _Drawn_ tab applies to every mask of every module, and it is remembered between sessions.

A shape only answers for the parameters it actually has, so a combination mapped to _Rotation_ does nothing over a Circle, a Polygon or a Brush, just like a row set to _Nothing_.

{{< note >}}
Because the mapping is yours to set, the listings below name the parameter each shape reads, not the keys that reach it: read _Size_ as "whichever combination is mapped to _Size_" -- <kbd class="mouse">scroll</kbd> alone, unless you changed it.
{{< /note >}}

### Brush options

{{< param-table image-height="4.5rem" >}}

| ![](mask/drawn/mask-drawn-brush-opt.en.png?class=framed) | The last collapsible section of the _Drawn_ tab holds two settings for painted strokes. Both are application-wide, as the wheel grid is: they apply to every Brush painted in any module, and are remembered between sessions. |
{{< /param-table >}}

{{< param-table >}}
| **Brush strokes smoothing** (_low_, _medium_ or _high_)<div>How many nodes the stroke is converted into when you release the button: more smoothing means fewer nodes, which eases later editing at the expense of accuracy. _Medium_ by default.</div> |
| **Pen pressure mapping**<div>Applies a graphics tablet's recorded pressure to the stroke's size, fading or opacity, one of the three at a time. _Relative_ scales the attribute between zero and the value the stroke would otherwise have, _absolute_ maps pressure straight onto the 0% to 100% range; size only offers the relative form. Off by default, the pressure reading being ignored.</div> |
{{< /param-table >}}

## Shapes

A mask is built from shapes, of five types, and any number of them can be combined into one.

### The five shapes

They differ in how much of the outline you draw yourself, and the effort is worth spending only where the subject asks for it: the further down this list, the more precise the mask and the longer it takes to place.

{{< param-table >}}
| **Circle**<div>A disc with a soft edge, placed in a single click and the quickest mask there is. It fits anything roughly round -- a face, a lamp, a bright patch of sky -- and its feathering makes the correction blend on its own.</div> |

| **Ellipse**<div>The same disc, stretched by the four nodes on its outline and turned to any angle. Reach for it as soon as the area is longer than it is wide, or round but seen at an angle.</div> |

| **Polygon**<div>A closed free-form outline through three or more nodes, joined by smooth curves by default: the mask covers the whole area it encloses. This is the shape for an area with a contour of its own to follow -- a building against the sky, a silhouette, a window -- and the one whose nodes let you follow it as closely as you like.</div> |

| **Brush**<div>An open stroke painted freehand, converted into connected nodes when you release the button; those nodes are then edited exactly like a Polygon's. Nothing is enclosed: the mask is the stroke itself, as wide as its _Size_ all along the path. It suits areas that are thin or irregular enough that a closed outline would be tedious to trace -- strands of hair, branches, a trail of light -- and it is the shape a graphics tablet pays off on, its pressure driving the stroke (see [brush options](#brush-options)).</div> |

| **Gradient**<div>A linear ramp running from a line you place out to the edge of the image: a single click places the 50% opacity line, and dashed lines mark where the opacity reaches 100% and 0%. Use it for a correction that has to fade across the frame rather than stop anywhere -- darkening a sky down to the horizon, balancing a light falling from one side. Each new gradient reuses the size, curvature and rotation of the last one you placed or edited.</div> |
{{< /param-table >}}

{{< note >}}
Depending on the module and the image, a gradient can provoke banding artifacts. Activating the [_dithering_](../../modules/dithering.md) module alleviates this.
{{< /note >}}

### Anatomy of a shape

Every editing gesture acts on whatever sits under the pointer, so the elements a shape is made of are worth naming apart. Which of them a shape has depends on its type: they all draw their lines, but a Circle has nothing else to grab, an Ellipse carries four nodes, and a Polygon and a Brush carry nodes, segments and handles alike.

An element is only drawn once its parent is selected, so they appear in turn as you go: a displayed mask shows the shape lines of all its shapes, the selected shape -- the one you clicked adds its border line and its nodes, and the selected node adds its own handles. The hint at the right of the title bar names the element the pointer is over and what a drag there will do.

{{< param-table image-height="4rem" gutter="0rem" image-crop="square" >}}
| **Lines** | **Solid** (shape) ![](mask/drawn/mask-drawn-shape-anat-line.png) | <div>The solid line, the outline proper: on a Circle, an Ellipse and a Polygon it encloses the area the mask covers at full strength, and the feathering starts there. A Brush draws it down the middle of its stroke instead, and a Gradient draws it as the 50% opacity line you placed.</div> | 
| | **Dashed** (border)![](mask/drawn/mask-drawn-shape-anat-border.png) | <div>The dashed line running alongside the shape line, marking the far end of the feathering: the mask fades from full strength at the shape line to nothing here, and the distance between the two is what [_Fading_](#shape-parameters) sets. A Gradient has two of them, one where the opacity reaches 100% and one where it reaches 0%, spaced by its [_Size_](#shape-parameters). It is part of the shape rather than a handle, so dragging it moves the whole shape -- except on an Ellipse, where it is the ring that rotates the shape.</div> |
| | **Dotted** (guide) ![](mask/drawn/mask-drawn-shape-anat-dotted.png) | <div>A guide rather than a part of the shape: it contributes nothing to the mask, has no opacity of its own, and there is nothing on it to grab or drag. Most are drawn only while a gesture is under way, to show where it is heading -- a Polygon draws the stretch running from the last node you placed to the pointer this way while you create it, a Gradient draws its axis right across the image while you turn it, and each goes as soon as the gesture ends..</div> |
{{< /param-table >}}

{{< param-table image-height="4rem" image-crop="square" >}}
| **Arrow** ![](mask/drawn/mask-drawn-shape-anat-arrow.png) | <div>The tie between a clone or heal shape and its _source_ -- the patch of the image it copies its pixels from -- and so [_retouch_](../../modules/retouch.md) shapes only. It runs from the source to the shape and its head points at the shape, which is what tells you which way the pixels travel. It lights up while the source is under the pointer, where <kbd class="mouse">drag</kbd> moves the sampled area without moving the shape itself. Where the two overlap there is no room for the shaft, so only the head is drawn, halfway between them. Being a guide, it is dotted and adds nothing to the mask.</div> |
{{< /param-table >}}

What follows applies mainly to **Polygon** and **Brush** shapes:

{{< param-table image-height="4rem" image-crop="square" >}}
| **Nodes** ![](mask/drawn/mask-drawn-shape-anat-nodes.png) | <div>A point the outline runs through, drawn round where the outline curves through it and square where it turns a corner -- a _cusp_. <kbd class="mouse">click</kbd> it to select it, which is what reveals its handles. <kbd class="mouse">Drag</kbd> one to move it.</div> | 

| **Segments** ![](mask/drawn/mask-drawn-shape-anat-segments.png) | <div>The stretch of outline between two consecutive nodes. Its shape is not its own: each of the two nodes it joins lends it one curvature handle, and so it leaves a round node on a curve and a cusp node in a straight line. Between two round nodes it curves along its whole length, between two cusps it runs dead straight, and between one of each it does both -- curved at the round end, straightening into the cusp.<br>
<kbd class="mouse">Drag</kbd> a segment to move both of those nodes together, which slides it without changing its curve, and <kbd>Ctrl</kbd>+<kbd class="mouse">click</kbd> (<kbd>⌘</kbd>+<kbd class="mouse">click</kbd> on macOS) to insert a node into it. </div> |
{{< /param-table >}}

{{< param-table image-height="4rem" gutter="0rem" image-crop="square" >}}
| **Handle** | **Curvature** ![](mask/drawn/mask-drawn-shape-anat-handle-curve.png) | <div>A small round handle joined to its node by a line, setting the direction and the strength of the curve running through that node, and so bending the two segments that meet there at once. There is one per node, not one per segment: both sides are derived from it symmetrically, which is what keeps the outline smooth across the node. It belongs to the nodes of a Polygon and of a Brush, shows on the selected node only, and a cusp node has none until it is switched back to a round one.<br>
<kbd class="mouse">Drag</kbd> it to bend the outline; **Reset round node** in [the context menu](#over-a-node) discards it and restores the automatically computed curve.</div> |

| | **Border** ![](mask/drawn/mask-drawn-shape-handle-border.png) | <div>A small square handle sitting on the border line, on the axis running outwards from its node; dragging it slides along that axis and sets the border of that one node instead of the whole shape's -- how wide the feathering is there on a Polygon, how wide the stroke is there on a Brush. Like the curvature handle it belongs to the nodes of a Polygon and of a Brush, and shows on the selected node only.</div> |

{{< /param-table >}}

## Creating a shape

Click one of the five shape buttons to enter creation mode for that shape. The mouse cursor turns into a cross over the image, confirming that the next click will place a shape rather than interact with the picture.

{{< note >}}
Creation mode then stays active: as soon as one shape is finished, another of the same type begins, so you can place several in a row without going back to the button.
{{< /note >}}

Two shapes depart from that cursor. The Brush hides the cursor entirely and draws its own filled circle instead, showing the current brush size and fading at the pointer. The Polygon switches to a pointing hand as you come back within reach of your first node, telling you that clicking there will close the outline.

To leave creation mode, click the shape's button again, press <kbd>Escape</kbd>, or right-click the canvas and choose **Done shape creation**. Any of these drops you into edit mode with the shapes you have placed.

The [wheel](#mouse-wheel) adjustments made on a shape being created also update the _defaults_ for that shape type, which the next shape you create will start from. The gestures each shape answers to while you place it are listed with its editing ones under [gestures by shape](#gestures-by-shape).

{{< note >}}
Scrolling up increases the value being adjusted. [Preferences > Invert the direction of the mouse vertical scroll](../../../../preferences-settings/darkroom.md) reverses this -- a general scroll-direction setting that affects every slider in Ansel, not just masks.
{{< /note >}}

## Editing a shape

### Selecting and moving

The {{< icon src="icon/icon-edit-shape.png" alt="Show and edit mask elements" >}} button displays the mask's shapes on the canvas.<br>
<br>
<kbd class="mouse">Click</kbd> on a shape on the canvas to select it -- it is highlighted in the [shape list](#the-shape-lists) at the same time. Selection works both ways: click an entry in the list and the view centers on the matching shape.
You can then <kbd class="mouse">Click</kbd> on any of [the elements](#anatomy-of-a-shape) the shape can contain.

<kbd class="mouse">Drag</kbd> a shape to move it as a whole, or one of its elements -- segment, node or handle -- to reshape it.

### Shape parameters

Beyond its outline, a shape carries a handful of numeric parameters, and most of the editing comes down to setting them.

{{< param-table>}}
| **Size**<div>How large the shape is, grown or shrunk about its own center without changing its outline. On a Gradient it is the extent of the transition instead, the distance between the two dashed lines.</div> |

| **Fading**<div>How abrupt the edge of the shape is: the width of the feathering, the distance between the shape line and its dashed border, over which the mask fades from full strength down to nothing.</div> |

| **Curvature** (_gradient only_)<div>Bends the gradient line into a curve, from -100% to 100%, the line running straight at zero.</div> |

| **Rotation** (_ellipse and gradient only)_<div>The orientation of the shape, turned in precise increments. An Ellipse and a Gradient only -- a Circle is round, and a Polygon and a Brush are turned by moving their nodes.</div> |

| **Opacity**<div>How strongly this one shape contributes to the mask, from 0% to 100%. It scales what the shape paints before that is combined with the shapes above it, so a shape at 50% gives the module half its effect where it covers the image.</div> |
{{< /param-table >}}

The wheel edits whichever parameter the combination you turn it with is mapped to in [the mouse wheel](#mouse-wheel) grid. It acts in creation as well as in edit mode, wherever the pointer sits over the shape.

To set a parameter precisely instead, <kbd class="mouse">right-click</kbd> on the shape and use the sliders at the top of [the context menu](#the-context-menu) -- the same ones the [shape manager](../../../toolboxes/shape-manager.md) offers. They all read an absolute value, save _Size_ on a shape other than a Gradient: that one opens at zero and scales the shape by however far you move it, in either direction, rather than reading a size.

{{< param-table image-height="5rem" image-crop="square" >}}
| ![](mask/drawn/mask-drawn-shape-node-fading.png) | On a shape built from nodes -- a Polygon or a Brush -- _Size_ and _Fading_ act on the selected node alone when one is selected, and on every node otherwise, which is how one part of an outline is given a wider feathering than the rest. |
{{< /param-table >}}

Size, fading and rotation describe the shape itself, so they follow it into every mask it is [attached to](#reusing-a-shape). Opacity does not: like the [set operator](../../../toolboxes/shape-manager.md#set-operators) and **Invert**, it belongs to the row the shape occupies in one mask, and the same shape can therefore carry a different opacity in each module using it.

### Invert and set operators

**Invert** flips the shape over, the mask then covering everything but what it encloses, and the **set operator** -- _Union_, _Intersection_, _Difference_ or _Exclusion_ -- decides what the shape adds to, or takes from, the mask built by the shapes above it. Both are set from the **Operation** submenu of [the context menu](#over-the-shape-itself), whether you open it on the canvas or on the shape's row in [the shape list](#the-shape-lists), and the [shape manager](../../../toolboxes/shape-manager.md#set-operators) shows each operator on an example.

Because an operator works on what sits above, order is part of the result: **Move Up** and **Move Down** in the same menu change the outcome, not just the display.

{{< note >}}
The shape at the top of the list has nothing to combine with, so the four operators are greyed out for it -- **Invert**, which needs no second operand, stays available.
{{< /note >}}

### Gestures by shape

Each shape answers to gestures of its own, some of them while you are still placing it. A Circle has none: it is dragged to move it and set through its parameters, and that is all.

{{< param-table indent="0" >}}
| **Ellipse** | <div>
- <kbd class="mouse">Drag</kbd> a node: eccentricity
- <kbd class="mouse">Drag</kbd> the border ring: rotation, with no modifier needed
- <kbd>Shift</kbd>+<kbd class="mouse">click</kbd> inside the shape: switches the feathering between equidistant and proportional decay
</div> |

| **Polygon** | While creating:
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
- <kbd class="mouse">Drag</kbd> a node's [border handle](#anatomy-of-a-shape): adjusts the feathering at that node only
</div> | |

| **Brush** | <div>
- <kbd class="mouse">Left-click</kbd> and <kbd class="mouse">drag</kbd>: paints the stroke
- Once released, its nodes are edited exactly like a Polygon's
</div> |

| **Gradient** | <div>
- <kbd class="mouse">Double-click</kbd>: resets the curvature
- <kbd class="mouse">Drag</kbd> the pivot at the center of the line: rotation
- <kbd>Shift</kbd>+<kbd class="mouse">click</kbd>, while still in creation mode: switches the opacity transition between a _linear_ ramp and a _sigmoidal_ (S-curve) one, which concentrates the transition closer to the center line. The choice sticks for the gradients you create afterwards
</div> |
{{< /param-table >}}

## Removing a shape

There are two distinct outcomes, and the menu keeps them apart:

- **Remove shape from mask** detaches the shape from this module's mask. The shape survives, still listed for the image and still usable by other modules — this is what the _unlink_ icon in the Shape list does too.
- **Delete shape** removes it altogether, everywhere it was used. The _trash_ icon in the lists does the same.

With the pointer over one of a Polygon's or Brush's nodes, the menu offers **Delete node** instead, which removes that single node rather than the shape.

## Reusing a shape

A shape is a single object shared by every mask that uses it: edit it in one module and every other module using it follows.

Press **Attach shapes** to swap the panel's list for every shape defined on the image, then tick a shape's checkbox to add it to the current module's mask, or untick it to detach it. Right-clicking a row here offers only **Duplicate** and **Rename**.

{{< figure src="mask/drawn/mask-drawn-shape-list-all2.en.png" style="width:19rem" class="align-left borderless tight framed" />}}
A row reading `Already in '<group>'` is greyed out because the shape is reached through a group that is itself attached, so it is already spoken for.

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

The menu opens with sliders for the shape's parameters, all described under [shape parameters](#shape-parameters): **Size** and **Opacity** on every shape, **Fading** on all but a Gradient, which carries a **Curvature** instead, and **Rotation** on an Ellipse and on a Gradient. They set the same values [the mouse wheel](#mouse-wheel) reaches directly on the canvas; the menu is simply the precise way in.

{{< param-table >}}
| **Operation** | **Invert**<div>Flips this shape over within the mask: everything it does not enclose is masked instead.</div> |
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

{{< param-table image-height="7rem" image-crop="square" >}}
| ![](mask/drawn/mask-drawn-distortion.png) | Because a shape is stored in the coordinate system of the original image, it travels up the pixelpipe before the module uses it and draws it on screen. Any distorting module active in between -- [_lens correction_](../../modules/lens-correction.md) or [_rotate and perspective_](../../modules/rotate-perspective.md), for instance -- therefore distorts the shape too, on screen and in the exported image alike: circles can render as ellipses, and gradient lines can end up curved.<br>
_A Circle near the edge of the frame, deformed into an ellipse under the effect of the lens correction module._ |
{{< /param-table >}}

To draw a shape that follows the subject accurately despite this, prefer a Polygon over a Circle or an Ellipse, since its extra nodes let you compensate for the distortion. For a Gradient, bending its line counteracts the simpler distortion that lens correction introduces.

## Panning and zooming

Mouse actions over a shape, or over its nodes and handles, apply to that shape. Away from it, dragging and scrolling pan and zoom the center view as usual, so there is no need to leave creation or edit mode to reposition the canvas.

On a zoomed-in image, dragging a shape towards the edge of the viewport pans the view in that direction on its own, and keeps panning while you hold the pointer there, so a shape can be moved past the visible area without interrupting the drag. The pan accelerates the closer to the edge you get. It also works while placing a new shape, but not while painting a Brush stroke, where dragging is the drawing action itself.
