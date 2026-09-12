---
name: agent-communication
description: "How orchestrator, plan/review, task, and reconcile agents communicate with each other. Load when starting or joining multi-agent work, sending a brief, handoff, review, or merge request, or naming a Polyscope workspace."
---

# Agent communication

This is the contract between the orchestrator, plan/review, task, and
reconcile agents: the names, channels, files, and formats they all rely on.
`agent-orchestration`, `agent-plan-review`, `agent-task-work`, and
`agent-reconcile` set out each role's obligations under it. Requests to
plan/review follow `plan-review-communication`.

It applies when agents work in separate workspaces, usually Polyscope worktrees
(checkouts under `~/.polyscope/`). In a single session with the user, such as a
plain main checkout, skip it. Work directly, and brief any subagents in a few
lines without names, context files, or handoff formats.

## Names

Polyscope names each worktree with an adjective and an animal
(`blissful-woodpecker`). Prefix it so workspaces sort and read clearly:

`{topic}-{surface}-{agent}-{work}-{worktree}`

- **topic**: a number that orders topics. `0` is top level, for the top
  orchestrator and the two shared workspaces, plan/review and reconcile.
- **surface**: the problem area (`import`, `theme`).
- **agent**: a number within the topic, if there are several agents.
- **work**: the role, if roles differ (`orchestrator`, `plan-review`,
  `reconcile`, `tasks`, `copy`).
- **worktree**: the Polyscope name, unchanged.

Drop segments that add nothing.

```
0-orchestrator-smart-kitten
0-plan-review-keen-heron
0-reconcile-calm-lynx
1-import-1-orchestrator-wistful-pony
1-import-2-tasks-brave-otter
2-theme-1-copy-amber-fox
```

The workspace name is the git branch. Polyscope displays it from the `branch`
column of its `worktrees` table in `~/.polyscope/polyscope.db`. The
orchestrator or the user chooses the name. **The agent in the workspace
renames itself by changing both the branch and that row.** Run this from the
worktree root:

```
new=<new-name>
git branch -m "$new"
sqlite3 ~/.polyscope/polyscope.db "update worktrees set branch = '$new', branch_renamed = 1 where path = '$(git rev-parse --show-toplevel)';"
```

The app's own rename action does the same thing. If you run only
`git branch -m`, Polyscope may keep showing the old name.

- **Rename once**, as soon as you're given the name. Polyscope may prompt a new
  agent to choose its own branch name, but an assigned name takes precedence.
- **Never rename again after that**, because other agents address you by that
  name. The one exception is repurposing the workspace for a new role, as
  `repurpose-workspace` describes.
- **Nothing on disk moves.** The checkout folder keeps the bare worktree name,
  and so does anything built from it, such as preview URLs.
- Sign messages and name context files with your branch, which is the full
  workspace name. Build paths and preview URLs from the folder.

## Who talks to whom

Each agent talks to its parent. Task agents talk to their topic's
orchestrator, topic orchestrators to `0`, and subagents to the agent that
spawned them. There are two shared workspaces:

- **`0-plan-review`**: orchestrators at every level send it plan and review
  requests. Its review comments reach task agents through their orchestrator.
- **`0-reconcile`**: task agents send it merge requests once their work is
  approved. It replies to the task agent and to that agent's orchestrator.

## Select The Transport

Select the transport from the tools available in the current session. A model
or provider name does not establish which communication features the harness
provides.

- When `ListAgents` and `SendMessage` are available, read
  [`references/claude-code.md`](references/claude-code.md).
- When another harness provides equivalent cross-session tools, use its direct
  messaging facility. Apply the same addressing and fallback rules described
  in the Claude Code reference.
- When direct messaging is unavailable, the recipient cannot be reached, or
  the agents use incompatible harnesses, read
  [`references/file-based.md`](references/file-based.md).

Read only the reference for the selected transport. If direct messaging fails,
load the file-based reference and continue there.

## Message Contract

Identify every message with its sender, recipient, and status or request. Use
the workspace names defined above. Keep a message self-contained when the
recipient cannot inspect the sender's session.

Use these statuses consistently: `READY FOR REVIEW`, `CHANGES REQUESTED`,
`BLOCKED`, `QUESTION`, `APPROVED`, `MERGE`, `MERGED`, `CONFLICT`, and `FAILED`.

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

## Merge requests

Once its work is `APPROVED`, the task agent sends `0-reconcile` a merge
request:

```
To: 0-reconcile-calm-lynx
From: 1-import-2-tasks-brave-otter
Request: MERGE
Orchestrator: 1-import-1-orchestrator-wistful-pony
Plan: /absolute/path/to/orchestrator/docs/work/2026-09-11-import-plan.md
Worktree: /absolute/path/to/task-worktree
Branch: 1-import-2-tasks-brave-otter
Commits: a1b2c3d..e4f5a6b
Approved: round 2, by 0-plan-review-keen-heron
Tests: the focused tests run, and their results
```

Reconcile replies to the task agent and its orchestrator with one of these:

- `MERGED`, with the resulting commit
- `CONFLICT` or `FAILED`, with numbered details and what it needs
- `QUESTION`, when it needs something before it can continue

Answer `CONFLICT` and `FAILED` the way you answer review comments. Fix the
problem, then send a new merge request with only the new commits.
