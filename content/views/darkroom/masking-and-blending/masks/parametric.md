---
title: Parametric masks
date: 2022-12-04T02:19:02+01:00
lastmod: 2026-08-23
id: parametric
weight: 30
draft: false
---

The parametric mask feature offers fine-grained selective control over how individual pixels are masked. It does this by automatically generating an intermediate blend mask from user-defined parameters. These parameters are color coordinates rather than the geometrical coordinates used in drawn masks.

For each data channel of a module (e.g. Lab, RGB) and several virtual data channels (e.g. hue, saturation) you  can construct a per-channel opacity function. Depending on each pixel's value for a given data channel this function calculates a blending factor between 0 and 1 (100%) for that pixel.

Each pixel of an image thus has different blending factors for each of its data channels. All blending factors are finally multiplied together (pixel-by-pixel), along with the value of the global _Opacity_ slider, to form a complete parametric blend mask for the image.

If the blend mask has a value of 0 for a given pixel, the input of the module is left unchanged. If the blend mask has a value of 1 (100%) for a pixel, the module has its full effect.

## Channel tabs

Click on one of the channel tabs to select a data channel to use to build your mask.

Modules acting in (_display-referred_) _Lab_ color space have data channels for L, a, b, C (chroma of LCh) and h (hue of LCh).

Modules acting in _display-referred RGB_ color space have data channels for g (gray), R, G, B, H (hue of HSL), S (saturation of HSL), and L (lightness of HSL).

Modules acting in _scene-referred RGB_ color space have data channels for g (gray), R, G, B, Jz (luminance component of JzCzhz), Cz (chroma, or saturation, of JzCzhz), and hz (hue of JzCzhz). The g (gray) value is calculated as a weighted average of the R, G & B channels, the exact weightings depending on the working color space being used. The JzCzhz color space is a polar representation of the Jzazbz color space, in the same way that LCh is a polar representation of the Lab space. Like the L in Lab color space, the Jz is a representation of the luminosity of a pixel that aligns with how we perceive brightness. However, the Jzazbz color space is much better for high dynamic range images and is less susceptible to hue shifts than Lab space.

_See [Wikipedia](https://en.wikipedia.org/wiki/Color_space) for more details about these color spaces._

Two sliders can be shown for each associated data channel: one that works on the _input data_ that the module receives and one that works on the _output data_ that the module produces prior to blending. The sliders for the output data channels are hidden by default and can be shown using the _Show output channels_ option in the blending menu.

Each channel slider's trapezoid markers are laid out over a fixed display range. In scene-referred processing, pixel values routinely go well past that range -- a bright highlight or specular reflection can sit at several times "100%" -- so without any correction, all of those over-range pixels would pile up at the very end of the slider with no room to tell them apart.

The _Boost factor_ slider solves this by rescaling the slider's range before it's displayed, expressed in EV (stops): raising it by 1 EV halves the values shown on the slider, effectively pulling those highlights back within reach so you can place the markers precisely between them. It solves a scale problem, not a color problem -- the underlying pixel data and the resulting mask are unaffected, only how much of the value range you can address with the markers. This slider is always shown but is only enabled (clickable) for channels where it is meaningful -- it stays grayed out on hue-type channels, for instance, where boosting has no effect.

You rarely need to set it by hand: using the right-hand [color picker](#color-pickers) to set a slider's range from an area of the image automatically fits the Boost factor to that area too, nudging it until the picked area's brightest value just fits on the visible slider. If you then adjust the Boost factor slider yourself, that manual value is kept until you pick a new area.

### Inspecting data channels & masks

Each slider has its own eye icon that toggles a persistent display of that channel's input/output image data as the center image, either in gray-scale values or in false colors depending on the setting in [preferences > darkroom > Display of individual color channels](../../../../preferences-settings/darkroom.md).

For a quicker look you don't need to click for, hold <kbd>Shift</kbd> while hovering over a slider to show its channel data, hold <kbd>Ctrl</kbd> (<kbd>⌘</kbd> on macOS) to show the resulting mask overlaid on the image instead, or hold both together to show both at once. Release the key(s) and the image returns to normal.

You can also click the mask icon next to a slider to toggle a persistent overlay of the resulting mask for that slider (click again to turn it off).

### Linear / log mode

Each slider has its own "Log scale" / "Linear scale" button beneath it. Click it to switch that slider's display to logarithmic mode; click again to switch back to linear. This only changes how values are laid out along the slider for mouse precision -- it has no effect on the image or the mask itself. On a linear slider, dragging across the shadow end of the range covers a tiny fraction of the travel, making fine values there hard to reach precisely with the mouse; log mode spreads that same range out, giving you access to tonalities that are otherwise impractical to select accurately.

## Channel input/output sliders

With each color channel slider you can construct a trapezoidal opacity function. For this purpose there are four markers per slider. Two filled triangles above the slider mark the range of values where opacity is 1. Two open triangles below the slider mark the range values where opacity is 0. Intermediate points between full and zero are given a proportional opacity.

The filled triangles, or inside markers, indicate the closed (mostly narrower) edge of the trapezoidal function. The open triangles, or outside markers, indicate the open (mostly wider) edge of the trapezoidal function. The sequence of the markers always remains unchanged: they can touch one another but they cannot switch position.

A polarity (+/-) button to the right of each the slider switches between "Range select" and "Range de-select" modes, with visual confirmation provided by exchanging the upper and lower triangle markers. These two types of trapezoidal functions are represented graphically in the following images.

**Range select**
: With the inside (filled) markers at the extremes, the whole range of values is selected (an "all at 100%" mask). Moving the markers inwards gradually excludes more of the image, keeping only the remaining narrow range. The outside (open) markers set how soft the transition is at each edge.

: {{< figure src="blendif_2a.jpg" caption="range select slider" />}}
: {{< figure src="blendif_2b.jpg" caption="range select opacity function" />}}

**Range deselect**
: Toggling the polarity swaps the markers: by default the whole range is deselected (an "all-zero" mask), and moving the markers inwards gradually includes more of the image around the remaining range.

: {{< figure src="blendif_3a.jpg" caption="range deselect slider" />}}
: {{< figure src="blendif_3b.jpg" caption="range deselect opacity function" />}}

## Color pickers

Two separate picker buttons are available above the sliders.

The left-hand button is a plain probe: click a point or drag over an area of your image. The corresponding values for the real and virtual data channels are then displayed as markers within each color channel slider, without changing the mask itself.

The right-hand button both picks and applies: click it, then click and drag a rectangle on the image to set the input slider's range directly from that area; <kbd>Ctrl</kbd>+click and drag (<kbd>⌘</kbd>+click and drag on macOS) to set the output slider's range instead (only relevant when output channels are shown).

## Invert

Click the invert button above the sliders to invert the polarity of the entire parametric mask. This differs from the polarity buttons beside the individual sliders which just invert the parameters for the current slider/channel.

## Reset

Click the reset button above the sliders to revert all parametric mask parameters to their default state.
