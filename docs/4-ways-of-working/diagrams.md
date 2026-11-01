---
title: Plots and mockups
status: accepted
date: 2026-11-01
related: [docs-standard.md, ../../DOGMA.md]
style: procedure
---

# Plots and mockups

[Dogma 6](../../DOGMA.md) sets one tool for each, so anyone can reproduce the result. Don't use Mermaid,
D2 or a hand-drawn SVG.

## Plots: archify

Every plot is drawn with archify, from the fork pinned in [`forks/archify`](../../forks/archify).

1. Write the source in `docs/archify/<slug>.json`.
2. Run `scripts/figure.sh draw`. It validates the source, applies piabrota's look
   (`docs/archify/piabrota.css`) and writes `docs/img/<slug>.png`. It needs node, jq, perl and Chrome.
3. Show the PNG in a doc, with alt text that says what the figure says.
4. Add a reading card under it: how to read the figure, and its source.
5. If the page has empty space below the drawing, set its height in `docs/archify/crop.tsv`.

`scripts/figure.sh check` runs offline. It fails when a PNG is missing, no doc shows it, or a source, the
look or the archify pin changed since the last draw.

To bump archify, change the submodule's commit in its own pull request, then draw every figure again.

## Mockups: OpenPencil

Every mockup is an OpenPencil `.fig` file in `docs/mockups/`, or beside the product it designs. Commit
the `.fig` file and its exports together.

Agents reach OpenPencil through its MCP server, pinned as `@open-pencil/mcp@0.16.0`, limited to the
mockups folder with `OPENPENCIL_MCP_ROOT`. A mockup is a draft: the code stays the source of truth.

No mockup exists in this repo yet.
