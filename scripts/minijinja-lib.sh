#!/usr/bin/env bash
# Sourced by the scripts that render templates. minijinja-cli, a Rust template tool, is the one engine here:
# no Go templates, no shell substitution. mj checks that the pinned version is on PATH, and renders strictly: an
# undefined variable is an error, autoescape is off, and templates can't include other files.
#   mj TEMPLATE [DATA_FILE] [-D key=value]...
# Install: cargo install minijinja-cli --version 3.0.1 --locked
# Bump through a reviewed PR.
MINIJINJA_VERSION="3.0.1"
mj() {
  local have
  have="$(minijinja-cli --version 2>/dev/null)" || {
    echo "minijinja-cli not found: cargo install minijinja-cli --version $MINIJINJA_VERSION --locked" >&2
    return 2
  }
  [ "$have" = "minijinja-cli $MINIJINJA_VERSION" ] || {
    echo "need minijinja-cli $MINIJINJA_VERSION, found: $have" >&2
    return 2
  }
  minijinja-cli --strict --autoescape none --no-include "$@"
}
