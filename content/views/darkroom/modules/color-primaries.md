---
title: Color primaries
date: 2026-04-01T00:00:00+02:00
id: color-primaries
applicable-version: 4.0
working-color-space: RGB
view: darkroom
masking: true
include_toc: true
---

Edit RGB/CYM primary control nodes in dt UCS and remap colors through a procedural 3D LUT.

The _color primaries_ module is a secondary color-grading tool built around the six additive and subtractive primaries:

- _red_,
- _yellow_,
- _green_,
- _cyan_,
- _blue_,
- _magenta_.

Each of these control nodes is sampled inside the internal RGB gamut and converted to _dt UCS HSB_. The module lets you change the hue, saturation and brightness of those six reference colors, then interpolates the resulting RGB shifts through a cylindrical local field to build a dense 3D LUT.

This gives a tool that sits between a classic primary/secondary corrector and a palette remapper:

- The controls are sparse and easy to understand,
- The final effect is continuous over the whole RGB volume,
- Achromatic colors remain fixed on the black-white axis.

## Scene-referred placement

The module is designed to run before [_color balance rgb_](./color-balance-rgb.md) in the pixelpipe.

Its internal LUT is built and applied in Rec.2020 HLG code values, while the module input and output stay in the pipeline working RGB space. Scene-referred RGB is normalized by the module _white level_ before entering the LUT domain and denormalized afterwards.

## General principles

The six user controls do not sit directly on the RGB cube corners. Instead, the module starts from the RGB and CYM corners and recesses them toward the achromatic axis. The amount of recession is controlled by _gamut coverage_.

At `100 %`, the control nodes reach the RGB cube shell. At lower values, the control hull shrinks inward. This setting is critical because it changes what the node edits mean geometrically:

- At `100 %`, negative saturation changes behave like a gamut compression, because the control hull touches the full internal gamut shell and desaturating the nodes pulls extreme colors back inward.
- Well below `100 %`, the control hull sits inside the gamut. Increasing saturation from there can increase colorfulness by stretching a smaller inner color volume toward the outer gamut.
- At `100 %`, positive saturation changes are dangerous. Since the control nodes already lie on the gamut shell, adding saturation there can push the interpolation toward very large RGB excursions and quickly explode the gamut.

In practice:

- use `100 %` coverage together with negative saturation shifts when your goal is gamut compression,
- lower _gamut coverage_ significantly below `100 %` when your goal is to make colors more vivid,
- avoid using `100 %` coverage together with positive saturation unless you need a very small and carefully controlled effect.

Use the LUT viewer, in the _options_ tab to preview the effect of your changes and validate the gamut is not all squeezed against the cube shell.

## Module controls

The user interface is split into two tabs:

- _colors_,
- _options_.

### Colors tab

The _colors_ tab contains one section for each primary or secondary color, ordered along the light spectrum:

- _red_,
- _yellow_,
- _green_,
- _cyan_,
- _blue_,
- _magenta_.

Each section contains the same three sliders.

hue
: Rotate the selected control node around the dt UCS hue ring.

: This changes the hue of the selected primary or secondary and lets neighboring colors follow through interpolation.

saturation
: Increase or decrease the chroma of the selected control node.

: Negative values pull the node toward the achromatic axis. Positive values push it outward.

: The practical meaning depends strongly on _gamut coverage_:

- with `100 %` coverage, negative saturation is the safe way to compress gamut,
- with lower coverage, positive saturation can be used to increase colorfulness,
- with `100 %` coverage, positive saturation can produce excessive out-of-gamut excursions and should be avoided.

brightness
: Change the dt UCS brightness of the selected control node.

: This is useful to make a primary or secondary color look lighter or darker without changing all other hues equally.

The slider backgrounds are color-coded from the actual node colors and converted to the current display color profile for preview.

{{< note >}}
While we take the chromaticity coordinates of the Rec.2020 RGB primaries, we define their colorshift perceptually in dt UCS HSB space, project the shift back in RGB, and interpolate it in 3D as RGB gradients where the smoothing also happens. This allows a perceptually-grounded color change definition while limiting chroma noise, fringes, and other color artifacts typically associated with manipulating color in perceptual spaces because the 3D interpolation in RGB better preserves image gradients.
{{< /note >}}

### Options tab

