---
title: Masks
date: 2022-12-04T02:19:02+01:00
lastmod: 2026-08-23
id: masks
weight: 30
draft: false
author: "people"
---

Masks limit a module's effect to certain parts of the image, so that a correction lands where you want it and leaves the rest of the picture untouched.

A mask is best pictured as a grayscale image laid over the picture: each pixel holds a value between 0 and 1.0 (0% to 100%), and that value is the _opacity_ handed to [blending](../_index.md). An opacity of 0 leaves a pixel exactly as the module received it, 1.0 gives it the module's full effect, and values in between apply it proportionally.

{{< note >}}
A mask decides _where_ a module applies, and how strongly. _How_ its input and output are mixed at that strength is the job of the [blend mode](../blend-modes.md).
{{< /note >}}

## Ways to build a mask

Three methods can set that per-pixel opacity. Each works on its own, or [combined](../_index.md#combining-masks) with the others:

- [Drawn masks](./drawn.md) — select areas by location, with shapes drawn directly on the image.
- [Parametric masks](./parametric.md) — select pixels by their own color and tonal values.
- [Raster masks](./raster.md) — reuse a mask that another module already computed earlier in the pixelpipe.

## Combining and refining masks

- [Combining drawn & parametric masks](./drawn-and-parametric.md) — how polarity and the _Combine masks_ setting merge a drawn mask with a parametric one.
- [Mask contours](./refinement-controls.md) — blur and feather a finished mask so that its edges follow the details of the image.
