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

The `claude-code harness` keeps routine agent messages automatic. `default
polyscope` uses human copy/paste messages with absolute paths; do not create a
polling workflow or tell agents to automatically read memos.
