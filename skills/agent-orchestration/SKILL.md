---
name: agent-orchestration
description: How to orchestrate multi-agent work, where a strong model plans and reviews and smaller agents implement. Covers model fit, splitting work, naming Polyscope workspaces, briefs, nested orchestrators, review, and integration. Load when delegating work across separate workspaces (usually Polyscope worktrees), starting an orchestrator workspace, or reviewing task agents' output.
---

# Orchestration

Strong models (Fable, Astra, Sol) plan and review. Smaller, faster models
implement, unless the problem is hard. You own the plan, the reviews, and the
integration.

## Before starting

**Check that this applies.** If you aren't running agents in separate
workspaces (e.g. you're a single session in a main checkout), you aren't
orchestrating. Just do the work.

**Check the model.** If you're on a small or cheap model, ask the user once
whether that's intended, then go with their answer.

## Plan and split

- Plan first. Split the work into bounded tasks, each with a deliverable, its
  own files (no overlap between tasks), acceptance criteria, and focused tests.
- Keep tightly coupled work together, and do trivial work yourself.
- Give routine tasks to a smaller model and hard ones to a strong model.
- Keep one agent slot free for yourself.
- When you create a workspace, choose its name by the convention in
  `agent-communication`. Put the name in the first brief and tell the agent to
  rename itself to it first, as that skill describes.

## Brief

Write every brief so it works even if the agent never loads a skill. It gives:

- an instruction to load the `agent-task-work` skill
- the goal and acceptance criteria
- the steps, in order
- the files the agent owns (everything else is read-only)
- the focused tests to run
- the channel: direct messages, or the absolute paths of the brief and handoff
  files
- the key rules, stated outright:
  - finish every step before asking for review
  - when in doubt about thoroughness, make it good
  - run only focused tests
  - commit on your own branch and don't push
  - give absolute paths in every message
- **first brief only:** the base to update to, meaning the latest merged code
  you know of. That's usually `origin/main`, or your own branch if its work
  isn't live yet.

## Communicate

Use direct messages when every agent is Claude Code, and context files
otherwise, watching the handoff files. Put any message a person has to carry in
one copyable code block with absolute paths. Details: `agent-communication`.

## Nested orchestrators

When work spans several problem surfaces, `0` may run one orchestrator per
surface (`1-import-1-orchestrator-…`). Each surface orchestrator integrates its
own tasks, runs the full suite, and hands one result up. `0` then merges the
surfaces and runs the suite again.

## Review

Review the commits against the brief, not just the handoff. Send one batch of
numbered, actionable comments. If a handoff covers only one of several steps,
send it back: the task isn't done.

## Integrate

- Merge the approved commits, resolve conflicts, and run the full suite. The
  blast radius is yours.
- Keep the history sensible:
  - Squash fixups and review rounds into the change they fix.
  - Rebase onto the base.
  - Keep unrelated changes in separate commits, with clear messages.
  - Don't rewrite commits another agent is still building on.
- Commit freely, but never push.
- Send failures back to the agent that owns the code, or fix small ones
  yourself.
- Format the whole repository.
- Report one outcome: what changed, which tests ran and their results, and the
  remaining risks.
- If the user redirects or cancels, tell the affected agents immediately.
