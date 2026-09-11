---
title: Canvas
date: 2026-09-11T00:00:00+02:00
lastmod: 2026-09-11
id: canvas
draft: false
weight: 35
author: "people"
tags:
    - layout
    - export
---

Canvas is a view for putting pictures next to each other: an infinite plane you drop images onto, arrange, annotate and export as pages. It is a sketchbook for photographers rather than a publishing tool — low-overhead authoring that favours a simple and relaxing experience.

Reach for it whenever the question is about a *set* of pictures rather than one picture. A canvas is either disposable, a work surface you never publish, or permanent, something you print or post.

Disposable canvases let you:

- perform advanced culling,
- assess the consistency of a series,
- prepare collections of images for an exhibition or a book,
- keep workflow memos, alongside text notes.

Permanent canvases let you:

- keep moodboards and inspiration boards,
- build storyboards or photo-based comic strips,
- create montages and collages for posters, blog posts, social media, banners and icons,
- do scrapbooking, journaling and other creative endeavours,
- create photo-based flowcharts, using connector arrows,
- build all sorts of story-telling.

{{< note >}}
Canvas is not a full-fledged publishing tool for magazines or books, and does not aim to become one. For a print-shop-grade layout, export the pages and finish them in a page-layout application.
{{< /note >}}

## A canvas is a file, not a library entry

A canvas is saved as a single `.anselcanvas` file — a zipped archive holding the layout and a copy of every picture in it. Nothing about it is stored in the Ansel database, so a canvas travels: you can hand it to a colleague who has no access to your raw files, and they can rearrange the layout on their end.

Because the pictures are embedded, a canvas keeps working when the originals move or go offline. Each frame still remembers which library image it came from, so once you touch an image up in the [darkroom](../darkroom/_index.md) you can pull the new development back into the canvas. Culling and layout can therefore run in parallel with the actual post-processing, and be merged at the end.

_Object → Check against the library_ (<kbd>R</kbd>) compares every frame against the library and marks it as current, stale or missing. _Refresh the stale images_ (<kbd>Ctrl</kbd>+<kbd>R</kbd>, macOS <kbd>⌘</kbd>+<kbd>R</kbd>) re-renders only the ones that changed; _Refresh all_ re-renders everything, which is also how you pick up a change to the render size.

## Getting started

1. Open the view from the **Ateliers** menu.
2. Drag images from the [filmstrip](../toolboxes/filmstrip.md) onto the plane, or use _Canvas → Open_ (<kbd>Ctrl</kbd>+<kbd>O</kbd>, macOS <kbd>⌘</kbd>+<kbd>O</kbd>) to reopen a canvas you saved earlier.
3. Move a frame by dragging it, resize it from its corner handles, rotate it from the handle above it.
4. Use _Arrange_ in the toolbar to lay every frame out at once, then adjust by hand.
5. Save with <kbd>Ctrl</kbd>+<kbd>S</kbd> (macOS <kbd>⌘</kbd>+<kbd>S</kbd>).
6. Export with <kbd>Ctrl</kbd>+<kbd>P</kbd> (macOS <kbd>⌘</kbd>+<kbd>P</kbd>).

## Moving around the plane

The plane is infinite and grows as you fill it. It is only at export time that the content is split into pages.

- <kbd class="mouse">Drag</kbd> on an empty area pans the view.
- <kbd class="mouse">Scroll</kbd> zooms around the pointer; <kbd>Shift</kbd>+<kbd class="mouse">scroll</kbd> pans sideways.
- The _navigation flower_, the small compass in the corner of the view, does the same with the mouse alone: its four petals pan, its inner ring zooms in and out, and its centre fits the whole canvas in the view.
- _Zoom → Fit_ (<kbd>Ctrl</kbd>+<kbd>0</kbd>, macOS <kbd>⌘</kbd>+<kbd>0</kbd>) and _1:1_ (<kbd>Ctrl</kbd>+<kbd>1</kbd>, macOS <kbd>⌘</kbd>+<kbd>1</kbd>) are in the toolbar.

While you pan, zoom or drag, the canvas is composited at half resolution and sharpens as soon as you stop, so a large canvas stays responsive under the pointer.

## Objects

