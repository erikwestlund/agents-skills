---
name: agent-communication
description: How orchestrator and task agents communicate, name Polyscope workspaces, and use context files and handoffs. Load when starting or joining multi-agent work, sending a brief, handoff, or review, or naming a Polyscope workspace.
---

# Agent communication

This is the contract between orchestrator and task agents: the names, channels,
files, and formats both sides rely on. `agent-orchestration` and
`agent-task-work` set out each side's obligations under it.

It applies when agents work in separate workspaces, usually Polyscope worktrees
(checkouts under `~/.polyscope/`). In a single session with the user, such as a
plain main checkout, skip it. Work directly, and brief any subagents in a few
lines without names, context files, or handoff formats.

## Names

Polyscope names each worktree with an adjective and an animal
(`blissful-woodpecker`). Prefix it so workspaces sort and read clearly:

`{topic}-{surface}-{agent}-{work}-{worktree}`

- **topic**: a number that orders topics. `0` is the top-level orchestrator.
- **surface**: the problem area (`import`, `theme`).
- **agent**: a number within the topic, if there are several agents.
- **work**: the role, if roles differ (`orchestrator`, `tasks`, `copy`, `review`).
- **worktree**: the Polyscope name, unchanged.

Drop segments that add nothing.

```
0-orchestrator-smart-kitten
1-import-1-orchestrator-wistful-pony
1-import-2-tasks-brave-otter
2-theme-1-copy-amber-fox
```

The orchestrator names workspaces when it creates them. **Once a workspace has
a name in this form, never rename it**, because other agents address you by
that name.

The workspace name is the git branch. Renaming a workspace in the Polyscope app
renames the branch and updates Polyscope's record, but nothing on disk moves.
The checkout folder keeps the bare worktree name, and so does anything built
from it, such as preview URLs.

- Rename only in the Polyscope app. `git branch -m` leaves Polyscope's record
  out of date.
- Sign messages and name context files with your branch, which is the full
  workspace name. Build paths and preview URLs from the folder.

## Who talks to whom

Each agent talks to its parent. Task agents talk to their topic's
orchestrator, topic orchestrators to `0`, and subagents to the agent that
spawned them.

## Channels

1. **Direct messages** when both sides are Claude Code (preferred): find the
   agent with `ListAgents`, then use `SendMessage`.
2. **Context files** when agents can't message each other, e.g. other or
   mixed providers.
3. **Human relay** when a person has to carry the message.

## Human relay

**Always** put the whole message in one code block the user can copy and
paste, and **always** give absolute paths for every file it mentions. The
receiving agent is in another worktree and can't resolve relative paths.

````
To: 1-import-2-tasks-brave-otter
From: 1-import-1-orchestrator-wistful-pony
Status: CHANGES REQUESTED
Review: /Users/erik/Projects/pequod/.context/1-import-2-tasks-brave-otter.brief.md
Address all 4 comments, rerun the focused tests, then post READY FOR REVIEW in
/Users/erik/Projects/pequod/.context/1-import-2-tasks-brave-otter.handoff.md
````

## Context files

Context files carry live messages between agents. Lasting project notes go in
`docs/` instead (see project-docs).

- The orchestrator names one shared directory by absolute path in the brief,
  usually the main checkout's `.context/`. Other worktrees can't see a
  worktree's own `.context/`.
- Each task gets two files, named after the task agent's workspace. Each side
  writes only its own file and watches the other's:
  - `<name>.brief.md`, written by the orchestrator: the brief, reviews, and
    approval.
  - `<name>.handoff.md`, written by the task agent: handoffs, questions, and
    replies.
- Append each entry under a dated, signed heading that starts with a status:
  `READY FOR REVIEW`, `CHANGES REQUESTED`, `BLOCKED`, `QUESTION`, or
  `APPROVED`.

**Watch the other side's file** so you resume without being nudged. In Claude
Code, use `Monitor` with an until-loop that exits on a new status line.
Elsewhere, poll every 30-60 seconds. Stop at `APPROVED` or when told.

## Handoffs

Keep them short and explicit:

- the status, and what was done for each step of the brief
- where to find it: the worktree's absolute path, the branch, and the commit
  range
- files changed
- commands run and their results, including failures
- open questions and risks

Send a review as one batch of numbered, actionable comments. Answer each by
number: fixed (and how) or declined (and why).
