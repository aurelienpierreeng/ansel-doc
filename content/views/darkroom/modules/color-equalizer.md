---
title: color equalizer
date: 2026-03-25T00:00:00+01:00
id: color-equalizer
applicable-version: 4.0
working-color-space: RGB
view: darkroom
masking: true
include_toc: true
---

Remap colors through a procedural 3D LUT driven by perceptual hue-ring controls.

The _color equalizer_ module is a secondary color-grading tool. It lets you define color shifts on three hue rings expressed in _dt UCS HSB_ space, then converts those shifts into a dense RGB 3D LUT that is applied to the image.

The user interface is meant to stay perceptually even:

- the editable graphs work in _hue_, _saturation_ and _brightness_ dimensions of _dt UCS HSB_,
- the underlying LUT is built in RGB code values and applied as a 3D cube transform,
- the interpolation between user nodes is smooth and periodic over hue.

Because the final effect is applied through a 3D LUT, hue, saturation and brightness edits can interact in a more global way than in curve-only modules. This makes the module well suited to creative color remapping and palette design, but more robust across dramatic changes.

## scene-referred placement

The module is designed to run after [_color balance rgb_](./color-balance-rgb.md) in the pixelpipe.

Its internal LUT is built and applied in Rec.2020 HLG code values, while the input and output of the module stay in the pipeline working RGB space. Scene-referred RGB is normalized by the module _white level_ before entering the LUT domain and denormalized afterwards.

## general principles

The _color equalizer_ is built around three brightness ranges:

- _shadows_,
- _midtones_,
- _highlights_.

For each range, three inner tabs define how colors should be remapped around the hue ring:

- _saturation_,
- _brightness_,
- _hue_.

Each graph is defined by editable nodes connected with a periodic monotone Hermite interpolation. The horizontal axis always represents hue. The vertical axis represents the selected correction dimension:

- _saturation_ scales chroma,
- _brightness_ scales the dt UCS brightness,
- _hue_ rotates hue around the ring.

From these user-defined ring deformations, the module builds a 64×64×64 RGB 3D LUT. The LUT is constrained to remain inside the RGB gamut cube.

## module controls

### primary tabs

shadows, midtones, highlights
: These tabs choose which brightness ring you are editing.

: Each ring corresponds to a fixed brightness anchor in dt UCS HSB space. In practice, the three rings let you define different color remappings for dark, medium and bright colors.

options
: This tab contains the global parameters controlling LUT generation and application.

### graph tabs

For each primary brightness tab, the following three inner tabs are available:

saturation
: Increase or decrease chroma around the hue ring.

brightness
: Increase or decrease the dt UCS brightness around the hue ring.

hue
: Rotate hues around the ring.

### graph interaction

left-click + drag
: Move an existing node.

Ctrl+left-click
: Add a new node on the curve.

right-click on a node
: Delete the selected node.

double-click
: Reset the current graph to its default flat state.

The graphs also display a vertical marker when the module color picker is active, showing the hue of the sampled color.

### options tab

The smoothing parameters are important when doing dramatic local changes : they will help blending color shifts to avoid hash transitions and halos between objects, as well as chroma noise. Increasing all smoothing parameters will make the actual color results drift away from user-set parameters at the benefit of better preserving gradients into the image and limiting edge artifacts.

white level
: Define the scene-referred white normalization used before the RGB signal enters the LUT domain.

: This is useful when the image uses values above diffuse white and you want the LUT to work inside a bounded `[0,1]` RGB code-value range.

brightness smoothing
: Control how far brightness edits spread along the achromatic axis when the local deformation field is built.

saturation smoothing
: Control how far saturation edits spread away from the neutral axis.

hue smoothing
: Control how many neighboring hue anchors contribute to the local deformation.

neutral protection
: Reduce the strength of color shifts close to the achromatic axis.

: Higher values protect near-neutral colors more strongly from hue and saturation remapping.

interpolation
: Choose the 3D LUT interpolation method used at application time.

: The same methods are available as in [_lut 3D_](./lut-3D.md): _tetrahedral_, _trilinear_ and _pyramid_. The difference is usually subtle with a dense LUT, but tetrahedral is the default and safest option.

