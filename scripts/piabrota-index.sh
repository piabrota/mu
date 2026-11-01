#!/usr/bin/env bash
# Render PIABROTA.md, the index of the org's public repos, from scripts/piabrota/repos.toml with minijinja-cli.
# The data is written by hand after reading the repos; private repos are never listed. Agent-run.
#   piabrota-index.sh           write PIABROTA.md
#   piabrota-index.sh --check   exit 1 when PIABROTA.md is stale, and write nothing
set -euo pipefail
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=scripts/minijinja-lib.sh
source "$HERE/minijinja-lib.sh"
OUT="$HERE/../PIABROTA.md"
new="$(mj "$HERE/templates/piabrota/PIABROTA.md.j2" "$HERE/piabrota/repos.toml")"
case "${1:-}" in
  --check)
    if [ "$new" = "$(cat "$OUT" 2>/dev/null)" ]; then echo "PIABROTA.md is fresh"
    else echo "PIABROTA.md is stale: run scripts/piabrota-index.sh" >&2; exit 1; fi ;;
  '') printf '%s\n' "$new" >"$OUT" ;;
  *) echo "usage: piabrota-index.sh [--check]" >&2; exit 2 ;;
esac
