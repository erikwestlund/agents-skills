---
name: polyscope-workflow
description: Route a Polyscope session to its communication channel and role skill. Load when starting, resuming, or changing roles in a Polyscope workspace.
---

# Polyscope Workflow

Use this router once when starting, resuming, or repurposing a Polyscope
workspace. It selects the communication channel and the role skill. The role
skill supplies the detailed workflow.

## Identify The Harness

Use the tools available in the current session to select a channel:

- In Claude Code, prefer direct communication when `ListAgents` and
  `SendMessage` are available. Use `ListAgents` to find the named session, then
  communicate with `SendMessage`.
- In another harness with equivalent cross-session tools, use its direct
  messaging facility.
- When direct messaging is unavailable or the recipient cannot be reached, use
  the shared `.context/` files or human relay described in
  `agent-communication`.

The available tools determine the channel. A provider or model name alone does
not establish which communication features the session has.

## Identify The Role

Use an explicit assignment or brief first. Otherwise, use the workspace name,
which is normally the current git branch:

- `0-orchestrator-*` or `*-orchestrator-*`: load `agent-orchestration`.
- `0-plan-review-*`: load `agent-plan-review`.
- `0-reconcile-*`: load `agent-reconcile`.
- `*-tasks-*`, or a brief assigning task execution: load `agent-task-work`.
- An explicit request to reuse the workspace: load `repurpose-workspace`, then
  route again under the new role.

If the harness does not provide the workspace name, read it with
`git branch --show-current`. An explicit assignment takes precedence when the
name and assignment disagree.

Load one role skill. Load supplemental skills when the operation reaches them:

- `agent-communication` for naming, cross-workspace messages, handoffs, review
  statuses, and merge requests.
- `plan-review-communication` for a plan or review exchange with
  `0-plan-review`.
- `context-reset` when preparing for a reset.

A workspace without a multi-agent assignment remains an ordinary workspace.
Continue with the user's task without creating roles or coordination machinery.
