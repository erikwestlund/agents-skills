---
name: polyscope-team-launch
description: "Provision a Polyscope orchestrated team from a project, role models, and proposed work units. Use when the user asks to launch, start, or create an orchestrated team; do not use for work inside an existing task group."
---

# Polyscope team launch

This skill defines the team shape. `agent-based-polyscope-launching` performs
the actual Polyscope launches and follow-up messages. `agent-orchestration`
governs a task group after its plan is ready.

## Team math

For `G` requested task groups, launch exactly `1 + (3 × G)` workspaces:

```text
1                  0-reconcile
3 for each group    planner/reviewer + orchestrator + task worker
```

Thus two groups require seven workspaces, not three:

```text
0-reconcile
1-import-plan-review       1-import-orchestrator       1-import-tasks
2-registration-plan-review 2-registration-orchestrator 2-registration-tasks
```

The initial task worker is an assigned, waiting worker. It does not implement
until its orchestrator sends the plan-derived brief. A planner can later ask
its orchestrator to split out additional workers, but that does not replace the
initial three-role scaffold.

## Launch order

Resolve the project and role models first. Then create every workspace in this
order:

1. Launch `0-reconcile-…` with the requested reconcile model. Its brief loads
   `agent-reconcile`, establishes the integration branch, and waits for merge
   requests. It does not implement proposed work units.
2. Launch one group plan/review workspace per requested work unit, numbered
   `1`, `2`, and onward. Each loads `agent-plan-review`, writes its group's
   plan, and replies `PLAN READY` with the absolute plan path.
3. Launch one group orchestrator for every group on the executor model. Its
   activation brief loads `agent-orchestration` and tells it to wait for the
   named planner's `PLAN READY`; it must not invent a plan or dispatch yet.
4. Launch one task worker for every group on the executor model. Its activation
   brief loads `agent-task-work` and tells it to wait for a plan-derived brief
   from the named orchestrator; it must not edit while waiting.

Named work units are task groups by default. The planner owns its local plan
and review. The group orchestrator owns contracts, dependencies, task dispatch,
and tracking.
`0-reconcile` owns integration order and the integrated test result; it does
not plan a group.

Do not call the team launched until all `1 + (3 × G)` workspaces have been
created and received their activation briefs. Then report every workspace's
role and state: reconcile waiting, planners planning, orchestrators waiting for
plans, and workers waiting for briefs. Continue monitoring: every `PLAN READY`
must be delivered to its orchestrator, and the orchestrator must deliver its
plan-derived brief to the waiting worker. If the plan needs more workers, the
orchestrator launches them then.

For two groups, import and registration, with “planners run Opus; the rest run
DeepSeek Flash,” the visible progression is:

```text
0-reconcile-...                         ds_flash   waiting
1-import-...-plan-review-...            claude_opus planning
2-registration-...-plan-review-...      claude_opus planning
1-import-...-orchestrator-...           ds_flash   waiting for plan
2-registration-...-orchestrator-...     ds_flash   waiting for plan
1-import-...-tasks-...                  ds_flash   waiting for brief
2-registration-...-tasks-...            ds_flash   waiting for brief
```

Launching only the first three is incomplete. Never report a finished team at
that point.

## Single task

For one task group with one work unit, launch one `0-<topic>-tasks-…`
workspace. It loads `agent-task-work` and performs its own reconciliation
checks. Do not create `0-reconcile` for that case. If the initiative later
gains task groups, use `agent-repurpose-workspace` to convert the `0` workspace
to `0-reconcile`, then number the task groups from `1`.

## Models

Use the role models the user specifies. A requested planner model applies only
to each group plan/review workspace. A requested executor model applies to the
group orchestrators, task executors, and `0-reconcile`. `claude_opus` selects
native Claude Opus for planners. `ds_flash` selects DeepSeek Flash for all of
the latter roles. When the user gives one model for the entire team, apply it
to every launched role.

Interpret “planners run Opus; the rest run DeepSeek Flash” as
`claude_opus` for group plan/review workspaces and `ds_flash` for
orchestrators, task executors, and `0-reconcile`. Do not treat an orchestrator
as a planner or ask the user to resolve that distinction.

Use `polyscope-launch` to identify the runtime for every selected model.
`claude_*`, `ds_*`, `fw_*`, and `zai_*` entries use Claude Code by default;
`oa_*` entries use Polyscope's native OpenAI agent. An OpenAI workspace must
receive a self-contained role brief rather than Claude CLI or Claude-skill
instructions. All runtimes use the same Polyscope workspace-message channel.

## Briefs

Every launch brief names the workspace role, the project, the selected skill,
the communication channel, and its authority boundary. The reconcile brief
waits. A planner brief requests a plan; an orchestrator brief says which
planner it waits for; a task-worker brief says which orchestrator it waits for.
Do not send a generic “work on this group” brief to any role.
