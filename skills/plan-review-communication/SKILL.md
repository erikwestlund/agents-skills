---
name: plan-review-communication
description: "Exchange plan and review requests within one task group. Load when sending or handling those requests."
---

# Talking to group plan/review

Each task group can have one plan/review workspace,
`N-<group>-…-plan-review-<worktree>`. It runs on the planner model. It handles
that group's plan and review. Task agents do not contact it directly.

The team launcher creates one before the group's orchestrator, so every
multi-group effort has a real plan before task dispatch. The planner sends its
first `PLAN READY` result to the team launcher; after that the group
orchestrator sends plan and review requests. Do not create one for another
group.

## Channel

Select the transport through `agent-communication`. With direct messaging,
send the request to the plan/review workspace. With file-based communication,
use two files in the shared `.context/` directory:
`<requester>.plan-review-request.md`, which you write, and
`<requester>.plan-review-reply.md`, which it writes. Watch the reply file as
the selected transport reference describes.

## Requests

Make every request self-contained, because plan/review may have reset its
context since your last one. Start with the request type, sign it, and give
absolute paths for everything.

```
To: 1-import-1-plan-review-keen-heron
From: 1-import-1-orchestrator-wistful-pony
Request: REVIEW
Plan: /absolute/path/to/planner-worktree/docs/work/2026-09-11-import-plan.md
Brief: /absolute/path/to/project/.context/1-import-2-tasks-brave-otter.brief.md
Worktree: /absolute/path/to/task-worktree
Commits: a1b2c3d..e4f5a6b
Round: 2. Comments 1-4 from round 1; the task agent says all are fixed.
```

- **PLAN:** give the group goal, constraints, checkout to write the plan in,
  and pointers to the context it needs, such as files and docs.
- **REVIEW:** give the plan file, the brief, the task's worktree, and the
  commit range. For later rounds, add the round number and the previous
  comments, and send only the new commits.

Send one request per task at a time. Plan/review handles requests in order, so
don't nudge it.

## Replies

Plan/review replies to the sender, signed, and starts with a status:

- `PLAN READY`, with the plan file's absolute path
- `APPROVED`
- `CHANGES REQUESTED`, with one batch of numbered, actionable comments
- `QUESTION`, when it needs something from you before it can continue

Answer a `QUESTION` in the same channel. Before passing review comments on to
a task agent, check them as `agent-orchestration` describes.
