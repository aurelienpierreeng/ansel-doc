---
title: drawing
date: 2026-03-08T00:00:00+01:00
id: drawing
applicable-version: 4.0
tags:
working-color-space: RGB
view: darkroom
masking: true
---

Paint premultiplied RGBA layers directly in darkroom and save them as pages inside a TIFF sidecar.

This module is a true painting layer system. It is not a local-adjustment mask editor and it is not a clone/heal tool like [retouch](./retouch.md). Instead, it creates and edits independent raster layers that are composited over the current image in the pixelpipe.

The intended use cases are:

- hand painting,
- dodging and burning with a brush,
- color glazing,
- painterly overlays,
- matte painting on top of a photograph,
- texture painting,
- soft masking or erasing with a pressure-sensitive tablet.

The TIFF sidecar is saved as 16 bits floating point, compressed losslessly, in scene-linear working RGB space (the colorspace ICC profile is included in the file), with premultiplied alpha. It can be modified in any software that supports this. 

Each instance of the module is saved as a different layer in this file. This sidecar can also be used to import any arbitrary image and compose it over the photograph, under the display view transform. Typical masking features are available too.

## what the module does

The module stores one or more drawing layers in a TIFF sidecar linked to the current image. Each layer is a premultiplied RGBA image in the module working space. The layer is loaded into memory, edited live in darkroom, composited over the image preview, and written back to the sidecar when needed.

The module works in three distinct spaces at the same time:

- a full-resolution authoritative layer cache, used for persistence,
- a view-dependent cropped and scaled process tile, used for realtime display while painting,
- the darkroom display buffer, where the layer is blended over the current image.

In practice, this means the brush can stay responsive while painting, even on large images, because the module paints live only into the visible process tile. The finished stroke is then replayed asynchronously at full resolution into the authoritative cache.

## general workflow

A typical workflow is:

1. Create a new drawing layer.
2. Choose a paint mode, fall-off, color and brush parameters.
3. Paint in darkroom.
4. Adjust or switch layers.
5. Save the sidecar explicitly if needed, or let the module flush it when leaving darkroom or closing the application.

The module can manage several layers inside the same sidecar TIFF. Each module instance is linked to one layer name and one layer order. You can therefore stack several drawing module instances if you want several independent painted layers in the history.

## how realtime painting works

The painting engine is split in two stages.

### 1. GUI stroke sampling worker

The first worker receives raw input events from the GUI:

- button press starts a stroke,
- pointer motion adds raw samples,
- button release ends the stroke.

Those raw events include:

- position,
- pressure,
- tilt,
- acceleration,
- current brush settings,
- stroke id and event id.

This worker converts raw input into evenly spaced dabs. It is responsible for:

- distance-based resampling,
- smoothing,
- interpolation of dab properties,
- pressure/tilt/acceleration mapping,
- stroke-local opacity and flow behavior,
- smudge carry state.

The emitted dabs are immutable records. Once a dab has been emitted into the stroke history, later stages are expected to consume it as-is.

### 2. full-resolution replay worker

While you paint, the module updates only the current process tile for display. When the stroke is finished, a second background worker replays the immutable dab history into the full-resolution layer cache.

This design avoids paying the cost of full-resolution rasterization at every live dab. It is the main reason the module can remain interactive on large images.

## compositing model

The drawing layer is stored as premultiplied RGBA and composited over the incoming image buffer.

That matters for three reasons:

1. Color and opacity are stored together in a way that avoids fringe artifacts at soft edges.
2. Erasing reduces alpha and therefore removes previously-painted contribution cleanly.
3. Layer blending remains stable through the pixelpipe and through OpenCL processing.

## brush tab

The _Brush_ tab contains the painting controls.

### paint mode

paint
: Paint the selected color over the current layer.

erase
: Reduce or remove previously-painted layer content by attenuating alpha.

blur
: Sample a local neighborhood and blend a blurred result back into the layer.

smudge
: Pick up already-painted pixels and drag them along the stroke.

### color

color
: Sets the brush color in display RGB.

pick from
: Choose whether the color picker samples from the module input or output.

HDR exposure
: Raises the brush color intensity above display white. This is useful if the layer is meant to live in a scene-referred HDR pipeline rather than as a simple display-referred overlay.

### geometry

