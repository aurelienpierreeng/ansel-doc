---
title: Shortcuts and keyboard interaction
date: 2025-05-10
weight: 10
---

Ansel interface is designed to support two mutually-exclusive modes of interaction and navigation: through pointing devices (mouse or graphic tablet) and through the keyboard. Compared to Darktable, many interactions that required combinations of both have been removed, which makes the workflows more efficient.

## Shortcuts and available actions

Ansel exposes app-wise actions and GUI controls to keyboard bindings through pathes like `Darkroom/Modules/Exposure/Black point`, where the left-most member of the path is the view and the right-most member is the actual control being bound. A such path defines an human-readable unique identifier that also says where the control is located in the application GUI.

Ansel has two kinds of objects that users can map to keyboard binding through those pathes:

- __GUI controls/widgets__ : buttons, sliders, comboboxes, etc. Shortcuts attached to those will give them the focus,
- __Actions__ : most of them are attached to the global menu, but some are contextual, depending on which widget has the focus. Shortcuts attached to those will trigger the actions.

The focus is a GUI state in which a widget will capture all keyboard events sent to the application. For text entries, that obviously means recording keystrokes to type text. For other widgets, like sliders, that may be capturing arrow keys events to increase/decrease the value. Only one widget in the whole application can grab the focus at any given time.

Clicking on a widget will automatically give it the focus, but that makes for a terrible workflow where you may have to constantly switch between mouse and keyboard. To allow a full-keyboard workflow, Ansel provides shortcuts to switch the focus to any desired target widget. From there, interacting with widgets (to change their value or their state) is done through generic (non-user-configurable) key bindings.

This means that :

1. Widgets shortcuts are only meant to __select a target widget__ (visible or not) to which further keyboard interactions will be dispatched,
2. There is __only one shortcut__ to configure (and remember) per widget,
3. All widgets of the same type (button, slider, combobox) will use the __same keyboard interactions__ once focused (easier to remember).

Focused control widgets will appear in a bolder font that the others. Focused modules will be highlighted.

Actions (other than widget focusing ones) don't target widgets at all, and calling their shortcut directly triggers them, possibly outside the GUI.

### Finding default shortcuts, setting new ones

{{< note >}}
__A popup window__ showing all available actions and their defined keys is available from the __global menu__, under _Edit_ → _Keyboard shortcuts…_. This window is meant to be at the same time a cheatsheet and a controller to edit shortcuts.
{{< /note >}}

{{< figure src="/shortcuts-popup.jpg" caption="The shortcuts window" />}}

The shortcut pathes are broken into a hierarchical tree in this window. The first level of the hierarchy defines the shortcuts groups:

- there is one _global group_ (tied to the global menu),
- there are several _local groups_ (tied to each view : darkroom, lighttable, etc.).

Inside each group, a combination of keys can be used at most once. If you try to re-use a key combination already in use somewhere else in the same group, you will get an error message saying what path is already using it.

Several shortcuts groups can include the same combination of keys. The global group is loaded all the time in all views of the application, the local groups are loaded only when entering their respecting view and unloaded when exiting it (only one is loaded at anytime). If the global and a local group have each a shortcut using the same keys, as long as the local group is loaded, its shortcut will take precedence over the global shortcut.

Read-only shortcuts
: They are signaled with a lock icon, meaning they can't be edited by users. They are described as _contextual interaction on focus_, because they will need a widget of the right type focused before to have any effect. You will find them under :
    - `Darkroom/Controls` (for sliders and comboboxes interactions),
    - `Lighttable/Thumbtable` (for navigation into the thumbnails grid).
: They are given here in a "cheatsheet" spirit and are guaranteed to be up-to-date with what the code defines. The values found in the popup supercede any documentation regarding shortcuts defaults. The keys used by the read-only shortcuts will be unusable in user-parametrable shortcuts from the same group.

User-parametrable shortcuts
: They are either focusing actions, targeting a control, a module or a toolbox, or direct action triggers, like any action from the global menu.
    - __Edit a shortcut__ : double click on the shortcut label, or on the _disabled_ label, in the _keys_ column, then type the keys you want to define as a shortcut. To stop recording keystrokes, you can either hit <kbd>Escape</kbd> or click outside the _keys_ column (which may be more reliable).
    - __Clear a shortcut__ : double click on the trashbin icon, on the right of the shortcut. There is no way to clear a shortcut once in editing mode.
: After a shortcut has been edited, it will be used without having to restart the application. If the shortcut applies to a menu entry, it should be updated in the menu too.

