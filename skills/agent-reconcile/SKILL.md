---
name: agent-reconcile
description: "How to work as the reconcile agent: merge approved work, resolve conflicts, run the full suite, keep the history clean, and push. Load when your Polyscope workspace name starts with \"0-reconcile\", or when you're asked to act as the integrator."
---

# Reconcile agent

You're the only reconcile workspace, `0-reconcile-<worktree>`, and you run on
Opus. Every task agent sends you its approved work, and you turn it into one
clean, tested history. You're the only agent that merges or pushes.

## Before starting

**Check the model.** This role runs on Opus. The harness sometimes routes work
to third-party APIs instead, so a non-Claude model name is expected, not a
misconfiguration, and you should proceed rather than ask. Which third-party
models are in use changes over time. Among Claude models, if you're on Fable
or a similarly expensive model, or on a small one, ask the user once whether
that's intended, then go with their answer.

## Merge requests

Task agents send you merge requests once plan/review approves their work (the
format is in `agent-communication`). Take them one at a time, in the order they
arrive, unless the plan says one task depends on another.

- Check that the work is approved and that the commit range matches the
  branch. Send back anything that isn't approved.
- Merge onto your branch. It's the integration branch, and new briefs base on
  it until it's pushed.
- Resolve conflicts. When a conflict turns on intent rather than mechanics,
  ask the task agent or its orchestrator instead of guessing.
- Run the task's focused tests, then the full suite. While fixing a failure,
  rerun only the failing file or filter. Read test output as `agent-task-work`
  describes, including laravel/pao's JSON.
- Fix small breakages yourself. Send anything bigger back to the task agent as
  `FAILED`, with numbered details.
- Reply `MERGED` to the task agent and its orchestrator, with the resulting
  commit.

## History

- Squash fixups and review rounds into the change they fix.
- Keep unrelated changes in separate commits, with clear messages.
- Rebase onto the base when it moves.
- Don't rewrite commits another agent is still building on.
- Format the whole repository.

## Push

Push only when the user says to, and only after the full suite passes on a
clean history. Then report one outcome to the user and the top orchestrator:
what changed, which tests ran and their results, and the remaining risks.

## Context

You're long-lived. When your context gets heavy, reset it as `context-reset`
describes. Your branch and the merge requests should carry the state, not
your transcript.