fall-off
: Chooses the brush alpha profile. The module currently provides four profiles:
: - linear,
: - gaussian,
: - quadratic,
: - sigmoidal.

: The preview widget shows each profile rasterized with the current hardness and sprinkle settings.

size
: Brush radius in pixels.

sampling distance
: Controls dab spacing along the stroke.
: - low values produce very dense stamping,
: - high values space dabs farther apart,
: - very high values are faster but can reveal the individual stamp structure.

: Internally this goes from approximately one-pixel spacing at 0% to roughly one brush diameter at 100%.

smoothing
: Applies stroke smoothing before the dab is emitted. This reduces jitter from the raw pointer stream, at the cost of slightly more predictive motion.

hardness
: Controls the inner solidity of the brush.
: - high values produce a hard center and steeper edge,
: - low values produce a soft brush with a larger transition zone.

### thickness

opacity
: The target opacity of the stroke.

flow
: Controls how overlapping dabs build up within the same stroke.
: - at 100%, the stroke behaves like watercolor or an airbrush with overlap normalization: overlapping dabs in the same stroke are capped so they do not keep building toward full opacity under normal sampling. Self-intersecting brush strokes will have a constant opacity.
: - at 0%, the stroke behaves more like a marker or highlighter: overlaps accumulate. Self-intersecting brush strokes will build up more opacity at the intersection.
: - anything else is a weighted mix of both strategies.

: This is one of the most important controls to understand. _Opacity_ defines the intended strength of the stroke. _Flow_ defines how that strength is distributed across overlapping dabs.

### texture

sprinkles
: Adds multiplicative grain/noise to the brush alpha.

sprinkle size
: Controls the spatial size of the grain in layer-space pixels.
: - low values give fine grain,
: - high values give larger speckles or blotches.

coarseness
: Controls the octave mix of the sprinkle noise.
: - 0% favors the coarsest octave,
: - 50% balances the octaves evenly,
: - 100% favors the finest octave.

## layer tab

The _Layer_ tab manages sidecar layers and preview background.

### background

image
: Shows the normal image under the drawing layer.

white, grey, black
: Replaces the image background in the preview with a flat color. This is useful to inspect painted alpha and edge quality independently of the photograph.

### layer management

layer name
: Name of the current drawing layer in the sidecar TIFF.

source layer
: Select an existing layer from the sidecar.

create new layer
: Creates a new blank layer with the current name.

delete layer
: Deletes the linked layer from the sidecar TIFF.

create background from input
: Creates a background layer initialized from the module input. This is useful if you want to paint destructively on a rasterized snapshot rather than on transparency, or if you want to open the sidecar TIFF in another drawing application while still having the reference image in background. Both layers are positionned as they appear.

### fill

white
: Fills the current layer with opaque white.

black
: Fills the current layer with opaque black.

transparency
: Clears the current layer to full transparency.

## history buttons

At the top of the module, outside the notebook tabs, there are three important buttons:

undo
: Restores the previous full-layer snapshot.

redo
: Reapplies the last undone snapshot.

save sidecar
: Forces the current in-memory layer state to be written immediately to the TIFF sidecar.

This is explicit persistence, not just a history item. It is useful if you want to secure long painting sessions before leaving darkroom.

## input tab

The _Input_ tab maps tablet or pointer data to brush parameters.

It supports three input sources:

- pressure,
- tilt,
- acceleration.

Each source can modulate four targets:

- size,
- opacity,
- flow,
- hardness.

For each source, you can also choose a mapping profile:

- linear,
- quadratic,
- square root,
- inverse linear,
- inverse square root,
- inverse quadratic.

These mappings are evaluated per raw input event, before the event is turned into a resolved dab. The cursor preview uses the mapped values too, so the visible cursor should reflect what will actually be emitted into the stroke.

## stroke sampling details

The stroke engine does not simply stamp one dab per mouse event. Instead, it tries to build a stable sampled path.

The raw pointer path is converted into evenly spaced dabs according to the selected sampling distance. If GUI events arrive too sparsely because of system load or fast mouse motion, the missing dabs are interpolated along the path. If smoothing is enabled, the final dab position and properties are blended with a prediction from the previously-emitted dabs.

The important consequence is that the visible stroke should depend much more on the chosen brush spacing than on the operating system event rate.

## why this module can be slow

