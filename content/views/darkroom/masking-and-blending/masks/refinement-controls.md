---
title: Mask contours
date: 2022-12-04T02:19:02+01:00
lastmod: 2026-06-17
id: mask-refinement
weight: 50
draft: false
---

When a parametric or drawn mask is active, several additional sliders are shown which allow the mask to be further refined.

details threshold (_deprecated_)
: This control allows you to alter the opacity of the mask based on the amount of detail in the image. Use this slider to select either areas with lots of detail (positive values) or areas that are flat and lacking in detail (negative values). The default (zero) effectively bypasses details refinement. This is mostly useful to apply sharpening and blurring effects that ignore out-of-focus (bokeh) regions or to sharpen only blurry parts, preventing over-sharpening of in-focus regions.
{{< note >}}
In Darktable, the details mask is available only for RAW images. Ansel generalizes it to any kind of image.
{{< /note >}}

blurring radius
: Blurring the mask creates a softer transition between blended and unblended parts of an image and can be used to avoid artifacts. The blurring radius slider controls the radius of a gaussian blur applied to the final blend mask. The higher the radius, the stronger the blur (set to 0 for an unblurred mask). Mask blur is always applied after feathering if both kinds of mask adjustment are activated. This allows any resulting sharp edges or artifacts to be smoothed.

feathering guide
: Mask feathering smooths a drawn or parametric mask such that the mask's edges automatically align with the edges of features in the image. The smoothing is guided either by the module's input or output (before blending), and may happen before or after the mask blurring, depending on what is selected in the “feathering guide” combobox. Feathering is particularly sensitive to the choice of guide image when used with edge-modifying modules (modules for sharpening or blurring an image).
: - _output before blur_: feathering is guided using the _output_ image of the module and takes place _before_ the mask is blurred
: - _input before blur_: feathering is guided using the _input_ image of the module and takes place _before_ the mask is blurred
: - _output after blur_: feathering is guided using the _output_ image of the module and takes place _after_ the mask has been blurred
: - _input after blur_: feathering is guided using the _input_ image of the module and takes place _after_ the mask has been blurred

feathering radius
: Adjust the strength of the feathering effect. Feathering works best if the mask's edges already approximately match some edges in the guiding image. The larger the “feathering radius” the better the feathering algorithm can align the mask to more distant edges. If this radius is too large, however, the feathered mask may overshoot (cover regions that the user wants to exclude). Feathering is disabled when the feathering radius is set to 0.


feathering mask opacity
: The strength of the module's effect is determined by the mask's local opacity. Feathering and blurring the mask may reduce the opacity of the original mask. The “feathering mask opacity” slider allows you to readjust the mask opacity to compensate. If the mask opacity is decreased (negative slider values) less opaque parts are affected more strongly. Conversely, if the mask opacity is increased (positive slider values) more opaque parts are affected more strongly. As a consequence, completely opaque portions of the mask always remain opaque and completely transparent portions always remain transparent. This is to ensure that regions that have been fully excluded from or included in a module's effect (by setting the mask's opacity to 0% or 100%) remain fully excluded or included.

feathering mask contrast
: This slider increases or decreases the mask contrast. This allows you to adjust the transition between the opaque and transparent parts of the mask.

temporarily switch off mask (eye icon)
: Sometimes it is useful to visualize a module's effect without the mask being active. Click this icon to temporarily deactivate the mask (the selected blend mode and global opacity remain in effect).

display mask (mask icon)
: Click this icon to display the current mask as a yellow overlay over a black-and-white version of the image. Solid yellow indicates an opacity of 100%; a fully visible gray background image (without yellow overlay) indicates an opacity of 0%.

## Example: feathering a drawn mask

It can be rather tedious to create a drawn mask that precisely covers a particular feature in an image — say, to enhance the color contrast of a foreground subject without affecting the background. Feathering does most of the work:

1. Start from a rough, fuzzy drawn shape that only approximately follows the subject's outline.
2. Raise the **feathering radius** (e.g. to 50) so the mask snaps to the nearest strong edges, and add a small **blurring radius** (e.g. 5) to smooth it.
3. Adjust the **feathering mask opacity** and **feathering mask contrast** (e.g. to 0.3 and 0.5) to tighten the transition.

The effect then stays restricted to the subject. Feathering works best when the subject is well separated from an out-of-focus background, because the distinct edge at its border guides the mask to match its shape.
