---
title: Mask contours
date: 2022-12-04T02:19:02+01:00
lastmod: 2026-08-23
id: mask-refinement
weight: 50
draft: false
---

When a parametric or drawn mask is active, several additional sliders are shown which allow the mask to be further refined.

Details threshold (_hidden by default_)
: This control allows you to alter the opacity of the mask based on the amount of detail in the image. Use this slider to select either areas with lots of detail (positive values) or areas that are flat and lacking in detail (negative values). The default (zero) effectively bypasses details refinement. This is mostly useful to apply sharpening and blurring effects that ignore out-of-focus (bokeh) regions or to sharpen only blurry parts, preventing over-sharpening of in-focus regions.
{{< note >}}
This slider is hidden in new edits and only reappears if an image's history already has a non-zero value for it (e.g. imported from an older edit). It is authored from the RGBA buffer right after demosaicing, so it works identically on RAW and non-RAW (JPEG, TIFF, etc.) images alike.
{{< /note >}}

Blurring radius
: Blurring the mask creates a softer transition between blended and unblended parts of an image and can be used to avoid artifacts. The blurring radius slider controls the radius of a gaussian blur applied to the final blend mask. The higher the radius, the stronger the blur (set to 0 for an unblurred mask). Mask blur is always applied after feathering if both kinds of mask adjustment are activated. This allows any resulting sharp edges or artifacts to be smoothed.

Feathering guide
: Mask feathering smooths a drawn or parametric mask such that the mask's edges automatically align with the edges of features in the image. The smoothing is guided either by the module's input or output (before blending), and may happen before or after the mask blurring, depending on what is selected in the “Feathering guide” combobox. Feathering is particularly sensitive to the choice of guide image when used with edge-modifying modules (modules for sharpening or blurring an image).
: - _Output before blur_: feathering is guided using the _output_ image of the module and takes place _before_ the mask is blurred
: - _Input before blur_: feathering is guided using the _input_ image of the module and takes place _before_ the mask is blurred
: - _Output after blur_: feathering is guided using the _output_ image of the module and takes place _after_ the mask has been blurred
: - _Input after blur_: feathering is guided using the _input_ image of the module and takes place _after_ the mask has been blurred

Feathering radius
: Adjust the strength of the feathering effect. Feathering works best if the mask's edges already approximately match some edges in the guiding image. The larger the “Feathering radius” the better the feathering algorithm can align the mask to more distant edges. If this radius is too large, however, the feathered mask may overshoot (cover regions that the user wants to exclude). Feathering is disabled when the feathering radius is set to 0.


Feathering mask opacity
: The strength of the module's effect is determined by the mask's local opacity. Feathering and blurring the mask may reduce the opacity of the original mask. The “Feathering mask opacity” slider allows you to readjust the mask opacity to compensate. If the mask opacity is decreased (negative slider values) less opaque parts are affected more strongly. Conversely, if the mask opacity is increased (positive slider values) more opaque parts are affected more strongly. As a consequence, completely opaque portions of the mask always remain opaque and completely transparent portions always remain transparent. This is to ensure that regions that have been fully excluded from or included in a module's effect (by setting the mask's opacity to 0% or 100%) remain fully excluded or included.

Feathering mask contrast
: This slider increases or decreases the mask contrast. This allows you to adjust the transition between the opaque and transparent parts of the mask.

Display mask (mask icon)
: Click this icon to preview the current mask in the center view: the image shows through where the module is applied, and a checkerboard covers what the mask leaves out. Click it again to turn the preview off. See [previewing the mask](../_index.md#previewing-the-mask) for how to read it and where its colors are set.

: <kbd>Ctrl</kbd>+click (<kbd>⌘</kbd>+click on macOS) always shows the mask specifically; <kbd>Shift</kbd>+click shows the color channel currently selected by hovering a [parametric mask](./parametric.md) slider instead; holding both together shows both at once. The same icon also appears next to the module's name in its header, so you can check its mask without opening the masking tabs.

## Example: feathering a drawn mask

{{< figure src="feathering.jpg" caption="feathering a rough drawn mask onto a subject, step by step" />}}

It can be rather tedious to create a drawn mask that precisely covers a particular feature in an image — say, to enhance the color contrast of a foreground subject without affecting the background. Feathering does most of the work:

1. Start from a rough, fuzzy drawn shape that only approximately follows the subject's outline.
2. Raise the **Feathering radius** (e.g. to 50) so the mask snaps to the nearest strong edges, and add a small **Blurring radius** (e.g. 5) to smooth it.
3. Adjust the **Feathering mask opacity** and **Feathering mask contrast** (e.g. to 0.3 and 0.5) to tighten the transition.

The effect then stays restricted to the subject. Feathering works best when the subject is well separated from an out-of-focus background, because the distinct edge at its border guides the mask to match its shape.
