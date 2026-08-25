---
title: Blend modes
date: 2022-12-04T02:19:02+01:00
lastmod: 2026-08-23
id: blend-modes
weight: 20
draft: false
latex: true
---

Blend modes define how the input and output of a module are combined (blended) together before the module's final output is passed to the next module in the pixelpipe.

Classic blending modes, designed for display-referred RGB (constrained to 0-100%), implicitly define a fulcrum at 50% (gray) or 100% (white) in their algorithms, depending on the blend mode. Because scene-referred is not subject to these restrictions, this fulcrum needs to be explicitly defined by the user when performing blending operations in the "RGB (scene)" color space. The additional _Blend fulcrum_ parameter will be presented to the user when using one of these blend modes in this color space. The effect depends on the operator used. For example, values above the fulcrum might be brightened and values below darkened, or vice versa.

The final output of a module is computed 'per-pixel' as follows:

```math
final_output = (1.0 - opacity) * module_input + opacity * blended_output
```

where the `blended_output` is a combination of the input and output images, depending on the blend mode (below), and the `opacity` is defined 'per-pixel' by a combination of the mask and global opacity parameter. An opacity of 0% outputs an image that is identical to the input image of the module.

The _Compositing_ combobox, right below the blend-mode selector, chooses which image is treated as the base layer. Its default, _Output over input_, matches the formula above. Switching it to _Input over output_ effectively reverses the roles of the input and output images in the 'per-pixel' computation:

```math
final_output = (1.0 - opacity) * module_output + opacity * blended_input
```

where the `blended_input` is a combination of the output and input images, depending on the blend mode below where _output_ and _input_ image references are reversed. With _Input over output_ compositing, an opacity of 0% outputs an image that is identical to the _output_ image of the module.

## Normal modes

