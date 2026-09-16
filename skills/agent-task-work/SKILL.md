---
name: agent-task-work
description: "How to work as a task executor under an orchestrator: implement the whole brief, test it, answer review, and reconcile or hand it off. Load when an orchestrator hands you a brief, or when your Polyscope workspace name has a \"tasks\" role."
---

# Task work

The orchestrator dispatched your brief from a plan, and your group’s
plan/review workspace will check your commits against it. When several task
groups exist, `0-reconcile` merges approved group work. A single
`0-…-tasks` workspace reconciles its own change. Implement all of it. If your
context gets heavy, reset it as `context-reset` describes.

If your activation brief says that you are waiting for an orchestrator's
plan-derived task brief, do exactly that: load this skill, confirm your
workspace name and model, orient from local instructions and project structure,
and check in with your orchestrator if useful. Do not create work artifacts,
edit code, run tests, commit, or launch subagents. Start the workflow below
only after your parent provides a complete implementation brief.

## Before starting

- **Check the model.** Use the executor model named in your brief. When the
  user says planners run Opus and the rest run DeepSeek Flash, task work runs
  `ds_flash`; do not substitute the planner model.
- **Take your name.** If the brief assigns a workspace name, rename to it
  first by updating both the git branch and Polyscope's database row, as
  `agent-communication` shows. After that, never rename again unless you're
  repurposed (see `agent-repurpose-workspace`).
- **Update to the base** the first brief names, usually `origin/main` or
  `0-reconcile`'s branch when that workspace exists.
- Read the whole brief: the files you own, the acceptance criteria, and the
  tests.

## Communicate

Use the transport selected by `agent-communication`. Send messages to the
orchestrator through the direct channel, the shared handoff and brief files, or
human relay as that skill directs.

## Finish the whole task

**Don't make one change and stop.** Before asking for review:

1. Implement everything, including any tests the brief asks for.
2. Run the focused tests and fix what fails.
3. Format the files you own.
4. Check your diff against the brief and do anything that's missing.
5. Commit on your branch.
6. Send one `READY FOR REVIEW` handoff covering what's done, your questions,
   and where to find it: the worktree path, the branch, and the commit range.

When in doubt about thoroughness, make it good.

Stop early only when you're truly blocked: a decision that isn't yours, or a
brief that's wrong. Say what you need and keep going on everything else.

## Tests

Run only the tests for your change, not the full suite, unless you are the
single `0-…-tasks` workspace. That workspace performs the reconciliation
checks required by its brief, including the appropriate integrated suite.
Report failures outside your scope instead of fixing them.

**Start with the narrowest run**, one file or one filter, and widen only when
it passes. Nearly all the context a test run costs comes from failure output:
stack traces, diffs, and long progress lines. A failing file is cheap, and a
failing suite is not.

In PHP projects with laravel/pao installed, Pest, PHPUnit, Paratest, PHPStan,
Rector, and Artisan give agents one compact JSON line instead of the usual
report, such as `{"tool":"pest","result":"passed","tests":5,"passed":5}`.
Failures list names and messages just as compactly. Read the JSON. Don't grep
for `Tests:` or `PASS` lines, and don't pipe the output through `head` or
`tail`.

## Subagents

You may use subagents. They report only to you; if a question needs the
orchestrator, you ask it. Keep their prompts brief: the task, the files, and
which skill to load.

## Scope

Edit only the files the brief gives you, and ask before touching others. Commit
on your branch. In a multi-group effort, never merge or push because
`0-reconcile` does that. A single-task workspace follows its brief’s
integration instructions; pushing still requires the user's authorization.

## Review

Answer every comment by number: fixed (and how) or declined (and why). Rerun
the focused tests, commit, and ask for review again. If you're told to cancel,
stop before writing anything else.

When a single `0-…-tasks` workspace performs its own reconciliation for work
produced by a non-flagship model, such as DeepSeek or GLM, it must run
`codex-adversarial-review` before reporting the result. A Claude Code runtime
alone does not trigger this requirement.

## Merge

When the orchestrator tells you `APPROVED`, send `0-reconcile` a merge request
in a multi-group effort, as `agent-communication` describes. A single
`0-…-tasks` workspace completes its own reconciliation checks and reports the
result to its orchestrator. Answer `CONFLICT` or `FAILED` the way you answer
review comments. You're done when the change is reconciled.
