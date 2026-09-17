---
name: agent-based-polyscope-launching
description: "Launch and activate every role in a Polyscope orchestrated team. Use when an agent is asked to create a Polyscope team, not for work inside an existing group."
---

# Agent-based Polyscope launching

You are the launch agent. You do not become a planner, orchestrator, worker,
or reconciler. Load `polyscope-launch`, `polyscope-team-launch`, and
`agent-communication`, then build the requested team and keep its roles moving
with workspace messages.

## Build the complete scaffold

For `G` requested groups, create `1 + (3 × G)` isolated workspaces. Never
stop after only `0-reconcile` and group orchestrators.

For each group `N`, create all three roles:

1. `N-<group>-1-plan-review-…` on the resolved `planner_reviewer` model.
2. `N-<group>-2-orchestrator-…` on the resolved `orchestrator` model.
3. `N-<group>-3-tasks-…` on the resolved `task_worker` model.

Launch `0-reconcile-…` on the separately resolved `reconciler` model. Never
inherit its model from the orchestrator or task worker.

The number after the group name is a sorting sequence, not a task identifier:
plan/review is always `1`, orchestrator is always `2`, and tasks begin at `3`.
Assign extra task workers `4`, `5`, and onward. Preserve this sequence so the
Polyscope sidebar reads plan → orchestrate → execute.

For two groups, this is seven workspaces: `0-reconcile` plus three roles for
each group. Use `ps launch <project> -m <model> "<activation brief>"` for each
one. Every activation brief must begin: “First, rename this workspace to
`<assigned branch>` by updating both the git branch and Polyscope database row
as `agent-communication` describes. Do this before any other action.” Do not
rely on a general naming reference later in the prompt.

Record the runtime alongside every workspace. Models with a managed Claude
Code provider profile (`claude_*`, `ds_*`, `fw_*`, `zai_*`) use Claude Code by
default. `oa_*` models use Polyscope's native OpenAI agent instead. For an
OpenAI workspace, make the activation brief self-contained and do not instruct
it to run Claude Code, select a Claude profile, load a Claude-only skill, or
use Claude-specific messaging. Polyscope workspace messages work for both.

## Start planners and hold workers

Every workspace gets a role-specific message. A created workspace without an
activation brief is not launched. A complete planning assignment authorizes a
planner to create its plan. It must name the group goal, constraints, and plan
location. Orchestrators, workers, and reconcile remain waiting until their
normal parent handoff arrives.

- **`0-reconcile`:** load `agent-reconcile`; orient and check in with group
  orchestrators if useful; wait for approved merge requests.
- **Planner/reviewer:** load `agent-plan-review`; rename; create the assigned
  plan; then send `PLAN READY` to its orchestrator.
- **Orchestrator:** load `agent-orchestration`; orient and check in with its
  planner and worker. Wait for the planner's `PLAN READY`;
  do not write a substitute plan or dispatch guessed tasks.
- **Task worker:** load `agent-task-work`; orient and check in with its
  orchestrator. Wait for the plan-derived task brief; do not edit or test.

Resolve each role with `agent-role resolve <provider> <role>` before launching.
The planner model belongs only to planner/review. The requested reasoning level
is policy metadata; report its effective value as `platform-default` until a
launcher can set it.

## Carry the handoffs

Creating the workspaces is only the first half of this role. After a planner
sends `PLAN READY`, keep using the selected communication medium:

1. Before every message, apply `agent-communication`'s recipient-verification
   rule. Open the recipient's actual worktree; confirm its current branch,
   `.context/` state, and relevant plan/brief are for the same group. Never
   address a workspace from its launch order or animal name alone.
2. On `PLAN READY`, send the plan path to that group's verified orchestrator.
3. The orchestrator turns the plan into the task-worker brief and sends it to
   that group's verified waiting worker.
4. If the plan needs more than one worker, the orchestrator launches and
   briefs extra `N-<group>-4-tasks-…`, `N-<group>-5-tasks-…`, and later
   workspaces on the resolved `task_worker` model.
5. After review approval, the orchestrator sends the merge request to
   `0-reconcile`.

Use the direct-messaging facility the harness actually provides. In Polyscope,
the API message endpoint is `POST /api/v1/workspaces/{id}/messages` with a
`content` field; `ps launch` sends the first message. Use `GET
/api/v1/workspaces/{id}/messages` to inspect conversation state when needed.
Do not assume a workspace can receive a cross-session message merely because
it shares the same model or provider.

## Status reporting

Report the named workspaces and their state, not a generic “team is up.” A
complete first report for two groups has seven rows: reconcile waiting, two
planners planning, two orchestrators waiting, and two workers waiting. Do not
claim that implementation has begun until an orchestrator dispatches a complete
worker brief.
