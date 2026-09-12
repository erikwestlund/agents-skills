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

`{group}-{surface}-{sequence}-{work}-{worktree}`

- **group**: a number that orders task groups. `0` is reserved for
  reconciliation. A single-task initiative can use `0` for its task workspace;
  task groups start at `1` when more work is added.
- **surface**: the problem area (`import`, `theme`).
- **sequence**: a sorting position within the group. It is not a task ID, but
  it is required: `1` is plan/review, `2` is orchestrator, and task workers
  begin at `3` and increment from there.
- **work**: the role, if roles differ (`orchestrator`, `plan-review`,
  `reconcile`, `tasks`, `copy`).
- **worktree**: the Polyscope name, unchanged.

Drop segments that add nothing.

```
0-reconcile-calm-lynx
0-sign-up-tasks-quick-otter
1-import-1-plan-review-amber-fox
1-import-2-orchestrator-wistful-pony
1-import-3-tasks-brave-otter
2-demos-1-plan-review-keen-heron
```

The sequence exists so the sidebar reads top to bottom as plan, orchestrate,
then execute. Preserve it exactly: do not use `1` for an orchestrator, do not
start task workers below `3`, and assign extra workers `4`, `5`, and onward.

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
  name. The one exception is repurposing the workspace for a new role, such as
  changing a single-task `0-…-tasks` workspace into `0-reconcile-…` after the
  initiative gains task groups, as `agent-repurpose-workspace` describes.
- **Nothing on disk moves.** The checkout folder keeps the bare worktree name,
  and so does anything built from it, such as preview URLs.
- Sign messages and name context files with your branch, which is the full
  workspace name. Build paths and preview URLs from the folder.

## Who talks to whom

Each agent talks to its parent. Task agents talk to their group’s orchestrator,
and subagents talk to the agent that spawned them. There is one initiative-level
workspace:

- **`0-reconcile`**: receives approved group merge requests when more than one
  task group exists. A single task reconciles its own change.

## Verify the recipient before messaging

Before every cross-workspace message, verify the recipient from its actual
worktree—not its sidebar position, bare animal name, or a remembered launch
order. This prevents a correct brief from reaching the wrong agent.

1. Resolve the Polyscope workspace record to its absolute local path.
2. Run `git -C <path> branch --show-current` and confirm the branch names the
   intended group and role.
3. Inspect the recipient's relevant local state: its `.context/` files and the
   plan, brief, or handoff it is supposed to receive or act on. Confirm its
   current role and state match the message—for example, the planner is the
   planner for that group, the orchestrator is waiting for that plan, or the
   task worker is waiting for that orchestrator's brief.
4. Confirm every absolute path and workspace name in the outgoing message
   belongs to that same group.

If any check disagrees, do not send. Find the correct worktree or ask the
sender/parent to resolve the identity. Repeat this check when a workspace has
been renamed, repurposed, reset, or has received a new assignment.

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

Once a group’s work is `APPROVED`, its orchestrator sends `0-reconcile` a
merge request. A single `0-…-tasks` workspace has no separate merge request:
it reconciles its own change.

```
To: 0-reconcile-calm-lynx
From: 1-import-3-tasks-brave-otter
Request: MERGE
Orchestrator: 1-import-2-orchestrator-wistful-pony
Plan: /absolute/path/to/planner-worktree/docs/work/2026-09-11-import-plan.md
Worktree: /absolute/path/to/task-worktree
Branch: 1-import-3-tasks-brave-otter
Commits: a1b2c3d..e4f5a6b
Approved: round 2, by 1-import-1-plan-review-amber-fox
Tests: the focused tests run, and their results
```

Reconcile replies to the task agent and its orchestrator with one of these:

- `MERGED`, with the resulting commit
- `CONFLICT` or `FAILED`, with numbered details and what it needs
- `QUESTION`, when it needs something before it can continue

Answer `CONFLICT` and `FAILED` the way you answer review comments. Fix the
problem, then send a new merge request with only the new commits.
