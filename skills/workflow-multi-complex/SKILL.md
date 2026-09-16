---
name: workflow-multi-complex
description: "Coordinate multiple complex task groups with an orchestrator, focused planners, executors, and reconciliation. Use after selecting the multi-complex workflow."
---

# Multiple complex task groups

Launch one `orchestrator`, one `planner_reviewer` per task group, one or more
`task_worker` executors per approved plan, and one `reconciler`. Their policy
defaults are medium, high, medium, and low reasoning.

The orchestrator owns cross-group dependencies, contracts, file overlap,
dispatch, and status. Each planner owns only its task group from plan through
review. A launcher assignment authorizes planners to start when it clearly
states their group goal, constraints, and plan location. Workers stay waiting
until the orchestrator gives a complete plan-derived implementation brief.

The orchestrator checks that plans do not conflict before dispatching. It sends
approved work to the reconciler, which owns merge order and integrated tests.
Use `task_worker_difficult` at high reasoning only for hard debugging,
migrations, security work, or similar exceptional implementation.

## Preview while work is underway

Create a group preview only when the group requires user-interaction testing.
The orchestrator owns one disposable preview branch and preview workspace for
that task group. It starts from the assigned base, then brings in only
plan/review-approved worker commits. This preview branch is local and does not
replace reconciliation or authorize a push.

Use the project's configured Polyscope or Herd workspace-preview setup. Do not
reuse the root project's ordinary development domain. Preserve the project
preview's isolated data and seed behavior.

After creating or updating a group preview, report this exact form to the user:

```text
Preview workspace: <orchestrator group-preview workspace path and branch>
Preview URL: <URL>
Includes: <approved task commit ranges>
Status: ready | blocked, with the reason
```

Individual worker previews are optional development aids. Tell the user to
open the orchestrator's group preview for the current combined work. The
reconciler remains responsible for the final integrated preview after its
normal merge process.

The `claude-code harness` keeps routine agent messages automatic. `default
polyscope` uses human copy/paste messages with absolute paths; do not create a
polling workflow or tell agents to automatically read memos.
