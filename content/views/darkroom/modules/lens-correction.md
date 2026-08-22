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

This module identifies the camera/lens combination from the image's Exif data, then looks up the correction parameters in a database of lens calibrations that ships with Ansel.

That database is built from the calibrations published by the [lensfun project](https://lensfun.github.io/), whose community measures and maintains them. Ansel does not use the lensfun library itself to correct your pictures — it reads the calibrations and does the arithmetic on its own, which is what lets the correction run on the GPU — but the profiles are lensfun's, and everything below about finding, adding or creating a profile applies unchanged.

If there is no correction profile for the automatically identified camera/lens combination, the controls for the three photometric parameters (below) are replaced with a warning message. You may try to find the right profile yourself by searching for it in the menu.

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

## Module controls

camera
: The camera make and model as determined by the image's Exif data. You can override this manually and select your camera from a hierarchical menu. Only lenses with correction profiles matching the selected camera will be shown.

lens
: The lens make and model as determined by the image's Exif data. You can override this manually and select your lens from a hierarchical menu. This is mainly required for pure mechanical lenses, but may also be needed for off-brand / third party lenses.

photometric parameters (focal length, aperture, focal distance)
: Lens corrections depend on certain photometric parameters that are read from the image's Exif data: focal length (for distortion, TCA, vignetting), aperture (for TCA, vignetting) and focal distance (for vignetting). Many cameras do not record focal distance in their Exif data, in which case you will need to set this manually.

: You can manually override all automatically selected parameters. Either take one of the predefined values from the drop-down menu or, with the drop-down menu still open, just type in your own value.

corrections
: Choose which corrections (distortion, TCA, vignetting) Ansel should apply. Change this from its default "all", if your camera has already performed some internal corrections (e.g. vignetting), or if you plan to undertake some corrections with a separate program.

geometry
: In addition to correcting lens flaws, this module can change the projection type of your image. Set this combobox to the desired projection type (e.g. "rectilinear", "fish-eye", "panoramic", "equirectangular", "orthographic", "stereographic", "equisolid angle", "thoby fish-eye").  To correct the aspect ratio of an anamorphic lens, use the [_rotate and perspective_](./rotate-perspective.md) module.

scale
: Adjust the scaling factor of your image to avoid black corners. Press the auto scale button (to the right of the slider) for Ansel to automatically find the best fit.

mode
: The default behavior of this module is to _correct_ lens flaws. Switch this combobox to "distort" in order to instead _simulate_ the flaws/distortions of a specific lens (inverted effect).

TCA overwrite
: Check this box to override the automatic correction parameters for TCA. This will expose the TCA red and TCA blue parameters below. Un-check the box to revert back to automatic corrections.

TCA red; TCA blue
: Override the correction parameters for TCA. You can also use these sliders to manually set the parameters if the lens profile does not include TCA correction. Look out for colored seams at features with high contrast edges and adjust the TCA parameters to minimize those seams.

corrections done
: Occasionally, for a given camera/lens combination, only some of the possible corrections are described by the profile. This message box will tell you which corrections have actually been applied to the image.

---

**Note:** TCA corrections will not be applied to images that have been identified as monochrome by their metadata, like the files produced by the Leica M10 Monochrom.

**Note:** The lens correction module will fill in missing data at the borders by repeating the borders' pixels. For strong corrections, this filling can be visible (especially on noisy images). Crop the image if necessary.

---

show guides
: Tick the box to show guide overlays whenever the module is activated. Click the icon on the right to control the properties of the guides. See [guides & overlays](../../toolboxes/guides-overlays.md) for details.
