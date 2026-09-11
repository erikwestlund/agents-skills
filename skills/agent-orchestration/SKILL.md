---
name: agent-orchestration
description: How to orchestrate multi-agent work. An Opus orchestrator dispatches and tracks, one Fable plan/review workspace (0-plan-review) plans and reviews, task agents on whatever model fits implement, and one Opus reconcile workspace (0-reconcile) merges and pushes. Covers roles and models, planning, splitting work, naming Polyscope workspaces, briefs, nested orchestrators, and review. Load when delegating work across separate workspaces (usually Polyscope worktrees), setting up the agents for a piece of work, or starting an orchestrator workspace.
---

# Orchestration

You dispatch and track. You turn the plan into briefs, keep the work moving,
and relay between agents. Planning and review go to a stronger model, merging
goes to a dedicated integrator, and implementation goes to whatever model fits.

## Roles

| Role | Workspace | Model | Does | Skill |
|---|---|---|---|---|
| Orchestrator (you) | `0-orchestrator-…` | Opus | Gets the plan, dispatches briefs, relays reviews, and tracks progress. | this one |
| Plan/review | `0-plan-review-…`, only one | Fable, or a comparable strong model | Writes plans and reviews commits against them. Never merges or pushes. | `agent-plan-review` |
| Task executor | `N-…-tasks-…`, as many as needed | Whatever fits: usually Opus, Sonnet for routine work, Fable only for hard problems | Implements one brief, then sends approved work to reconcile. | `agent-task-work` |
| Reconcile | `0-reconcile-…`, only one | Opus | Merges approved work, resolves conflicts, runs the full suite, keeps the history clean, and pushes. | `agent-reconcile` |

Under the third-party fallback the model column collapses to one model: the
stronger third-party model takes plan/review, and one cheaper third-party
model covers every other role. Which models those are changes over time.

Most orchestration and integration is bookkeeping that runs long and fills a
lot of context, which makes it the costliest place to put Fable. Save Fable
for the plan and the reviews.

## Before starting

**Check that this applies.** If you aren't running agents in separate
workspaces (e.g. you're a single session in a main checkout), you aren't
orchestrating. Just do the work.

**Check the model.** The orchestrator runs on Opus. The harness sometimes
routes work to third-party APIs instead, so a non-Claude model name is
expected, not a misconfiguration, and you should proceed rather than ask.
Which third-party models are in use changes over time. Among Claude models, if
you're on Fable or a similarly expensive model, or on a small one, ask the
user once whether that's intended, then go with their answer.

**Check the shared workspaces.** Find `0-plan-review` and `0-reconcile` with
`ListAgents`. Create any that are missing, or ask the user to, and never start
a second of either. Small efforts can skip both: plan, review, and integrate
yourself, following their skills.

## Plan

- Request a plan from `0-plan-review`, as `plan-review-communication`
  describes. It writes the plan to `docs/work/yyyy-mm-dd-<topic>-plan.md` and
  replies with the path.
- The plan file is the source of truth. Dispatch from it, and give its
  absolute path in every brief and review request.

## Split and dispatch

- Follow the plan's tasks. Each has a deliverable, its own files (no overlap
  between tasks), acceptance criteria, and focused tests.
- Keep tightly coupled work together, and do trivial work yourself.
- Pick each task's model by fit: usually Opus, Sonnet for routine work, and
  Fable only when the problem is hard. Skip this in third-party mode, where
  every task runs the same cheaper model and the plan's suggested model
  doesn't apply.
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

## Nested orchestrators

When work spans several problem surfaces, `0` may run one orchestrator per
surface (`1-import-1-orchestrator-…`). Each dispatches and tracks its own
tasks and hands one status up. All of them share the one `0-plan-review` and
the one `0-reconcile`.

## Review

If a handoff covers only one of several steps, send it back without a review,
because the task isn't done.

Otherwise, send `0-plan-review` a review request, as
`plan-review-communication` describes. When the comments come back, drop any
that fall outside the brief and make sure each one is actionable. Then send
the task agent one batch of numbered comments. When plan/review approves, tell
the task agent `APPROVED`. It then sends its own merge request to
`0-reconcile`.

## Track and finish

- Watch for `MERGED` and `FAILED` from `0-reconcile`, and keep each task's
  status current.
- When a `FAILED` needs a decision about the plan, take it to `0-plan-review`.
- If the user redirects or cancels, tell the affected agents immediately.
- When the work is merged, report one outcome to the user: what changed, the
  test results from `0-reconcile`, and the remaining risks.

## Context

You hold a long context. When it gets heavy, reset it as `context-reset`
describes. The plan file, briefs, and handoffs should carry the state, not
your transcript.
