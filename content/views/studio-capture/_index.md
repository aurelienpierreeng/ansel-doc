---
title: Studio Capture
date: 2026-07-06T03:15:02+01:00
lastmod: 2026-07-06
id: studio-capture
draft: false
weight: 20
author: "people"
---

Studio Capture is a dedicated view for tethered shooting sessions. Instead of
switching back to Lighttable every time a new photo lands on disk, this view
watches a folder, imports new captures automatically, optionally applies a
set of styles to them, and always shows you the latest shot full-size — with
the filmstrip below to review the rest of the session.

{{ warning }}
Studio Capture doesn't support yet control and loading images directly from a camera. You need to use a third party program such as Digikam or Entangle to take and download images  in a local folder.
{{ /warning }}

It sits alongside Lighttable, Darkroom, Map and Print in the global menu "Ateliers".

## Quick start

1. Open **Studio Capture** in the global menu "Ateliers".
2. In **Auto import**, choose the folder your camera or tethering software writes images into.

{{ warning }}
Do not choose the on-camera folder as you either will not be able to take pictures or Ansel will not be able to refresh the folder correctly.
{{ /warning }}

3. Optionally, build a list of styles in **Auto style** to auto-apply to every incoming shot (e.g. a base look, a black & white conversion...).
4. Press **Start the session**.
5. Shoot. Each new image appears automatically in the center, with any configured styles already applied, and gets added to the filmstrip.

You can leave Studio Capture and come back — monitoring keeps running in the background as long as Ansel is open, and Ansel offers to resume it if it was still running when you last closed the application.

## Auto import

This panel controls what folder is being watched and what happens to each image that shows up in it.

### Session controls

At the top of the panel:

- **Project date** — free-text date used by the `$(YEAR)`, `$(MONTH)`, `$(DAY)` naming variables (see below). Must be typed as `YYYY-MM-DD`, optionally followed by `HH:MM:SS.mmm` — you can type just the leading part you care about (e.g. `2026` or `2026-07`) and the rest is filled in for you (`2026` becomes January 1st, 2026 at midnight). Leave empty to use the current date at scan time.
- **Jobcode** — a free-text label available as the `$(JOBCODE)` naming variable, handy for tagging a session by client or shoot name.
- **Scan frequency** — how often (in seconds) the folder is checked for new images. Changes apply the next time you start a session, not to one already running.
- **Status line** — shows whether a session is running, whether it's ready to start, or (in orange) what's missing before it can start.

### Source tab

- **Folder to survey** — the folder that receives your camera's images.
- **Delete original file** — only relevant when copying to another location (see Destination below): removes the source file once the copy has been verified byte-for-byte.

{{ warning }}
Do not choose the on-camera folder as you either will not be able to take pictures or Ansel will not be able to refresh the folder correctly.
{{ /warning }}

{{< note >}}
- Deleting image on-camera is not possible as it could corrupt the memory card.
- The source folder and scan frequency are locked while a session is running, since the engine compares each scan against a baseline recorded when monitoring started.
- The source folder cannot contain the destination folder.
{{< /note >}}

### Destination tab

- **File handling** — *Add to library* imports images where they already are; *Copy to disk* additionally copies each file to an organized location before importing it. Choosing *Copy to disk* reveals the rest of this tab:
  - **On conflict** — what to do if the computed destination file already exists:
    - *Skip*: keep the existing destination file and import that instead of copying over it.
    - *Overwrite*: replace it with the incoming source.
    - *Create unique filename* (default): copy the source under a numbered suffix instead of colliding. This is the safest default for tethering, since naming patterns often don't vary from shot to shot.
  - **Base directory**, **Project directory pattern**, **File naming pattern** — where copies land and how they're named. Both patterns accept `$(...)` variables — start typing `$(` in either field to see the list via auto-completion (things like `$(YEAR)`, `$(JOBCODE)`, `$(FILE_NAME)`...).
  - A live preview below shows the destination path your current settings would produce, so you can check it before starting.

