---
name: agent-task-work
description: How to work as a task (implementation) agent under an orchestrator. Covers model fit, the base branch, finishing every step before review, focused tests, subagents, and answering review. Load when an orchestrator hands you a brief, or when your Polyscope workspace name has a "tasks" role.
---

# Task work

The orchestrator wrote the plan and will review your work. Implement all of it.

## Before starting

- **Check the model.** Task work usually goes to smaller, faster models, and to
  a strong one only when the problem is hard. If you're on a high-powered model
  (Fable, Astra, Sol, or similar) and the task looks routine, ask the user once
  whether that's intended, then go with their answer.
- **Take your name.** If the brief assigns a workspace name, rename to it
  first by updating both the git branch and Polyscope's database row, as
  `agent-communication` shows. After that, never rename again.
- **Update to the base** the first brief names, usually `origin/main`.
- Read the whole brief: the files you own, the acceptance criteria, and the
  tests.

## Communicate

Message the orchestrator directly with `SendMessage` when you can. Otherwise,
write to your handoff file and watch the brief file for replies. If the user
has to carry a message, give it as one copyable code block with absolute paths.
Details: `agent-communication`.

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

Run only the tests for your change, not the full suite; the orchestrator owns
the blast radius. Report failures outside your scope instead of fixing them.

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
on your branch, but never push or merge.

## Review

Answer every comment by number: fixed (and how) or declined (and why). Rerun
the focused tests, commit, and ask for review again. If you're told to cancel,
stop before writing anything else.
