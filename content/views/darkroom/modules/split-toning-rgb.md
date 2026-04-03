---
title: Split-toning RGB
date: 2026-04-03T00:00:00+02:00
id: split-toning-rgb
applicable-version: 4.0
working-color-space: RGB
view: darkroom
masking: true
include_toc: true
---

Blend two CAT16 plus RGB mixer corrections across brightness keyframes.

The _split-toning RGB_ module applies two independent color transforms:

- one keyed on the dark tones,
- one keyed on the bright tones.

Each keyframe combines:

- a chromatic adaptation defined by a correlated color temperature in _CAT16_,
- a 3×3 RGB channel mixer working in the pipeline working RGB space.

The two transforms are then interpolated according to the scene luminance of each pixel. This makes the module suitable both for creative split toning and for technical correction of mixed illuminants, for example cool bounce light in the shadows combined with a warmer direct illuminant in the highlights.

## Scene-referred placement

The module is designed to run in linear scene-referred RGB and is inserted before [_color primaries_](./color-primaries.md) in the pixelpipe.

The keying metric is the scene luminance \(Y\) derived from the current working RGB profile. This means the transition between the two keyframes is driven by brightness rather than by hue.

## General principles

The user interface contains two tabs:

- _dark_ (shown as _shadows_),
- _bright_ (shown as _highlights_).

Each tab defines one brightness keyframe in EV. By default:

- the dark keyframe sits at `-16 EV`,
- the bright keyframe sits at `0 EV`.

For each keyframe, the module first builds a full 3×3 transform:

1. a CAT16 chromatic adaptation derived from the selected temperature,
2. followed by the selected RGB mixer matrix.

The full transform is then blended over brightness as follows:

- below the dark keyframe, the dark transform fades linearly from identity up to full strength,
- between dark and bright, the module linearly interpolates from the dark transform to the bright transform,
- above the bright keyframe, the bright transform fades linearly back to identity.

The fade-out distance outside the `[dark ; bright]` segment is equal to the distance between the two keyframes.

This is important because the module does not blend colors after correction. It blends the full transform matrix itself, which generally gives more natural transitions than mixing already-corrected RGB values.

## Preview

At the top of the module, a preview strip shows a linear gray gradient processed through the current split-toning settings.

This preview is normalized around the current keyframes so you can read at a glance:

- where the dark transform starts to appear,
- where the interpolation happens,
- where the bright transform fades out.

The preview colors are projected through the current display profile, so they reflect the actual monitor rendering rather than raw working-space RGB.

## Module controls

Each tab contains three sections:

- a brightness keyframe,
- a CAT16 temperature,
- one of three RGB mixer GUI modes.

### Brightness

brightness
: Set the brightness keyframe in EV for the current tab.

: The slider includes an area picker. Sample any region in the image and the module will measure the average luminance of that area, convert it to scene \(Y\), then map it to EV to place the keyframe automatically.

: Use this to anchor the _dark_ keyframe on a representative shadow or the _bright_ keyframe on a representative highlight.

### Temperature

temperature
: Set the color temperature of the illuminant assumed for the current keyframe.

: Internally, this builds a CAT16 chromatic adaptation in the current working RGB space. Lower temperatures bias the correction toward warmer light assumptions, higher temperatures toward cooler ones.

: Because the temperature is only one part of the full transform, it can be used on its own for illuminant correction or combined with the channel mixer for more stylized color remapping.

### Mode

mode
: Choose how the RGB mixer matrix is exposed in the GUI.

: The following modes are available:

- _Complete_,
- _Simple_,
- _Primaries_.

These are only different parameterizations of the same backend 3×3 mixer. Switching mode does not select a different processing algorithm. It only changes how the matrix is edited.

#### Complete mode

_Complete_ is the unconstrained 3×3 mixer representation.

For each output row:

- _output red_,
- _output green_,
- _output blue_,

you can set the contribution of:

- _input R_,
- _input G_,
- _input B_.

Each row also provides a _normalize_ checkbox. When enabled, that row is normalized by the sum of its coefficients.

This is the most general representation and is always available.

#### Simple mode

_Simple_ is an exact geometric representation of a restricted subset of normalized mixer matrices. It exposes 6 parameters:

global hue rotation
: A rigid rotation of the normalized chroma plane.

chroma (u,v) axes orientation
: The orientation of the principal axes used to express the chroma transform.

u stretch and v stretch
: Signed gains along the two chroma axes. A value of `1` is neutral. `0` collapses the selected axis to achromatic.

achromatic coupling amount and achromatic coupling hue
: Couple a chroma direction into the achromatic axis while preserving the black-white axis.

This mode is exact only when all three output rows are normalized and have non-zero sums. If the current matrix does not satisfy those constraints, the GUI falls back to _Complete_.

#### Primaries mode

_Primaries_ is another exact GUI representation, this time expressed as a generalized primaries basis in working RGB. It exposes 9 parameters:

- _white hue_,
- _white purity_,
- _red hue_,
- _red purity_,
- _green hue_,
- _green purity_,
- _blue hue_,
- _blue purity_,
- _gain_.

This mode is exact only when the current 3×3 mixer can be interpreted as a non-degenerate affine basis change with non-zero affine sums. If not, the GUI falls back to _Complete_.

## Practical guidance

This module works best when the two keyframes reflect real exposure zones in the scene.

A practical workflow is often:

1. pick a representative shadow area on the _dark_ tab to set the dark brightness keyframe,
2. pick a representative highlight area on the _bright_ tab to set the bright keyframe,
3. use the temperature sliders first to correct mixed illuminants,
4. refine the look with the RGB mixer of each tab,
5. use the preview strip to check the transition region between both anchors.

For technical correction:

- use the dark keyframe to neutralize colored bounce light in the shadows,
- use the bright keyframe to compensate the direct illuminant in the highlights,
- keep the mixer close to identity and rely mostly on CAT16 temperature when you want the most physically grounded result.

For creative grading:

- place the two keyframes closer together to concentrate the transition in the midtones,
- push them farther apart to make the blend more gradual,
- use different mixer modes for exploration, but remember they all write the same backend matrix.

If the image starts to feel synthetic, simplify the transform first:

- reduce the mixer excursions,
- rely more on temperature,
- widen the distance between the two brightness anchors.

This module is strongest when used as a broad tonal and illuminant shaper, not as a local hue-isolation tool.
