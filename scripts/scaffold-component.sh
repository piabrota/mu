#!/usr/bin/env bash
# Write the scaffold of a new piabrota Rust component into a clone of its repo: Cargo.toml, src/lib.rs, the
# toolchain pin, a justfile, README sections, AGENTS.md, docs/architecture.md, the devcontainer and .gitignore,
# rendered by minijinja-cli from templates/rust-component/.
# The repo must hold new-repo.sh's first commit. Never overwrites a file, and
# appends its sections to the README.md that commit holds. The architecture doc's
# Responsibilities and Depends on are left for a person to write; then commit on a
# branch and open a PR. Agent-run.
#   scaffold-component.sh [--mit-templates] <repo> "<job sentence>" <clone dir>
# --mit-templates also adds an MIT-licensed templates/ folder, for repos whose templates are copied
# into products.
set -euo pipefail
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TPL="$HERE/templates/rust-component"
# shellcheck source=scripts/minijinja-lib.sh
source "$HERE/minijinja-lib.sh"
MIT="$HERE/../../asgard/LICENSES/MIT.txt"   # the side-by-side asgard clone holds the MIT text
# Bump through a reviewed PR. The image must be at least two weeks old when pinned.
RUST_VERSION="1.99.0"
RUST_IMAGE="docker.io/library/rust:$RUST_VERSION-bookworm@sha256:114c7a4425406451c2866b6aafe69fe29b1b298832db1277d411ac73c82d04d6"
die() { echo "scaffold-component: $*" >&2; exit 2; }

mit=false
if [ "${1:-}" = --mit-templates ]; then mit=true; shift; fi
[ $# = 3 ] || die 'usage: scaffold-component.sh [--mit-templates] <repo> "<job sentence>" <clone dir>'
r="$1"; job="$2"; d="$3"
[[ "$r" =~ ^[a-z0-9][a-z0-9-]*$ ]] || die "bad repo name: $r"
[ -n "$job" ] || die "the job sentence is empty"
[ -d "$d/.git" ] && [ -f "$d/REUSE.toml" ] && [ -f "$d/LICENSES/MPL-2.0.txt" ] \
  && grep -qF 'repo: https://github.com/gitleaks/gitleaks' "$d/.pre-commit-config.yaml" 2>/dev/null \
  && [ "$(head -n1 "$d/README.md" 2>/dev/null)" = "# $r" ] \
  || die "$d doesn't hold new-repo.sh's first commit"
if [[ "$r" == *-* ]]; then title="$r"; else title="$(printf %s "${r:0:1}" | tr '[:lower:]' '[:upper:]')${r:1}"; fi

# template -> destination
FILES=(Cargo.toml.j2:Cargo.toml lib.rs.j2:src/lib.rs rust-toolchain.toml.j2:rust-toolchain.toml
  justfile.j2:justfile AGENTS.md.j2:AGENTS.md architecture.md.j2:docs/architecture.md
  devcontainer.json.j2:.devcontainer/devcontainer.json gitignore.j2:.gitignore)
$mit && FILES+=(templates-README.md.j2:templates/README.md)
for f in "${FILES[@]}"; do [ ! -e "$d/${f#*:}" ] || die "$d/${f#*:} exists; nothing was written"; done
if $mit; then
  [ ! -e "$d/LICENSES/MIT.txt" ] || die "$d/LICENSES/MIT.txt exists; nothing was written"
  [ -f "$MIT" ] || die "no MIT text at $MIT"
fi

render() { # render TEMPLATE: prints it with its variables filled; a value is never rendered again, so the job stays as is
  mj "$TPL/$1" -D "repo=$r" -D "title=$title" -D "date=$(date +%F)" -D "job=$job" \
    -D "rust_version=$RUST_VERSION" -D "rust_image=$RUST_IMAGE"
}
for f in "${FILES[@]}"; do
  mkdir -p "$(dirname "$d/${f#*:}")"
  render "${f%%:*}" > "$d/${f#*:}"
done
render README.md.j2 | tail -n +4 >> "$d/README.md"   # the stub keeps its title and description
if $mit; then
  cp "$MIT" "$d/LICENSES/MIT.txt"
  cat >> "$d/REUSE.toml" <<'EOF'

[[annotations]]
path = ["templates/**"]
precedence = "closest"
SPDX-FileCopyrightText = "2026 piabrota contributors"
SPDX-License-Identifier = "MIT"
EOF
fi
echo "Scaffolded $r in $d."
echo "Next: write the Responsibilities and Depends on sections of docs/architecture.md,"
echo "then commit on a branch and open a PR through as-bot.sh."
