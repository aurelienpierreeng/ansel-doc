---
title: Ansel-nn-parity
date: 2026-08-18T01:00:00+02:00
id: Ansel-nn-parity
weight: 55
draft: false
author: "people"
---

The `Ansel-nn-parity` binary checks that the neural network behind the [AI raw
denoise](../views/darkroom/modules/ai-raw-denoise.md) module computes the same
thing on your CPU and on your graphics card as it did on the machine that trained it.

You should not normally need it. It exists for one specific situation: **the denoised image
looks wrong — a grid, a mesh, a colour cast — and you suspect the graphics card**. This tool
answers that question with a number instead of an opinion, and tells you which of the three
implementations disagrees with the other two.

## Running it

```
Ansel-nn-parity <model.anselnn> <fixture-directory> [size] [--core <Ansel options>]
```

The model is one of the `.anselnn` files shipped with Ansel (typically in
`/usr/share/ansel/` or `share/ansel/` inside your installation). The fixture directory holds a
reference input and the output the training framework produced from it; fixtures live in the
[ansel-denoise](https://github.com/aurelienpierreeng/ansel-denoise) repository under
`fixtures/models/`, one per model, and must match the model you point at — the tool refuses to
run otherwise, because comparing one model against another model's reference produces a large
error that looks exactly like a real defect.

Anything after `--core` is passed to Ansel itself, which is how you select a device:

```
Ansel-nn-parity share/ansel/denoise-large-single-v1.anselnn fixtures/models/large-single 96 \
    --core --conf opencl_devid_export="+1"
```

## Reading the output

```
model denoise-large-single-v1.anselnn: in=5 out=1, fixture 96x96
  torch vs CPU     : max abs err 1.79e-07 (at 440: 0.535022 vs 0.535022)
  using OpenCL device 0
  torch vs OpenCL  : max abs err 1.79e-07 (at 440: 0.535022 vs 0.535022)
  CPU   vs OpenCL  : max abs err 1.19e-07
  PASS (tolerance 2e-04)
```

Healthy numbers sit around `1e-07`, the precision limit of single-precision arithmetic. The
tolerance is `2e-04`, so a passing result has roughly a thousandfold margin.

What a failure tells you depends on **which line** fails:

- **`torch vs OpenCL` fails while `torch vs CPU` passes** — your graphics driver is the
  problem, not Ansel and not the model. The usual cause is an inaccurate math library in the
  driver; see [possible problems & solutions](../preferences-settings/performance/opencl/problems-solutions.md).
- **Both fail by the same amount** — the fixture does not belong to that model. Check that you
  paired them correctly.
- **`torch vs CPU` fails alone** — that would be a genuine bug in Ansel. Please report it.

If no OpenCL device is available the GPU comparison is skipped and only the CPU is checked.

## What it does not cover

The reference input is synthetic, so the tool validates the network and the OpenCL kernels — not
the whole module. A correct result here means the arithmetic is sound; it does not prove that
every rendering path around it is. It is a hardware and driver check, not a substitute for
looking at your pictures.
