---
title: photographic grain
date: 2026-03-23T00:00:00+01:00
id: crystallographic-grain
applicable-version: 4.0
working-color-space: RGB
view: darkroom
masking: true
include_toc: true
---

Simulate photographic grain from a stochastic stack of silver-halide crystal layers.

This module implements a production version of the model presented in [Stochastic photographic grain synthesis from crystallographic structure simulation](https://eng.aurelienpierre.com/2023/07/stochastic-photographic-grain-synthesis-from-crystallographic-structure-simulation/). The goal is not to add generic noise, but to discretize the scene-referred image into finite crystal footprints that capture and deplete light through an emulsion stack.

Unlike simple additive noise, the module works with crystal-shaped grains, a per-layer filling ratio, and a remaining-light model. Each crystal captures a flat tone averaged over its own footprint, so image detail finer than the grain size is not preserved inside the grain.

This way of simulating photographic grain is inspired by physics but is not a 1:1 simulation. The sensitometry aspect was deliberately left since that part is covered by other modules already, and chemical effects of developers over the grain size has not been simulated.kk                   

## scene-referred placement

_Photographic grain_ is a scene-referred module and is meant to run before _filmic rgb_ in the pixelpipe.

That matters because the module simulates light being captured by crystals in the emulsion. It therefore belongs before display rendering and before output-referred tone mapping. Grain statistics are built from the scene-referred signal, then later modules shape the final display contrast as usual.

## reference model

The emulsion is modeled as a stack of elementary crystal layers. For each layer:

- crystal seeds are placed stochastically from a target filling ratio,
- each accepted seed randomly picks one crystal footprint from a small precomputed bank,
- the current light field is averaged over that grain footprint,
- the captured amount is limited by the layer sensitivity,
- that flat crystal tone is written to the output over the whole grain surface,
- the same energy is subtracted from the remaining light field before deeper layers are processed.

The implementation keeps the physically important part of the article:

- light is split in depth through layers,
- grain is built from finite crystal footprints,
- capture is limited by the remaining available light,
- the final stack is normalized for average exposure.

## crystal model

Crystal footprints are regular polygons rasterized on the pixel grid with sub-pixel boundary coverage:

- average size is controlled by the _crystal average size_ slider,
- crystal size follows a log-normal distribution,
- polygon vertex count follows a gaussian distribution centered around six,
- orientation is randomized,
- grains with more than five sides are approximated as circles for speed,
- non-integer radii keep a partial-occlusion boundary instead of collapsing to a hard binary edge.

Each layer precomputes a bank of random crystal footprints, then accepted seeds randomly pick one bank entry. This avoids recomputing crystal geometry inside the hot pixel loop while keeping enough variation inside each layer.

## modes

### B&W

The image is reduced to one luminance-like scalar light field, one grain stack is synthesized from it, and the resulting luminance modulation is reapplied to RGB while preserving the original color ratios.

This is the closest mode to the scalar reference model and the most neutral starting point.

### color

Color mode models film as sequential blue-, green-, then red-sensitive sub-stacks. The remaining-light field is updated in depth order, so deeper color-sensitive layers only see the light not already captured above them.

This is not a full chemical simulation of color negative film, but it is more physical than three independent parallel RGB noise syntheses. The geometry can also be partly shared across channels to control how correlated the grain structure is between color-sensitive layers.

## controls

mode
: Choose between one monochrome grain stack and one sequential color grain stack.

filling
: Surface ratio occupied by crystals in each layer. Ilford B&W film emulsions from the 1960's have been documented to have around 15% of the layer surface covered by silver crystals. A 25% filling ratio visually match better modern film stock.

: This is a per-layer crystal coverage target, not the final visible grain coverage after the full stack has been accumulated.

: Pushing this value to 100% essentially removes all grain.

crystal average size
: Average crystal footprint in pixels at 100% zoom.

: Below 100% zoom, the footprint follows the effective raster scale of the current processing grid. Above 100% zoom it is clamped, so zooming in does not invent larger grains.

: The silver halide crystal is the actual unit sensor of film emulsions, which means details finer than the grain size cannot be recorded. This parameter therefore affects both the coarseness of the grain and the sharpness of the image. 

layers
: Number of crystal layers stacked through the emulsion. In color mode, this is understood as the number of layers per channel.

: More layers generally average the result and reduce the visibility of individual grains. Fewer layers make the grain more abrupt and coarser.

: Real film emulsions have theoritically :
: - around 14 crystal layers for B&W film using non-tabular grains, 
: - 14 crystal layers per color layer for color film using tabular grains,
: - up to 83 layers for B&W film using tabular grains (Kodak T-Max, Iford Delta).

crystal size variability
: Log-normal standard deviation of crystal sizes.

: At `0`, grain size stays very regular. Increasing this produces a broader size distribution and a less synthetic texture.

layer sensitivity
: Per-layer capture bias in EV.

: `0 EV` is the neutral setting. It means one layer captures its nominal `1 / layers` share once normalized by the average rasterized grain surface. Positive values make each layer capture more energy. Negative values make each layer capture less.

inter-channel grain correlation
: In color mode only.

: Probability that blue-, green- and red-sensitive sub-layers reuse the same crystal births and shapes at matching depths. Lower values give more independent chromatic grain. Higher values produce more shared, film-like grain structure.

grain colorfulness
: In color mode only.

: Scales only the chromatic amplitude of the RGB grain residual while keeping its achromatic grain strength unchanged. Lower values mute fluorescent color speckle without desaturating the underlying image.

## presets

The module ships with two built-in presets:

- _color grain_: filling `85%`, crystal average size `4 px`, `30` layers, layer sensitivity `0 EV`, inter-channel grain correlation `67%`, grain colorfulness `67%`, crystal size variability `0.25`.
- _B&W grain_: filling `25%`, crystal average size `4 px`, `30` layers, layer sensitivity `0 EV`, crystal size variability `0.25`.

These are meant as practical starting points rather than measured film stocks.

## practical workflow

Start in this order:

1. Choose _mode_.
2. Set _crystal average size_ to establish the grain scale.
3. Tune _filling_ to control how much of each layer is occupied by crystals.
4. Adjust _layers_ and _layer sensitivity_ to control how much energy the stack captures.
5. Add _crystal size variability_ if the structure feels too regular.
6. In color mode, reduce _grain colorfulness_ or increase _inter-channel grain correlation_ if the grain feels too fluorescent.

In practice:

- if the grain is too strong, reduce _filling_ or _layer sensitivity_, or increase _layers_,
- if the grain is too fine, increase _crystal average size_,
- if the pattern is too regular, increase _crystal size variability_,
- if color grain looks synthetic, lower _grain colorfulness_ first, then increase _inter-channel grain correlation_ if needed.

## preview, zoom and thumbnails

The user-facing grain size is defined relative to the 100% image view, but the implementation compensates for the actual processing grid:

- zooming in above 100% does not enlarge grains beyond their 100% reference size,
- zooming out adapts the grain to the current raster scale,
- reduced mipmap inputs, such as the thumbnail pipeline, are compensated so grain size stays closer to the darkroom reference instead of becoming artificially coarse.

Critical tuning should still be judged near the final viewing scale.

## masking and blending

This module supports Ansel masks and blending operators.

That lets you:

- apply different grain sizes or fillings to different regions,
- keep faces and skin cleaner than backgrounds,
- stack several instances for more complex emulsions,
- reduce the visible contribution of one instance with opacity while preserving its internal grain statistics.

## performance

This module is significantly more expensive than synthetic additive noise because it simulates many layers of crystal capture.

Processing cost mainly increases with:

- larger crystal average size,
- more layers,
- larger output images.

The module supports OpenCL. CPU and OpenCL both use the same light-depletion model, but performance still depends strongly on image size and grain settings.

## notes

- The result is intentionally stochastic. Two parameter sets with similar average strength may still produce different local clustering.
- The module simulates grain structure, not full film sensitometry or print chemistry.
- Color mode is not a complete color-film emulsion simulator, but a sequential color-sensitive grain model built on the same remaining-light framework.
