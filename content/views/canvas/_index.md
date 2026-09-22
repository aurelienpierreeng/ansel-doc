---
title: Canvas
date: 2026-09-11T00:00:00+02:00
lastmod: 2026-09-22
id: canvas
draft: false
weight: 35
author: "people"
tags:
    - layout
    - export
---

Canvas is where photographs become something else: an infinite plane on which you gather pictures, text, maps, drawings and shapes, arrange them freely, connect them, and export the result as pages to print or to post.

Most photographs are not the end of the road. Unless a picture is printed on its own as a fine-art print, it usually becomes material for something larger — a family album, a travel journal, a moodboard for a client, a zine, a poster, a post, a storyboard. That last step usually means leaving the photo editor for another application, exporting every picture along the way and losing track of which version went where. Canvas brings that step into Ansel, next to the pictures and their development, so that work which starts from a raw file can be finished in the same place.

It is made for people who create *around* photographs rather than for publishing houses. It favours a quick, relaxed way of working over the exhaustive controls of a desktop-publishing suite, and it is made for paper first — real page sizes, bleed, folds and bindings, and colour handled the way a print needs it — while exporting just as well for screens.

A canvas is used in one of two ways, and you switch between them by showing or hiding the page borders.

**Without pages, it is an infinite sketchbook.** Nothing is cut up, and the plane grows as you fill it. It is a place to:

- cull a series by laying it out and looking at it as a whole,
- check that a series holds together, or prepare the selection for an exhibition or a book,
- keep workflow memos next to the pictures they are about,
- keep moodboards, inspiration boards and storyboards,
- scrapbook, journal and sketch.

**With pages, it is a layout.** The plane is divided into contiguous pages, spreads or poster tiles, and the export writes one file per sheet: a multi-page PDF or TIFF, or a numbered sequence of PNG or JPEG images. It is a way to:

- lay out a photo book, a zine or a portfolio,
- make posters, collages and montages,
- prepare pictures for social media, banners and thumbnails at their exact sizes,
- tell stories with pictures: photo-based comic strips, and flowcharts drawn with connector arrows.

{{< note >}}
Canvas is not a desktop-publishing suite for magazines or books, and does not aim to become one. For print-shop-grade layout work — long documents, style sheets, vector PDF output — export the pages and finish them in a page-layout application.
{{< /note >}}

