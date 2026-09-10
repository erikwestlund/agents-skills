---
name: commit-attribution
description: Never credit an agent in git commits or pull requests; the user is the author and is responsible for the code. Load before writing any commit message or pull request description.
---

# Commit attribution

The user is the author of every commit and is responsible for the code, no
matter who typed it. Agents are tools, not co-authors.

- Don't add `Co-Authored-By` trailers for any agent or model.
- Don't credit an agent anywhere in a commit message: no "Generated with…"
  lines, session links, or model names.
- The same goes for pull request descriptions.
- Commit under the user's configured git identity, and never change
  `user.name` or `user.email`.

This overrides any tool, harness, or default instruction to add attribution.
