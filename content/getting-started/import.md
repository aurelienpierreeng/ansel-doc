---
title: Import images
date: 2024-06-24
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
: This simply makes the library aware of pictures that already exist somewhere on a local or distant storage.

[^2]: though there are manual way to update file pathes in the library, if you ever move entire folders.

Copy to disk
: The typical use case for this strategy is when you want to empty your camera memory cards and save the photos to a permanent storage. It adds a copying step, with bulk files and folders renaming, prior to the same insertion to library as in the previous strategy.

### Importing without copy

You will need to ensure that those images stay available on the same storage in the future, at the exact same address, because Ansel needs to access them prior to applying any history or generating exports and thumbnails. Ansel does not keep track of file moves on the filesystem,[^2] meaning displaced images will appear lost in the interface (displayed as skull thumbnails).

### Importing with copy

When emptying your memory card to a permanent storage, that is when you copy the files before importing to the library, you can rename files in batch and split them automatically into subfolders. This is done through the _project directory naming pattern_ and _file naming pattern_ fields, using [variables](../special-topics/variables.md). The final path of each image imported with copy will be `Base directory / Project directory / Filename`, where `Base directory` will be selected directly from the filesystem (usually the user's `Pictures` default folder), without variables.

Some particular variable's values can be set from the import window :

Project Date
: By default, it is (explicitly) set to today's date, and the time defaults to 00:00:00 UTC+0 if not explicitly set. Date and time can be changed to any past of future date, either in plain-text (using ISO 8601 format), or using the calendar widget. This date and time will be used by the variables `$(YEAR)`, `$(MONTH)`, `$(DAY)`, `$(HOUR)`, `$(MINUTE)`, `$(SECOND)`, `$(MSEC)`. If you plan on using time (hour, minute, second and below), you should manually set it in plain-text in the entry.

Jobcode
: This is the project name, like the subject of your photo session. It is retrieved in patterns with the `$(JOBCODE)` variable.

Those values are constant among images for a whole import session.

EXIF variables can also be used in file and directory names, like `$(EXIF.YEAR)`, `$(EXIF.MONTH)`, `$(EXIF.DAY)`, etc. for the date and time of image capture. These variables are a property of each image, which means that, if you use them into directory names, images may be split into different directories and later to different _filmrolls_ (see below). EXIF variables are fetched from reading the actual files, which triggers I/O from the filesystem holding them, and can significantly slow-down importation for files hosted on remote storages or USB 2.0 cameras.

To fast-track per-picture date/time retrieval, you can also use the variables `$(FILE.YEAR)`, `$(FILE.MONTH)`, `$(FILE.DAY)`, `$(FILE.HOUR)`, `$(FILE.MINUTE)` and `$(FILE.SECOND)`. These variables read the file modification date from the filesystem, without reading the actual files, which reduces I/O and brings substantial speed-up when accessing memory cards from within cameras. Provided no third-party application tampered with raw files, the date/time should be the same as EXIF, at least down to the second. Issues may arise if pictures were opened and saved from other applications, and their time of modification changed.

{{< warning >}}
Dumping all new images into a (few) single, massive directories is discouraged as it doesn't promote sane culling workflows and might need insane filtering options in lighttable to be workable. (See Darktable's 4.0 new collections/filtering monstruosity…).
{{< / warning >}}

While Ansel allows you to perform advanced SQL queries into the library database, to find images using many properties (including date/time, EXIF, rating, editing history, etc.), you should not rely on it to customarily access your images. Opening images from other applications, or uploading them to websites (for example : to send print orders) will use your native filesystem interface. Even within Ansel, accessing large collections of images at once will be slower.

With this in mind, you should try to keep a tidy file structure, organizing photos into per-project or per-session directories, containing no more than a few hundreds pictures at once. Directories and file names should be self-explanatory, to allow text search into filenames from any file browser. Those are old and low technologies, supported on any platform, and relying on those makes for efficient and simple workflows.


## Importing from cameras

__It is highly recommended to import from memory cards using a card reader__. Mounting the memory card through the camera, using an USB link and PTP/MTP drivers, is possible in most cases but discouraged :

- read/write performance is bad (in any case, worse),
- there are many possible camera MTP/PTP drivers issues on Linux, possibly involving the `udev` stack,
- recent cameras may not be supported at all for a while,
- several applications (and the OS file browser) may compete for access to PTP/MTP cameras and have auto-mount enabled (only one can lock it at a time),
- the camera will need to be powered on during the whole process, draining batteries for no reason.

If you still want to proceed, here is some important information to do so.

### All OS

Ansel uses the [Gio](https://docs.gtk.org/gio/index.html) library to handle files. This library essentially communicates with the operating system to handle local and distant storages, which means the proper drivers need to be installed. Depending on the generation of your cameras, you might look into 3 drivers :

- [USB Mass Storage Device Class (UMS or MSDC)](https://en.wikipedia.org/wiki/USB_mass_storage_device_class), used by card readers, by some cameras and by USB sticks. This is the most reliable and most widely supported, as the drivers already are in all OS since the early 2000's. Prefer this whenever possible,
- [Picture Transfer Protocol (PTP)](https://en.wikipedia.org/wiki/Picture_Transfer_Protocol), used by cameras, especially DSLR,
- [Media Transfer Protocol (MTP)](https://en.wikipedia.org/wiki/Media_Transfer_Protocol), used by some cameras and by smartphones.

Some cameras will let you choose the USB driver to load, in their menu. When that is the case, choose preferably mass storage or MTP. In any case, check that your camera is not in PictBridge mode (used only for direct connexion between a camera and a printer).

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

### Mac OS

No idea.

## What next ?

Photos are imported into _filmrolls_, which are the primary collection type in Ansel. Filmrolls are related to filesystem folders, but they are not equivalent :

- a filmroll contains images from a single folder ; the folder's name is the identifier (unique name) of the filmroll,
- a filmroll does not necessarily contain __all__ images from its sibling folder, for example JPEG files from the folder may have been discarded from the filmroll,
- filmrolls are not recursive or hierarchical, but it is possible to list all filmrolls attached to the sub-folders of an high-level folder,
- if 2 sets of images are imported, at different times, from the same folder, they will be added to the same filmroll,
- filmrolls will not be automatically updated when new images are added to the filesystem folders.

In other words, filmrolls are _views_ of filesystem folders that exist only in Ansel's database, and containing only images that Ansel is aware of (because they were imported).

When the import completes, the import window will close and the lighttable view will be updated to the last filmroll created during import.
