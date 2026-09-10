---
name: project-docs
description: Where to keep lasting project notes, with dated work logs in docs/work and notes for whoever picks up the work in docs/notes. Load when recording progress, decisions, or findings, or when pausing or ending work someone else will continue.
---

# Project docs

Keep lasting notes in the project's `docs/` directory and commit them with the
work. Start each file name with the date (`yyyy-mm-dd-`) and follow it with a
short kebab-case topic, so a folder lists in order and is easy to scan.

- `docs/work/yyyy-mm-dd-<topic>.md`: thoughts, progress, and decisions, written
  as the work goes.
- `docs/notes/yyyy-mm-dd-<topic>.md`: notes for whoever picks the work up next.
  Say where things stand, what's left, and what's still open.

These aren't the `.context/` files used in multi-agent work. Those carry live
messages between agents (see agent-communication).