This page reads at two depths. [The canvas in ten minutes](#the-canvas-in-ten-minutes) covers everything needed to fill a canvas, style it and share it — enough for scrapbooking, journaling, sketching or a moodboard, and you can stop reading there. The sections after it go into detail for preparing work for print, working with a publisher or a print shop, fine typography and drawing. The [annex](#annex-how-the-canvas-blends-colour) explains how the canvas blends colour, and why its transparency and shadows look the way they do.

## A canvas is a file, not a library entry

A canvas is saved as a single `.anselcanvas` file — a zipped archive holding the layout and a copy of every picture, map and drawing in it. Nothing about it is stored in the Ansel library, so a canvas travels: you can hand it to someone who has no access to your raw files, and they can open it and rearrange the layout on their side.

Because the pictures are embedded, a canvas keeps working when the originals move or go offline. Each picture still remembers which library image it came from, so after touching an image up in the [darkroom](../darkroom/_index.md) you can bring the new development into the canvas — see [Keeping the canvas in step with the library](#keeping-the-canvas-in-step-with-the-library). Layout and development can therefore go on in parallel and meet at the end.

## The canvas in ten minutes

Everything in this section is reached from the toolbar above the plane or from the keyboard. Each toolbar button's tooltip also names its shortcut.

### Fill it

Open the view from the **Ateliers** menu, then drag pictures from the [filmstrip](../toolboxes/filmstrip.md) onto the plane. Everything else is added from the toolbar or with a key:

Text frame (<kbd>T</kbd>)
: A text frame at the centre of the view. You write in Markdown: `**bold**`, `*italic*`, `#` headings and lists all work.

Notes (<kbd>Shift</kbd>+<kbd>T</kbd>)
: The [text note](../toolboxes/notes.md) of each selected image — or of every image when none is selected — as a text frame linked to its image.

Map (<kbd>M</kbd>)
: A map frame at the centre of the view, placed where the selected image was taken, or at coordinates you type. An image's right-click menu also offers **Add a map of where it was taken**.

Drawing (<kbd>D</kbd>)
: A drawing read from an SVG file, placed at the size the file states.

Shapes
: A rectangle (<kbd>B</kbd>), a regular polygon (<kbd>P</kbd>) or a star (<kbd>Shift</kbd>+<kbd>P</kbd>). Drag out its box, or click to place one.

Lines
: A straight line (<kbd>L</kbd>) or a curve (<kbd>Shift</kbd>+<kbd>L</kbd>). Drag from one end to the other, or click to place one.

Connector (<kbd>C</kbd>)
: A line from one frame to another. Click an anchor dot on the first frame, then one on the second. The line follows its frames when they move.

A drawing tool stays armed so that you can draw the next shape or line straight away. <kbd>Esc</kbd> or a right click puts it away.

### Move around the plane

- <kbd class="mouse">Scroll</kbd>: zooms around the pointer.
- <kbd>Shift</kbd>+<kbd class="mouse">scroll</kbd>: pans sideways.
- <kbd class="mouse">Middle-drag</kbd>, or <kbd>Alt</kbd>+<kbd class="mouse">drag</kbd> (macOS <kbd>⌥</kbd>+<kbd class="mouse">drag</kbd>): pans.
- The _navigation flower_, the small compass in the corner of the view, does the same with the mouse alone: its four petals pan, its inner ring zooms in and out, and its centre fits the whole canvas in the view.
- _Fit_ (<kbd>Ctrl</kbd>+<kbd>0</kbd>, macOS <kbd>⌘</kbd>+<kbd>0</kbd>) and _1:1_ (<kbd>Ctrl</kbd>+<kbd>1</kbd>, macOS <kbd>⌘</kbd>+<kbd>1</kbd>) are in the toolbar.

While you pan, zoom or drag, pictures and drawings are drawn at a reduced resolution and sharpen as soon as you stop, which keeps a large canvas responsive. Text, borders, shapes and lines stay sharp throughout.

### Select, move, resize, rotate

- Click an object to select it. <kbd>Ctrl</kbd>+click or <kbd>Shift</kbd>+click (macOS <kbd>⌘</kbd>+click or <kbd>Shift</kbd>+click) adds it to the selection or takes it out.
- Drag across an empty part of the plane to select every object wholly inside the rectangle. Hold <kbd>Ctrl</kbd> or <kbd>Shift</kbd> (macOS <kbd>⌘</kbd> or <kbd>Shift</kbd>) to add to what is already selected.
- Drag an object to move the selection. It snaps to its neighbours and to the guides — see [Arranging and snapping](#arranging-and-snapping).
- Drag a corner handle to resize. The opposite corner stays where it is. Pictures, drawings, polygons and stars keep their proportions unless _Proportions_ is turned off in their properties; text frames, maps and rectangles take whatever proportions you give them.
- Drag the handle above a frame to rotate it. <kbd>Shift</kbd> snaps the angle to 15° steps, <kbd>Ctrl</kbd> (macOS <kbd>⌘</kbd>) to 45° steps.
- The arrow keys nudge the selection by one screen pixel, and by ten with <kbd>Shift</kbd>.
- <kbd>Delete</kbd> or <kbd>Backspace</kbd> deletes the selection. An object's right-click menu offers **Order**, **Duplicate** and **Delete**, and a frame's **Rotate** as well; a connector attached to a frame has no **Duplicate**.
- <kbd>Esc</kbd> steps back one level at a time: the gesture in progress, then the armed tool, then the open properties, then the selection.

A connector attached to a frame at both ends goes wherever its frames go, so it is never moved on its own.

### Change how something looks

Double-click an object, or select it and press <kbd>I</kbd>, to open its _properties_: a strip next to the object holding the few controls that object is most often changed by. A text frame's strip carries its font, size, colour and alignment; a shape's its geometry, fill and border colour; a connector's its route, arrowheads and colour; a picture's a line naming the file and saying whether it is up to date.

The arrow button at the end of the strip, _All the properties_, opens the rest of them in a card underneath, grouped in sections. The close button, or <kbd>Esc</kbd>, closes them. The properties never open on a single click, and they are placed where they cover none of the object's handles.

Every frame shares the canvas's border, corner rounding and drop shadow, and every line shares the canvas's line — set once for the whole canvas from _Borders_, _Shadows_ and _Lines_ in the toolbar. An object given its own in its properties keeps it. [Working with the properties](#working-with-the-properties) has the details.

### Choose a background

_Background_ in the toolbar paints the plane with _Transparent_, with a _Plain colour_, or with one of eight procedurally generated papers:

- _Moleskine paper_, an ivory notebook paper with a soft texture;
- _Watercolour paper_, a white paper with a thick tooth;
- _Laid paper_, a cloudy cream sheet carrying the papermaking mould's own wires — close-set laid lines about a millimetre apart, crossed by a chain line every 23 mm;
- _Embossed paper_, dried on a metallic mesh whose imprint stays in the fibres;
- _Japanese paper_, with large soft clouds and long wrinkles;
- _Psychedelic washi_, the same sheet with its wrinkles dyed in saturated threads of colour rather than lit as pale ridges;
- _Kraft paper_, unbleached brown wrapping paper with long fibres and the odd dark fleck of bark;
- _Charcoal card_, a near-black sheet whose tooth catches the light instead of casting shade.

The colour patch next to it tints the paper, so the same texture serves a warm ivory and a cool grey. _Texture_ opens four sliders: _Contrast_ for the body of the relief, _Detail_ for its fine structure, _Scale_ for the size of its features, and _Grain_ for the pixel-level grain that finishes it. _Reset_ puts back the paper as designed.

_Transparent_ leaves the plane a hole. It is shown as a chequerboard the size of the grid, and it is carried all the way to the exported file as an alpha channel, which is why JPEG — a format with no alpha channel — is not offered for a transparent canvas.

### Save, share, export

- **Canvas → Save** (<kbd>Ctrl</kbd>+<kbd>S</kbd>, macOS <kbd>⌘</kbd>+<kbd>S</kbd>) writes the `.anselcanvas` file; **Save as...** (<kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>S</kbd>, macOS <kbd>⌘</kbd>+<kbd>Shift</kbd>+<kbd>S</kbd>) writes a copy under another name.
- **Canvas → Open...** (<kbd>Ctrl</kbd>+<kbd>O</kbd>, macOS <kbd>⌘</kbd>+<kbd>O</kbd>) reopens a canvas, and **New** (<kbd>Ctrl</kbd>+<kbd>N</kbd>, macOS <kbd>⌘</kbd>+<kbd>N</kbd>) starts an empty one.
- **Canvas → Export...** (<kbd>Ctrl</kbd>+<kbd>P</kbd>, macOS <kbd>⌘</kbd>+<kbd>P</kbd>) writes the canvas as images: PDF and TIFF hold every page in one file, PNG and JPEG write one file per page. A canvas without pages exports as one page around everything on it.

Undo and redo are <kbd>Ctrl</kbd>+<kbd>Z</kbd> and <kbd>Ctrl</kbd>+<kbd>Y</kbd> (macOS <kbd>⌘</kbd>+<kbd>Z</kbd> and <kbd>⌘</kbd>+<kbd>Y</kbd>).

## Working with the properties

### The strip and the card

The properties open on a double click, on <kbd>I</kbd>, or from **Properties** in an object's right-click menu, and only then: selecting, moving or resizing an object never opens them. They close on their close button, on <kbd>Esc</kbd>, when the selection changes to another object, and when a drawing tool is armed.

The strip holds, from left to right, a glyph or a line about the object, its everyday controls, then up to three buttons: the object's content action, the arrow that opens the card (_All the properties_), and the close button. The content action goes *into* the object:

- a text frame: edit its text;
- a picture: develop it in the [darkroom](../darkroom/_index.md);
- a drawing: read it again from its file, after you have edited it in a drawing application.

Double-clicking an object whose properties are already showing, or pressing <kbd>Enter</kbd>, does the same.

The card holds every property, in sections that always come in the same order: the object's own sections first (_Character_, _Paragraph_, _Text box_ and _Text shadow_ for a text frame; _Picture_, _Drawing_, _Map_, _Route_ or _Shape_ for the others), then _Arrange_, _Fill_, _Border_ (_Line_ for a connector), _Corners_, _Shadow_ and _Cutout_. A section an object does not have is simply absent. One section is open at a time, and the one you left open is opened again the next time you look at the same kind of object. Inside a section, what is changed often comes first and what is rarely needed comes after a dotted rule.

The properties stay out of the way. They are placed next to the object, clear of every handle you might want to grab, and they do not move while the pointer is over them or while you are typing into them. When the view has no room left for them, they are hidden and a message suggests zooming out.

### Following the canvas, or owning a value

Four groups of properties follow the canvas until an object is given its own: the border and the corner rounding of every frame, the drop shadow of every object, and the line of every connector and free line. A text frame's font works the same way, following the canvas's default font. The canvas's values are set from _Borders_, _Shadows_ and _Lines_ in the toolbar.

The heading of such a section carries a switch and a one-line summary. Off, the object follows the canvas, and the summary says so. On, the object keeps values of its own, starting from exactly what was on screen, so turning the switch on changes nothing you can see. Editing any value of the group turns the switch on for you — except writing the canvas's own value while the object follows it, which changes nothing, so resetting a slider with a double click leaves the object following the canvas. To hand a group back to the canvas, turn its switch off.

### Typing lengths

Every length in the properties and in the _Guides_ accepts a unit, typed after the number: `210mm`, `21 cm`, `8.5in`, `12"`, `612pt` or `1080px`, with a decimal point or a decimal comma. A bare number is taken in the unit the field already shows, and a field keeps showing the last unit you typed into it. Each length in the _Guides_ also carries a unit menu next to it. The units are the point (1/72 inch), the pixel (1/96 inch), the millimetre, the centimetre and the inch.

Choosing a unit only changes how a length is written: the length itself does not move.

### Undo

Every gesture in the properties is one undo step, however many values it passed through: a slider dragged from end to end, a number typed, a colour picked. A colour window shows its colour on the canvas while it is open; closing it keeps the colour, and <kbd>Esc</kbd> inside it gives the old one back.

## Pictures, notes, maps and drawings

Pictures
: Dragged in from the filmstrip. The strip names the file and its size and, once the canvas has been [checked against the library](#keeping-the-canvas-in-step-with-the-library), whether the copy in the canvas is up to date. The _Picture_ section shows the _Film roll_ it comes from and offers _Refresh from the library_, _Show the image's text note_ and _Add a map of where it was taken_. The content action opens the image in the darkroom; once you come back, refresh it to bring its new development into the canvas.

Notes
: Text frames linked to an image's [text note](../toolboxes/notes.md). A note frame is a text frame in every other respect. **Reload the image's text note** in its right-click menu reads the note again.

Maps
: The strip carries the _Zoom_ level, from 1 to 19, and _Fetch_, which fetches the tiles again. The _Map_ section sets the _Style_ — the tile provider and its look — and the _Latitude_ and _Longitude_ of the centre. The map covers its frame at the tiles' own aspect ratio, cropped rather than stretched. **Fetch the map again** in its right-click menu downloads it anew.

Drawings
: SVG files, placed at the size the file states; a file that states no physical size is placed at its own drawing units, taken as points. The file itself travels inside the canvas, so the drawing survives the original being moved or deleted. After you edit the file, the content action or **Read the drawing's file again** in the right-click menu brings the change in. A drawing is drawn afresh at the size it is shown at, so it stays sharp at any zoom and at any export resolution. It gets no border and no shadow by default: it is ink on the page, not a card. Text flowing around a drawing follows the drawing's own ink, not the rectangle around it.

## Text and typography

### Writing

A text frame is written in Markdown, in a dialog opened by the content action, by <kbd>Enter</kbd>, or by **Edit the text...** in its right-click menu. The supported subset covers what captions, notes and short texts need: headings (`#` to `###`), bullet lists (`*` or `-`) and numbered lists (`1.`), `**bold**`, `*italic*` or `_italic_`, `` `code` ``, `~~strikethrough~~`, links (the text is kept, the address dropped), horizontal rules, and hard line breaks written as two spaces at the end of a line.

**Paragraphs are separated by a blank line**, as Markdown has it. A single line break inside a paragraph joins the two lines. The paragraph controls below — indent, spacing — act on paragraphs, so they need that blank line to find them.

The frame's height is yours to set, or follows the text with _Auto height_. **Fit the frame to the text** in the right-click menu fits it once.

### Character

_Font_, _Size_ and _Colour_ are on the strip. The size is in points, the same points the page is measured in, so twelve-point type is the same size on an A4 page as on a poster.

_Letter spacing_
: The tracking, in thousandths of an em, so that it follows the type size. Negative values condense a line and positive values open it out. A condensed *cut* of a typeface is a different thing, chosen in the font name.

_OpenType features_
: What the font can do with its own alternates: ligatures, small capitals, old-style or tabular figures, fractions, swashes, stylistic sets. Only the features the chosen font actually ships are offered, so the list changes with the font; the numbered ones are named after their number, since only the font knows what a given stylistic set draws. Features the layout engine needs to set text correctly — joining, mark placement, the script's own rules — are not offered, because turning them off breaks the text rather than styling it.

The section's switch gives the frame a font of its own, or hands it back to the canvas's default font.

### Paragraph

_Alignment_
: On the strip: _Left_, _Centred_, _Right_ or _Justified_. A justified paragraph never stretches its last line.

_Line height_
: The leading, as a multiple of what the font asks for: 1 is the font's own.

_First-line indent_ and _Paragraph spacing_
: The first moves the first line of every paragraph in from the edge, or out of it with a negative value — what a bibliography or a dictionary wants. The second adds space before every paragraph but the first. A typographer uses one of the two, rarely both.

_Optical margins_
: Hangs punctuation just outside the column, so that its edge reads from the letters' stems rather than from a quotation mark or a comma. It works at both edges: a line starting with a quotation mark begins a little further left, and in justified text a line ending with a comma reaches a little further right.

### Text box

_Vertical_
: Where the text sits in its frame when the frame is taller than the text: _Top_, _Middle_ or _Bottom_.

_Auto height_
: The frame's height follows its content, growing and shrinking downwards as you write, so the top edge stays where you put it.

_Inset_
: How far the text is held off the frame's edges, inside its border — what keeps a coloured frame from having its text run into the edge. One value serves all four sides; unlink it to set _Top_, _Right_, _Bottom_ and _Left_ separately.

_Flow around frames_ and its _Gap_
: Flows the text around the frames laid **over** it, keeping the gap you set. It follows what each frame actually draws — its cutout, its border and its shadow — not the rectangle around it: cut a picture to a circle and the text follows the curve and uses the empty corners beside it. Only frames above the text in the stack push it; anything behind it is simply behind it. A line carries on across every clear stretch of the column, so a picture standing in the middle of a column has text on both sides of it.

### Text shadow

A shadow cast by the letters themselves, with _Right_ and _Down_ offsets, a _Blur_, an _Extent_ and a _Colour_ whose opacity is its strength. It falls over the frame's own background and under the letters, and a blur of zero gives a hard-edged copy of the text — a drop shadow as a typesetter draws one. It is independent of the frame's _Shadow_, which the frame's box casts.

The strokes of a letter are thin, so a wide blur spreads them into almost nothing. _Extent_ thickens the letters' silhouette before the blur, so a soft glow behind a caption keeps its strength. With no blur and no offset, _Extent_ alone draws a crisp outline around the letters — the easiest way to keep a caption readable over a busy picture.

### How lines break

- A word is never split across two lines. A word wider than its column overflows the column rather than being cut in half.
- A number stays with the sign that follows it — `50 %`, `20 °C`, `5 ‰` — and French punctuation set with a space before `;`, `:`, `!` or `?`, or inside guillemets, never strands its mark at the start of a line.
- There is no automatic hyphenation. A soft hyphen you insert yourself is honoured, and the line breaks there with a hyphen.
- A paragraph breaks its lines in the same places at every zoom and in the export, so what you proofread on screen is what is printed.

## Drawing shapes and lines

### Shapes

The rectangle (<kbd>B</kbd>), polygon (<kbd>P</kbd>) and star (<kbd>Shift</kbd>+<kbd>P</kbd>) tools draw a shape by dragging out its box, or place one with a click. <kbd>Ctrl</kbd> (macOS <kbd>⌘</kbd>) holds a rectangle to a square, and <kbd>Shift</kbd> draws any shape from its centre.

The _Shape_ section holds:

_Geometry_ and _Filled_
: On the strip: _Rectangle_, _Polygon_ or _Star_, and whether the shape is filled. A filled shape's background colour and its border colour are on the strip as well.

_Sides_
: How many sides a polygon has, or how many points a star has, from 3 to 12.

_Depth_
: How far the notches between a star's points are pushed towards its centre.

_Roundness_
: How round the sides are, from straight to a circle. A rounded shape has no corners left for the corner radius to take.

_Turn_
: Turns the shape inside its frame. The frame itself does not move or turn: the shape is scaled to stay inside it, so it breathes a little as it goes round.

A shape pushes flowing text by what it paints: a filled shape as a solid, an empty one by its outline only.

New shapes take the style of the last one: its fill, border, corners and shadow. A polygon also remembers its sides and roundness, and a star its points, depth and roundness, separately, since a polygon and a star are two different things to reach for.

### Lines and curves

The line (<kbd>L</kbd>) and curve (<kbd>Shift</kbd>+<kbd>L</kbd>) tools draw between two points of the plane: drag from one end to the other, or click to place one. <kbd>Ctrl</kbd> (macOS <kbd>⌘</kbd>) holds the line to 45° steps, <kbd>Shift</kbd> to 15°. A curve is the same gesture, bent into an arc over the line you dragged.

Both ends of a line are its own: select it and drag an end to move it, anywhere — over a picture included, which is how an arrow points at a detail in a photograph. Bring an end within reach of a frame's anchor dot and the dot lights up; let go there and the end attaches to that frame, exactly like a connector's end.

A new line takes the width, colour, dashes and arrowheads of the last line you drew or edited.

## Connectors

### Drawing a connector

Arm the connector tool (<kbd>C</kbd>), click an anchor dot on one frame, then one on another. The tool stays armed for the next connector. <kbd>Esc</kbd> once takes back a first dot you have clicked; <kbd>Esc</kbd> again, or a right click, puts the tool away.

### Where an end attaches

Each frame offers nine anchor points: the middle of each edge, the four corners, and the centre. They are the frame's own points, so they turn with it. Two more behaviours are worth knowing:

- An end set to _Automatic_ leaves by whichever edge midpoint is nearest the other end, and changes side as the frames move.
- An end set to the centre, whose dot is drawn as a ring, aims at the middle of the frame and touches whichever side faces the other end. It stops where the frame actually draws something rather than on the rectangle around it: round off a frame's corners and the line follows the curve; cut the frame to a circle, an ellipse or a polygon and the line meets that shape, including its fall-off and its border.

### Changing where an end attaches

Select the connector and both its ends show a mark: a **hollow square** on an end attached to a frame, a **filled square** on a free end. Drag an attached end over any frame — including a frame the connector does not touch yet — and that frame shows its nine dots, the one nearest the pointer lights up, and the line moves to it so you can see where it will land before you let go. Let go to attach the end there. Letting go over empty plane puts the end back where it was, and the frame the other end holds is refused, since both ends on one frame would make a line of no length.

The same choice is made in words in the card: _Start_ and _End_ in the _Route_ section. Each appears only for an end that is attached to a frame.

You can drag the ends of the connector you have just drawn without putting the connector tool away first: while it is selected, a press on one of its ends takes that end rather than starting a new connector.

### Route, arrows and line

_Route_
: On the strip: _Straight_, _Square_ or _Cubic spline_.

_Arrow at the start_ and _Arrow at the end_
: On the strip: an arrowhead at either end, both, or neither.

_Waypoint_
: On the strip: adds a point the line passes through, which you drag to route the line around other frames.

_Reverse_
: On the strip: swaps the start and the end. The line keeps its path, and an arrowhead set at the end is now drawn at the other end, so the arrow points the other way.

The _Line_ section holds its _Width_, its _Colour_ — also on the strip — and _Dashed_. Every connector and free line follows the canvas's _Lines_ until it is given its own. A connector casts a shadow like any other object.

## Frames, borders, shadows and cutouts

The canvas's own border, corner rounding and shadow are set from _Borders_ (_Width_, _Colour_, _Corners_) and _Shadows_ (_Right_, _Down_, _Radius_, _Extent_, _Colour_) in the toolbar. An object overrides them from its own _Border_, _Corners_ and _Shadow_ sections — see [Following the canvas, or owning a value](#following-the-canvas-or-owning-a-value).

Border
: A width and a colour. On a rectangular frame it sits inside the frame's edge, with the content inset by it; on a cut-out frame it follows the cut shape.

Corners
: How far the frame's corners are rounded. Zero is square, and the rounding never goes past half the frame's shorter side.

Shadow
: An offset, a blur radius, an extent and a colour whose opacity is the shadow's strength. **The radius is the shadow's own switch**: at zero there is no shadow, a positive radius drops it outside the object, and a negative one casts it inside, along the edges. The shadow is taken from the object as it is drawn — after its cutout, its border and its opacity — so a feathered frame casts a feathered shadow and a translucent one a fainter shadow.
: A blur only spreads the shadow, it never adds to it: the wider the radius, the fainter the shadow, until a thin object's shadow all but disappears. **The extent grows the object's silhouette before the blur** — outward for a shadow dropped outside, inward for one cast inside — so the shadow keeps its full strength that much further, and a wide radius then fades it softly instead of washing it out. A feathered cutout keeps its feathering: its whole soft edge moves out by the extent. The extent does not switch a shadow on by itself; it grows whichever side the radius names.

Fill
: The object's _Opacity_, and a frame's _Background_: the colour laid under its content, which is what fills a text frame's box.

Cutout
: Cuts the frame out of its rectangle with a drawn shape — _Circle_, _Ellipse_, _Polygon_ or _Gradient_ — with a _Feather_ past its edge and _Invert_ to keep the other side. _Size_, _Size Y_, _Rotation_ and _Curvature_ appear for the shapes they apply to. The frame's border then follows the cut shape instead of the rectangle.

The shapes are the same [drawn masks](../darkroom/masking-and-blending/masks/drawn.md) the darkroom uses, so what you already know about them applies here.

### Editing a cutout

Turn on _Edit shape_ in the _Cutout_ section and the shape's handles appear over the frame: its centre or anchor, its radius or radii, and its feather on the dashed ring. Over the frame, <kbd class="mouse">scroll</kbd> sets the feather, <kbd>Shift</kbd>+<kbd class="mouse">scroll</kbd> the object's opacity, and <kbd>Ctrl</kbd>+<kbd class="mouse">scroll</kbd> (macOS <kbd>⌘</kbd>+<kbd class="mouse">scroll</kbd>) the gradient's curvature or the ellipse's rotation.

On a polygon, <kbd>Ctrl</kbd>+click (macOS <kbd>⌘</kbd>+click) on an edge inserts a node, <kbd>Shift</kbd>+click on a node removes it, and a double click switches it between a cusp and a smooth node. The right-click menu offers the same actions for the node or the edge under the pointer: **Switch to a smooth node** or **Switch to a cusp node**, **Give this node its computed curve back** once you have steered it by hand, **Remove this node**, and **Add a node here** on an edge. Outside the edit mode, **Edit the shape to work on this node** turns the edit mode on from a node.

A polygon node also owns two things the shape as a whole does not, and they appear on whichever node you bring the pointer near — one node at a time, so the handles never bury the shape:

- Its own **fall-off**, on the dashed tether leaving the node. Drag its end away from the node to widen the fall-off there, and towards the node to tighten it. A node you have never touched follows the shape's _Feather_, so a polygon behaves as one piece until you pull a node's fall-off out.
- Its two **control points**, the round handles tethered on either side, which steer how the curve enters and leaves the node.

What dragging a control point does depends on the kind of node:

Smooth node
: The two handles stay opposite each other, so one of them sets **both** the direction the curve leaves in and the **tension** it leaves with: drag it round the node to turn the curve, away from the node to make it pull harder, towards the node to slacken it. The curve keeps running smoothly through the node however far you take it.

Cusp node
: The two sides are free of each other, so each handle shapes its own side alone and the curve may turn a corner at the node.

A node starts as a cusp with its handles folded onto it, which is why a new polygon has straight edges. Make it smooth and its curve is computed from its neighbours until you steer a handle; from then on the curve is the one you gave it, and **Give this node its computed curve back** hands it back to the neighbours.

The handles are told apart by shape: a **square** is a cusp node, a **circle** is a smooth one, a circle on a short tether is a control point, and the end of the dashed tether is the node's fall-off.

## Locking a handle while you drag it

Hold <kbd>Ctrl</kbd> (macOS <kbd>⌘</kbd>) while dragging a handle and it is constrained:

- A handle that moves to a **place** — a cutout's centre, its radius, its feather, a polygon node, a connector's waypoint — keeps to one axis, whichever it has travelled furthest along since you pressed. Move mostly sideways and it stays level; move mostly up or down and it stays in its column.
- A handle that sets a **direction** — a connector's tangent handles, which set the direction its curve leaves in — snaps that direction to 45° steps around the point it turns about, keeping the length you pulled it to.
- A frame's **rotation** handle snaps to 45° steps, where <kbd>Shift</kbd> snaps to 15°.

## Arranging and snapping

Frames snap while you drag them: to the grid, to their neighbours, and to the page borders, margins and bleed lines. Every frame keeps a clear _padding_ around itself, so two frames snapped side by side sit **two paddings apart** and their padding boxes meet on one shared line. With _Snap sizes to neighbours_, a frame you resize can also take a neighbour's width or height. Which of these are active is set in _Guides_ in the toolbar.

_Arrange_ lays out the selected frames — or all of them when none is selected — as a _Square grid_, a _Masonry_, a _Row_ or a _Column_ (<kbd>1</kbd> to <kbd>4</kbd>), keeping the padding between them. _Sort by_ decides the order they are laid out in: _canvas order_, _filename_, _captured_, _id_ or _full path_, as in the [lighttable](../lighttable/_index.md), with frames that are not pictures following in canvas order. _Auto_ applies the layout.

**Order** in an object's right-click menu changes its depth in the stack: **Bring to front**, **Bring forward**, **Send backward**, **Send to back**. Depth matters beyond looks: only the frames above a text frame push its text aside.

## Pages and pre-press

A canvas can be divided into **pages**, tiled from the origin. Everything about pages is in _Guides_ in the toolbar.

### A canvas is measured in points

A canvas unit is a **point**, a seventy-second of an inch — the typographer's own unit — and every length on the plane is one: a page's size, a frame's, a border's width, a padding, a type size. Twelve-point type is twelve points on every page, whatever its size.

A screen format is named in pixels, and a pixel is taken at 96 to the inch, the same reference pixel web browsers use. A 1080 × 1920 story is therefore 810 × 1440 points on the plane, and exporting it at 96 dpi gives back exactly 1080 × 1920 pixels. That is what lets a story and a sheet of A4 sit side by side at their real relative sizes.

_Export DPI_ decides how many pixels an exported page carries, and nothing else: changing it moves nothing on the plane. A design does not resize itself when you change the page size either — twelve points stays twelve points — so filling a different page is a deliberate change you make yourself.

### Page size

_Size_ offers, in this order: _None_, _Custom size_, the ISO sizes _A0_ to _A6_, _US Letter_, and the screen formats _Instagram square_, _Instagram portrait_, _Story, reel, Short_, _Facebook post_, _Facebook cover_, _YouTube thumbnail_ and _YouTube banner_. _Orientation_ turns the page to _Portrait_ or _Landscape_.

_Custom size_ shows two more fields, _Custom W_ and _H_, for a page of any size — type it in the unit your print shop gives it in, such as `148mm` or `5.5in`.

### Guides

The guides follow the printer's convention, so a page laid out here looks like the template a print shop would send you: the page border is the **trim** and is black, the **bleed** red, the **margins** violet, the **padding** around each frame blue, and a **fold** is the one dashed line. The trim, the margins, the bleed and the padding each have their own _Show_, _Snap_, _Size_ and _Colour_. _Over_ draws them on top of the content instead of underneath, which is how you place a frame that deliberately crosses a page break. The grid has its own _Show_, _Snap_, _Size_ and _Colour_ too.

Margins
: Kept clear **inside** every page edge. Nothing enforces it — it is a line to lay frames against and a rule for them to snap to — and nothing is moved.

Bleed
: How far the sheet keeps going **past** every page edge. A frame cut in two by a page break carries on into the bleed on both sheets, which is what a trim cuts into. It is a property of the canvas, so the export writes the sheet it describes.

### Spreads and folds

A **spread** is the block of pages printed on one sheet of paper: so many _Across_ by so many _Down_. A book is 2 by 1 — two facing pages, one fold down the middle — a zine folded both ways is 2 by 2, and a poster printed at home and taped together is as many as it takes. Leave both at 0 and the canvas is tiled evenly, every page on its own.

Inside a spread the pages touch, and the line between them is a **fold**, drawn dashed: a picture laid across it carries on over both pages and is not cut. Between one spread and the next the canvas opens up by twice the bleed, because those are two different sheets and each needs its own bleed all round. On a spread the bleed and the margins belong to the sheet rather than to each page, so a page in the middle of a spread has no bleed at its folds.

_Bind gutter_ is the allowance the binding takes out of the middle. It is kept clear inside each page **at the fold only**, added to the margin there, so a perfect binding does not swallow the centre of a picture that crosses it.

## Exporting

**Canvas → Export...** (<kbd>Ctrl</kbd>+<kbd>P</kbd>, macOS <kbd>⌘</kbd>+<kbd>P</kbd>) writes the canvas's pages. The page size, its orientation and its bleed are the canvas's own, set in _Guides_, so what you laid out is what comes out.

Format
: _PDF_ and _TIFF_ hold every page in one file; _PNG_ and _JPEG_ write one file per page, numbered after the name you give (`book_01.png`, `book_02.png`). A single page keeps the name itself. For a transparent canvas, JPEG is not offered.

Resolution (dpi)
: How many pixels per inch of the page's own size. It starts from the canvas's _Export DPI_; a value changed here applies to this export and leaves the canvas as it is.

Quality
: How hard the pages are compressed. A PDF page is a photograph and is carried as one, which keeps the file from weighing what its pixels weigh; 100 keeps every detail and makes it several times larger. PNG and TIFF are always lossless.

Output profile and Rendering intent
: The [colour profile](../../color-management/_index.md) the pages are converted to and embedded in the file, and the [rendering intent](../../color-management/rendering-intent.md) of that conversion.

The export writes one page per **sheet**, not per canvas page: a book's spread comes out as one wide page with the fold in the middle. Pages with nothing on them are skipped. A canvas with no page size exports as one page around everything on it.

Text and lines are rasterised with everything else, so an exported page is pixels rather than vectors.

## Keeping the canvas in step with the library

The toolbar's _Object_ menu keeps the pictures and notes in the canvas in step with the library:

- **Check against the library** (<kbd>R</kbd>) compares every picture with the library and marks it as current, stale or missing.
- **Refresh the stale images and the notes** (<kbd>Ctrl</kbd>+<kbd>R</kbd>, macOS <kbd>⌘</kbd>+<kbd>R</kbd>) renders again only the pictures whose development changed, and reads the notes again.
- **Refresh every image** renders every picture again, which is also how you pick up a change of render size.

A single picture is refreshed from **Refresh from the library** in its right-click menu or in its _Picture_ section.

## Keyboard shortcuts

{{< table >}}
| Action | Linux / Windows | macOS |
| --- | --- | --- |
| New canvas | <kbd>Ctrl</kbd>+<kbd>N</kbd> | <kbd>⌘</kbd>+<kbd>N</kbd> |
| Open a canvas | <kbd>Ctrl</kbd>+<kbd>O</kbd> | <kbd>⌘</kbd>+<kbd>O</kbd> |
| Save the canvas | <kbd>Ctrl</kbd>+<kbd>S</kbd> | <kbd>⌘</kbd>+<kbd>S</kbd> |
| Save the canvas as | <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>S</kbd> | <kbd>⌘</kbd>+<kbd>Shift</kbd>+<kbd>S</kbd> |
| Export the canvas | <kbd>Ctrl</kbd>+<kbd>P</kbd> | <kbd>⌘</kbd>+<kbd>P</kbd> |
| Add a text frame | <kbd>T</kbd> | <kbd>T</kbd> |
| Add the text notes of the selected images | <kbd>Shift</kbd>+<kbd>T</kbd> | <kbd>Shift</kbd>+<kbd>T</kbd> |
| Add a map | <kbd>M</kbd> | <kbd>M</kbd> |
| Place a drawing | <kbd>D</kbd> | <kbd>D</kbd> |
| Draw a connector | <kbd>C</kbd> | <kbd>C</kbd> |
| Draw a line | <kbd>L</kbd> | <kbd>L</kbd> |
| Draw a curve | <kbd>Shift</kbd>+<kbd>L</kbd> | <kbd>Shift</kbd>+<kbd>L</kbd> |
| Draw a rectangle | <kbd>B</kbd> | <kbd>B</kbd> |
| Draw a polygon | <kbd>P</kbd> | <kbd>P</kbd> |
| Draw a star | <kbd>Shift</kbd>+<kbd>P</kbd> | <kbd>Shift</kbd>+<kbd>P</kbd> |
| Show the properties of the selected object | <kbd>I</kbd> | <kbd>I</kbd> |
| Go into the selected object (edit, develop, reload) | <kbd>Enter</kbd> | <kbd>Enter</kbd> |
| Step back: gesture, tool, properties, selection | <kbd>Esc</kbd> | <kbd>Esc</kbd> |
| Delete the selection | <kbd>Delete</kbd> or <kbd>Backspace</kbd> | <kbd>Delete</kbd> or <kbd>Backspace</kbd> |
| Select all | <kbd>Ctrl</kbd>+<kbd>A</kbd> | <kbd>⌘</kbd>+<kbd>A</kbd> |
| Nudge the selection by a pixel, by ten | arrows, <kbd>Shift</kbd>+arrows | arrows, <kbd>Shift</kbd>+arrows |
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

## Annex: how the canvas blends colour

Almost everything on a canvas is a blend of two colours: a translucent frame over a picture, the soft edge of a feathered cutout, the fade of a drop shadow, a text shadow under its letters, even the smoothed edge of every letter and every line. How those blends are computed decides whether they look like light or like mud, and the canvas computes them the way light mixes.

### Why blending colour codes goes wrong

Files and screens store colours as codes that are not proportional to the light they stand for: the scale is compressed towards the bright end, so that the dark tones, to which the eye is most sensitive, get more of the available codes. Code 128 out of 255 is therefore not half the light of code 255 but only about a fifth of it.

Most graphics software blends those codes directly, as if they were light. A white edge covering half of a black pixel then comes out as code 128 — about 22 % of the light, where half the light was owed. Every blend is too dark: edges look heavier than they should, a translucent frame dims what is under it too much, and a shadow's fade turns muddy instead of fading evenly.

### What the canvas does instead

The canvas paints each object into a layer of its own, then decodes that layer into **linear light** — numbers proportional to the light, the way a camera sensor counts it — before blending anything. The cutout's feathering, the border, the opacity and the shadow are all computed there, and every layer is laid over the page in that linear space, in 32-bit floating point. The finished page is encoded back into codes once, at the very end.

Half-covered white over black then gives what it should: half the light, which is code 186 in Adobe RGB (188 in sRGB), not 128.

The layers carry **premultiplied alpha**: a colour is stored already weighted by how much of the pixel it covers. A fully transparent pixel therefore carries no colour at all, so a feathered edge never picks up a dark or coloured fringe from whatever colour an invisible pixel happened to hold, and a picture shrunk onto its frame keeps clean edges. An opaque pixel comes back out as exactly the code it went in with, so nothing that is not blended is changed.

### One working space, colour management last

The canvas blends in one space throughout: **linear Adobe RGB (1998)**, wider than sRGB and a better match for what a print can reproduce.

- The pictures leave the [pixelpipe](../darkroom/pixelpipe/the-pixelpipe-and-module-order.md) in Adobe RGB, with the profile embedded in the copy the canvas keeps. Older copies made in sRGB, and map tiles, are converted when they are read.
- Every colour the canvas draws itself — borders, text, backgrounds, papers, lines, shadows — goes through the same conversion as the pictures, so a border matches the picture it frames exactly.
- Colour management happens once, on the finished page: on screen it is converted to your [display profile](../../color-management/display-profile.md), and on export to the output profile chosen in the export dialog, with the rendering intent chosen there; that profile is embedded in the file.

Keeping every input in one space until the very end is what makes a blend mean the same thing wherever it happens, and what you see on screen the same as what is printed, within what the screen and the printer can each show.

### Drawings keep the look their author gave them

The SVG standard defines how a drawing blends *inside itself* — its overlaps, gradients and soft edges — in sRGB, with the sRGB curve applied. Blending its pieces one by one in the canvas's linear space would draw a different picture from the one its author saw. So a drawing is first rendered whole, exactly as the standard specifies, and only the finished drawing is converted into the canvas's space and blended with the rest of the page.

### Transparency, all the way out

A transparent canvas is carried to the exported file as an alpha channel, page by page, in PNG, TIFF and PDF alike, so the page can be placed over anything in another application with its holes intact. That is the reason JPEG, which has no alpha channel, is not offered for a transparent canvas: it would have to fill the holes with some colour, and no single colour is the right one.
