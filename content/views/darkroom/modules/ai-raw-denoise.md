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
  measurement. How much that is worth depends on the size: it matters most
  for the **quarter** and **half** networks, which lack the capacity to
  handle low-frequency chroma alone, and very little at **large** size —
  see [model quality](#model-quality-and-cost) below.

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
: The per-channel correction factors (defaults 282 %, 394 %, 296 %). They
  are calibrated against raw-mosaic noise measurements over 253 cameras;
  the demosaicing loss the profiles suffered is channel-dependent
  (strongest on the dense green lattice) and varies somewhat between camera
  models, so per-image adjustment can pay off at very high ISO.

#### Cameras whose noise profile needs the correction removed

Ansel's noise profiles are **community-contributed** and were measured
over many years with varying rigour. For some camera families the values
are not consistent with the rest of the database, and the calibrated
defaults above — which assume a consistent profile — then over-state the
noise enough that the network produces a **large hue and saturation
shift** over the whole image.

Identified so far: **entry-level Canon DSLRs** and **Panasonic Micro Four
Thirds** bodies. The list is not exhaustive; the symptom is the reliable
signal.

**Very high ISO is a second, separate case, on any camera.** A profile
covers the ISO settings that were actually measured, and above the highest
one the last measurement is simply reused. Of the 433 profiled cameras,
the median stops at **ISO 25 000** and only a quarter reach 51 200 — so
past roughly ISO 64 000 most bodies are running on a value measured far
below, describing a sensor regime that no longer applies.

The error there can point either way, so read the symptom before reaching
for a slider: grain left behind means the assumed noise is too low (raise
*global correction*), while a tint means the balance *between* channels is
off (trim the offending channel). Unlike the camera families above, this is
a property of those frames, not of the body — correct the high-ISO images,
not the camera.

**The fix, for the camera families above:** set **red, green and blue
correction back to 100 %** — or lower if a cast remains. That removes the
calibration bump entirely and feeds the network the profile's own values.
Save it as a [preset](../../../preferences-settings/presets.md)
auto-applied to that camera model and you will not have to think about it
again.

This cannot be corrected centrally. Those profiles are legacy data shared
with [_denoise (profiled)_](./denoise-profiled.md) and the rest of the
noise-aware modules: rewriting them would silently change how existing
edits render everywhere else in Ansel, which is a worse outcome than a
slider you set once per camera.

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
| large                   | +10.6        | +10.5      |
| half                    | +9.9         | +9.8       |
| quarter                 | +8.2         | +8.4       |

| PSNR gain (dB), ISO > 12000 | single-scale | multiscale |
| --------------------------- | ------------ | ---------- |
| large                       | +12.2        | +12.1      |
| half                        | +11.5        | +11.5      |
| quarter                     | +9.5         | +9.7       |

**PSNR barely separates the two variants**, because it averages over the
whole image while their difference lives in *low-frequency chroma*: broad
coloured blotches that account for little error energy but are very
visible. A metric that isolates them — residual chroma after binning
16×16 — shows what the tables above cannot, and it depends strongly on the
model size:

| multiscale's chroma advantage | all ISO | ISO > 12000 |
| ----------------------------- | ------- | ----------- |
| large                         | 0.2 dB  | 0.3 dB      |
| half                          | 1.4 dB  | 1.6 dB      |
| quarter                       | 2.6 dB  | 2.9 dB      |

**The smaller the network, the more the coarse chroma pass is worth.** A
large network has enough capacity to handle low-frequency chroma on its
own, so multiscale buys it almost nothing; a quarter-size one does not, and
the coarse pass is what keeps it free of blotches. Practically: **at large
size prefer single-scale** — it is marginally ahead on PSNR and cheaper
(×3.5 against ×3.9 on CPU, ×3.8 against ×5.0 on GPU). **At half and
especially quarter size, prefer multiscale** whenever the image is noisy
enough to blotch: it costs 20–40 % more at half size and 50–75 % more at
quarter size, and it is what those sizes need to stay clean.

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
| denoise (profiled), **best per-image settings** | +8.8 | +11.9 |
| AI, quarter single-scale | +7.2 | +9.9 |
| AI, quarter multiscale | +7.9 | +10.5 |
| AI, half single-scale (the default) | +9.1 | +12.4 |
| AI, half multiscale | +9.3 | +12.9 |
| AI, large multiscale | +9.7 | +13.4 |
| AI, large single-scale | +9.8 | +13.7 |

**Read the second row with caution — it is not a setting you can dial in.**
Those numbers took an exhaustive parametric sweep: 21 combinations of
algorithm, colour mode and strength, re-rendered for every picture and
every ISO, scored against a clean reference that only exists because the
noise was synthetic. And the winner moved from picture to picture — strength
between 100 % and 200 %, and on one image wavelets in RGB beat non-local
means in Y0U0V0, which won everywhere else. There is no single "good"
configuration to recommend, and on a real photograph you have no clean
reference to score against: you are tuning by eye, on the same image whose
correct appearance you are trying to recover.

Its **default** settings — the realistic case — land 5 to 8 dB lower,
mostly because the shipped noise profiles understate the true sensor noise.

So the fair summary depends on the size you run. **Half and large beat the
best the classical module can be made to do** — by 0.3 to 1.0 dB at ISO
3200 and 0.5 to 1.8 dB at 12800 — and they do it with no tuning at all,
identically on every picture tested. **The quarter models do not**: a
perfectly tuned *denoise (profiled)* is 0.9 to 2.0 dB ahead of them. That
is the honest price of a network eight times smaller, and it is worth
knowing before choosing that size — though against the classical module's
*realistic* settings, quarter is still 4 to 6 dB ahead.

The classical module also remains useful when you want manual control over
the trade-off, or on images the models handle poorly.

Both measurements are reproducible from the
[training repository](https://github.com/aurelienpierreeng/ansel-denoise):
`scripts/compare_denoisers.py` writes the synthetic raws and drives Ansel
itself, `scripts/speckle_bench.py` produces the model tables above, and
`scripts/report_doc_tables.py` re-derives every number on this page from
the committed results.

### Processing cost

Every denoising option on one scale, ×1 being the **half-size,
single-scale** model — the default. Measured on a 24 Mpx raw with Ansel's
own per-module timer, keeping the fastest of three exports:

| relative cost                              | CPU   | GPU   |
| ------------------------------------------ | ----- | ----- |
| AI, large multiscale                       | ×3.9  | ×5.0  |
| AI, large single-scale                     | ×3.5  | ×3.8  |
| AI, half multiscale                        | ×1.2  | ×1.4  |
| **AI, half single-scale** (the default)    | **×1**| **×1**|
| AI, quarter multiscale                     | ×0.5  | ×0.5  |
| AI, quarter single-scale                   | ×0.34 | ×0.29 |
| *denoise (profiled)*, non-local means      | ×0.5  | ×0.9  |
| *denoise (profiled)*, wavelets             | ×0.13 | ×0.2  |

The classical module in **wavelet** mode is the cheapest thing here by a
wide margin: about eight times below the default, and still two to three
times below even the quarter-size networks. Its **non-local-means** mode —
the setting the quality sweep usually preferred — is a different matter. It
costs about half the default on CPU, roughly what quarter multiscale costs,
and on GPU it lands near the default itself: nearly twice quarter
multiscale and three times quarter single-scale. So on a GPU the classical
module's *good* mode is no longer the cheap choice; a quarter-size network
runs faster than it.

Two caveats on the GPU column. The differences there are *steeper* than on
CPU, not flatter: the models were tiled to fit a 4 GB card, and tiling
overlap costs proportionally more for the wider networks — on a card with
more memory the large models close some of that gap. And CPU-to-GPU
comparisons are deliberately absent, because that ratio depends entirely on
which CPU and which GPU. As a rough order of magnitude, a mid-range
discrete GPU runs the large model faster than a desktop CPU runs the half
model; on laptops without a discrete GPU, prefer the half or quarter size.
