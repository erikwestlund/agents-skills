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

1. `N-<group>-plan-review-…` on the planner model.
2. `N-<group>-orchestrator-…` on the executor model.
3. `N-<group>-tasks-…` on the executor model.

For two groups, this is seven workspaces: `0-reconcile` plus three roles for
each group. Use `ps launch <project> -m <model> "<activation brief>"` for each
one. Rename each workspace according to `agent-communication` as soon as its
brief runs.

Record the runtime alongside every workspace. Models with a managed Claude
Code provider profile (`claude_*`, `ds_*`, `fw_*`, `zai_*`) use Claude Code by
default. `oa_*` models use Polyscope's native OpenAI agent instead. For an
OpenAI workspace, make the activation brief self-contained and do not instruct
it to run Claude Code, select a Claude profile, load a Claude-only skill, or
use Claude-specific messaging. Polyscope workspace messages work for both.

## Activate every role

Every workspace gets an initial, role-specific message. A created workspace
without an activation brief is not launched.

- **`0-reconcile`:** load `agent-reconcile`; establish the integration branch;
  wait for approved group merge requests; do not plan or implement.
- **Planner/reviewer:** load `agent-plan-review`; inspect the group scope;
  write its plan; send `PLAN READY` and the absolute plan path back to this
  launch agent.
- **Orchestrator:** load `agent-orchestration`; wait for the named planner's
  `PLAN READY`; do not write a substitute plan or dispatch guessed tasks.
- **Task worker:** load `agent-task-work`; wait for the named orchestrator's
  plan-derived task brief; do not edit while waiting.

The planner model belongs only to planner/review. When the request says
“planners run Opus; the rest run DeepSeek Flash,” use `claude_opus` for the
two planners and `ds_flash` for the reconcile workspace, two orchestrators,
and two task workers.

## Carry the handoffs

Creating the workspaces is only the first half of this role. Keep using the
available Polyscope message channel after they are up:

1. On `PLAN READY`, send the plan path to that group's orchestrator.
2. The orchestrator turns the plan into the task-worker brief and sends it to
   that group's waiting worker.
3. If the plan needs more than one worker, the orchestrator launches and
   briefs extra `N-<group>-tasks-…` workspaces on the executor model.
4. After review approval, the orchestrator sends the merge request to
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
planners planning, two orchestrators waiting for plans, and two workers
waiting for briefs. Continue the launch role until those handoffs occur or a
specific question blocks them.
