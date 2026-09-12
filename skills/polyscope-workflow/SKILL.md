---
name: polyscope-workflow
description: "Route a Polyscope session to its role and supporting skills. Load when starting, resuming, or changing roles in a Polyscope workspace."
---

# Polyscope Workflow

Use this router once when starting, resuming, or repurposing a Polyscope
workspace. It selects the role skill. The role skill supplies the detailed
workflow, and `agent-communication` selects the available transport when agents
need to communicate.

## Identify The Role

Use an explicit assignment or brief first. Otherwise, use the workspace name,
which is normally the current git branch:

- `*-orchestrator-*`: load `agent-orchestration`.
- `*-plan-review-*`: load `agent-plan-review`.
- `0-reconcile-*`: load `agent-reconcile`.
- `*-tasks-*`, or a brief assigning task execution: load `agent-task-work`.
- An explicit request to reuse the workspace: load `agent-repurpose-workspace`, then
  route again under the new role.

If the harness does not provide the workspace name, read it with
`git branch --show-current`. An explicit assignment takes precedence when the
name and assignment disagree.

Load one role skill. Load supplemental skills when the operation reaches them:

- `agent-communication` for naming, cross-workspace messages, handoffs, review
  statuses, and merge requests.
- `plan-review-communication` for a plan or review exchange within the
  current task group.
- `context-reset` when preparing for a reset.

A workspace without a multi-agent assignment remains an ordinary workspace.
Continue with the user's task without creating roles or coordination machinery.
