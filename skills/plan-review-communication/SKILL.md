---
name: plan-review-communication
description: How orchestrators request plans and reviews from the single 0-plan-review workspace, and how it replies. Load when you need a plan or a review from the plan/review agent, or when you are that agent handling requests.
---

# Talking to plan/review

There is one plan/review workspace, `0-plan-review-<worktree>`, and it runs on
Fable. Orchestrators at every level send it plan and review requests. Task
agents don't. Their reviews reach them through their orchestrator.

If there isn't one yet, create it or ask the user to, and never start a
second.

## Channel

Message it directly: find it with `ListAgents`, then use `SendMessage`. If you
can't, use two files in the shared `.context/` directory:
`<requester>.plan-review-request.md`, which you write, and
`<requester>.plan-review-reply.md`, which it writes. Watch the reply file as
`agent-communication` describes.

## Requests

Make every request self-contained, because plan/review may have reset its
context since your last one. Start with the request type, sign it, and give
absolute paths for everything.

```
To: 0-plan-review-keen-heron
From: 1-import-1-orchestrator-wistful-pony
Request: REVIEW
Plan: /Users/erik/.polyscope/clones/8389bf53/wistful-pony/docs/work/2026-09-11-import-plan.md
Brief: /Users/erik/Projects/pequod/.context/1-import-2-tasks-brave-otter.brief.md
Worktree: /Users/erik/.polyscope/clones/8389bf53/brave-otter
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