This module is more expensive than an ordinary color adjustment module, because it maintains and updates raster images interactively.

The main cost sources are:

### large brush footprints

Brush cost grows with the damaged area. A very large soft brush can touch hundreds of thousands of pixels per dab.

### blur and smudge

These modes are slower than ordinary paint and erase because they need extra neighborhood sampling and, for smudge, a carried runtime state.

### sprinkles

Sprinkles add procedural grain evaluation to the alpha path. Large sprinkle size and high-strength grain can become expensive, especially with large brushes.

### full-resolution replay

Live painting updates only the view-dependent process tile. The finished stroke is then replayed asynchronously at full resolution into the authoritative cache. This moves cost away from the live stroke, but it does not remove it.

On very long or very large strokes, the replay worker can remain busy for a while after the stroke ends.

### saving and leaving darkroom

The sidecar TIFF must reflect the authoritative full-resolution layer. If there are still deferred replay jobs pending when you:

- save the sidecar,
- leave darkroom,
- close the application,

then Ansel must wait for those jobs to finish before the sidecar can be written safely.

The module therefore shows a blocking modal wait dialog when leaving or closing while a layer still needs to be finalized and saved.

## performance architecture and limitations

The module uses several caches and workers to remain interactive. The first one being that layers are saved at the resolution of the RAW input, so this is a considerably larger painting matte than in most drawing applications.

### process tile

While painting, the module rasterizes into a process tile representing the current visible area plus a safety margin. This is what makes realtime interaction possible.

The consequence is that the immediate preview is view-dependent. If you pan or zoom, the tile must be rebuilt from the authoritative cache.

### authoritative full-resolution cache

The real saved layer lives in a full-resolution in-memory cache. The sidecar TIFF is only the persistence format.

This is necessary because rebuilding a full-resolution layer from a previously-scaled preview tile would destroy fine texture and blur procedural details such as sprinkles.

### deferred replay worker

Finished strokes are replayed into the full-resolution cache in a second worker thread. This reduces live latency, but it introduces a second source of work that must eventually complete.

### OpenCL

The module supports OpenCL in the compositing path. That accelerates the darkroom display path, but the brush rasterizer itself remains CPU-driven.

Practical consequences:

- the pixelpipe can blend the layer on GPU,
- stroke generation and dab rasterization are still CPU tasks,
- if OpenCL is disabled for the module, the compositing path will run on CPU,
- if OpenCL is enabled but later modules need the GPU at the same time, total responsiveness can still depend on system load and GPU contention.

### first-use costs

The first stroke in a session can still be slightly slower than later ones because some caches, threads and buffers are warmed lazily. Several first-use penalties have been reduced, but a completely cost-free first stroke is unrealistic in a raster painting system that initializes preview and replay resources on demand.

## practical advice

For best performance:

- keep brush size reasonable, paint with short strokes,
- avoid excessive smoothing unless needed,
- use lower sprinkle values for large brushes,
- reserve blur and smudge for smaller localized work,
- let the background replay worker catch up before saving or leaving darkroom if you painted a very long stroke.

For best visual consistency:

- think of opacity as stroke strength,
- think of flow as overlap behavior,
- use the preview background colors to inspect edges and alpha,
- save the sidecar after important milestones if you are building complex painted layers.

## caveats

This module is not designed for geometric retouching, source-target healing, or patch-based object removal. Use [retouch](./retouch.md) for that.

This module also does not replace masking-and-blending logic. It paints real pixels into a persistent layer. If you need parametric masks or drawn masks that remain fully procedural, use Ansel masking instead.

Because the layer is stored in a TIFF sidecar and replayed at full resolution, complex sessions can generate a non-trivial amount of CPU work and memory traffic compared with classic adjustment modules.

## summary

The _drawing_ module is a raster painting layer system for darkroom. It converts stylus or mouse input into sampled dabs, paints them live into a process tile for immediate display, then replays finished strokes asynchronously into a full-resolution authoritative layer cache that is saved in a TIFF sidecar.

Its strengths are:

- direct painting,
- tablet-aware input mapping,
- persistent paint layers,
- scene-referred HDR-aware color painting,
- responsive live preview.

Its main limits are:

- large-brush cost,
- slower blur and smudge modes,
- deferred full-resolution replay after strokes,
- blocking waits when pending work must be saved before leaving darkroom.
