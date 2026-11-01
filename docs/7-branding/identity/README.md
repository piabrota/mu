---
title: Identity
status: accepted
date: 2026-11-01
related: [tokens.css, tokens.json]
style: guide
---

# Identity

The piabrota design language, in [`tokens.css`](tokens.css) and [`tokens.json`](tokens.json). It follows
the rules of [piabrota.art's site](https://github.com/piabrota/nix-os/blob/main/site/DESIGN.md): a dark
sheet, one red, and every state said in words before colour. Dark mode comes first; light mode is
equally supported.

## Palette

| Token | Dark (default) | Light | Use |
| --- | --- | --- | --- |
| `bg` | `#0B0D12` | `#FFFFFF` | page background |
| `surface` | `#14171F` | `#F4F5F7` | panels, code, sidebars |
| `border` | `#2A303C` | `#D8DCE3` | dividers and outlines |
| `text` | `#EDEFF3` | `#0B0D12` | body text |
| `muted` | `#9AA3B2` | `#4F5868` | secondary text |
| `accent` | `#BC2318` | `#BC2318` | the logo's red |
| `accent-text` | `#FF6B5E` | `#A51D14` | the same red where it must be read, such as links |
| `on-accent` | `#FFFFFF` | `#FFFFFF` | text and icons on an accent fill |
| `ok` | `#3FB950` | `#1A7F37` | passed status |
| `warn` | `#D29922` | `#9A6700` | warning status |
| `crit` | `#F85149` | `#CF222E` | failed status |

## Type

- Fjalla One for titles, headings and the brand.
- Inter for prose and interface text.
- JetBrains Mono for code and data.

Fonts load from Google Fonts; no font file is stored here.