Normal
: The most commonly used blend mode, "Normal" simply mixes input and output to an extent determined by the opacity parameter. This mode is commonly used to reduce the strength of a module's effect by reducing the opacity. This is also usually the blend mode of choice when applying a module's effect selectively with masks. This mode is also known as the "over" Porter-Duff alpha blending operator (see [alpha compositing](https://en.wikipedia.org/wiki/Alpha_compositing) for more details).

Normal bounded
: _not available in the "RGB (scene)" color space_
: This blend mode is the same as “Normal”, except that the input and output data are clamped to a particular min/max value range. Out-of-range values are effectively blocked and are not passed to subsequent modules. Sometimes this helps to prevent artifacts. However, in most cases (e.g. highly color-saturated extreme highlights) it is better to let unbound values travel through the pixelpipe to be properly handled later. The “Normal” blend mode is therefore usually preferred.

## Arithmetic modes

Addition
: Add together the pixel values of the input and output images, lightening the output. When blending in the "RGB (scene)" color space, the pixel values of the output image are multiplied by a value proportional to the "Blend fulcrum".

Subtract
: Subtract the pixel value of the _output_ from the _input_. When blending in the "RGB (scene)" color space, the pixel values of the output image are multiplied by a value proportional to the "Blend fulcrum". Pixel values less than 0 are set to 0.

Multiply
: Multiply the pixel values of the input and output together. When blending in display-referred color spaces, pixel values are between 0 and 1.0, the final output will be clamped and will always be darker. When blending in the "RGB (scene)" color space, this value is further multiplied by a value proportional to the "Blend fulcrum". In this case, values may be greater than 1.0 and therefore brighten the base image. This may have other side-effects, such as updating the white point in the filmic module.

: Multiply blending simulates an optical variable density filter, where the density is defined by the output of the module. It has many applications, from blooming and local contrast enhancements (when used with a blur or low-pass filter) to dodging/burning and global contrast enhancements (when used with exposure). The fulcrum sets the output intensity threshold between darkening and brightening (any RGB value below fulcrum will darken).

Divide
: Divide the pixel values of the input by the output. When blending in the "RGB (scene)" color space, the pixel values of the output image are multiplied by a value proportional to the "Blend fulcrum".

: Since this is the inverse of the Multiply mode, it will darken where Multiply brightens and vice versa. Everything else works in essentially the same way.

Screen
: _not available in the "RGB (scene)" color space_
: Invert the input and output pixel values, multiply those values together and invert the result. This yields approximately the opposite effect to "Multiply" mode -- the resulting image is usually brighter, and sometimes “washed out” in appearance.

Average
: Return the arithmetic mean of the input and output pixel values.

Difference
: Return the absolute difference between the input and output pixel values.

Geometric mean
: Return the square root of the product of the input and output pixel values.

Harmonic mean
: Return the product of the input and output pixel values, multiplied by 2 and divided by their sum.

## Contrast enhancing modes

The following modes are not available in the "RGB (scene)" blending color space as they rely on an assumption of "50% mid gray" which only applies to display-referred and non-linear color spaces.

Overlay
: This mode combines the "Multiply" and "Screen" blend modes: The parts of the input where the output is brighter, become brighter; The parts of the image where the output is darker, become darker; Mid-gray is unaffected.

Softlight
: This mode is similar to "Overlay", except the results are softer and less bright.

Hardlight
: This mode is not related to "Softlight" in anything but name. Like Overlay mode it is a combination of "Multiply" and "Screen" modes and has a different effect above and below mid-gray. The results with Hardlight blend mode tend to be quite intense and usually need to be combined with a reduced opacity.

Vividlight
: This mode is an extreme version of Overlay/Softlight. Values darker than mid-gray are darkened; Values brighter than mid-gray are brightened. You will probably need to tone down its effect by reducing the opacity

Linearlight
: This mode is similar to the effect of "Vividlight".

Pinlight
: This mode performs a darken and lighten blending simultaneously, removing mid-tones. It can result in artifacts such as patches and blotches.

## Color channel modes

### Lab channels

The following are available for blending in the Lab color space only

Lab lightness
: Mix the lightness from the input and output images, while taking the color channels (a and b) unaltered from the input image. In contrast to “Lightness” this blend mode does not involve any color space conversion and does not clamp any data. In some cases this blend mode is less prone to artifacts than “Lightness”.

Lab a-channel
: Mix the Lab "a" color channel from the input and output images, while taking the other channels unaltered from the input image.

Lab b-channel
: Mix the Lab "b" color channel from the input and output images, while taking the other channels unaltered from the input image.

Lab color
: Mix the Lab color channels (a and b) from the input and output images, while taking the lightness unaltered from the input image. In contrast to “Color” this blend mode does not involve any color space conversion and does not clamp any data. In some cases this blend mode is less prone to artifacts than “Color”.

### RGB channels

The following are available when blending in RGB color spaces only.

RGB red channel
: Mix the "red" channel from the input and output images, while taking the other channels unaltered from the input image. When blending in the "RGB (scene)" color space, the "red" channel from the output image is multiplied by a value proportional to the "Blend fulcrum".

RGB green channel
: Mix the "green" channel from the input and output images, while taking the other channels unaltered from the input image. When blending in the "RGB (scene)" color space, the "green" channel from the output image is multiplied by a value proportional to the "Blend fulcrum".

RGB blue channel
: Mix the "blue" channel from the input and output images, while taking the other channels unaltered from the input image. When blending in the "RGB (scene)" color space, the "blue" channel from the output image is multiplied by a value proportional to the "Blend fulcrum".

## HSV channels

The following are available when blending in the "RGB (display)" color space only.

HSV value
: Mix the lightness from the input and output images, while taking color unaltered from the input image. In contrast to “Lightness” this blend mode does not involve clamping.

HSV color
: Mix the color from the input and output images, while taking lightness unaltered from the input image. In contrast to “Color” this blend mode does not involve clamping.

## Others

Lightness
: Mix lightness from the input and output images, while taking color (chromaticity and hue) unaltered from the input image.

Chromaticity
: Mix chromaticity from the input and output images, while taking lightness and hue unaltered from the input image. This blend mode uses RGB ratios, divided by a Euclidean norm.

Lighten
: _not available in the "RGB (scene)" color space_
: Compare the pixel values of the input and output images, and output the lighter value.

Darken
: _not available in the "RGB (scene)" color space_
: Compare the pixel values of the input and output images, and output the darker value.

Hue
: _not available in the "RGB (scene)" color space_
: Mix hue (color tint) from the input and output images, while taking lightness and chroma unaltered from the input image.

Color
: _not available in the "RGB (scene)" color space_
: Mix color (chroma and hue) from the input and output images while taking lightness unaltered from the input image.

: _Caution: When modules drastically modify hue (e.g. when generating complementary colors) this blend mode can result in strong color noise._

Coloradjustment
: _not available in the "RGB (scene)" color space_
: Some modules act predominantly on the tonal values of an image but also perform some color saturation adjustments. This blend mode takes the lightness from the module's output and mixes colors from input and output, enabling control over the module's color adjustments.

{{< note >}}
The "RAW" blending color space (used by a small number of modules that act before demosaicing) offers the same blend-mode list as Lab and "RGB (display)".
{{< /note >}}

{{< warning >}}
Three entries appear suffixed "(deprecated)" in the blend-mode selector: _Difference (deprecated)_, _Subtract inverse (deprecated)_ and _Divide inverse (deprecated)_. They are kept so an edit created with an older version keeps rendering identically, and are only ever offered when that edit's history already uses one of them -- don't pick them for new edits. Their current equivalents: for _Difference (deprecated)_, use _Difference_ (a corrected version of the same math); for _Subtract inverse (deprecated)_ and _Divide inverse (deprecated)_, use _Subtract_ or _Divide_ with the _Compositing_ combobox set to _Input over output_, which reverses the roles of input and output the same way the old "inverse" variants did.
{{< /warning >}}