The shortcuts popup window has __a double search-engine__:

- one __for features__, that performs a case-insensitive search into action pathes,
- one __for keys__, allowing to search for key modifiers, or keys, or combinations of both:
    - if only a key modifier or key is given, results will be returned for partial matches,
    - if both a key and a modifier are given, results will be returned for full matches,
    - the syntax for key combinations is `<Mod1><Mod2>Key`, where all elements are optional. Auto-completion is provided for modifiers when you start typing `<`.
- __features and key searches can be combined__ to efficiently narrow results,
- as long as any search entry is not empty, the shortcut treeview is expanded. To automatically expand all items while not searching anything in particular, you can input `/` into the feature search entry.

### Vimkey-like, global action search

All the available actions can be searched and triggered from anywhere in the software, using a vimkey-like command with auto-completion. The feature is available from the global menu, under _Help_ → _Search actions_ (default shortcut : <kbd>Ctrl</kbd>+<kbd>P</kbd>).

{{< figure src="/actions-search.jpg" caption="The action search" />}}

This opens a modal popup with a search entry. Type in there a path (partial or complete) or simply the name of the action you are looking for. The auto-completion will return the list of all available actions matching your search from the currently-active shortcut groups, along with a description and their defined shortcut (if any). From there, by selecting one of the results (with mouse click, or navigating with arrow keys then hitting <kbd>Enter</kbd>), you will trigger the action. To cancel, hit <kbd>Escape</kbd>.

In this context, the action pathes become commands that can be triggered from the search popup without having to define shortcuts, which helps if you know __what__ action you want to trigger but don't remember __where__ its controller is in the GUI, or simply if you can't be bothered remembering shortcuts.

In darkroom, if you select in the global action search the path to a control (slider or combobox) within a module, the focusing action will open the parent module, scroll it such that it gets visible, make sure the control is visible (like changing the notebook page if the control is within a notebook/tabs) and focus the control. From there, you can keep interacting with the control through arrow keys to change its value.

This feature has also replaced the module search bar used since Darktable 3.6, because triggering the focus action on a module achieves the same result as restricting the list of modules to those matching a name query (making this module appear in GUI).

## Keyboard workflow

### Global menu

All menues have mnemonics that can be shown by hitting <kbd>Alt</kbd> : they will then appear underlined. Hitting the underlined letter along with <kbd>Alt</kbd> will open the target menu. Once one menu is opened, you can navigate through all menues using arrow keys.

### Lighttable

#### Toolboxes

You can collapse/expand the toolboxes, in the left sidebar, by assigning them shortcuts or using the global action search on their focusing action. The effect of the focusing action is a toggle, so expanded toolboxes will be collapsed on the next action trigger.

Once a control has gained focus in a toolbox (which, so far, can only happen with a click), focusing on the next control can be done with <kbd>Tab</kbd> or using the arrow keys (in some situations). Otherwise, the focus is automatically given to the thumbtable (grid of thumbnails).

#### Thumbtable

Navigation within thumbnails can be done with arrow keys. <kbd>PageUp</kbd>/<kbd>PageDown</kbd> scroll the view to the previous/next page. <kbd>Home</kbd>/<kbd>End</kbd> move all the way to the start/end of the grid.

Navigation within thumbnails only hovers. To commmit the hovered thumbnail to a selection, press <kbd>Space</kbd> for a singleton selection. To add/remove the hovered thumbnail to/from the current set of selected images, press <kbd>Ctrl</kbd>+<kbd>Space</kbd>. To extend the current selection up to the hovered thumbnail (range selection), press <kbd>Shift</kbd>+<bkd>Space</kbd>.

A selection is absolutely mandatory to be able to modify image metadata, such as ratings (stars), color labels, etc. or to apply any batch operations. Ansel is designed such that selections can only be made by "hard" interactions (pressing an hardware button), as to prevent user errors. Batch selection options, independent from the thumbtable, can be found in the global menu, under _Selection_.

Applying ratings uses the numeric keys (0-5) by default, applying color labels uses the F1-F6 keys.

Opening a picture in darkroom is done with <kbd>Enter</kbd>.

#### Filters

You can filter the current collection by text using the search entry, which will search into all text metadata of the image. To enter the search entry, the default shortcut is <kbd>Ctrl</kbd>+<kbd>F</kbd>.

### Darkroom

#### Modules

To collapse/expand and focus a module, you can:

- hit <kbd>Alt</kbd> and see the mnemonic keys that some module have in their name, then type the mnemonic. This works only for visible modules.
- use the action search or define a shortcut on the module focusing action. This works also for hidden modules.

