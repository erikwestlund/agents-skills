---
name: workflow-multi-simple
description: "Coordinate several independent bounded coding tasks with a lead, parallel workers, and a reconciler. Use after selecting the multi-simple workflow."
---

# Multiple simple tasks

Launch one `lead`, one `task_worker_mechanical` per independent task, and one
`reconciler`. Their policy defaults are medium, low, and low reasoning.

The launcher gives the lead a complete assignment. The lead can immediately
break the work into bounded briefs, validate file ownership, dispatch workers,
and perform the group review. Each worker starts only after its lead-provided
brief includes owned files, acceptance criteria, focused tests, and a base.

Workers return committed review handoffs to the lead. The lead sends approved
merge requests to the reconciler. The reconciler merges clean work and runs the
integration checks. It escalates to `reconciler_escalation` when conflict or
integration judgment exceeds a clean mechanical merge.

Use automatic direct messages in the `claude-code harness`. In `default
polyscope`, the user carries copy-ready messages with absolute paths; a memo is
read only when its path is named in that message.
