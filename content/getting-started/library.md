---
title: Library and collections
date: 2025-05-15
weight: 04
---

Ansel keeps a database of all images it knows, that is all images that were [imported](import.md), until you actively remove them from the library (global menu : _File_ → _Remove from library_). The library stores the filesystem path of the images, their metadata and their editing history.

{{< warning >}}
Ansel does not listen to the content of filesystem folders, meaning it will not be notified if imported images are (re)moved on the filesystem. You will need to manually update the pathes if that is the case, or you can move those files directly with Ansel (under the global menu _File_).
{{< /warning >}}

Ansel will then perform database extractions based on arbitrary user criteria : those are called _collections_. They are built in [lighttable](../views/lighttable/_index.md) from the _library_ toolbox and from the _include_ toolbar. Ansel has no concept of gallery or virtual folder that you __create__ first, then to which you __add__ arbitrary images. Instead, in Ansel, you __attach__ tags to images, then __collect__ all images having a certain tag (or any kind of metadata, base folder, etc.), possibly mixing filters and search criteria to narrow-down the search : this is what makes a collection.

The first two tabs of the _library_ toolbox, _folders_ and _collections_, contain simple interfaces to the most-used querying criteria : base folder of the images (called _filmroll_), and tags attached to images. The third tab, _queries_, offers a more complete and somewhat cumbersome interface to perform any kind of advanced query, possibly mixing several criteria with boolean operators (OR/AND/AND NOT), among filmrolls, tags and many more image metadata.

Once you have built a collection by inputing querying criteria, you can save them into a preset into the _library_ toolbox, by clicking on the menu in its header, then _store a new preset_.

Once the first stage of querying is performed in the _library_ toolbox, the _include_ toolbar, in the second row of the header, will apply workflow-related refinements (see [lighttable](../views/lighttable/_index.md) for more details).

A collection can be defined only from the lighttable view, and is then globally shared within the whole software. It defines the content of the lighttable thumbnail grid and of the [filmstrip](../views/toolboxes/filmstrip.md) in all other views.
