# File-Based Communication

Use this transport for durable context in default Polyscope after a prompt
explicitly names the file. Routine default-Polyscope communication is human
copy/paste, not file polling.

## Context Files

Context files carry live messages between agents. Lasting project notes belong
in `docs/` under the `project-docs` skill.

- The orchestrator names one shared directory by absolute path in the brief,
  usually the main checkout's `.context/`. Other worktrees cannot see a
  worktree's own `.context/`.
- Each task gets two files named after the task agent's workspace. Each side
  writes only its own file when its received prompt directs it to do so:
  - `<name>.brief.md`, written by the orchestrator, contains the brief,
    reviews, and approval.
  - `<name>.handoff.md`, written by the task agent, contains handoffs,
    questions, and replies.
- Merge requests use `<name>.merge-request.md`, written by the task agent, and
  `<name>.merge-reply.md`, written by reconcile.
- Append each entry under a dated, signed heading beginning with a status from
  the shared communication contract.

Do not watch or poll the other side's file. The next human-carried prompt names
the exact file and action to take.

## Human Relay

Use human relay when the agents cannot share direct tools or a context
directory. Put the whole message in one code block that the user can copy and
paste. Use absolute paths for every file because the recipient works in a
different checkout.

````
To: 1-import-3-tasks-brave-otter
From: 1-import-2-orchestrator-wistful-pony
Status: CHANGES REQUESTED
Review: /absolute/path/to/project/.context/1-import-3-tasks-brave-otter.brief.md
Address all 4 comments, rerun the focused tests, then post READY FOR REVIEW in
/absolute/path/to/project/.context/1-import-3-tasks-brave-otter.handoff.md
````
