#!/usr/bin/env bash
#
# Make this repository the source of every user-installed system-wide skill.
# Safe to re-run. Harness-owned hidden entries, such as Codex's .system
# directory, are left alone.
set -euo pipefail

repo="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
canonical_repo="$HOME/Projects/agents-skills"
targets=("$HOME/.claude/skills" "$HOME/.codex/skills")

if [ ! -d "$canonical_repo" ]; then
  echo "canonical skill repository is missing: $canonical_repo" >&2
  exit 1
fi

canonical_repo="$(cd "$canonical_repo" && pwd -P)"
if [ "$repo" != "$canonical_repo" ]; then
  echo "run the installer from the canonical checkout: $canonical_repo/install.sh" >&2
  exit 1
fi

# Refuse before changing anything if a visible entry is not a symlink. Removing
# a real directory automatically could destroy an independently installed skill.
for target in "${targets[@]}"; do
  [ -d "$(dirname "$target")" ] || continue
  [ -d "$target" ] || continue
  for entry in "$target"/*; do
    [ -e "$entry" ] || [ -L "$entry" ] || continue
    if [ ! -L "$entry" ]; then
      echo "unmanaged system-wide skill blocks installation: $entry" >&2
      exit 1
    fi
  done
done

for target in "${targets[@]}"; do
  [ -d "$(dirname "$target")" ] || continue
  mkdir -p "$target"

  # Remove links for skills that are no longer in this repository, regardless
  # of which checkout or source created them.
  for entry in "$target"/*; do
    [ -e "$entry" ] || [ -L "$entry" ] || continue
    name="$(basename "$entry")"
    if [ ! -d "$repo/skills/$name" ]; then
      rm "$entry"
      echo "removed $entry"
    fi
  done

  for skill in "$repo"/skills/*/; do
    dest="$target/$(basename "$skill")"
    source="${skill%/}"
    if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$source" ]; then
      echo "kept $dest"
      continue
    fi
    ln -sfn "$source" "$dest"
    echo "linked $dest"
  done
done
