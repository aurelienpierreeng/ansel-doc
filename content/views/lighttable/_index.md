---
title: Lighttable
date: 2022-12-04T02:19:02+01:00
lastmod: 2023-10-11
id: lighttable-and-dam
draft: false
weight: 20
author: "people"
---


The lighttable view is the default view loaded when Ansel is started, and allows you to view and manage your image collection. It will noticeably allow you to:

- cull your images, assign then ratings and ultimately decide which images are worth keeping and editing,
- filter your images based on ratings, base folder, or any metadata supported by the software (EXIF/IPTC/XMP),
- apply metadata, like title, description, tags, GPS coordinates, or correct EXIF date/time,
- copy-paste editing histories between images or apply styles, individually or in batches,
- export images editing histories to final files.

## Lighttable content

All the images known to Ansel are stored in a database, the [library](../../install/configuration.md). The lighttable shows thumbnails of a subset of this library, called a _collection_. A collection is created by filtering the images from the library using criteria, first from the [library toolbox](../toolboxes/collections.md), then from filtering/include toolbar.

Library
: The library toolbox, in the left sidebar, provides the primary querying criteria to extract a subset of images from the library database. The main criteria are :
    - __Folders__ : the base folder in which the images are stored on your filesystem. They can be shown as a flat list or as a tree. Note that Ansel does not directly read the folder's content, but shows its [imported](../../getting-started/import.md) images (from its database) whose base folder matches this criterion. As such, the actual filesystem folder may contain more images than what Ansel will show, if they have not been imported.
    - __Collections__ : allows to query all images that have a certain tag assigned. This is similar to what other software call "collections" or "virtual folders", except that, in Ansel, you don't add an image to a virtual folder, you assign a tag to an image, and then query all images having that tag.
    - __Queries__ : enables more advanced querying rules, using metadata and boolean combinations of criteria (or/and/and not). Note that _folders_ and _collections_ (aka _tags_) only provide a simplified interface for the most common fields that can be found in the _queries_ tab. Available metadata to filter can be:
        - __gear__ : lens name, camera, focal length,
        - __exposure settings__ : shutterspeed, ISO, aperture,
        - __date and time__ : of the shot, of last modification, last export, last print, etc.
        - __user set data__ : title, description, copyright, creator, publisher, etc.
        - __internal technical tags__ : file format, local copies, etc.

Include
: The _include_ toolbar, in the second top row, allows to quickly filter in and out images based on their (_in order of appearance_):
    - __rating__ :
        - unrated (0 star) : the barred star icon,
        - _rejected_ state : the circled cross icon (same as on the thumbnails),
        - 1 to 5 stars : the next 5 star icons. Those are positional, meaning :
            - selecting the third starred-button will filter in all images having 3 stars,
            - to select images rated at least 3 stars, you will need to select the third, fourth and fifth stars, which can be quickly achieved with <kbd>Ctrl</kbd>+<kbd>left click</kbd> on the third star.
    - __color labels__ :
        - unlabled images : the white disk,
        - color-labeled images : colored disks,
    - __edited state__ :
        - images having no editing history : the horizontally-barred circle,
        - images having an editing history : the yin-yang +/- circle (same as on the thumbnails),
    - __selection__ : restricting the collection to any arbitrary user-defined selection. This replaces Darktable's _culling_ view.
    - __text search__ : restricting the collection to all images having at least one textual property matching the search query (filename, folder, title, etc.).
: The controls from the _include_ toolbar are toggle buttons, meaning when they are selected, images matching those criteria will be shown (filtered in/included), and when they are unselected, images matching those criteria will be hidden (filtered out/excluded). To show everything (_include everything_ or _exclude nothing_), you will therefore need to have all buttons checked, which can be quickly achieved by doing a right click on any of the buttons, then selecting _Select all filters_ in the context menu. If no button is toggled, no image is included and the lighttable grid stays empty.

To summarize, the _library_ toolbox helps filtering images based on their intrinsic properties, while the _include_ toolbar, allows to target workflow-based properties that you can set yourself to keep track of your work in progress :

- Star ratings help culling and narrowing down the set of images you will actually edit. For example :
    - 5 stars means "to edit absolutely",
    - 4 stars means "to edit if time permits",
    - 3 stars means "backup plan",
- Color labels help tracking where you are in your workflow. For example :
    - red label means "basic/batch editing applied",
    - yellow label means "fine-tuned/individual editing applied",
    - green label means "exported",
    - blue label means "printed"
    - purple label means "sent to client".

Those are, of course, examples that you can adapt to your needs and workflow. Note that you can also use text tags to keep track of all that, but they will not show over thumbnails in the lighttable.

## Lighttable display

Display options