### module color picker

A module-wide color picker is available below the graph notebooks.

It samples the module input in RGB, averages the selected area, normalizes the result by the module _white level_, and converts it to dt UCS HSB for feedback.

The picker is used to:

- draw a vertical hue marker on all graphs,
- display whether the sampled color lies mostly in _shadows_, _midtones_ or _highlights_.

When the sampled brightness lies between two rings, the label displays the relative distance between them, for example `35% shadows, 65% midtones`.

## LUT viewer

The bottom part of the module contains a 3D LUT viewer. It displays the LUT geometry as a projected RGB cube:

- one colored node for the input RGB sample,
- one colored node for the output RGB sample,
- an arrow from input to output.

The viewer uses the LUT internal RGB coordinates for geometry, but converts node colors to the display color profile for drawing.

### viewer controls

azimuth
: Rotate the cube around the achromatic axis.

axis tilt
: Tilt the achromatic axis relative to the viewing plane. At 90°, it shows a chromaticity diagram with the achromatic axis orthogonal to the graph plane. At 0°, it shows the achromatic axis parallel to the graph plane.

slice depth
: Move the slicing plane through the cube. On dense LUTs, slicing allows to get an "internal" view of the cube at a certain depth, for legibility purposes, without displaying color nodes behind and in front of the slicing plane ± slice thickness. 

slice thickness
: Show only node pairs lying within a band around the slicing plane. At 100 %, it effectively disables the effect of slicing and the graph may be too crowded to be legible.

color shift threshold
: Hide `input -> output` mappings whose input/output distance is below the selected percentage of RGB code values. At 0 %, it shows all mappings, which may crowd the graph beyond legibility.

target gamut
: Restrict the displayed samples to those inside the selected RGB gamut.

save to cLUT
: Export the currently displayed LUT to a reusable `.cube` file with metadata describing the LUT color space. This file will need to be applied in HLG Rec2020 colorspace.

### viewer mouse interaction

mouse wheel
: Zoom in and out, centered on the mouse cursor position.

left-button drag
: Pan the view.

middle-button drag horizontally
: Change the azimuth angle.

middle-button drag vertically
: Change the axis tilt angle.

double-click
: Reset zoom, pan and view orientation.

These interactions affect only the visualization. They do not modify the LUT itself.

## typical use

A common workflow is:

1. Use _color balance rgb_ first to establish the global color mood.
2. In _color equalizer_, choose one of the three brightness tabs.
3. Use the module color picker to locate the hue and brightness range you want to target.
4. Adjust _hue_, _saturation_ and _brightness_ graphs for that range.
5. Inspect the resulting RGB deformation in the LUT viewer.
6. Fine-tune the smoothing parameters in the _options_ tab if the remapping spreads too much or not enough.

The module is most effective for creative palette remapping, hue replacement, and selective saturation/brightness shaping of already-balanced images.

## limitations

### Changing greys

The module is not allowing to modify the achromatic axis, as to tint greys. This is on purpose because the LUT building steps uses a cylindrical 3D interpolation that guarantees its numerical stability. The grey (achromatic) axis is used as the spine on which we base the whole interpolation process. 

Tinting greys is otherwise known as _white balancing_. It can also be achieved in [_color balance RGB_](./color-balance-rgb.md) with regard to luminance. That should be achieved prior to using the _color equalizer_

### Compatibility with Darktable color equalizer

The Darktable "team" chose to steal from Ansel an [earlier prototype](https://github.com/aurelienpierreeng/ansel/pull/283) of _color equalizer_ that was brittle and judged unworthy of going into production by its author, Aurélien PIERRE. This prototype applies color shifts in dt UCS HSB space directly, and uses several guided filter instances to deal with edge artifacts and chroma noise. This is a broken attempt at fixing a broken design, because the issue is trying to do color shifts in another color space than RGB. Because of that, preserving image gradients is not possible and edge artifacts can't be avoided, and no amount of guided filters will make it ok.

Ansel _color equalizer_ is not compatible at all with the Darktable one, which should never have been pushed to production. But again, different projects, different quality standards.