Everything on the plane is an *object*. Selecting exactly one of them floats a property bar under it with that object's settings.

Images
: Dragged in from the filmstrip. Each carries a copy of its render and its identity in the library.

Maps
: _Add → Map_ (<kbd>M</kbd>) drops a map frame at the centre of the view. It takes its position from the GPS metadata of the selected image, or from coordinates you type, and fetches its tiles from the provider you choose. Give the frame the place and zoom level you want and it covers the frame at the tiles' own aspect ratio, cropped rather than stretched.

Text frames
: _Add → Text_ (<kbd>T</kbd>) adds a free text frame. Text is written in Markdown and laid out at the frame's inner width.

Sidecar notes
: _Add → Notes_ (<kbd>Shift</kbd>+<kbd>T</kbd>) adds one text frame per selected image, linked to that image's `.txt` sidecar. The frame shows the note; _Refresh_ pulls in what the file says now.

Connectors
: _Add → Connector_ (<kbd>C</kbd>) draws a line between two frames. Click the anchor dot on the first frame, then on the second. A connector can be straight, square or a cubic spline, solid or dashed, with an arrow head at either end, both ends or neither, and it carries a draggable waypoint to route it around other frames. It follows its frames when they move.

Each frame offers nine anchor points: the middle of each edge, the four corners, and the centre. They are the frame's own points, so they turn with it. The centre is the one to pick when you do not care which side the line leaves by: its dot sits at the middle of the frame, drawn as a ring, and the line itself touches whichever side faces the other end, sliding around as that end moves.

A line on the centre stops where the frame actually draws something rather than on the rectangle around it. Round off a frame's corners and the line follows the curve; cut the frame to a circle, an ellipse or a polygon and the line meets that shape, including its fall-off and its border, instead of ending in the empty corner beside it.

{{< note >}}
A connector can also resolve its anchor automatically, choosing the pair of edge midpoints nearest each other.
{{< /note >}}

## Arranging

Frames snap while you drag them, in this order: to the grid, to their neighbours' edges one *gutter* apart, and to the page borders, margins and bleed lines. A resized frame can also take a neighbour's width or height. Which of these are active is set under _Guides_ in the toolbar.

_Arrange_ lays the whole canvas out at once as a **grid**, a **masonry**, a **row** or a **column** (<kbd>1</kbd> to <kbd>4</kbd>), with the gutter as the spacing. _Sort by_ decides the order the frames are laid out in — canvas order, file name, capture time, import order, or full path — and _Auto_ applies the layout.

The right-click menu on an object changes its depth in the stack: bring to front, send to back, raise, lower.

## Backgrounds

The plane is painted with **transparent**, with a solid colour, or with one of five procedurally generated papers: **Moleskine**, an ivory notebook paper with a soft texture; **watercolour**, a white paper with a thick tooth; **embossed**, dried on a metallic mesh whose imprint stays in the fibres; **Japanese** washi, with large soft clouds and long wrinkles; and **psychedelic washi**, the same sheet with its wrinkles dyed in saturated threads of colour rather than lit as pale ridges.

Transparent leaves the plane a hole. It is shown as a chequerboard the size of the grid, and it is carried all the way out: an exported page keeps the hole as an alpha channel, so JPEG — which has none — is not offered while the canvas is transparent.

A paper is tinted by the background colour, so the same texture serves a warm ivory and a cool grey. _Texture_ opens four sliders that tune it: _Contrast_ for the relief's body, _Detail_ for its fine structure, _Scale_ for the size of the features, and _Grain_ for the pixel-level dither that finishes it. One everywhere is the paper as designed.

## Frames, shadows and cutouts

The canvas carries a default border, corner radius and drop shadow, set under _Frames_ in the toolbar, and every object may override them from its own property bar.

Border
: A width in canvas units and a colour. On a rectangular frame it sits inside the edge with the picture inset by it.

Radius
: How far the frame's corners are rounded. Zero is square.

Shadow
: An X and Y offset, a blur radius and a colour whose opacity is the shadow's strength. **The radius is the shadow's own switch**: at zero there is no shadow, a positive radius drops it outside the object, and a negative one casts it inside along the edges.

