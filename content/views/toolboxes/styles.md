---
title: Styles
date: 2026-06-16
id: styles
tags:
view: lighttable
---

A **style** is a named, saved editing recipe — a subset of a history stack that can be applied to any number of images. Styles let you reuse looks, technical corrections, or module configurations without having to redo them from scratch.

Styles are accessible from two places:

- The **Styles menu** in the menu bar, which lists all your styles and applies them in one click.
- The **Styles toolbox module**, available as a floating window via **Styles → Manage styles…**

## Applying a style

Click any style name in the **Styles menu** to apply it to all currently active images. If **Ask merge settings before apply** is enabled (the default), a [merge settings dialog](#merge-settings-dialog) appears first. See the [copy-paste history](../lighttable/history-copy-paste.md) page for a full explanation of what merge position and pipeline order mean.

Double-clicking a style name in the **Styles toolbox module** applies it to all selected images using the currently saved settings, without showing the dialog.

{{< note >}}
Style application and [copy-paste](../lighttable/history-copy-paste.md) share the same underlying merge engine but maintain **independent** default settings. Changing the merge mode for styles has no effect on paste operations, and vice versa.
{{< /note >}}

### Merge settings dialog

When **Ask merge settings before apply** is active, clicking a style in the Styles menu opens a dialog with two choices:

Merge position
: how the style's modules are placed relative to the image's existing history:
    - **Below (Prepend)** — the style becomes the base; your existing edits run afterwards and override conflicts. Use this for decorative looks that sit underneath per-image corrections.
    - **Above (Append)** — your existing edits become the base; the style runs afterwards and overrides conflicts. Use this for technical corrections (calibration, profiling) that must take precedence.
    - **Replace** — your existing history is discarded and replaced entirely by the style.

Use incoming pipeline order
: when checked, the module execution order stored in the style replaces yours. This option is **disabled** when the style was saved without a pipeline order; a tooltip explains this when you hover over the greyed-out checkbox.

Ask me every time
: when unchecked, the saved defaults are used silently on future applies. You can re-enable the dialog from **Styles → Ask merge settings before apply**.

### Default settings (Styles menu)

The merge mode and pipeline order defaults for style application are controlled at the bottom of the Styles menu:

**Styles → History pasting mode**
: Choose **Prepend**, **Append**, or **Replace** as the default merge position.

**Styles → Nodes pasting mode → Copy module order**
: Toggle whether the style's pipeline order is applied by default.

**Styles → Ask merge settings before apply**
: Toggle whether the dialog is shown each time a style is applied from the menu.

## Creating a style

### From the history stack module (darkroom)

Open the [history stack](./history-stack.md) panel in the darkroom. Click the **create style** button (the icon to the right of "compress history stack"). A dialog lets you name the style, add an optional description, and choose which modules from the current history to include.

### From the Styles toolbox module

Click **create** in the toolbox. The same dialog appears, drawing from the history stack of the single selected image.

### Hierarchical names

Use the pipe character `|` as a separator in the style name to create sub-categories. For example, a style named `print|tone curve +0.5 EV` appears under a **print** category in both the Styles menu and the toolbox. Categories can be nested.

### Saving pipeline order

When creating a style, the pipeline order (module execution sequence) is saved alongside the module parameters only if you check the appropriate option in the creation dialog. Styles without a saved order are still fully functional — Ansel will keep the destination image's existing order when applying them.

## Managing styles

The **Styles toolbox module** is the primary interface for managing styles. Open it via **Styles → Manage styles…** in the menu bar.

edit
: Open a dialog to include or exclude individual modules from an existing style. Tick **duplicate** to create a new style instead of overwriting the existing one (you will need to supply a new unique name).

remove
: Delete the selected style immediately, without a confirmation prompt.

import
: Load a style from a `.dtstyle` XML file. If a style with the same name already exists you will be asked whether to overwrite it.

export
: Save the selected style to disk as a `.dtstyle` file for backup or sharing.

## Keyboard shortcuts

You can assign a keyboard shortcut to any style in **Edit → Keyboard shortcuts…** and then press that shortcut from anywhere in the lighttable or darkroom to apply the style to all active images using the current saved merge settings (the dialog is not shown for shortcut-triggered applies).
