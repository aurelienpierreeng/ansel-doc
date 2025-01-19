---
title: shortcuts
date: 2022-12-04T02:19:02+01:00
id: shortcuts
weight: 120
draft: false
---
Some actions in Ansel can be performed with a keyboard shortcut. A table of key shortcuts is available in _Help > Table of key shortcuts_. 

**Note:** The table shows different key shortcuts for different Views.

## Assigning key shortcuts

For the time being shortcuts can only be defined or changed by editing your `$HOME/.config/Ansel/shortcutsrc` file. There is no support for MIDI-devices in Ansel.

### Deleting default shortcuts

When launching the application, Ansel loads default shortcuts first, and then loads user-defined shortcuts on top. This allows default shortcuts to be overridden with a new action but prevents them from being deleted (since the deleted shortcut will be automatically reloaded on the next restart).

There are two ways to delete default shortcuts:

#### Prevent default shortcuts from being reloaded

Disable [Preferences > Miscellaneous > Interface > Load default shortcuts at startup](./miscellaneous.md) to prevent default shortcuts from being reloaded. While this option is disabled, Ansel will only load user-defined shortcuts and any defaults that you have not subsequently deleted or overridden.

#### Override default shortcut with a no-op action

You can _override_ the action of a default shortcut by assigning an identical shortcut to the "global/no-op" action (which does nothing). You can do this by directly editing your `$HOME/.config/Ansel/shortcutsrc` file (you must exit Ansel first). For example, the following default shortcuts are defined in `shortcutsrc` for switching views in Ansel:

```
Return=global/switch views/darkroom
Escape=global/Ateliers/Lighttable
```

You could disable these shortcuts by changing `shortcutsrc` as follows:

```
Return=global/no-op
Escape=global/no-op
```

## Actions

**Note:** The following two section were used to explain the deprecated shortcut mapping screen and are left here for future reference or development.

Shortcuts are used to initiate _actions_ within Ansel.

An _action_ is usually (but not always) an operation that you might undertake using Ansel's point-and-click user interface. For example:

- Increase, decrease or reset sliders
- Scroll through dropdown lists
- Enable, expand or focus modules
- Click buttons
- Switch between views

Such point-and-click type _actions_ are normally defined as the application of an _effect_ to an _element_ of a _widget_, where these terms are defined as follows:

Widget
: Each visible part of the user interface is known as a _widget_. For example the Ansel application window is a widget, containing side panel widgets, each of which contains module widgets, each of which contains button, slider and dropdown list widgets etc... When assigning a shortcut to an action, you must first decide which widget it is to be applied to.

Element
: An _element_ is the part of a UI widget that is affected by your shortcut. For example, for a slider that has a color picker, you can make a shortcut activate the color picker _button_ element or change the _value_ element of the slider. For a row of tabs (the row is a single widget) you can select which tab element to activate or use your mouse scroll wheel to scroll through the tabs.

Effect
: A shortcut can sometimes have multiple possible _effects_ on a given _element_. For example, a button can be activated as if it was pressed with a plain mouse-click or as if it was pressed with Ctrl+click. A slider's value can be edited, increased/decreased or reset.

## Common actions

The following is a list of some of the actions to which you can assign shortcuts, organized by widget type. 

### Global

Actions in the "global" section can be executed from any Ansel view. Most of these actions do not have specific _elements_ as they are used to perform one-off operations.

### Views

Actions in the "views" section can only be executed from the specified Ansel view. As with global actions, most do not have specific _elements_ as they are used to perform one-off operations.

### Buttons

A button is a clickable icon in the Ansel interface. The default action, when assigning shortcut to a _button_, is to activate that button as if clicked with the left mouse button. You can modify this action to activate the button as if clicked while holding a modifier key.

### Toggles

A toggle is a button that has a persistent on/off state. It therefore has additional _effects_ to allow you to toggle it or explicitly set its state. As with a normal button the default action, when assigning a shortcut to a toggle, is to activate the toggle as if clicked with the left mouse button (which toggles the button on/off).

### Utility modules

All utility modules have the following elements:

_Show_
: Acts as a _toggle_ that expands and collapses the module.

_Reset_
: Acts as a _button_ that resets all module parameters when activated. The _ctrl-activate_ action can be used to re-apply any automatic presets for that module.

_Presets_
: Allows you to select actions from the [Presets](../views/darkroom/processing-modules/presets.md) menu (e.g. edit, update, previous, next). The default action, when assigning a shortcut to a _preset_ element, is to display a list of the available presets for selection. 

The default action, when assigning a shortcut to a utility module, is to _toggle_ the _show_ element (expand/collapse the module).

In addition, shortcuts are available for all of the controls on each module as well as any stored presets (see below).

### Processing modules

Processing modules have the same elements and defaults as utility modules with the following additional elements:

_Enable_
: Acts as a _toggle_ that switches the module on and off.

_Focus_
: Acts as a _toggle_ that focuses or defocuses the module.

_Instance_
: Allows you to select actions from the [Multiple-instance](../views/darkroom/processing-modules/multiple-instances.md) menu (e.g. move up/down, create new instance). The default action, when assigning a shortcut to the _instance_ element, is to display a list of the available options for selection; 

If an action affects a processing module that can have multiple instances, you can choose which instance to adjust with a given shortcut. By default, all actions will affect the "preferred" instance, as defined using the settings in [Preferences > Miscellaneous > Shortcuts with multiple instances](./miscellaneous.md#shortcuts-with-multiple-instances).


### Dropdowns

A dropdown is a multi-selection box and has the following elements available:

_Selection_
: Allows values to be selected from the dropdown list in various ways. The default action, when assigning a shortcut to a dropdown, is to display a popup _edit_ box with a list of the available values for selection.

_Button_
: A standard _button_ element that allows the button to the right of the dropdown (if present) to be activated. For example, the _aspect_ dropdown in the [_Crop_](../modules/processing-modules/crop.md) module has a button that allows the crop controls to be changed from portrait to landscape and vice versa.

### Sliders

A slider allows you to continuously alter an integer or decimal value, and has the following elements available:

_Value_
: Allows the current value of the slider to be altered. The default action, when assigning a shortcut to a slider, is to display a popup _edit_ box so you can enter a value. Value elements are also used for modifying some on-screen graphs. When modifying the _value_ element with a shortcut you may not exceed the bounds set in the visual slider.

_Force_
: This is the same as the _value_ element described above, but it allows you to exceed the bounds set in the visual slider.

_Zoom_
: Allows you to change the upper and lower bounds of the visual slider without altering the current value.

_Button_
: A standard _button_ element that allows the button to the right of the slider (if present) to be activated. For example, a slider may include a color picker to visually set its value based on selected elements of the image.