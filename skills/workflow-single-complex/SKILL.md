---
name: workflow-single-complex
description: "Plan, implement, and review one complex coding task with a focused planner/reviewer and executor. Use after selecting the single-complex workflow."
---

# Single complex task

Launch two roles:

- `planner_reviewer`, default high reasoning
- `task_worker`, default medium reasoning

The launcher gives the planner a complete planning assignment. That assignment
authorizes it to inspect the repository, write a focused plan, and identify
the executor brief. The planner owns review after implementation.

The executor begins only after receiving the planner's complete brief. It
implements, runs focused tests, commits if requested, and returns a review
handoff. The planner reviews the commit range. The executor reconciles its own
approved change and pushes only when the user explicitly authorizes it.

For `default polyscope`, give each handoff as one copy-ready block containing
the relevant absolute plan, brief, worktree, and commit paths. For the
`claude-code harness`, deliver it directly and automatically.