white level
: Define the scene-referred white normalization used before the RGB signal enters the LUT domain.

: This is useful when the image contains values above diffuse white and you want the internal LUT to work in a bounded RGB code-value range.

: The slider includes a color picker. Sample a bright reference in the image to set the normalization directly from the scene.

gamut coverage
: Control how far the six control nodes reach toward the RGB cube shell.

: This parameter defines the effective color volume controlled by the module.

: At `100 %`, the control nodes lie on the gamut boundary and desaturation acts like gamut compression.

: Reducing the value recesses the control hull toward the achromatic axis. This is often the better starting point when your goal is to increase colorfulness.

brightness smoothing
: Control how far brightness edits spread along the black-white axis when the deformation field is built.

saturation smoothing
: Control how far saturation edits spread away from the achromatic axis. Increase if you start seing chroma noise.

hue smoothing
: Control how broadly neighboring hue regions contribute to each local deformation. Increase if you start seeing chroma noise or uneven transitions between hues.

neutral protection
: Reduce the strength of color shifts close to the achromatic axis.

: Higher values protect near-neutral colors more strongly from hue and saturation remapping.

interpolation
: Choose the 3D LUT interpolation method used at application time.

: The same methods are available as in [_lut 3D_](./lut-3D.md): _tetrahedral_, _trilinear_ and _pyramid_. With a dense LUT the visual differences are usually subtle, but tetrahedral is the default and safest option.

## LUT viewer

The bottom part of the _options_ tab contains a 3D LUT viewer. It displays the LUT geometry as a projected RGB cube:

- One colored node for the input RGB sample,
- One colored node for the output RGB sample,
- An arrow from input to output.

The viewer can display either:

- the interpolated LUT,
- the sparse control nodes used to build it.

These two modes are mutually exclusive and help answer different questions:

- use the interpolated LUT view to inspect the final color field,
- use the control-node view to understand how the sparse primaries scaffold is arranged in RGB.

The viewer uses the LUT internal RGB coordinates for geometry, but converts node colors to the display color profile for drawing.

### Viewer controls

azimuth
: Rotate the cube around the achromatic axis.

axis tilt
: Tilt the achromatic axis relative to the viewing plane. At `90°`, it shows a chromaticity diagram with the achromatic axis orthogonal to the graph plane. At `0°`, it shows the achromatic axis parallel to the graph plane.

slice depth
: Move the slicing plane through the cube. On dense LUTs, slicing allows an internal view of the cube at a given depth without displaying all nodes in front of and behind the plane.

slice thickness
: Show only node pairs lying within a band around the slicing plane. At `100 %`, slicing is effectively disabled and the graph may become too crowded to read.

color shift threshold
: Hide `input -> output` mappings whose input/output distance is below the selected percentage of RGB code values.

target gamut
: Restrict the displayed samples to those inside the selected RGB gamut.

show control nodes
: Switch the viewer from the interpolated LUT cloud to the sparse control-node cloud.

save to cLUT
: Export the currently displayed LUT to a reusable `.cube` file with metadata describing the LUT color space. This file needs to be applied in HLG Rec.2020 color space.

### Viewer mouse interaction

mouse wheel
: Zoom in and out, centered on the mouse cursor position.

left-button drag
: Pan the view.

middle-button drag horizontally
: Change the azimuth angle.

## Practical guidance

The strongest creative and technical lever in this module is _gamut coverage_. It is not just a reach parameter. It changes whether the module behaves more like a gamut compressor or more like a colorfulness enhancer.

A safe workflow is often:

1. set _white level_ correctly,
2. choose _gamut coverage_ based on the intent,
3. edit the six node saturations first,
4. refine hue and brightness afterwards,
5. inspect the result in the LUT viewer.

As a rule of thumb:

- for gamut compression, start from `100 %` coverage and pull the relevant nodes inward with negative saturation values (desaturation),
- for colorfulness enhancement, reduce _gamut coverage_ first and then add saturation cautiously,
- if colors start to break apart or look synthetic, reduce either the saturation shifts or the coverage before increasing smoothing.

The effect will be stronger in the immediate vicinity of the color control nodes, so defining the _gamut coverage_ also defines where your settings have the most weight. As we move away from the control nodes, the effect becomes weaker, which gracefully blends the colorshifts but can also mute the initial intent.