Cutout
: Cuts the frame out of its rectangle with a drawn shape — a circle, an ellipse, a polygon or a gradient — with a fall-off past its edge and an _Invert_ option that keeps the other side. The frame's border then follows the cut shape instead of the rectangle.

{{< note >}}
Where a property has a canvas-wide default, the value itself says whether the object follows it: **-1 reads as `default`** and means "whatever the canvas says". Type any other value and the object takes its own, starting from what was on screen.
{{< /note >}}

Transparency is set through each colour's own opacity, in the colour picker.

### Editing a cutout

Turn on _Edit_ in the Cutout row of the property bar and the shape's handles appear over the frame: its centre or anchor, its radius or radii, and its feather on the dashed ring. Over the frame, <kbd class="mouse">scroll</kbd> sets the feather, <kbd>Shift</kbd>+<kbd class="mouse">scroll</kbd> the opacity, and <kbd>Ctrl</kbd>+<kbd class="mouse">scroll</kbd> (macOS <kbd>⌘</kbd>+<kbd class="mouse">scroll</kbd>) the gradient's curvature or the ellipse's rotation.

On a polygon: <kbd>Ctrl</kbd>+<kbd class="mouse">click</kbd> (macOS <kbd>⌘</kbd>+<kbd class="mouse">click</kbd>) on an edge inserts a node, <kbd>Shift</kbd>+<kbd class="mouse">click</kbd> on a node removes it, and a double click makes it smooth or sharp. The right-click menu offers the same actions plus the shape's properties as sliders.

A polygon node also owns two things the shape as a whole does not, and they appear on whichever node you bring the pointer near — one node at a time, so the handles never bury the shape:

- Its own **fall-off**, on the dashed tether leaving the node. Drag its end away from the node to widen the fall-off there and towards the node to tighten it. A node you have never touched simply follows the shape's Feather, so a polygon behaves as one piece until you pull a node's fall-off out.
- Its two **control points**, the round handles tethered either side, which steer how the curve enters and leaves the node. Dragging one turns the node into a hand-shaped one: the curve stops being computed through it, and the other side keeps the shape it had.

The three handles are told apart by shape: a square is the node itself, a circle is its curve, and the end of the dashed tether is its fall-off.

## Locking a handle while you drag it

Hold <kbd>Ctrl</kbd> (macOS <kbd>⌘</kbd>) while dragging a handle and it is constrained:

- A handle that moves to a **place** — a cutout's centre, its radius, its feather, a polygon node, a connector's waypoint — keeps to one axis, whichever it has travelled furthest along since you pressed. Move mostly sideways and it stays level; move mostly up or down and it stays in its column.
- A handle that sets a **direction** — a connector's tangent handles, which are the gradient its curve leaves by — snaps that direction to 45° steps around the point it turns about, keeping the length you pulled it to.
- A frame's **rotation** handle snaps to 45° steps, where <kbd>Shift</kbd> snaps to 15°.

The shapes are the same [drawn masks](../darkroom/masking-and-blending/masks/drawn.md) the darkroom uses, so what you already know about them applies here.

## Pages

A canvas can be divided into **pages**, tiled from the origin and outlined with dashed lines. Set the size under _Guides_ in the toolbar: ISO A0 to A6, US Letter, or one of the screen formats a picture is usually made for — Instagram square and portrait, a story, reel or Short, a Facebook post or cover, a YouTube thumbnail or channel banner.

One canvas unit is one point, so a print size is its size in points and a screen format is its size in pixels at 72 dpi: a story page is 1080 by 1920 units, and exported at 72 dpi it comes out at exactly 1080 by 1920 pixels.

Two more guides are drawn from the page, each with its own _Show_, _Size_, _Colour_ and _Snap_, next to the page borders':

Margins
: Kept clear **inside** every page edge. Nothing enforces it — it is a line to lay frames against and a rule for them to snap to — and nothing is moved.

Bleed
: How far the sheet keeps going **past** every page edge. A frame a page break cuts in two carries on into the bleed on both sheets, which is what a binding folds around and a trim cuts into. It is a property of the canvas, so the export simply writes the sheet it describes.

Showing the page borders is how you prepare a simple photo book: mind the borders while you lay frames out, and the export splits the plane into pages from left to right, top to bottom, skipping any page with nothing on it.

