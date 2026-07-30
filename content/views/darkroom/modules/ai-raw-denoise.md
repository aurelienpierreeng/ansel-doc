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
systematically understate the true sensor noise; the module corrects this
with factors calibrated against raw-mosaic measurements over 253 cameras —
the controls below are trims on top of that calibration.

global correction
: Scales the assumed noise amplitude for all channels (100 % trusts the
  calibration). Raise it if noise remains, lower it if fine detail is eaten.

red / green / blue correction
: Per-channel trims of the profile correction. The demosaicing loss the
  profiles suffered is channel-dependent (strongest on the dense green
  lattice), and varies somewhat between camera models.

## Model quality and cost

Quality is measured as **PSNR gain** (peak signal-to-noise ratio, in
decibels): PSNR is the log-scale ratio between the maximum signal and the
residual error against a known clean reference. Absolute PSNR mostly tracks
the ISO (noisier input, lower numbers everywhere) and says little about the
reconstruction itself, so the tables report the **gain over the noisy
input** — how far, from the noisy capture toward the clean target, the
denoiser actually took the image. **Higher is better**; +3 dB halves the
residual error energy. Measured on held-out cameras with physically
calibrated synthetic noise, ISO 3200–51200.

| PSNR gain (dB), all ISO | single-scale | multiscale |
| ----------------------- | ------------ | ---------- |
| large                   | +9.1         | +9.8       |
| half                    | +8.6         | *(in training)* |

The choice criterion becomes legible **above ISO 12000**, where
low-frequency chroma noise is what separates the variants — this is where
the multiscale models earn their cost (and the per-pixel averages still
understate it: on flat areas at ISO 51200, where single-scale models leave
colored blotches, the multiscale gain exceeds +25 dB, about 10 dB beyond
single-scale on the same charts):

| PSNR gain (dB), ISO > 12000 | single-scale | multiscale |
| --------------------------- | ------------ | ---------- |
| large                       | +10.3        | +11.3      |
| half                        | +9.7         | *(in training)* |

Relative processing cost on **CPU** (×1 = the half-size, single-scale
model — the CPU default):

| CPU runtime | single-scale | multiscale |
| ----------- | ------------ | ---------- |
| large       | ×4           | ×4.2       |
| half        | ×1           | ×1.2       |

Relative processing cost on **GPU** (×1 = half-size, single-scale; launch
overheads flatten the differences compared to CPU):

| GPU runtime | single-scale | multiscale |
| ----------- | ------------ | ---------- |
| large       | ×2.5         | ×2.7       |
| half        | ×1           | ×1.1       |

CPU-to-GPU comparisons are deliberately absent: the ratio depends entirely
on which CPU and which GPU. As a rough order of magnitude, a mid-range
discrete GPU runs the large model faster than a desktop CPU runs the half
model; on laptops without a discrete GPU, prefer the half size.
