---
name: workflow-single-simple
description: "Run one bounded, low-risk coding task with one medium-cost executor. Use after selecting the single-simple workflow."
---

# Single simple task

Use one `task_worker_mechanical` executor. Its policy default is low reasoning;
raise it to medium when the task needs ordinary debugging or judgment.

The launcher's complete brief authorizes the worker to start. It must include
the goal, owned files, acceptance criteria, focused tests, base branch, and
whether a commit is requested. The worker implements, tests, and reports the
result. It may reconcile its own change. Pushing remains explicit user
authorization.

There is no planner, orchestrator, or separate reconciler. Escalate to
`workflow-single-complex` if design questions or scope expansion appear.
