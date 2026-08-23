# AGENTS.md

Guidance for AI agents (and human contributors) working on this repository, the source for the [Ansel user manual](https://ansel.photos/en/doc). This file distills the project's own documentation philosophy from [Documenting Ansel](https://ansel.photos/en/contribute/documenting/) into concrete rules for this codebase.

## What this repo is

A [Hugo](https://gohugo.io/) static site. Source content lives in `content/` (English, the canonical language); translations live as `.po` files under `po/`. There is no local theme/shortcode source in this repo — shortcodes such as `note`, `warning`, `figure`, `table`, `gallery`, and `relref` come from the Hugo module configured in `config.yaml`; don't try to invent new ones without checking whether an existing one already covers the need.

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

**Module pages** (`content/views/darkroom/modules/*.md`):
1. One or two short paragraphs of intro right after the frontmatter: what the module does and when to reach for it (no heading).
2. Optional context/theory sections if the module needs background to use well (e.g. `## Introduction`, `## General principles`, `## Prerequisites`) — use footnotes for any cited sources.
3. `## Workflow` — **required**, not optional: a concrete, usually numbered, recommended procedure for getting good results with the module (what order to touch the controls in, what to do before/after, what to combine it with). This is the practical "how do I actually use this" answer that `## Module controls` alone doesn't give — every module page should have one, even a short one, unless the module truly has only one control and no meaningful order of operations.
4. `## Module controls` — by far the most common heading in this section of the manual; walk through the module's actual UI controls here (often as a definition list, see below).
5. Optional closing sections as needed: `## Caveats`, `## Tips and tricks`, `## Practical guidance`.

Most existing module pages predate this requirement and don't have a `## Workflow` section yet — add one when writing a new module page, and when substantially editing an existing one that's missing it.

**Index/section pages** (`_index.md`, e.g. `content/views/toolboxes/_index.md`):
1. One or two intro paragraphs explaining what this category of page covers and how it relates to neighboring categories (with links).
2. A `{{< note >}}` for any important caveat about scope (e.g. what moved elsewhere, what's out of scope).
3. A `## Working with X` section for interactions that apply across the whole category.
4. One `##`/`###` section per logical grouping, each holding a short bullet list of links to the child pages with a one-line description — this is the primary place that makes child pages discoverable, so don't skip it when adding a new child page.

**Preference/setting reference pages** (`content/preferences-settings/*.md`):
1. A one-line intro linking to the relevant view/feature.
2. `##` sections grouping related settings (e.g. `## General`, `## Modules`).
3. Each setting as a Markdown definition list entry (term = setting name as it appears in the UI, definition = what it does, including the default value), per the existing "Structure and formatting conventions" below.

## Documentation style

Ansel runs on **Linux, Windows, and macOS**, and the manual is read by users of all three — write with a cross-platform audience in mind by default:

- Don't assume Linux or a particular desktop environment. Phrase instructions platform-neutrally where behavior is identical, and call out platform differences explicitly where it isn't (paths, package managers, install steps, etc. — see the existing per-OS callouts in `content/install/`).
- Avoid OS-specific screenshots when the UI is identical across platforms; if you do include one, don't imply it's the only look.

**Keyboard shortcuts** must be given for all three platforms, not just Linux/Windows. On macOS, <kbd>Ctrl</kbd> is conventionally replaced by the primary modifier <kbd>⌘</kbd> — always write the ⌘ symbol, never the word "Cmd", whether in running prose (e.g. "press ⌘+Z to undo") or in a rendered key combination. When documenting a shortcut:

- Spell out both bindings explicitly with `<kbd>` tags rather than leaving macOS to be inferred:
  - Linux/Windows: `<kbd>Ctrl</kbd>+<kbd>Z</kbd>`
  - macOS: `<kbd>⌘</kbd>+<kbd>Z</kbd>`
- Other modifiers (<kbd>Shift</kbd>, <kbd>Alt</kbd>/<kbd>Option</kbd>) should also be given per platform where they differ.
- If a shortcuts table/list is being written, prefer a layout with separate columns (or rows) for Linux/Windows vs. macOS rather than a single ambiguous column.

## Structure and formatting conventions

- **Sections**: use `##` (h2) headings to break up a page — Hugo auto-generates a right-sidebar table of contents from `<h2>` (and down to level 3, per `config.yaml`). Don't rely on `#`/h1 for in-page sections; the title from frontmatter already serves that role.
- **Definition lists**: for preference/setting reference pages, the established pattern is a Markdown definition list — the setting name as the term, a colon-indented description as the definition (see `content/preferences-settings/darkroom.md`). Follow this pattern for new settings rather than bullet lists.
- **Callouts**: use the `{{< note >}}...{{< /note >}}` and `{{< warning >}}...{{< /warning >}}` shortcodes for asides and caveats — don't fake these with blockquotes or bold text.
- **Screenshots/figures**: use the `{{< figure src="..." caption="..." />}}` shortcode, not raw `![]()` Markdown image syntax, so captions and styling stay consistent.
- **Keyboard keys**: wrap key names in `<kbd>` tags — see "Documentation style" above for the cross-platform (Linux/Windows/macOS) convention.
- **Emphasis conventions**: italics (`_..._`) for introducing a term or naming a UI concept inline, bold (`__...__`) sparingly for strong emphasis — follow the existing balance in nearby pages rather than over-emphasizing.
- **Cross-references**: prefer relative Markdown links to other content files for stability; use `{{< relref >}}` where the existing pages do (e.g. linking across language/section boundaries).
- **Tables**: use the `{{< table >}}` shortcode where existing pages do (for anything beyond a trivial Markdown table), for consistent styling.

## Citations

If a claim benefits from an external/scientific source, use Markdown footnote syntax with numeric references, and prefer a DOI or other long-term-stable URL over an ephemeral link. Follow IEEE-style citation formatting for the reference list.

## Language and translations

- **English (`content/`) is the source of truth.** Translations are maintained separately as `.po` files under `po/` — do not hand-edit translated content pages to fix an English wording issue; fix it in the English source.
- Keep sentences reasonably self-contained and avoid idioms that are hard to translate, since this content flows into a `.po`-based translation pipeline covering many languages.

## Before writing or editing a page

1. Check whether the concept already has a page — link to it instead of duplicating an explanation.
2. Check what section/weight it belongs in, and whether existing sibling pages set a pattern (frontmatter fields, heading structure, definition-list vs. prose) worth following.
3. After writing, add links *to* the new page from related existing pages where it genuinely helps navigation — a page that nothing links to is much harder to discover.
4. If the page answers a question that repeatedly comes up (e.g. on the forum), consider whether it should also be linked from a higher-level overview/FAQ-style page, not just buried in a subsection.
