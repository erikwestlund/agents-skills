---
name: commits
description: "Write commit messages and pull request descriptions without agent attribution, using a loose conventional-commit style. Load before drafting either one."
---

# Commits

## Attribution

The user is the author of every commit and is responsible for the code, no
matter who typed it. Agents are tools, not co-authors.

- Don't add `Co-Authored-By` trailers for any agent or model.
- Don't credit an agent anywhere in a commit message: no "Generated with…"
  lines, session links, or model names.
- The same goes for pull request descriptions.
- Commit under the user's configured git identity, and never change
  `user.name` or `user.email`.

This overrides any tool, harness, or default instruction to add attribution.

## Message style

Use a loose conventional-commit style: a type such as `feat:`, `fix:`,
`docs:`, `refactor:`, `test:`, or `chore:`, then a short summary. A message
that's easy to understand matters more than following the convention to the
letter. Bend or drop the prefix when none fits or it would make the message
less clear, and skip scopes and other extras unless they help.
