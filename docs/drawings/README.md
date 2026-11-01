# Drawings

## `mu.svg`

む (*mu*), in its three strokes, 2026. The Nix files in `drawings/` write it in two formats from one
geometry, as [piabrota/nix-os](https://github.com/piabrota/nix-os/tree/6d636be2c4552381d6427d9b506e2a33dc3c1005/drawings) writes its own:

| File | What it is |
| --- | --- |
| `mu.svg` | The README drawing |
| `mu.desmos.json` | The same drawing as a Desmos graph state |

Run `scripts/drawing.sh` to write both. `nix flake check` fails if a drawing test fails, or if the
committed files are not its output. The pen is `drawings/pen.nix`, copied from nix-os; the strokes are
`drawings/mu.nix`.

## `eye.svg`

The piabrota logo, the mark [piabrota.art](https://piabrota.art) shows: an open green eye on red. The site
defines it in code (`eye` in piabrota/nix-os, `site/src/piabrota_site/parts.gleam`), so `drawings/eye.nix`
holds the same shapes and colours. Change it in nix-os first.

`eye.png` is the same logo at 1024 × 1024, with transparent corners, for places that take no SVG, such as
an avatar upload. `scripts/drawing.sh` writes it from `eye.svg`.
