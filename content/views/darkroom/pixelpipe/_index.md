---
title: The pixelpipe
date: 2022-12-04T02:19:02+01:00
lastmod: 2026-06-17
id: pixelpipe
weight: 30
draft: false
author: "people"
---

The **pixelpipe** is the ordered sequence of [processing modules](../modules/_index.md) that turns your original RAW file into the image you see and export. Each module takes the output of the previous one as its input, applies one operation, and hands its result to the next module — exactly like a stack of adjustment layers, applied from the bottom up.

```mermaid
flowchart LR
    RAW([RAW file]) --> M1[module 1] --> M2[module 2] --> M3[module n] --> OUT([output image])
```

Nothing is ever written back to your original file: the pixelpipe is re-run on demand from the RAW plus your [history stack](history-stack.md), both for the on-screen preview and for the final [export](../../toolboxes/export.md).

This section explains the concepts behind that process:

- [The anatomy of a processing module](the-anatomy-of-a-module.md) — what a single module is and the controls it shares with every other module.
- [The pixelpipe & module order](the-pixelpipe-and-module-order.md) — why the order matters, the scene-referred workflow, and how to inspect or change the order.
- [The history stack](history-stack.md) — how your edits are recorded.
- [Undo and redo](undo-redo.md).

## Why Ansel stays responsive

You do not need to understand the internals to use the darkroom, but one design choice is worth knowing because it shapes how the darkroom feels: **Ansel caches the output of every module and only recomputes what actually changed.**

Each module's output is stored under a fingerprint of everything it depends on (its parameters, its mask, the image region, the modules before it). When you change a setting, only that module and the ones **after** it in the pipe are recomputed — everything before it is reused from the cache.

```mermaid
flowchart LR
    A[module 1] --> B[module 2] --> C["module 3 ✏️<br/>(changed)"] --> D[module 4] --> E[module 5]
    classDef cached fill:#2d6,stroke:#161,color:#000;
    classDef recomp fill:#f95,stroke:#a40,color:#000;
    class A,B cached;
    class C,D,E recomp;
```

In the diagram above, editing module 3 only recomputes modules 3 to 5 (orange); modules 1 and 2 (green) are served instantly from the cache. The same logic means that toggling a module on/off, using a [color picker](../../toolboxes/scopes.md), or re-exporting an image you already exported does not rebuild the whole pipeline. In practice this makes Ansel several times to several **dozens** of times faster than recomputing everything, which is what makes a heavy edit still feel interactive.
