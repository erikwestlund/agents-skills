#!/usr/bin/env bash
set -euo pipefail

source_repo="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
test_root="$(mktemp -d)"
temp_parent="$(cd "$(dirname "$test_root")" && pwd -P)"

cleanup() {
  case "$(cd "$test_root" && pwd -P)" in
    "$temp_parent"/*) rm -rf -- "$test_root" ;;
    *) echo "refusing to remove unexpected test directory: $test_root" >&2 ;;
  esac
}
trap cleanup EXIT

canonical_repo="$test_root/Projects/agents-skills"
mkdir -p "$canonical_repo" "$test_root/.claude/skills/unmanaged" \
  "$test_root/.codex/skills/.system" "$test_root/alternate"
cp "$source_repo/install.sh" "$canonical_repo/install.sh"
cp -R "$source_repo/skills" "$canonical_repo/skills"
cp "$source_repo/install.sh" "$test_root/alternate/install.sh"

ln -s /missing/retired "$test_root/.claude/skills/retired-skill"
ln -s /wrong/source "$test_root/.codex/skills/writing"
touch "$test_root/.codex/skills/.system/preserved"

# A real directory must stop the entire run before stale links are removed.
if env HOME="$test_root" "$canonical_repo/install.sh" \
  >"$test_root/preflight.out" 2>"$test_root/preflight.err"; then
  echo "expected unmanaged-directory preflight failure" >&2
  exit 1
fi
[ -L "$test_root/.claude/skills/retired-skill" ]
rmdir "$test_root/.claude/skills/unmanaged"

# A second checkout must not become a competing system-wide source.
if env HOME="$test_root" "$test_root/alternate/install.sh" \
  >"$test_root/alternate.out" 2>"$test_root/alternate.err"; then
  echo "expected alternate-checkout refusal" >&2
  exit 1
fi

env HOME="$test_root" "$canonical_repo/install.sh" >"$test_root/first.out"
canonical_repo="$(cd "$canonical_repo" && pwd -P)"

[ ! -L "$test_root/.claude/skills/retired-skill" ]
[ -f "$test_root/.codex/skills/.system/preserved" ]

for skill_root in "$test_root/.claude/skills" "$test_root/.codex/skills"; do
  for skill in "$canonical_repo"/skills/*/; do
    skill_name="$(basename "$skill")"
    [ "$(readlink "$skill_root/$skill_name")" = "${skill%/}" ]
  done
done

first_state="$(find "$test_root/.claude/skills" "$test_root/.codex/skills" \
  -mindepth 1 -maxdepth 1 -type l -exec sh -c \
  'for entry do printf "%s -> %s\n" "$entry" "$(readlink "$entry")"; done' sh {} + | sort)"

env HOME="$test_root" "$canonical_repo/install.sh" >"$test_root/second.out"

second_state="$(find "$test_root/.claude/skills" "$test_root/.codex/skills" \
  -mindepth 1 -maxdepth 1 -type l -exec sh -c \
  'for entry do printf "%s -> %s\n" "$entry" "$(readlink "$entry")"; done' sh {} + | sort)"

[ "$first_state" = "$second_state" ]
if grep -Eq '^(linked|removed) ' "$test_root/second.out"; then
  echo "second run changed the installation" >&2
  exit 1
fi

echo "install test passed"
