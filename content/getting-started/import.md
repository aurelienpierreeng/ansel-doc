---
title: Import images
weight: 01
---

## Basics

Ansel backbone is a library of images, saved as an SQLite database into `~/.config/ansel/library.db`. Since Ansel is a non-destructive photo editor, editings are saved as histories of settings, along with image metadata, as text[^1] into the library database. The application of editing histories over raw images, as to produce output raster images, is the export step.

The library is also used to keep track of image collections (by tags, folders, EXIF, editing time, etc.). Because of this, we need to make the library aware of new images : it is the import step. This will initialize a new database entry with metadata and a virgin history for each imported picture.

[^1]: or as binary blobs, but still : we store the recipes, not the results.

The import modal window can be accessed from the global menu _File_ → _Import..._.

## Two kinds of imports

The _file handling_ setting allows to enforce 2 different strategies :

Import in library
: This simply makes the library aware of pictures that already exist somewhere on a local or distant storage. You will need to ensure that those images stay available on this storage in the future, at the exact same path, because Ansel needs to access them prior to applying any history or generating exports and thumbnails. Ansel does not keep track of file moves on the filesystem,[^2] meaning displaced images will appear lost in the interface (displayed as skull thumbnails).

[^2]: though there are manual way to update file pathes in the library, if you ever move entire folders.

Copy to disk
: The typical use case for this strategy is when you want to empty your camera memory cards and save the photos to a permanent storage. It adds a copying step, with bulk files and folders renaming, prior to the same insertion to library as in the previous strategy.

## Importing from cameras

__It is highly recommended to import from memory cards using a card reader__. Using an USB link through the camera is discouraged. This is both for read/write performance (card readers are much faster, especially when using USB 3.0) and to avoid MTP/PTP drivers issues, which are numerous as you will see later.

If you still want to import through your camera, here is some important information.

### All OS

Ansel uses the [Gio](https://docs.gtk.org/gio/index.html) library to handle files. This library essentially communicates with the operating system to handle local and distant storages, which means the proper drivers need to be installed. Depending on the generation of your cameras, you might look into 3 drivers :

- [USB Mass Storage Class](https://en.wikipedia.org/wiki/USB_mass_storage_device_class), used by card readers, by some cameras and by USB sticks. This is the most reliable and most widely supported, as the drivers already are in all OS since the early 2000's. Prefer this whenever possible.
- [Picture Transfer Protocol (PTP)](https://en.wikipedia.org/wiki/Picture_Transfer_Protocol), used by cameras.
- [Media Transfer Protocol (MTP)](https://en.wikipedia.org/wiki/Media_Transfer_Protocol), used by some cameras and smartphones.

### Windows

Mass Storage devices should work out-of-the-box, however PTP and possibly MTP devices will require an USB driver compatible with `libusb` (like [Zadig](https://zadig.akeo.ie/)) to work with Gio. Once the driver is installed and the camera plugged-in, you need to go to the configuration panel and enable the Zadig driver for the relevant USB port. This will prevent the camera to work properly with other Windows applications and with the rest of the OS (file browser and such). You will need to deinstall the USB port and reinstall it with native drivers to regain access to your camera from Windows.

### Linux

Gio relies on [GVFs](https://en.wikipedia.org/wiki/GVfs) and [FUSE](https://en.wikipedia.org/wiki/Filesystem_in_Userspace) to mount external (and possibly remote) filesystems using various protocols (FTP, sFTP, Samba, DAV, PTP, MTP, etc.). You will need the following packages installed on your system (_actual package names may vary depending on your distribution_) :

- for all cameras and card readers : `gvfs`, `gvfs-fuse`,
- for PTP cameras : `gvfs-gphoto2`
- for MTP cameras : `gvfs-mtp`.

Note that only one application can lock a PTP camera at a time. If your file browser or any part of your OS is automatically mounting the PTP device when hotplugging, it might not be available to Ansel.

There might also be interactions with the `udev` stack that you might need to debug.

{{< note >}}
Buying a 20 $ memory card reader will save you a lot of headaches and give you much faster I/O. Connection issues with USB cameras are out of the scope of Ansel and will not be debugged.
{{< /note >}}


## What next ?

Photos are imported into _filmrolls_, which are the primary collection type in Ansel. Filmrolls are related to filesystem folders, but they are not equivalent :

- a filmroll contains images from a single folder ; the folder's name is the identifier (unique name) of the filmroll,
- a filmroll does not necessarily contain __all__ images from its sibling folder, for example JPEG files from the folder may have been discarded from the filmroll,
- filmrolls are not recursive or hierarchical, but it is possible to list all filmrolls attached to the sub-folders of an high-level folder,
- if 2 sets of images are imported, at different times, from the same folder, they will be added to the same filmroll,
- filmrolls will not be automatically updated when new images are added to the filesystem folders.

In other words, filmrolls are _views_ of filesystem folders that exist only in Ansel's database, and containing only images that Ansel is aware of (because they were imported).

When the import completes, the import window will close and the lighttable view will be updated to the last filmroll created during import.
