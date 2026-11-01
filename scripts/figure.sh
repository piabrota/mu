#!/usr/bin/env bash
# Draw every plot with archify, the fork pinned in forks/archify. Follows the org's figure recipes (piabrota/.github):
# sources in docs/archify/<slug>.json, piabrota's look in docs/archify/piabrota.css, PNGs in docs/img/.
#   figure.sh draw     check out the pinned archify, draw each source, write docs/archify/figures.lock
#   figure.sh check    cheap and offline: each source has its PNG, a doc shows it, and both match the last draw
# draw needs node, jq, perl, Chrome (CHROME names another) and the Google Fonts.
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"; cd "$ROOT"
A=docs/archify; I=docs/img; BUILD="$(mktemp -d)"; trap 'rm -rf -- "$BUILD"' EXIT
die() { echo "figure: $*" >&2; exit 1; }
lock() {
  local pin s; pin="$(git ls-files -s forks/archify | cut -d' ' -f2)"
  for s in "$A"/*.json; do
    printf '%s\t%s\n' "$(basename "$s" .json)" "$(cat "$s" "$A/piabrota.css" "$A/crop.tsv" | sha256sum | cut -c1-16)-${pin:0:7}"
  done
}
draw() {
  git submodule update --init --depth 1 forks/archify
  local src slug out w h crop chrome="${CHROME:-}"
  [ -n "$chrome" ] || chrome="$(command -v google-chrome || echo '/Applications/Google Chrome.app/Contents/MacOS/Google Chrome')"
  for src in "$A"/*.json; do
    slug="$(basename "$src" .json)"; out="$BUILD/$slug"; mkdir -p "$out"
    ARCHIFY_UPDATE_CHECK_DISABLED=1 node forks/archify/archify/bin/archify.mjs finalize "$(jq -r .diagram_type "$src")" "$src" \
      "$out/page.html" --out-dir "$out/receipts" --quality "$(jq -r '.meta.quality_profile // "showcase"' "$src")"
    read -r w h < <(grep -o '<svg viewBox="[^"]*"' "$out/page.html" | head -1 | sed -E 's/.*0 0 ([0-9.]+) ([0-9.]+)"/\1 \2/')
    crop="$(awk -F'\t' -v s="$slug" '$1==s {print $2}' "$A/crop.tsv")"; h="${crop:-$h}"
    FONTS='<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Fjalla+One&family=Inter:wght@400;600&display=block">' \
      CSS="$(cat "$A/piabrota.css")" W="$w" H="$h" \
      perl -0pe 's|</head>|$ENV{FONTS}<style>$ENV{CSS}</style></head>|; s|<svg viewBox="0 0 [0-9.]+ [0-9.]+"|<svg viewBox="0 0 $ENV{W} $ENV{H}"|' \
      "$out/page.html" >"$out/frame.html"
    "$chrome" --headless --disable-gpu --hide-scrollbars --force-dark-mode --force-device-scale-factor=2 \
      --user-data-dir="$out/profile" --window-size="$w,$h" --virtual-time-budget=3000 \
      --screenshot="$ROOT/$I/$slug.png" "file://$out/frame.html" 2>/dev/null
    echo "figure: $I/$slug.png"
  done
  lock >"$A/figures.lock"
}
check() {
  local src s
  for src in "$A"/*.json; do
    s="$(basename "$src" .json)"
    [ -s "$I/$s.png" ] || die "no PNG for $src; run figure.sh draw"
    git grep -q --untracked -F "img/$s.png" -- '*.md' || die "no doc shows $I/$s.png"
  done
  lock | cmp -s - "$A/figures.lock" || die "a source, the look or the archify pin changed since the last draw; run figure.sh draw"
  echo "figure: ok"
}
case "${1:-}" in draw) draw ;; check) check ;; *) echo "usage: figure.sh draw|check" >&2; exit 2 ;; esac