{{< note >}}
- The destination folder cannot be contained in the source folder.
{{< /note >}}

### Starting and stopping

Press **Start the session** once your configuration is valid — the button stays greyed out otherwise, with the status line explaining what's missing (an unreadable source folder, an invalid project date, a base directory that doesn't exist or sits inside the surveyed folder, an empty naming pattern...).

Every time you press **Start**, Ansel checks whether the surveyed folder already holds images — a folder never surveyed before, new files that appeared while Ansel was closed, or files added since the last time you stopped this session — and if so asks whether to import them right away instead of silently absorbing them into the baseline. Declining just records them as already-known, so a later scan won't pick them up either.

A new file is only imported once its size and modification time stop changing for one full scan interval — this avoids importing a file while your camera or tethering software is still writing it.

## Auto style

This panel manages an ordered list of styles ("the pool") that gets applied, in order, to every image Studio Capture imports.

### Pool and Styles

- **Pool** — the styles that are actually applied on import, in the order they're applied. Each row has:
  - `↑` / `↓` to move it earlier/later in the order.
  - `-` to remove it from the pool.
- **Styles** — every style available in your library. Click the **+** icon next to a style to add it to the pool. A style already in the pool is greyed out here so you can see at a glance what's already queued.

Styles in the pool all apply in `append` pasting mode on top of each other, in list order, the same way applying several styles manually would. Reorder or remove entries at any time — it takes effect on the next imported image; already-imported photos are not retroactively changed and you would have to apply them manually by clicking the button.

### Applying styles manually

The **Apply to the displayed image** button re-applies the whole pool, in order, to whichever capture is currently shown in the center, on top of its current history (with the `append` pasting mode) — useful if you change your style pool mid-session and want to bring an earlier shot in line with the rest, without leaving Studio Capture.

## Viewing captures

The center always shows one capture, full-size, with any styles already baked in. Use the filmstrip at the bottom to look back through the session.

- **Zoom**: <kbd>double-click</kbd>, <kbd>middle-click</kbd>, or <kbd>scroll</kbd> the image to toggle between fit-to-window and 100%.
- **Pan** at 100%: <kbd>drag</kbd>, or use the <kbd>arrow keys</kbd>.
- **Filmstrip**: <kbd>double-click</kbd> a thumbnail to preview that capture in the
  center.
- **Open in Darkroom**: press <kbd>Return</kbd> at any time to open the currently displayed capture for full editing.

### Color picker

The Scopes module's color picker (point or box sample) works directly on the image shown here, the same way it does in Darkroom.

## Display toolbox

The bottom-left toolbox buttons — shared with Darkroom — affect how the
image is *displayed*:

- **Raw overexposed** / **Overexposed (clipping)** — highlight clipped highlights, with the same options (threshold, mode, colors) as in
  Darkroom.
- **Soft proof** / **Gamut check** — preview how the image will look under a target output profile, or flag out-of-gamut colors.
- **ISO 12646** — frame the image on a neutral grey background with a white margin, for more accurate visual judgment of exposure/color.
- **Picture display** — background brightness and picture margins for the center view.
- **Guides** — overlay a grid (rule of thirds, etc.) on top of the displayed image; right-click the button for guide options.

{{< note >}}
These only affect the picture while it's shown at fit-to-window zoom; they have no effect at 100%.
{{< /note >}}

## Session resume

If Ansel is closed while a session is still monitoring, it offers to resume that session the next time it starts — accepting switches straight to Studio Capture and restarts monitoring on the same folder. Declining stops asking for that session. Stopping a session manually also clears the prompt.

## Tips

- Keep the scan frequency low (a few seconds) for a responsive tethering workflow; there's little cost to scanning often.
- The base directory for copies can never be inside the folder being surveyed, to avoid the copies themselves being picked up as new input.
- The picker position is remembered between images, so it makes easier to check the value of a particular area. 
