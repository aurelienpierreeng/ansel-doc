---
title: Data privacy
date: 2026-06-21
weight: 70
draft: false
---

Ansel is a desktop application that runs entirely on your computer. It needs **no account**, and by
default it sends **nothing** anywhere. The only data that ever leaves your machine is the *optional*,
*anonymous* information described on this page — and only after you have explicitly agreed to it.

This page documents, from your point of view, exactly **what** can be collected, **how**, **where**
it goes, **who** processes it and **what for**. The exact source code that collects and sends each
piece of data is linked at the bottom for independent audit.

## The short version

- Everything here is **opt-in**. On first launch Ansel shows a single dialog with one checkbox per
  data flow, both of which you can leave unticked.
- Ansel **never** sends your images, your file names, your folder paths, your metadata, your location,
  your name, your email, your IP-based identity, or anything that could identify you or your photos.
- You can change your mind at any time in **Preferences ▸ Storage ▸ Privacy**.
- If you build Ansel yourself, both features can be compiled out entirely.

{{< note >}}
The information collected is *anonymous and aggregate*: it describes the software and the computer it
runs on, not you and not your work. There is no account and no way to link a report back to a person.
{{< /note >}}

## The consent dialog

The first time you run Ansel with its interface, you are shown one dialog titled **"Help us improve
Ansel"**. It contains:

- a checkbox to enable **crash reports**,
- a checkbox to enable **anonymous usage statistics**,
- a link to this very page,
- a button to confirm your choice.

Whatever you choose is remembered, and the dialog is never shown again. Nothing is sent for any flow
whose box you leave unticked. If Ansel is started without its graphical interface (command-line
processing), no dialog can be shown and nothing is collected until you have made a choice in the
interface.

## The two data flows

Crash reporting and usage analytics are **independent**. They have separate checkboxes, separate
on/off switches in the preferences, go to **different** service providers, and can be enabled one
without the other.

### 1. Crash reports

**What for** — so that when Ansel crashes, the developers automatically receive the technical details
needed to find and fix the bug, instead of relying on you to notice, locate and attach a crash log.

**When** — only if a crash actually happens. A crash report is stored locally at the moment of the
crash and uploaded the **next** time you start Ansel.

**What is sent**

- the *backtrace* — the list of internal program functions that were running when Ansel failed
  (including, on Linux, a detailed `gdb` backtrace attached as a text file);
- your operating system and version;
- your hardware: number of CPU cores, amount of RAM, graphics card / OpenCL device name;
- on Linux: whether you use X11 or Wayland, and your desktop environment (GNOME, KDE, …);
- your screen resolution, the Ansel window size, and display scaling (DPI/PPD);
- the Ansel version and build type;
- how long the session ran before crashing, and counts of recent crash-free sessions;
- *context about the moment of the crash*: which views, panels and editing modules were in use during
  that session (by name and count), and the **kind** of image being processed — its file
  **extension** (e.g. `cr3`, `jpg`), whether it is a raw/non-raw/HDR/monochrome file, whether it
  still needs demosaicing, and its pixel dimensions (no filename, no path).

**Who and where** — crash reports are processed by [**Sentry**](https://sentry.io), on their
**European Union** (Germany) infrastructure. Sentry's privacy policy:
<https://sentry.io/privacy/>.

**Turn it off** — untick *Preferences ▸ Storage ▸ Privacy ▸ Send anonymous crash reports*.

### 2. Anonymous usage statistics

**What for** — so the developers can see which features and platforms are actually used, and focus
their limited time where it helps the most. A small open-source project otherwise has almost no
visibility into how its software is used.

**When** — one summary at the start of each session and one at the end. The data describes the
session as a whole; it is not a live recording of your actions.

**What is sent**

- a *random installation identifier* — a meaningless random number generated on your computer, used
  only to avoid counting the same installation many times. It is **not** derived from your hardware,
  account or network, and cannot identify you;
- your operating system, number of CPU cores, amount of RAM, graphics card, and (on Linux) display
  server and desktop environment;
- your screen resolution and display scaling;
- the Ansel version and build type;
- how long the session lasted;
- which views, panels and editing modules you used, **as counts only** (e.g. "exposure module
  enabled 4 times") — never in what order or at what time;
- the **kinds** of files you worked on: file **extensions** and broad type flags (raw vs non-raw,
  needing demosaicing or not) with counts — never file names, paths, contents or metadata.

**Who and where** — usage statistics are processed by [**PostHog**](https://posthog.com) on their
**European Union** infrastructure (`eu.i.posthog.com`). PostHog's privacy policy:
<https://posthog.com/privacy>.

**Turn it off** — untick *Preferences ▸ Storage ▸ Privacy ▸ Share anonymous usage statistics*.

## What is never collected

To be unambiguous, Ansel **never** transmits any of the following, under any setting:

- your photographs or any image data, thumbnails or previews;
- file names, folder names or paths;
- image metadata (EXIF, IPTC, GPS/location, capture dates, camera serial numbers, …);
- your name, email address, or any account information (there is no account);
- your editing history or the parameter values of your edits;
- the contents of your catalog/database, tags, ratings or comments;
- keystrokes, mouse movement, or screen captures.

## Changing or revoking your choice

Open **Preferences ▸ Storage ▸ Privacy**. There you will find the two independent switches:

- **Send anonymous crash reports**
- **Share anonymous usage statistics**

Changes take effect immediately for usage statistics and from the next launch for crash reporting.
Turning a switch off stops all corresponding transmission.

## For developers and auditors

Both features are free software, like the rest of Ansel, and can be reviewed line by line. The
relevant source files in the
[Ansel repository](https://github.com/aurelienpierreeng/ansel) are:

| What | File |
|---|---|
| The consent dialog and on/off logic | [`src/common/privacy_consent.c`](https://github.com/aurelienpierreeng/ansel/blob/master/src/common/privacy_consent.c) |
| Crash reporting: setup, what context is attached, what is sent | [`src/common/sentry.c`](https://github.com/aurelienpierreeng/ansel/blob/master/src/common/sentry.c) |
| Usage statistics: setup, payload, network sending | [`src/common/telemetry.c`](https://github.com/aurelienpierreeng/ansel/blob/master/src/common/telemetry.c) |
| Where view usage is recorded | [`src/views/view.c`](https://github.com/aurelienpierreeng/ansel/blob/master/src/views/view.c) |
| Where panel usage is recorded | [`src/libs/lib.c`](https://github.com/aurelienpierreeng/ansel/blob/master/src/libs/lib.c) |
| Where editing-module usage is recorded | [`src/develop/imageop.c`](https://github.com/aurelienpierreeng/ansel/blob/master/src/develop/imageop.c) |
| Where the processed file type is recorded | [`src/develop/pixelpipe_hb.c`](https://github.com/aurelienpierreeng/ansel/blob/master/src/develop/pixelpipe_hb.c) |

If you distribute your own build of Ansel, you can disable these features entirely at compile time
with the CMake options `-DUSE_SENTRY=OFF` (crash reporting) and `-DUSE_TELEMETRY=OFF` (usage
statistics), in which case the corresponding code is not even included in the binary.