## Exporting

_Canvas → Export…_ (<kbd>Ctrl</kbd>+<kbd>P</kbd>, macOS <kbd>⌘</kbd>+<kbd>P</kbd>) writes the canvas's pages.

Format
: **PDF** and **TIFF** hold every page in one file; **PNG** and **JPEG** write one file per page, numbered from the name you give (`book_01.png`, `book_02.png`). A single page keeps the name itself.

Resolution
: How many pixels per inch of the page's own size. A page is rasterised at exactly that and no more.

Quality
: How hard the pages are compressed. A PDF page is a photograph and is carried as one, which is what keeps the file from weighing what its pixels weigh; 100 keeps every code and makes it several times larger. PNG and TIFF are always lossless.

Output profile and rendering intent
: The [colour profile](../../color-management/_index.md) the pages are converted to, embedded in the file that is written.

{{< note >}}
The page size, its orientation and its bleed are the canvas's own, set under _Guides_ in the toolbar, so what you laid out is what comes out. A canvas with no page size exports as one page around every frame.
{{< /note >}}

Text and connectors are rasterised along with everything else, so an exported page is pixels rather than vectors.

## Colour

The canvas composites in linear Adobe RGB (1998) with premultiplied alpha, which is what makes translucent frames, feathered cutouts and drop shadows blend the way light does rather than the way codes do. Every colour it draws — borders, text, backgrounds, grid dots — goes through the same conversion as the pictures, so a border matches the picture it frames. On screen the finished canvas goes through your monitor profile; on export it goes through the profile you chose.

## Keyboard shortcuts

{{< table >}}
| Action | Linux / Windows | macOS |
| --- | --- | --- |
| New canvas | <kbd>Ctrl</kbd>+<kbd>N</kbd> | <kbd>⌘</kbd>+<kbd>N</kbd> |
| Open a canvas | <kbd>Ctrl</kbd>+<kbd>O</kbd> | <kbd>⌘</kbd>+<kbd>O</kbd> |
| Save the canvas | <kbd>Ctrl</kbd>+<kbd>S</kbd> | <kbd>⌘</kbd>+<kbd>S</kbd> |
| Save as | <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>S</kbd> | <kbd>⌘</kbd>+<kbd>Shift</kbd>+<kbd>S</kbd> |
| Export the canvas | <kbd>Ctrl</kbd>+<kbd>P</kbd> | <kbd>⌘</kbd>+<kbd>P</kbd> |
| Add a text frame | <kbd>T</kbd> | <kbd>T</kbd> |
| Add the notes of the selected images | <kbd>Shift</kbd>+<kbd>T</kbd> | <kbd>Shift</kbd>+<kbd>T</kbd> |
| Add a map | <kbd>M</kbd> | <kbd>M</kbd> |
| Draw a connector | <kbd>C</kbd> | <kbd>C</kbd> |
| Fit the view to the canvas | <kbd>Ctrl</kbd>+<kbd>0</kbd> | <kbd>⌘</kbd>+<kbd>0</kbd> |
| Zoom to 100% | <kbd>Ctrl</kbd>+<kbd>1</kbd> | <kbd>⌘</kbd>+<kbd>1</kbd> |
| Toggle the grid | <kbd>G</kbd> | <kbd>G</kbd> |
| Toggle snapping to the grid | <kbd>Shift</kbd>+<kbd>G</kbd> | <kbd>Shift</kbd>+<kbd>G</kbd> |
| Arrange as a grid, masonry, row, column | <kbd>1</kbd> … <kbd>4</kbd> | <kbd>1</kbd> … <kbd>4</kbd> |
| Check the images against the library | <kbd>R</kbd> | <kbd>R</kbd> |
| Refresh the stale images | <kbd>Ctrl</kbd>+<kbd>R</kbd> | <kbd>⌘</kbd>+<kbd>R</kbd> |
| Undo | <kbd>Ctrl</kbd>+<kbd>Z</kbd> | <kbd>⌘</kbd>+<kbd>Z</kbd> |
| Redo | <kbd>Ctrl</kbd>+<kbd>Y</kbd> | <kbd>⌘</kbd>+<kbd>Y</kbd> |
{{< /table >}}
