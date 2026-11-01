#!/usr/bin/env bash
# Write the README drawings, docs/drawings/eye.svg, mu.svg and its Desmos state, from drawings/*.nix.
# nix flake check then fails if a drawing test fails or the committed files are not this output.
#   drawing.sh
set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")/.."
art="$(nix --extra-experimental-features 'nix-command flakes' build .#mu-art --no-link --print-out-paths)"
cat "$art/eye.svg" >docs/drawings/eye.svg
cat "$art/mu.svg" >docs/drawings/mu.svg
cat "$art/mu.desmos.json" >docs/drawings/mu.desmos.json
