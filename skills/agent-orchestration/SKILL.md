---
name: agent-orchestration
description: "How to orchestrate multi-agent work across separate workspaces (usually Polyscope worktrees): dispatch briefs from a plan, relay reviews, and track tasks. Load when you are the orchestrator or are setting up the agents for a piece of work."
---

# Orchestration

You dispatch and track. You turn an approved group plan into briefs, keep the
work moving, and relay between agents. Planning and review are a separate
role; merging goes to a dedicated integrator.

## User-facing term

`Orchestrated team` is the user-facing term for this workflow. The named work
units are task groups. Each group has a planner, an orchestrator, and one or
more task executors.

`Claude Code` identifies the requested agent runtime. It does not require a
specific messaging transport. Choose direct messages or context files from the
actual harness capabilities, as `agent-communication` describes.

Only a group orchestrator launches or delegates work inside its assigned group.

## User-facing term

`Orchestrated team` is the user-facing term for this workflow. It means a
multi-agent effort with an orchestrator, plan/review, task executors, and
reconciliation. A request may name proposed `work units`; treat them as plan
input, then split or combine them according to dependencies and file overlap.

`Claude Code` identifies the requested agent runtime. It does not require a
specific messaging transport. Choose direct messages or context files from the
actual harness capabilities, as `agent-communication` describes.

## Roles

| Role | Workspace | Model | Does | Skill |
|---|---|---|---|---|
| Group plan/review | `N-<group>-…-plan-review-…` | Planner model | Writes one group plan and reviews that group’s completed work. | `agent-plan-review` |
| Group orchestrator | `N-<group>-…-orchestrator-…` | Executor model | Turns the approved plan into briefs, dispatches workers, and tracks the group. | this one |
| Task executor | `N-<group>-…-tasks-…`, as many as the plan needs | Executor model | Implements one brief for its group. | `agent-task-work` |
| Reconcile | `0-reconcile-…`, only one when several groups exist | Executor model | Merges approved groups, resolves conflicts, runs the full suite, keeps the history clean, and pushes. | `agent-reconcile` |

For example, “planners run Opus; the rest run DeepSeek Flash” means
`claude_opus` for group plan/review and `ds_flash` for the other three roles.
An orchestrator is not a planner.

## Scope and numbering

`0` is the reconciliation namespace. A multi-group initiative starts
`0-reconcile`, and task groups start at `1`, so their workspaces remain stable
as the initiative expands.

For an initiative with one task group and one work unit, use one
`0-<topic>-tasks-…` workspace. It implements and reconciles its own change; do
not create a separate reconcile workspace. If more task groups are added, use
`agent-repurpose-workspace` to
turn the `0` workspace into `0-reconcile-…` when appropriate, and name the new
groups `1`, `2`, and onward.

## Before starting

**Check that this applies.** If you aren't running agents in separate
workspaces (e.g. you're a single session in a main checkout), you aren't
orchestrating. Just do the work.

**Check the model and plan.** You run on the group's executor model. Your
brief must name an approved group-plan path and the plan/review workspace. If
it does not, ask the team launcher for them; do not write a replacement plan
or dispatch workers from guesses.

**Check the shared workspace.** `polyscope-team-launch` creates
`0-reconcile` first for a multi-group initiative. Never start a second.

## Split and dispatch

- Follow the approved group plan. Turn its work into units with
  deliverables, file ownership, acceptance criteria, and focused tests.
- Keep tightly coupled work in one group. A group with one work unit can have
  one task executor; a larger group can dispatch several task executors.
- Launch every task worker on the group’s executor model unless the user
  explicitly assigns a different model. Do not silently substitute the
  planner model.
- Keep one agent slot free for yourself.
- When you create a workspace, choose its name by the convention in
  `agent-communication`. Put the name in the first brief and tell the agent to
  rename itself to it first, as that skill describes.

## Brief

Write every brief so it works even if the agent never loads a skill. It gives:

- an instruction to load the `agent-task-work` skill
- the absolute path of the plan file
- the goal and acceptance criteria
- the steps, in order
- the files the agent owns (everything else is read-only)
- the focused tests to run
- the channel: direct messages, or the absolute paths of the brief and handoff
  files
- the names of `0-reconcile` and yourself
- the key rules, stated outright:
  - finish every step before asking for review
  - when in doubt about thoroughness, make it good
  - run only focused tests, starting with the narrowest file or filter
  - commit on your own branch, and never merge or push
  - once approved, send `0-reconcile` a merge request
  - give absolute paths in every message
- **first brief only:** the workspace name, and the base to update to, meaning
  the latest integrated code. That's usually `origin/main`, or `0-reconcile`'s
  branch if its work isn't pushed yet.

## Communicate

Use direct messages when every agent is Claude Code, and context files
otherwise, watching the handoff files. Put any message a person has to carry in
one copyable code block with absolute paths. Details: `agent-communication`.

## Group orchestration

Every task group has its own planner and orchestrator. The orchestrator
dispatches and tracks that group’s task executors, relays local review, and
reports one approved merge candidate to `0-reconcile`. Groups coordinate shared
contracts directly and share one `0-reconcile` when it exists.

## Review

If a handoff covers only one of several steps, send it back without a review,
because the task isn't done.

Otherwise, send the group’s plan/review workspace a review request. Send
cross-group questions to the affected group orchestrator. When the comments
come back, drop any that fall outside the brief and make sure each one is
actionable. Then send the task agent one batch of numbered comments. Once a
group’s work is approved, its orchestrator sends the merge request to
`0-reconcile`, or the single task reconciles its own change.

## Track and finish

- Watch for `MERGED` and `FAILED` from `0-reconcile`, and keep each group’s
  status current.
- When a `FAILED` needs a decision about shared contracts or dependencies,
  coordinate with the affected group or ask the user.
- If the user redirects or cancels, tell the affected group immediately.
- When the work is merged, report one outcome to the user: what changed, the
  test results from `0-reconcile`, and the remaining risks.

## Context

You hold a long context. When it gets heavy, reset it as `context-reset`
describes. The plan file, briefs, and handoffs should carry the state, not
your transcript.
