---
title: AI raw denoise
date: 2026-07-30T00:00:00+01:00
id: ai-raw-denoise
draft: false
---

Removes sensor noise from the raw mosaic with a neural network, **before
white balance, chromatic-aberration correction and demosaicing** — so every
later stage of the pipeline inherits clean data, and demosaicing interpolates
real detail instead of weaving noise into maze and zipper artifacts.

Unlike general-purpose AI denoisers, these models are trained **specifically
on non-demosaiced RAW sensor data, for the exact point of the Ansel pipeline
where the module runs**, using Ansel's per-camera noise profiles to
synthesize physically accurate Poisson-Gaussian noise. One set of weights
covers every camera Ansel has a noise profile for, **Bayer and X-Trans
alike** — a newly profiled camera is supported without retraining. The
models weigh **between 7 and 36 MB** each and run **entirely locally**, on
CPU (OpenMP) or GPU (OpenCL); nothing ever leaves your machine.

The training corpus is a public collection of base-ISO raw tiles. **You can
contribute your own pictures to help train better models** — see
[contributing training data](https://ansel.photos/en/contribute/training-data/):
the whole workflow takes about ten minutes and requires no machine-learning
knowledge.

## Controls

strength
: Opacity of the noise removal: blends between the original image (0 %) and
  the fully denoised result (100 %). Lower it to keep some residual grain.

model version
: Pins the trained network a history entry uses, so edits keep rendering
  identically across application updates.

model size
: Network width. **large** is the reference quality, practical on GPU;
  **half** is roughly four times cheaper and is the default — enable-and-see
  should never freeze a computer; switch to large once you know the cost.
  **quarter** is four times cheaper again, for weak hardware or
  near-realtime editing.

model variant
: **single-scale** runs the full-resolution denoising pass only — fast, but
  no dedicated handling of low-frequency chroma noise. **multiscale** adds a
  coarse chroma pass on a downscaled image plus a low-band fusion that, on
  smooth areas, pins the largest scales to the sensor's own averaged
  measurement — the high quality option, recommended at high ISO where
  single-scale denoising can leave colored blotches.

### noise profile correction

The per-pixel noise amplitude fed to the network comes from the camera's
noise profile at the image ISO. The feedback line under the section header
shows which profile was matched (a generic profile is used for unprofiled
cameras). The shipped profiles were measured on demosaiced data and
systematically understate the true sensor noise; the correction is carried
entirely by the controls below — what the sliders show is exactly what
multiplies the profile's noise amplitude, nothing is applied behind the
scenes.

global correction
: Scales the assumed noise amplitude for all channels (100 % trusts the
  sliders as-is). Raise it if noise remains, lower it if fine detail is
  eaten.

red / green / blue correction
: The per-channel correction factors. The defaults are calibrated against
  raw-mosaic noise measurements over 253 cameras; the demosaicing loss the
  profiles suffered is channel-dependent (strongest on the dense green
  lattice) and varies somewhat between camera models, so per-image
  adjustment can pay off at very high ISO.

## Model quality and cost

Quality is measured as **PSNR gain** (peak signal-to-noise ratio, in
decibels): PSNR is the log-scale ratio between the maximum signal and the
residual error against a known clean reference. Absolute PSNR mostly tracks
the ISO (noisier input, lower numbers everywhere) and says little about the
reconstruction itself, so the tables report the **gain over the noisy
input** — how far, from the noisy capture toward the clean target, the
denoiser actually took the image. **Higher is better**; +3 dB halves the
residual error energy. Measured on held-out cameras with physically
calibrated synthetic noise, ISO 3200–51200 — cameras the models never saw
in training.

| PSNR gain (dB), all ISO | single-scale | multiscale |
| ----------------------- | ------------ | ---------- |
| large                   | +10.1        | +10.2      |
| half                    | +9.9         | +9.8       |
| quarter                 | *(in training)* | *(in training)* |

| PSNR gain (dB), ISO > 12000 | single-scale | multiscale |
| --------------------------- | ------------ | ---------- |
| large                       | +11.7        | +11.9      |
| half                        | +11.5        | +11.5      |
| quarter                     | *(in training)* | *(in training)* |

**PSNR barely separates the variants — deliberately so.** It averages over
the whole image, and the difference between single-scale and multiscale
lives in *low-frequency chroma*: broad colored blotches that cover few
pixels' worth of error but are highly visible. A metric that isolates them
(residual chroma after binning 16×16) puts multiscale ahead by 1.8 dB at
large size and 2.2 dB above ISO 12000, and on flat high-ISO charts — where
any chroma structure is error by construction — the gap widens further.
So: **pick multiscale when you see colored blotches, not because of the
table above**. At low ISO the two are interchangeable.

### Compared to *denoise (profiled)*

Ansel's classical [_denoise (profiled)_](./denoise-profiled.md) module solves
the same problem with hand-designed filters (non-local means or wavelets),
after demosaicing. The two were measured **through the same pipeline**: a
real base-ISO photograph is the reference, physically calibrated noise for
a target ISO is injected into its raw mosaic, and the result is rendered
with one module or the other — so the numbers include everything the two
approaches do differently, not just the denoising step.

The classical module was given every advantage: its algorithm, colour mode
and strength were **swept per picture and per ISO, and only its best run
counted** — a setting you can only find if you already have the clean
image. The AI models ran at their shipped defaults.

| PSNR gain (dB) | ISO 3200 | ISO 12800 |
| -------------- | -------- | --------- |
| denoise (profiled), default settings | +3.4 | +3.5 |
| denoise (profiled), **best per-image settings** | +8.8 | +12.0 |
| AI, half single-scale (the default) | +9.2 | +12.5 |
| AI, large multiscale | +9.5 | +13.2 |

Two things to take from this. **Tuned to its optimum, the classical module
is competitive** — within roughly 1 dB of the neural models, and the gap is
smaller at low ISO than at high. But **its defaults leave 5 to 8 dB on the
table**, because the shipped noise profiles understate the true sensor
noise, and no single strength value is right for every camera: the optimum
found here ranged from 100 % to 200 %, and even the best *algorithm*
changed between images. The AI models need none of that: they reach a
slightly better result at their defaults, on every picture tested.

The measurement is reproducible — `scripts/compare_denoisers.py` in the
[training repository](https://github.com/aurelienpierreeng/ansel-denoise)
writes the synthetic raws and drives Ansel itself.

Relative processing cost on **CPU** (×1 = the half-size, single-scale
model — the CPU default):

| CPU runtime | single-scale | multiscale |
| ----------- | ------------ | ---------- |
| large       | ×4           | ×4.2       |
| half        | ×1           | ×1.2       |
| quarter     | *(in training)* | *(in training)* |

Relative processing cost on **GPU** (×1 = half-size, single-scale; launch
overheads flatten the differences compared to CPU):

| GPU runtime | single-scale | multiscale |
| ----------- | ------------ | ---------- |
| large       | ×2.5         | ×2.7       |
| half        | ×1           | ×1.1       |
| quarter     | *(in training)* | *(in training)* |

CPU-to-GPU comparisons are deliberately absent: the ratio depends entirely
on which CPU and which GPU. As a rough order of magnitude, a mid-range
discrete GPU runs the large model faster than a desktop CPU runs the half
model; on laptops without a discrete GPU, prefer the half size.
