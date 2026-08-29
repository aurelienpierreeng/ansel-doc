# AGENTS.md

Guidance for AI agents (and human contributors) working on this repository, the source for the [Ansel user manual](https://ansel.photos/en/doc). This file distills the project's own documentation philosophy from [Documenting Ansel](https://ansel.photos/en/contribute/documenting/) into concrete rules for this codebase.

## What this repo is

A [Hugo](https://gohugo.io/) static site. Source content lives in `content/` (English, the canonical language); translations live as `.po` files under `po/`. Shortcodes — `note`, `warning`, `figure`, `table`, `gallery`, `relref` — come from the theme, a Hugo module configured in `config.yaml`; don't invent new ones without checking whether an existing one already covers the need.

Every shortcode comes from the theme, including `param-table` and `icon`, which were written for these docs but live in `themes/ansel/layouts/shortcodes/` in the [ansel-website](https://github.com/aurelienpierreeng/ansel-website) repo. Nothing in this repo's `layouts/` reaches the published site: ansel-website imports this repo as a Hugo module with an explicit list of mounts (`content`, `assets`, `po`, `tools`), and Hugo drops a module's default mounts as soon as one is declared for it. A new shortcode therefore has to be added to the theme, in that repo; `layouts/` here is only for local-preview overrides, which the site never sees.

## Building the site locally

`hugo` (extended, matching the version in ansel-website's `.github/workflows/hugo.yml`) and `go` both have to be on `PATH` — Hugo shells out to `go` to resolve the theme module. Then `hugo server` from the repo root, or `hugo` for a one-shot build.

The theme is pinned by commit in `go.mod`. A shortcode added to `themes/ansel/` in ansel-website is invisible here until that pin moves, and the build then fails outright with `template for shortcode "<name>" not found`. Push the theme change first, then bump the pin:

```
hugo mod get github.com/aurelienpierreeng/ansel-website/themes/ansel@master
```

and commit the resulting `go.mod`/`go.sum`.

To iterate on the theme itself, `module.workspace: hugo.work` in `config.yaml` builds against a sibling `../ansel-website` checkout instead of the published module, so theme edits show up here without a commit / push / bump round trip. `hugo.work` is gitignored because it hard-codes that sibling path — which means the `module.workspace` line must not be committed either: a clone without the file fails immediately with `module workspace ... does not exist`. Keep the workspace enabled locally and out of what you push, and remember it also hides a stale pin, so re-check the build against the published module before pushing content that uses a new shortcode.

## Core philosophy: documentation is a graph, not a list

> "Knowledge is a network graph anyway. You just have to mind the links between the nodes. They are at least as important as the content."

Don't write pages as isolated feature descriptions. Every page should connect to the surrounding network of concepts:

- **Link liberally.** Any concept, module, view, or setting that has its own page should be a hyperlink to it, using relative Markdown links (see existing pages for the pattern, e.g. `[drawn mask](../views/darkroom/masking-and-blending/masks/drawn.md)`) or the `relref` shortcode where appropriate.
- **Connect tooling to goals.** Don't just describe what a widget does in isolation — link it to the workflow or use case it serves, and vice versa. Both "I want to understand this tool" and "I want to achieve this goal" are legitimate entry points, and pages should support readers coming from either direction.
- **Write for the reader's actual task.** Before writing or editing a page, consider: what does the reader already need to know (link those prerequisites), and what are they trying to do (quick reference vs. detailed how-to vs. conceptual/theoretical background)? Match depth and structure to that need rather than writing everything at maximum detail.

## Six ways readers find content

Keep all of these in mind, they are not just "nice to have":

1. **Chronological** — sequential, page-by-page reading (`weight` in frontmatter controls this order).
2. **Thematic** — the sidebar tree of nested sections/sub-folders.
3. **Transversal** — tags and cross-references linking related content across sections.
4. **Hint-based** — "more information" pointers and links to related pages.
5. **Source-based** — footnotes citing external references/publications.
6. **Search** — content should be phrased so it's findable (use the terms a user would actually search for, not just internal jargon).

When adding a page, don't only drop it into the tree — also consider whether it needs tags, cross-links from related pages, and a clear enough title/heading structure to be found by search.

## Frontmatter conventions (this repo)

Follow the existing pattern (see `archetypes/default.md` and existing content) rather than inventing a new schema:

```yaml
---
title: Page Title
date: YYYY-MM-DDTHH:MM:SS+TZ
id: page-id
weight: 50        # optional: controls manual ordering within a section
draft: false
tags:
    - tag1        # optional: for transversal/tag-based access
applicable-version: 3.8   # optional: on module pages, first version the feature shipped in
view: darkroom             # optional: on module/feature pages, which view it belongs to
masking: true               # optional: on module pages, whether masking & blending applies
---
```

- `weight` is how you control reading order within a section — use it deliberately when sequence matters (e.g. a getting-started flow), and omit it when alphabetical/date ordering is fine.
- `id` should be a stable slug; other pages may `relref` to it.
- Only add `tags` when they genuinely help cross-cutting discovery — don't tag every page with everything.

## Page structure

Beyond markup conventions, existing content follows a few recurring page anatomies depending on the kind of page. Match the one that fits rather than improvising a new layout:

**Index/section pages** (`_index.md`, e.g. `content/views/toolboxes/_index.md`):
1. A short, succinct opening paragraph giving the essential summary in one or two sentences (what this category of page is), followed by a more detailed paragraph elaborating on it and linking it to neighboring categories.
2. A `{{< note >}}` for any important caveat about scope (e.g. what moved elsewhere, what's out of scope).
3. A `## Working with X` section for interactions that apply across the whole category.
4. One `##`/`###` section per logical grouping, each holding a short bullet list of links to the child pages with a one-line description — this is the primary place that makes child pages discoverable, so don't skip it when adding a new child page.

**Module pages** (`content/views/darkroom/modules/*.md`):
1. A short, succinct opening paragraph giving the essential summary in one or two sentences (what the module does), followed by a more detailed paragraph elaborating on when to reach for it — right after the frontmatter, no heading.
2. Optional context/theory sections if the module needs background to use well (e.g. `## Introduction`, `## General principles`, `## Prerequisites`) — use footnotes for any cited sources.
3. `## Workflow` — **required**, not optional: a concrete, usually numbered, recommended procedure for getting good results with the module (what order to touch the controls in, what to do before/after, what to combine it with). This is the practical "how do I actually use this" answer that `## Module controls` alone doesn't give — every module page should have one, even a short one, unless the module truly has only one control and no meaningful order of operations.
4. `## Module controls` — by far the most common heading in this section of the manual; walk through the module's actual UI controls here (often as a definition list, see below).
5. Optional closing sections as needed: `## Caveats`, `## Tips and tricks`, `## Practical guidance`.

Most existing module pages predate this requirement and don't have a `## Workflow` section yet — add one when writing a new module page, and when substantially editing an existing one that's missing it.


**Preference/setting reference pages** (`content/preferences-settings/*.md`):
1. A one-line intro linking to the relevant view/feature.
2. `##` sections grouping related settings (e.g. `## General`, `## Modules`).
3. Each setting as a Markdown definition list entry (term = setting name, capitalized per "Spelling and capitalization" below even though the UI label itself is lowercase; definition = what it does, including the default value), per the existing "Structure and formatting conventions" below.

## Documentation style

**Spelling and capitalization:**

- Use correct English spelling and grammar throughout — proofread before committing.
- Capitalize the first letter of every sentence.
- Capitalize the first letter of parameter/setting names when naming them in the documentation, even where the Ansel UI itself displays the label in lowercase (e.g. write "Invert the direction of the mouse vertical/horizontal scroll", not "invert the direction..."). This applies to definition-list terms, inline mentions, and table entries alike. Existing pages predate this rule and mostly use the raw lowercase UI label — whenever you come across one, fix its casing to match this rule, even if that setting isn't otherwise the focus of your change.

Ansel runs on **Linux, Windows, and macOS**, and the manual is read by users of all three — write with a cross-platform audience in mind by default:

- Don't assume Linux or a particular desktop environment. Phrase instructions platform-neutrally where behavior is identical, and call out platform differences explicitly where it isn't (paths, package managers, install steps, etc. — see the existing per-OS callouts in `content/install/`).
- Avoid OS-specific screenshots when the UI is identical across platforms; if you do include one, don't imply it's the only look.

**Keyboard shortcuts** must be given for all three platforms, not just Linux/Windows. On macOS, <kbd>Ctrl</kbd> is conventionally replaced by the primary modifier <kbd>⌘</kbd> — always write the ⌘ symbol, never the word "Cmd", whether in running prose (e.g. "press ⌘+Z to undo") or in a rendered key combination. When documenting a shortcut:

- Spell out both bindings explicitly with `<kbd>` tags rather than leaving macOS to be inferred:
  - Linux/Windows: `<kbd>Ctrl</kbd>+<kbd>Z</kbd>`
  - macOS: `<kbd>⌘</kbd>+<kbd>Z</kbd>`
- Other modifiers (<kbd>Shift</kbd>, <kbd>Alt</kbd>/<kbd>Option</kbd>) should also be given per platform where they differ.
- If a shortcuts table/list is being written, prefer a layout with separate columns (or rows) for Linux/Windows vs. macOS rather than a single ambiguous column.

**Never compare Ansel to darktable** in regular feature/module/preference pages. Ansel is a fork, but it is documented on its own terms: describe what a feature does and how to use it, not how it differs from, improves on, or removes something from darktable, and don't editorialize about darktable's own choices. This keeps pages accurate and readable for users who have never used darktable, and it keeps that framing out of pages where it will silently rot as both projects diverge further. The narrow exceptions are the pages whose whole purpose is migration/compatibility — `content/install/darktable.md`, `content/from-darktable.md`, and "Coming from Darktable" `{{< note >}}` callouts pointing to where a relocated feature now lives — where a direct comparison is the point.

**Stay on the subject of the block.** A description of a control describes *that* control. Don't use it to explain a neighbouring setting, to restate what another entry in the same listing already covers, or to walk the reader through the panel — each entry is read on its own, in any order, and prose about anything else is noise where it sits. The exception is a genuine dependency the reader cannot act without: a control that does nothing until another is set, or whose meaning changes with it. Give that in one clause, name the other control and link to where it is documented, rather than explaining it a second time. Anything broader — how the panel fits together, what has to be switched on first, what the tool is for — belongs to the prose introducing the listing, where it is written once and read once.

**GUI elements: location, relocation, and removal.** Three distinct cases, handled three different ways — don't mix them up:

1. **Current/relocated element**: never state where a GUI element is *not* located. Don't write things like "no longer found in the Preferences dialog" or "used to be a toolbox module" — state directly and only where the element currently lives, with no reference to a past or absent location. This is an absolute rule with the same narrow exception as the darktable-comparison rule above: pages/callouts whose whole purpose is documenting differences with darktable (`content/install/darktable.md`, `content/from-darktable.md`, "Coming from Darktable" `{{< note >}}` callouts) may describe where something used to be, since that's the point of those pages. Outside that exception — including the many existing `{{< note >}}` callouts elsewhere that currently phrase a relocation this way — fix this pattern to a direct, present-location statement whenever you come across one.
2. **Deprecated but still present, for backward compatibility**: reserved for elements that still exist in the codebase and are deliberately kept visible so old edit histories keep reproducing the same result — e.g. a _legacy_ module version or the _legacy_ module order (see `content/views/darkroom/pixelpipe/the-pixelpipe-and-module-order.md`). It does not cover every conditionally-shown element, only ones intentionally retained for this reason. Say so explicitly with a `{{< warning >}}` or `{{< note >}}`: that it's kept for backward compatibility, since when, and what the current/non-legacy equivalent is.
3. **Removed outright from the source code** — no gating, just gone: **delete the paragraph/section entirely** rather than leaving a deprecation notice behind. There is nothing left to gate, and a stale "this is deprecated" note about something that no longer exists at all is just as inaccurate as leaving the original description in place.

## Structure and formatting conventions

- **Sections**: use `##` (h2) headings to break up a page — Hugo auto-generates a right-sidebar table of contents from `<h2>` (and down to level 3, per `config.yaml`). Don't rely on `#`/h1 for in-page sections; the title from frontmatter already serves that role.
- **Definition lists**: for preference/setting reference pages, the established pattern is a Markdown definition list — the setting name as the term, a colon-indented description as the definition (see `content/preferences-settings/darkroom.md`). Follow this pattern for new settings rather than bullet lists.
- **Callouts**: use the `{{< note >}}...{{< /note >}}` and `{{< warning >}}...{{< /warning >}}` shortcodes for asides and caveats — don't fake these with blockquotes or bold text.
- **Screenshots/figures**: use the `{{< figure src="..." caption="..." />}}` shortcode, not raw `![]()` Markdown image syntax, so captions and styling stay consistent — the one exception is a picture inside a `param-table` cell, where `figure` cannot be used (see *Illustrated listings* below). Two or more figures that belong side by side go in `{{< gallery cols="2" >}}`, which lays them out in a row at full width. Images live flat in `assets/` (or a subfolder of it, e.g. `mask/`) and are referenced by that path, with no leading slash; the theme generates the responsive `srcset` itself, so supply the full-resolution file. To constrain a figure, pass `width` and `height` together in the image's own ratio — `height` alone letterboxes it, and the `style` parameter is silently dropped by Go's contextual escaping. Three switches ride on the `class` parameter, and they combine — `class="framed align-left"`:

  - `framed` draws a hairline around the picture. Use it on **screenshots**: a shot of a panel, a menu or a dialog ends on its own light grey and bleeds into the page background, leaving the reader guessing where it stops. Leave it off photographs, diagrams and gradients, which have a subject of their own and only get boxed in by a frame.
  - `align-left` pins a picture narrower than the column to the left margin instead of centring it.
  - `borderless` drops the rules a figure draws above and below *itself* — the horizontal lines that set it apart as a plate — for an illustration that belongs to the sentence around it. Don't confuse it with `framed`, which is about the picture's own outline, not the figure's separators; the two are independent and can be used together.
- **Inline icons**: to name a button in the middle of a sentence, use `{{< icon src="..." alt="..." >}}`. The theme's render-image hook turns every `![]()` into a block `<figure>` with lightbox controls, which breaks the paragraph around it; `icon` emits a plain `<img>` scaled to the text (optional `height`, in em, defaults to 1.4). Every icon is framed and its corners rounded by the theme, the way `figure`'s `framed` class outlines a screenshot -- a button cropped out of the interface carries the panel's grey to its edges, so there is nothing to switch off and no `class` to pass. Reserve it for genuinely small images — a screenshot still belongs in a `figure`.
- **Keyboard keys**: wrap key names in `<kbd>` tags — see "Documentation style" above for the cross-platform (Linux/Windows/macOS) convention.
- **Mouse actions**: a click, scroll or drag is user input just as much as a keystroke, so it is a `<kbd>` too, with the `mouse` class: `<kbd class="mouse">Scroll</kbd>`. The theme draws it as an outline instead of Bootstrap's solid pad, with identical metrics, so the two read as one shortcut when mixed — `<kbd>Shift</kbd>+<kbd class="mouse">scroll</kbd>`. Tag the action only where it *names an input*, the way a listing does (`- <kbd class="mouse">Scroll</kbd>: diameter`); in running prose "click", "scroll" and "drag" are ordinary verbs and stay plain text. Modifiers keep their own `<kbd>`, per platform, as for any shortcut.
- **Emphasis conventions**: bold (`**...**`, the form used throughout the content) for **menu entries** — anything that appears as a line in a menu, including a parameter shown there as a slider — and, sparingly, for strong emphasis. Italics (`_..._`) for every other UI element named inline (tabs, buttons, checkboxes, panel settings, option values, status text) and for introducing a term. Within one menu, emphasize every entry the same way rather than splitting actions from parameters. Follow the existing balance in nearby pages rather than over-emphasizing.
- **Cross-references**: prefer relative Markdown links to other content files for stability; use `{{< relref >}}` where the existing pages do (e.g. linking across language/section boundaries).
- **Tables**: use the `{{< table >}}` shortcode where existing pages do (for anything beyond a trivial Markdown table), for consistent styling. It renders through `markdownify`, which loses the page context, so a relative `.md` link inside a cell collapses to the site root — put such links in the sentence introducing the table instead.
- **Menu and parameter listings**: use `{{< param-table >}}` rather than `table` or a bullet list. Write data rows only — it generates the header Markdown requires and then strips it, since the theme paints `<thead>` as an empty dark bar. Each row names the entry (bold, followed by any shortcut as `(or <kbd>Key</kbd>)`), then wraps the explanation in a bare `<div>` to indent it underneath. An optional leading column carries the submenu an entry sits in, on the same row as that submenu's first entry. Consecutive blocks butt together with no gap, so one menu can be split into several tables — submenu, then top level — and still read as a single listing. Unlike `table`, relative `.md` links work inside cells. Column count comes from the *widest* row, so a lone lead-in row above two-column rows is safe. A row may also span several source lines — anything not starting with `|` belongs to the row above. Such a cell is rendered as Markdown blocks of its own, so an explanation written as a list becomes a real `<ul>`, with the hanging indent a wrapping item needs; don't fake one with `-` and `<br>`. Raw Markdown gives a table row no way to span lines and silently spills the overflow out of the table, unbalancing the whole page's HTML — only `param-table` makes it safe.
- **Illustrated listings**: a trailing cell may hold a picture instead of text, one per entry, which the block lays out down the right-hand side — see the set operators in `content/views/toolboxes/shape-manager.md`. Write it as a plain Markdown image, `![](file.jpg "caption")`, **not** `{{< figure >}}`: nested shortcode output is spliced into the parent's `.Inner` before the table is parsed, and `figure`'s output spans several lines, which breaks the row apart and ejects the pictures out of the table. The Markdown image goes through the theme's `render-image` hook, which calls the very same partial as `figure`, so the markup, lightbox and `srcset` are identical. The one thing a Markdown image has nowhere to put is `figure`'s `class` parameter, so it rides in the URL as a `class=` query the hook strips off before looking the file up — `![](panel.png?class=framed)`, several classes joined by `+` as in `?class=framed+align-left`. The switches mean the same as on a `figure` (see *Screenshots/figures* above), and so does the rule for using them: `framed` on a screenshot, not on a diagram or a photograph. Such a block opts out of the theme's 36rem reading-width cap so the pictures reach the right margin; the text column stays capped, and the picture is centred in the space it leaves. `image-height` gives every picture in the block a uniform maximum height, which is usually wanted — without it each one fills its column:

  ```
  {{< param-table image-height="9rem" >}}
  | **Union**<div>Adds the shape to the mask.</div> | ![](union.jpg "union result") |
  {{< /param-table >}}
  ```

  The picture may also lead the row rather than close it — `| ![](wheel.png) | <div>...</div> |`. Which column is sized for what follows it: with a trailing picture the text column keeps the 36rem measure and the picture takes what is left, while a leading picture is given exactly the width it renders at (`image-height` applied to its own aspect ratio) so the explanation beside it gets every remaining pixel. Set `image-height` in that case — without it there is no width to size the column to, and the picture falls back to filling a share of the table.

  `margin-left` (any CSS length) indents a whole block, to nest a listing under the sentence or entry it belongs to, and `indent` overrides the 4rem the explanation `<div>` is set in by — `indent="0"` cancels it, for an explanation that already has a column to itself. The reading measure stays at 36rem either way.

For a menu, organize the listing around what the menu actually branches on — typically what is under the pointer, or which mode the user is in — rather than around an abstraction of your own, and give each case its own listing.

## Accuracy: stay in sync with the source code

This is user-facing documentation for a real, actively-developed application ([github.com/aurelienpierreeng/ansel](https://github.com/aurelienpierreeng/ansel)) — it must describe what Ansel *actually* does, not what it used to do or what seems plausible.

- Don't describe a control, default value, keyboard shortcut, preference, or behavior from memory, from an old version, or by analogy with darktable — verify it against the current source (or a current build/screenshot) when in doubt, especially for anything numeric (defaults, ranges) or anything likely to have changed recently.
- When a change in the source code (a new option, a renamed control, a changed default, a removed feature) makes a page inaccurate, update that page as part of the change rather than leaving it stale — for a relocated, deprecated, or removed GUI element specifically, see "GUI elements: location, relocation, and removal" under "Documentation style" above.
- If unsure whether current wording still matches the application, say so rather than guessing, and prefer checking the source over leaving an unverified claim.

## Citations

If a claim benefits from an external/scientific source, use Markdown footnote syntax with numeric references, and prefer a DOI or other long-term-stable URL over an ephemeral link. Follow IEEE-style citation formatting for the reference list.

## Language and translations

- **English (`content/`) is the source of truth.** Translations are maintained separately as `.po` files under `po/` — do not hand-edit translated content pages to fix an English wording issue; fix it in the English source.
- Keep sentences reasonably self-contained and avoid idioms that are hard to translate, since this content flows into a `.po`-based translation pipeline covering many languages.

## Before writing or editing a page

1. Check whether the concept already has a page — link to it instead of duplicating an explanation.
2. Check what section/weight it belongs in, and whether existing sibling pages set a pattern (frontmatter fields, heading structure, definition-list vs. prose) worth following.
3. Verify against the current source code rather than assuming — see "Accuracy" above.
4. After writing, add links *to* the new page from related existing pages where it genuinely helps navigation — a page that nothing links to is much harder to discover.
5. If the page answers a question that repeatedly comes up (e.g. on the forum), consider whether it should also be linked from a higher-level overview/FAQ-style page, not just buried in a subsection.
