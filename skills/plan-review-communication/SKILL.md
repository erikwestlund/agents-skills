---
name: plan-review-communication
description: "Exchange plan and review requests with the single 0-plan-review workspace. Load when sending or handling those requests."
---

# Talking to plan/review

There is one plan/review workspace, `0-plan-review-<worktree>`, and it runs on
Fable, or on the stronger third-party model when the harness routes to a
third-party API. Orchestrators at every level send it plan and review
requests. Task agents don't. Their reviews reach them through their
orchestrator.

If there isn't one yet, create it or ask the user to, and never start a
second.

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
To: 0-plan-review-keen-heron
From: 1-import-1-orchestrator-wistful-pony
Request: REVIEW
Plan: /absolute/path/to/orchestrator/docs/work/2026-09-11-import-plan.md
Brief: /absolute/path/to/project/.context/1-import-2-tasks-brave-otter.brief.md
Worktree: /absolute/path/to/task-worktree
Commits: a1b2c3d..e4f5a6b
Round: 2. Comments 1-4 from round 1; the task agent says all are fixed.
```

- **PLAN:** give the goal, the constraints, the checkout to write the plan in,
  and pointers to the context it needs, such as files, docs, and earlier plans.
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
