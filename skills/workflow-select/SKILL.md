---
name: workflow-select
description: "Select and launch the appropriate single- or multi-agent workflow for a coding request. Use when a user asks how to organize, launch, or coordinate coding agents."
---

# Select an agent workflow

Classify the request on two axes: one or many independent tasks, and simple or
complex planning needs.

| Shape | Use |
|---|---|
| One simple task | `workflow-single-simple` |
| One complex task | `workflow-single-complex` |
| Several simple tasks | `workflow-multi-simple` |
| Several complex task groups | `workflow-multi-complex` |

Treat a task as complex when it has material design choices, broad file impact,
unfamiliar code, a migration, security implications, or meaningful dependency
risks. Treat tasks as separate only when their file ownership and contracts can
be made independent.

Before launching any workflow that needs confirmation, show the selected shape,
the role roster, communication medium, provider, resolved models, and requested
reasoning levels. Resolve each role with:

```text
agent-role resolve <provider> <role>
```

Ask for confirmation before launching `single_complex`, `multi_simple`, or
`multi_complex`. A clear user launch instruction activates planners. Workers
start only after their parent gives them a complete implementation brief.

Use `claude-code harness` only when its direct agent messaging is available.
Its routine communication remains automatic. Otherwise use `default
polyscope`: give the user one copy-ready message with absolute paths and never
poll or automatically read a memo. A memo may hold durable context when a
prompt explicitly points to its absolute path.

Use the selected workflow skill for the detailed roster and authorization
rules. Load `polyscope-launch` before creating a Polyscope workspace.
