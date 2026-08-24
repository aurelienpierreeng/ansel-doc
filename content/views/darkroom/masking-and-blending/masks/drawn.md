---
title: Drawn masks
date: 2022-12-04T02:19:02+01:00
lastmod: 2026-08-23
id: drawn
weight: 20
draft: false
---

A drawn mask builds the per-pixel opacity handed to [blending](../_index.md) from shapes you draw directly on the image, so a module's effect lands exactly where you place them.

Shapes are stored internally as vectors, rendered at whatever resolution the pixelpipe needs, and expressed in the coordinate system of the original image. A shape therefore keeps covering the same part of the picture no matter what you change elsewhere in the edit -- with one visual side effect worth knowing about, see [shape distortions](#shape-distortions) below. Once drawn, a shape can be adjusted, removed, or reused by any other module.

Drawn masks are handled from the _Drawn_ tab of the _Masking & Blending_ tool, in the darkroom [left panel](../../darkroom-view-layout.md#left-panel), for whichever module currently has focus. The tab works alongside the [_Parametric_](./parametric.md) and [_Raster_](./raster.md) ones, since any combination of masking methods can be active at once (see [combining masks](../_index.md#combining-masks)).

## The Drawn panel

The tab holds:

Enable
: Blending is switched on per module by the _Enable_ checkbox at the top of the tool, above the row of tabs, and the whole panel stays grayed out until you check it. The _Drawn_ tab is armed by default -- as are _Parametric_ and _Raster_ -- so it is ready to use as soon as blending is on. Its own _Disable_ checkbox turns drawn masking back off when you want it out of the way.

Mask name
: A text field naming this module's mask. It starts out showing `Mask <module name>` as a placeholder; type your own name and press <kbd>Enter</kbd> to replace it. Meaningful names pay off as soon as several modules carry masks.

Polarity ( ± icon )
: Reverses the polarity of the whole drawn mask. A circle, by default, restricts the module to the area inside it; flipping the polarity applies the module everywhere _except_ inside that circle.

Show and edit mask elements
: Displays the mask's shapes on the canvas so you can edit them. <kbd>Ctrl</kbd>+click (<kbd>⌘</kbd>+click on macOS) enters _restricted_ edit mode instead, in which a shape's overall position and size are locked -- neither dragging nor scrolling over it moves or resizes it -- and only its individual nodes and segments respond. This is the safe way to fine-tune Polygon and Brush shapes.

Shape list
: The shapes making up this module's mask, described in [the shape lists](#the-shape-lists) below.

Attach shapes
: Switches the list above to every shape defined for the image, so you can attach or detach them. See [reusing a shape](#reusing-a-shape).

Shape buttons
: Five buttons at the bottom right create a new shape: Circle, Ellipse, Polygon, Brush and Gradient. See [creating a shape](#creating-a-shape).

Brush options
: A collapsible section holding two settings that apply to Brush shapes only: _Brush strokes smoothing_ and _Pen pressure mapping_, both described under [Brush](#shapes).

## The shape lists

The panel has two lists that share the same slot; the _Attach shapes_ button picks which one is showing.

The **mask list** is the default view and holds the shapes this module's mask is built from, applied in list order from top to bottom. Each row carries, from left to right: the [set operator](../../../toolboxes/mask-manager.md#set-operators) combining that shape with the ones above it, an icon if its polarity is inverted, its name, an _unlink_ icon that detaches the shape from this mask while keeping it available elsewhere, and a _trash_ icon that deletes the shape outright. Right-clicking a row opens the shape-level part of [the context menu](#the-context-menu) — its parameter sliders, the _Operation_ submenu and _Move Up_ / _Move Down_ — which is handy for a shape that is hard to reach on the canvas, or hidden behind others.

The **all-shapes list**, shown while _Attach shapes_ is pressed, lists every shape defined for the current image. A checkbox on each row attaches it to this module's mask or detaches it, and its name can be edited in place by double-clicking. A row reading _Already in '&lt;group&gt;'_ is greyed out because the shape is part of a group that is itself already attached, so it is spoken for. Right-clicking a row here offers only _Duplicate_ and _Rename_.

{{< note >}}
Both lists can be resized by dragging their lower edge, and the height you set is remembered.
{{< /note >}}

## The context menu

Right-clicking on the canvas opens a menu headed by the shape's name. What follows depends on one thing: what sits under the pointer. There are four cases.

The same menu is reachable without the canvas: right-clicking a row in the panel's [mask list](#the-shape-lists) opens its shape-level part, described under [over the shape itself](#over-the-shape-itself) below, minus the removal entries — the row's own _unlink_ and _trash_ icons cover those.

### While creating a shape

- _Close path_ (Polygon only) — closes the outline, once at least three nodes are placed. <kbd>Enter</kbd> does the same
- _Remove last point_ (Polygon only) — deletes the node you just placed. <kbd>Backspace</kbd> does the same
- _Done shape creation_ — leaves creation mode. <kbd>Escape</kbd> does the same

### Over the shape itself

The menu opens with sliders for the shape's parameters. Which ones depends on the shape:

{{< table >}}
| Shape | Sliders |
| --- | --- |
| Circle, Polygon, Brush | _Size_, _Fading_, _Opacity_ |
| Ellipse | _Size_, _Fading_, _Rotation_, _Opacity_ |
| Gradient | _Curvature_, _Fade_, _Rotation_, _Opacity_ |
{{< /table >}}

They set the same values that scroll and its modifiers reach directly on the canvas, listed per shape under [Shapes](#shapes) below; the menu is simply the precise way in. _Opacity_ is how strongly this one shape contributes to the mask.

Below the sliders:

- _Operation → Invert_ — inverts this shape's polarity within the mask
- _Operation → Union_, _Intersection_, _Difference_, _Exclusion_ — the [set operator](../../../toolboxes/mask-manager.md#set-operators) combining this shape with the ones above it in the mask
- _Move up_ / _Move down_ — reorders the shape within the mask
- _Remove shape from mask_ — detaches it, leaving it available to other modules. <kbd>Delete</kbd> does the same
- _Delete shape_ — deletes it for good

### Over a node

Polygon and Brush only. The parameter sliders appear as above, followed by the entries below. The _Operation_ submenu and the reordering entries are not offered here, and _Delete node_ takes the place of _Remove shape from mask_ and _Delete shape_ — so a slip of the mouse deletes a node, never the whole shape.

- _Switch to round node_ / _Switch to cusp node_ — turns a corner into a smooth curve, or the reverse. <kbd>Ctrl</kbd>+click (<kbd>⌘</kbd>+click on macOS) on the node does the same
- _Reset round node_ — discards curvature handles you dragged by hand and restores the automatically computed curve
- _Delete node_ — removes that node only, leaving the rest of the shape. <kbd>Delete</kbd> does the same

### Over a segment

Polygon and Brush only. This adds one entry to the shape-level ones (_Operation_, _Remove shape from mask_ and _Delete shape_); the parameter sliders and the reordering entries are not shown.

- _Add a node here_ — inserts a node at that point of the outline. <kbd>Ctrl</kbd>+click (<kbd>⌘</kbd>+click on macOS) on the segment does the same

## Shapes

Five shapes are available. Scroll always changes the size and <kbd>Shift</kbd>+scroll the feathering, in creation as well as in edit mode, wherever the pointer sits over the shape. Below each shape are the actions specific to it.

### Circle

A disc with a soft edge, placed with a single click.

- Scroll: diameter
- <kbd>Shift</kbd>+scroll: width of the feathering

### Ellipse

Behaves like the Circle, with four nodes on its outline to stretch it.

- Drag a node: eccentricity
- Drag the border ring: rotation, with no modifier needed
- <kbd>Shift</kbd>+<kbd>Ctrl</kbd>+scroll (<kbd>Shift</kbd>+<kbd>⌘</kbd>+scroll on macOS): rotation in precise increments
- <kbd>Shift</kbd>+click inside the shape: switches the feathering between equidistant and proportional decay

### Polygon

A free-form outline through three or more nodes, joined by smooth curves by default.

While creating it:

- Click: adds a node
- <kbd>Ctrl</kbd>+click (<kbd>⌘</kbd>+click on macOS): adds a sharp corner instead
- <kbd>Backspace</kbd>: removes the node you just placed
- Click near the first node, or <kbd>Enter</kbd>: closes the shape

Once closed:

- Drag a node or a segment: reshapes the outline
- Click a node: reveals its curvature handle, which can then be dragged
- Drag a control point on the border: adjusts the feathering around that part only
- Scroll: resizes the whole shape
- <kbd>Shift</kbd>+scroll: border width, from anywhere inside the shape

### Brush

A painted stroke, converted into connected nodes when you release the button; those nodes are then edited exactly like a Polygon's.

- Left-click and drag: paints the stroke
- Scroll while drawing: brush size
- _Brush strokes smoothing_ (_low_, _medium_ or _high_): how many nodes the conversion produces -- more smoothing means fewer nodes, which eases later editing at the expense of accuracy
- _Pen pressure mapping_: applies a graphics tablet's recorded pressure to the brush's width, hardness or opacity. _Relative_ scales the attribute between zero and its default value, _absolute_ maps pressure straight onto the 0% to 100% range

The last two live in the _Brush options_ section of the panel.

{{< note >}}
Rendering a complex brush shape can consume a significant number of CPU cycles. Consider using a Circle, Ellipse or Polygon instead where possible.
{{< /note >}}

### Gradient

A linear gradient running from a line you place to the edge of the image. A single click places the 50% opacity line, and dotted lines mark where the opacity reaches 100% and 0%. Each new gradient reuses the extent, curvature and rotation of the last one you placed or edited.

- Scroll: extent, the distance between the two dotted lines
- <kbd>Shift</kbd>+scroll: bends the line into a curve
- Double-click: resets the curvature
- Drag the pivot at the center of the line: rotation
- <kbd>Shift</kbd>+<kbd>Ctrl</kbd>+scroll (<kbd>Shift</kbd>+<kbd>⌘</kbd>+scroll on macOS): rotation in precise increments
- <kbd>Shift</kbd>+click, while still in creation mode: switches the opacity transition between a _linear_ ramp and a _sigmoidal_ (S-curve) one, which concentrates the transition closer to the center line. The choice sticks for the gradients you create afterwards

Depending on the module and the image, a gradient can provoke banding artifacts. Activating the [_dithering_](../../modules/dithering.md) module alleviates this.

## Creating a shape

Click one of the five shape buttons to enter creation mode for that shape. The mouse cursor turns into a cross over the image, confirming that the next click will place a shape rather than interact with the picture.

{{< note >}}
Creation mode then stays active: as soon as one shape is finished, another of the same type begins, so you can place several in a row without going back to the button.
{{< /note >}}

Two shapes depart from that cursor. The Brush hides the cursor entirely and draws its own filled circle instead, showing the current brush size and hardness at the pointer. The Polygon switches to a pointing hand as you come back within reach of your first node, telling you that clicking there will close the outline.

To leave creation mode, click the shape's button again, press <kbd>Escape</kbd>, or right-click the canvas and choose _Done shape creation_. Any of these drops you into edit mode with the shapes you have placed.

The scroll actions that adjust a shape being created also update the _defaults_ for that shape type, which the next shape you create will start from.

{{< note >}}
Scrolling up increases the value being adjusted. [Preferences > Invert the direction of the mouse vertical scroll](../../../../preferences-settings/darkroom.md) reverses this -- a general scroll-direction setting that affects every slider in Ansel, not just masks.
{{< /note >}}

## Editing a shape

Click _Show and edit mask elements_ to display the mask's shapes on the canvas, then drag a shape to move it. Clicking a shape also selects it in the [shape list](#the-shape-lists).

For nodes, segments and per-shape parameters, right-click on the shape and work from [the context menu](#the-context-menu).

## Removing a shape

There are two distinct outcomes, and the menu keeps them apart:

- _Remove shape from mask_ detaches the shape from this module's mask. The shape survives, still listed for the image and still usable by other modules — this is what the _unlink_ icon in the mask list does too.
- _Delete shape_ removes it altogether, everywhere it was used. The _trash_ icon in the lists does the same.

With the pointer over one of a Polygon's or Brush's nodes, the menu offers _Delete node_ instead, which removes that single node rather than the shape.

## Reusing a shape

A shape is a single object shared by every mask that uses it: edit it in one module and every other module using it follows.

Press _Attach shapes_ to swap the panel's list for every shape defined on the image, then tick a shape's checkbox to add it to the current module's mask, or untick it to detach it. Shapes greyed out as _Already in '&lt;group&gt;'_ are reached through a group that is itself attached.

The [mask manager](../../../toolboxes/mask-manager.md) covers the same shapes from a separate window, where they can also be grouped, reordered and renamed across all modules at once.

## Shape distortions

Because a shape is stored in the coordinate system of the original image, it travels up the pixelpipe before the module uses it and draws it on screen. Any distorting module active in between -- [_lens correction_](../../modules/lens-correction.md) or [_rotate and perspective_](../../modules/rotate-perspective.md), for instance -- therefore distorts the shape too, on screen and in the exported image alike: circles can render as ellipses, and gradient lines can end up curved.

To draw a shape that follows the subject accurately despite this, prefer a Polygon over a Circle or an Ellipse, since its extra nodes let you compensate for the distortion. For a Gradient, bending its line counteracts the simpler distortion that lens correction introduces.

## Panning and zooming

Mouse actions over a shape, or over its nodes and handles, apply to that shape. Away from it, dragging and scrolling pan and zoom the center view as usual, so there is no need to leave creation or edit mode to reposition the canvas.

On a zoomed-in image, dragging a shape towards the edge of the viewport pans the view in that direction on its own, and keeps panning while you hold the pointer there, so a shape can be moved past the visible area without interrupting the drag. The pan accelerates the closer to the edge you get. It also works while placing a new shape, but not while painting a Brush stroke, where dragging is the drawing action itself.
