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

Ask about previews only when the work requires testing a user's interaction
with the application, such as a UI flow, route behavior, form, or browser
journey. Do not ask for previews for backend, infrastructure, API, refactor, or
data-only work. When a preview applies, ask whether the user wants individual
task previews, a group preview while work is underway, or both. Recommend the
group preview for multi-agent work. The status report must name the exact
workspace and preview URL the user should open.

Use `claude-code harness` only when its direct agent messaging is available.
Its routine communication remains automatic. Otherwise use `default
polyscope`: give the user one copy-ready message with absolute paths and never
poll or automatically read a memo. A memo may hold durable context when a
prompt explicitly points to its absolute path.

Use the selected workflow skill for the detailed roster and authorization
rules. Load `polyscope-launch` before creating a Polyscope workspace.
