#!/usr/bin/env bash
#
# Link every skill in skills/ into each agent's global skills directory.
# Safe to re-run. Skips agents that aren't installed and never replaces a real
# directory with a link.
set -euo pipefail

repo="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
targets=("$HOME/.claude/skills" "$HOME/.codex/skills")

for target in "${targets[@]}"; do
  [ -d "$(dirname "$target")" ] || continue
  mkdir -p "$target"
  for skill in "$repo"/skills/*/; do
    dest="$target/$(basename "$skill")"
    if [ -e "$dest" ] && [ ! -L "$dest" ]; then
      echo "skip $dest: exists and is not a link" >&2
      continue
    fi
    ln -sfn "${skill%/}" "$dest"
    echo "linked $dest"
  done
done