The module focusing action will automatically :

1. open the native module tab of this module,
2. expand and focus the module,
3. scroll the right sidebar such that at least the header of the module (if not the whole module) is visible,
4. collapse and fade out all other modules,

The user-defined set of favourite modules, that used to be displayed in a separate tab, is replaced by the ability to target a specific module through its focusing action.

To expand+focus the previous/next module in the current module tab, use <kbd>Page Up</kbd>/<kbd>Page Down</kbd>.

To switch to the next/previous module tab, use <kbd>Ctrl</kbd>+<kbd>Tab</kbd> and <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>Tab</kbd>. Once you reached one end of the modules tabs, it will cycle back to the other end.

#### Modules controls

To go directly to a control (slider or combobox), use the action search or define a shortcut to its focusing action. This will automatically:

1. open the native module tab of this module,
2. expand and focus the module,
3. scroll the right sidebar such that at least the header of the module (if not the whole module) is visible,
4. collapse and fade out all other modules,
4. open the right notebook (tab) page if the control is insterted into a notebook,
5. focus the control.

Once the control is focused:

- on sliders:
    - arrow keys <kbd>Left</kbd>/<kbd>Right</kbd> will increase/decrease the value by a normal step,
    - <kbd>Ctrl</kbd>+ arrows change the value using a fine step,
    - <kbd>Shift</kbd>+ arrows change the value using a coarse step,
    - <kbd>Insert</kbd> triggers the attached color-picker if any.
- on comboboxes:
    - arrow keys <kbd>Up</kbd>/<kbd>Down</kbd> will cycle through the options,
    - <kbd>Enter</kbd> validates the selected option and closes the popup,
    - <kbd>Escape</kbd> exits the popup without validating the selected option.

Once a control is focused, you can focus to the previous/next with <kbd>Up</kbd>/<kbd>Down</kbd> keys, or <kbd>Tab</kbd>. To focus the previous/next control outside a notebook tab, when you reached the end of the current notebook page, use <kbd>Ctrl</kbd>+<kbd>Up</kbd>/<kbd>Down</kbd>.

Once a shortcut is attached to a control (slider or combobox) focusing action, as long as the shortcut keys are kept pressed, all mouse scrolling events are sent to this control even when the mouse is not over the widget (as it would normally require to record scrolling events). This allows a 2-hands mixed workflow where one hand, on the keyboard, selects the target control, while the other scrolls on the mouse to adjust the value. It replaces MIDI support that achieves the same through mapping exactly one potentiometer to exactly one control, which will quickly run out of knobs to control Ansel.

#### Module instances

When several instances of modules are in use, shortcuts are always attached to the first-added instance, which may not necessarily be the first in the pixel pipeline: the first instance is always the unnamed, base instance, until it gets deleted (then the next replaces it).[^1]

[^1]: The recommended workflow always uses the first instance as an average global setting, most likely to be accessed from keyboard for quick adjustments. Later instances are supposed to be local, often using masks, for which keyboard setting will not be enough if possible at all.

All module instances that have an instance name set will get a private focusing action attached to the module (but none attached to its controls), using a path prefixed with `Modules/Instances/` and followed by `Module name/Instance name`. Since instance names are a property of each editing history, and not constant during the lifecycle of the whole application, this focusing action cannot be assigned a key shortcut and is accessible only from the global action search.

When renaming the base instance of a module, it gets its own `Modules/Instances/` focusing action, but this is only a duplicate of the default one from `Modules/`, and it doesn't change the behaviour of the default actions (focusing the module and its controls).

## System integration

Certain shortcuts are already reserved by your operating system and desktop environment. It may be a good idea to let the OS listen and decode those before they are passed on to Ansel (in which case, they are consumed and never passed on). To do so, go into the [Preferences](../preferences-settings/miscellaneous.md) popup, to _miscellaneous_, and check the box _let the OS mask Ansel shortcuts_.

## Key variants and alternatives

The numpad key alternatives (digits, enter, delete, home, end, insert, page up/down, arrows) are decoded as the non-numpad alternatives by all shortcuts, which means numbers will be seen as the same object no matter where they are typed. They respond to numlock as they should (numlock on enables digits and arithmetic operators, numlock off enables navigation).

Ansel allows single-key shortcuts, without modifier, which is non-standard and may cause issues with some keys. For this reason, shortcuts are temporarily disabled when a text entry is active. If that causes issues on your system, consider using typical double-key shortcuts (with a modifier).
