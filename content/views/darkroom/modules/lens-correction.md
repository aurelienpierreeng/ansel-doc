---
title: Lens correction
date: 2022-12-04T02:19:02+01:00
id: lens-correction
applicable-version: 3.8
tags:
working-color-space: RGB
view: darkroom
masking: false
---

Automatically correct for (and simulate) lens distortion, transversal chromatic aberrations (TCA) and vignetting.

This module identifies the camera/lens combination from the image's Exif data, then corrects each flaw from one of two places: a *community profile* from the calibration database that ships with Ansel, or a *vendor profile* your own camera wrote into the raw file. See [where corrections come from](#where-corrections-come-from) below.

The database is built from the calibrations published by the [lensfun project](https://lensfun.github.io/), whose community measures and maintains them. Ansel does not use the lensfun library itself to correct your pictures — it reads the calibrations and does the arithmetic on its own, which is what lets the correction run on the GPU — but the profiles are lensfun's, and everything below about finding, adding or creating a profile applies unchanged.

If neither source has anything for your lens, the module has nothing to offer but "no correction" on each flaw. You may try to find the right profile yourself by searching for it in the camera and lens menus.

If your lens is present in the list but has not been correctly identified, this may require some adjustment within the exiv2 program (see [this post](https://dev.exiv2.org/boards/3/topics/2854) for details). Note that you may need to re-import the images once such adjustments have been made as the lens name is retrieved as part of the import process.

By default, only the lenses that are directly compatible with your camera's mount are listed and automatically identified. If you are using lenses for a different mount with an adapter (for example a Four Thirds lens adapted to a Micro Four Thirds body), then you must run the [`lensfun-add-adapter`](https://lensfun.github.io/manual/v0.3.2/lensfun-add-adapter.html) tool to enable those lenses, and then rebuild Ansel's database as described in [updating the lens database](#updating-the-lens-database).

If you can't find your lens, check if it is in the list of [currently supported lenses](https://lensfun.github.io/lenslist/). If it is there but not in Ansel, your copy of the database predates it — see [updating the lens database](#updating-the-lens-database).

If there is still no matching profile for your lens, a [lens calibration service](https://www.darktable.org/2013/07/have-your-lens-calibrated/) is offered by Torsten Bronger, one of darktable's users. Alternatively you may visit the [lensfun project](https://lensfun.github.io/lenslist/) to learn how to generate your own set of correction parameters — and if you do, see [updating the lens database](#updating-the-lens-database) for how to make Ansel see them. Don't forget to share your profile with the lensfun team!

## Updating the lens database

Ansel ships a snapshot of the lensfun calibrations, taken when the version you installed was built. It is a plain file and it does not change by itself, so there are three reasons you might want to rebuild it:

- the lensfun community has published a profile for your lens since your Ansel was built;
- you ran `lensfun-add-adapter` to enable lenses mounted through an adapter;
- you calibrated a lens yourself, and its profile is in your personal lensfun directory.

None of those are visible to Ansel until the database is rebuilt, because the profiles live in lensfun's directories and Ansel reads its own file.

The rebuild is a command, not a menu entry. It is a rare operation, it is not interactive, and it wants Ansel closed — so it lives on the command line:

```sh
# optional: fetch the latest calibrations published by the lensfun project
lensfun-update-data

# rebuild Ansel's database from every profile installed on this machine
ansel-lens-db-update
```

**Close Ansel before running it.** The new file is written safely — it is created under a temporary name and moved into place, so a running Ansel can never read a half-finished database — but each running instance keeps its own copy open until it exits, so it would go on using the old one. Nothing breaks; the update simply would not appear until you restart.

The update **adds to** the lenses Ansel shipped with, it does not replace them. The tool starts from the calibrations in your Ansel installation, then merges over them every profile lensfun can see on this machine: the system-wide database, the system and user update directories, and your own profiles in `~/.local/share/lensfun`. Where two describe the same lens, the one found later wins — your own always beats the rest. Those are lensfun's precedence rules, not something Ansel decides.

So calibrating one lens yourself gives you that lens *plus* the fifteen hundred already there, not a database containing only yours.

The result is written to your configuration directory, and Ansel reads it in preference to the one it shipped with. Nothing is overwritten: to go back to the database Ansel came with, delete the file the tool reports having written.

Run `ansel-lens-db-update --help` for the options, which mostly matter if you keep profiles in unusual places.

> **Note:** `lensfun-update-data` and `lensfun-add-adapter` belong to the lensfun project and are not installed with Ansel. On Linux they come with your distribution's lensfun package; on Windows and macOS you would have to install lensfun yourself to use them.
>
> `ansel-lens-db-update` itself needs no lensfun installation to be useful. `~/.local/share/lensfun` is read on every platform, so a lens you calibrated yourself is picked up whether or not a system-wide lensfun exists — and because the update starts from the calibrations Ansel shipped, the result is those plus yours either way.

## Where corrections come from

Each of the three flaws this module fixes — vignetting, distortion and chromatic aberration — is corrected from a *source*, and you choose one per flaw:

**community profile**
: From the calibration database Ansel ships. Measured by the lensfun community for your lens *model* — someone else's copy of the same lens, which is normally close enough.

**vendor profile**
: From the profile your camera wrote into the raw file itself. Sony, Fujifilm and Olympus bodies publish one, as do many cameras that shoot DNG. The manufacturer measured the actual lens on a bench, so this is usually the better of the two, and Ansel picks it by default wherever the file offers it.

**manual correction**
: From values you type. Offered for chromatic aberration only, since that correction is two numbers; the others would need a whole polynomial.

**no correction**
: Leave this flaw alone.

**A source only appears if it can actually be used on the image in front of you.** If your lens is not in the database, "community profile" is not offered for it. If your camera wrote nothing into the file, neither is "vendor profile". So the list you see *is* the list of things that will work — there is nothing to try and find out.

That is decided per flaw, not per file, because manufacturers do not all publish the same set. Olympus bodies, for instance, embed distortion and chromatic aberration but no vignetting — so on those images the first two default to the camera's own profile while vignetting stays on the database, which is exactly what you want and needs no action from you.

> **Note:** a manufacturer's profile describes distortion and chromatic aberration as a single measurement, so "vendor profile" is offered for chromatic aberration only when distortion is using it too. The other way round is free: a vendor distortion works with a community or hand-typed aberration, which is what you want if you are chasing residual fringing your camera's profile leaves behind.

## Module controls

camera
: The camera make and model, as read from the image's Exif data. Click it to choose a different one from the full list of bodies the database knows. Only lenses that fit the selected body's mount are then offered.

: Worth overriding when your body is not in the database at all. If an earlier version of the same camera is listed, it usually carries the same lens mount and, on a fixed-lens compact, often the very same lens — picking it deliberately is the way to get a correction the automatic match cannot find.

lens
: The lens make and model, as read from the image's Exif data. Click it to choose a different one from the lenses fitting the selected body.

: This is what you need for a lens with no electronic contacts: it reports nothing to the camera, so nothing reaches the Exif data and nothing can be matched automatically. It is also useful for off-brand lenses whose reported name does not resemble the catalogue's.

photometric parameters (focal length, aperture, focal distance)
: Lens corrections depend on certain photometric parameters that are read from the image's Exif data: focal length (for distortion, TCA, vignetting), aperture (for TCA, vignetting) and focal distance (for vignetting). Many cameras do not record focal distance in their Exif data, in which case you will need to set this manually.

: You can manually override all automatically selected parameters. Either take one of the predefined values from the drop-down menu or, with the drop-down menu still open, just type in your own value.

vignetting
: Correct the darkening towards the corners of the frame. Choose the source, as described above.

distortion
: Correct the bending of straight lines — barrel or pincushion. Choose the source, as described above. The two controls below belong to this correction and appear with it.

geometry
: Change the projection of your image, for example to render a fish-eye frame as rectilinear. Only offered with **community profile**, because the projection of a lens is something the database describes and a vendor profile does not — the manufacturer measured the lens in the projection it was built for. To correct the aspect ratio of an anamorphic lens, use the [_rotate and perspective_](./rotate-perspective.md) module instead.

scale
: Correcting distortion pushes some of the frame outside its own borders and pulls empty corners in. This zooms the image to hide them. Press the button to the right of the slider to let Ansel find the smallest zoom that just removes the black corners.

: With a **vendor profile** the manufacturer's own zoom factor is already applied, so this slider starts at 1 and is what you want *on top of* it.

chromatic aberration
: Correct the coloured fringes at high-contrast edges, caused by the lens focusing colours at slightly different sizes. Choose the source, as described above. Not offered on images your camera recorded as monochrome, which have no colour channels to misalign.

TCA red; TCA blue
: The correction amounts, shown only with **manual correction**. Look for coloured seams along high-contrast edges and adjust until they are least visible.

mode
: Whether to *correct* the lens's flaws or to *apply* them to an image that does not have them. This is being retired and is shown only on images that already use it — the module exists to remove lens flaws, and nobody was found to want the opposite.

## What this module cannot do

Worth knowing before you go looking for a control that is not there.

**Vendor profiles are all-or-nothing.** The manufacturers' own editing software lets you dial a profile's strength down — half the distortion, three quarters of the vignetting. Ansel applies the profile as measured. If you want less than the full correction, the community profile is the source that gives you a scale to play with, or use the [_rotate and perspective_](./rotate-perspective.md) module for distortion you want to shape by hand.

**Not every manufacturer publishes every correction.** Olympus bodies record distortion and chromatic aberration but no vignetting; a DNG carries whichever corrections its writer chose to record, which is sometimes none at all. Ansel does not invent the missing ones — the row simply is not offered, and the community profile covers that flaw if it knows your lens.

**Only Sony, Fujifilm, Olympus and DNG vendor profiles can be read.** This is a gap in Ansel rather than in your camera: Canon raws, for instance, do carry a vignetting correction block of their own, and Ansel simply has no reader for it yet. Files from makers not in that list use the community profile, which for popular lenses is usually well populated. If your camera's profile matters to you, say so — knowing which bodies people actually want is what decides which reader gets written next.

**Changing the projection needs the community profile.** The "geometry" control turns a fish-eye frame into a rectilinear one, and it only appears when distortion is set to **community profile**. A manufacturer measured the lens in the projection it was built for and describes no other, so there is nothing in a vendor profile to reproject from.

**Chromatic aberration cannot borrow a profile it was not measured against.** "Vendor profile" is offered for it only when distortion is using the vendor profile too, because a manufacturer measures the colour fringing as a departure from *their* distortion figures. Pairing it with the community profile's distortion would combine two different measurements of the same lens. The useful direction works: vendor distortion with a community or hand-typed chromatic aberration.

**Corrections are read from the raw file each time it is opened.** Nothing about the vendor profile is stored in your library, so if a file is edited on another machine whose Ansel is older, or the file itself is replaced, the correction follows the file rather than your edit. Ansel tells you in its log when it falls back to the community profile because a vendor profile could not be found or read.

**Very old edits still follow the database of the day.** Images corrected automatically by much older versions of Ansel did not record which corrections they used — they asked the database again on every open. If such an edit renders differently after a database update, that is why. Any edit you make or touch from now on writes its choice down and is reproducible.

---

**Note:** chromatic aberration is not corrected on images identified as monochrome by their metadata, like the files produced by the Leica M10 Monochrom — there are no colour channels to misalign. The control is not offered on those images.

**Note:** The lens correction module will fill in missing data at the borders by repeating the borders' pixels. For strong corrections, this filling can be visible (especially on noisy images). Crop the image if necessary.

---

show guides
: Tick the box to show guide overlays whenever the module is activated. Click the icon on the right to control the properties of the guides. See [guides & overlays](../../toolboxes/guides-overlays.md) for details.
