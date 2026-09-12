# File-Based Communication

Use this transport when direct cross-session messaging is unavailable, the
recipient cannot be reached, or the agents use incompatible harnesses.

## Context Files

Context files carry live messages between agents. Lasting project notes belong
in `docs/` under the `project-docs` skill.

- The orchestrator names one shared directory by absolute path in the brief,
  usually the main checkout's `.context/`. Other worktrees cannot see a
  worktree's own `.context/`.
- Each task gets two files named after the task agent's workspace. Each side
  writes only its own file and watches the other's:
  - `<name>.brief.md`, written by the orchestrator, contains the brief,
    reviews, and approval.
  - `<name>.handoff.md`, written by the task agent, contains handoffs,
    questions, and replies.
- Merge requests use `<name>.merge-request.md`, written by the task agent, and
  `<name>.merge-reply.md`, written by reconcile.
- Append each entry under a dated, signed heading beginning with a status from
  the shared communication contract.

Watch the other side's file so work resumes without a prompt. When `Monitor` is
available, use an until-loop that exits on a new status line. Otherwise, poll
every 30–60 seconds. Stop at `APPROVED` or `MERGED`, or when directed.

## Human Relay

Use human relay when the agents cannot share direct tools or a context
directory. Put the whole message in one code block that the user can copy and
paste. Use absolute paths for every file because the recipient works in a
different checkout.

````
To: 1-import-2-tasks-brave-otter
From: 1-import-1-orchestrator-wistful-pony
Status: CHANGES REQUESTED
Review: /absolute/path/to/project/.context/1-import-2-tasks-brave-otter.brief.md
Address all 4 comments, rerun the focused tests, then post READY FOR REVIEW in
/absolute/path/to/project/.context/1-import-2-tasks-brave-otter.handoff.md
````
