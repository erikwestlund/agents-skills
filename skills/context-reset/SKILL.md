---
name: context-reset
description: "How to reset an agent's context without losing its place. Load when context is getting heavy, before a /clear, or when the user asks to reset, clear, or restart a session."
---

# Context reset

When your context gets heavy (a long transcript, a lot of tool output,
compaction warnings) or the user asks, reset it instead of pushing on.

1. **Write a resume note** to `docs/notes/yyyy-mm-dd-<topic>.md` in your
   checkout (see `project-docs`). A fresh agent must be able to act from it
   alone:
   - who you are: your workspace name, your role, and the skills to load
   - the goal, or the absolute paths of the plan and brief that define it
   - what's done, with commits
   - what's in progress, including uncommitted changes
   - the next step, specific enough to act on
   - decisions made and why, and open questions
   - absolute paths to everything else you need: handoff and context files,
     key source files, and preview URLs
   - for orchestrators, the other agents: their names, tasks, and status
   - the agents to check in with after the reset, by name (see below)
2. **Tell any agents waiting on you** that you're resetting.
3. **Give the user one copyable block** to paste after clearing. It names you
   and your role, the skill to load, the note's absolute path, and the agents
   to check in with:

   ```
   You are 1-import-2-tasks-brave-otter, a task agent. Load the
   agent-task-work skill. Read
   /absolute/path/to/worktree/docs/notes/2026-09-11-import-resume.md,
   then check git status and the log. Check in with your orchestrator,
   1-import-1-orchestrator-wistful-pony, before continuing from the note's
   next step.
   ```

4. Ask the user to run `/clear` and paste the block.

## After the reset

1. Read the note.
2. Check the actual state: `git status`, the log, and any handoff or context
   files. Trust the repo over the note where they disagree.
3. **Check in before you act.** Message the agents you depend on. Say where you
   think things stand and ask what has changed since:
   - **Orchestrators** check in with their group plan/review and `0-reconcile`.
   - **Task agents** check in with their orchestrator.
   - **Group plan/review and `0-reconcile`** check in with each orchestrator
     whose request is still open.
4. Continue from the next step once they've answered, or once you've confirmed
   nothing is waiting on them.
