---
name: repurpose-workspace
description: How to repurpose an agent's workspace for a new role or task. The agent wraps up the old work, renames the workspace, and resets its context into the new role. Load when the user or an orchestrator asks you to take on a new role or task in your existing workspace, or to reuse or repurpose a workspace.
---

# Repurpose a workspace

Repurposing is a context reset with a new identity. The workspace takes a new
name and role and starts fresh, with nothing from the old role left hanging.

The orchestrator or the user chooses the new name, following the convention in
`agent-communication`. Repurposing is the only time a named workspace renames
again.

1. **Wrap up the old role.** Commit everything. Make sure your work is merged,
   or explicitly handed to another agent. Tell the agents you worked with that
   this workspace is leaving the role, and who now owns anything still open.
2. **Write a closing note** for the old role to
   `docs/notes/yyyy-mm-dd-<topic>.md`: where the work ended, what's still
   open, and who owns it now.
3. **Switch to the new name.** If the new work builds on your current branch,
   rename it as `agent-communication` shows. Otherwise, start a fresh branch
   from the new base and point Polyscope's row at it:

   ```
   new=<new-name>
   git switch -c "$new" <base>
   sqlite3 ~/.polyscope/polyscope.db "update worktrees set branch = '$new', branch_renamed = 1 where path = '$(git rev-parse --show-toplevel)';"
   ```

   Delete the old branch only with `git branch -d`, which refuses when its
   work isn't merged. If it refuses, leave the branch alone.
4. **Give the user one copyable block** to paste after clearing. It names the
   new identity and role, the skill to load, the brief or plan to read by
   absolute path, and the agents to check in with:

   ```
   You are 1-theme-2-tasks-brave-otter, a task agent. Load the
   agent-task-work skill. Read your brief at
   /Users/erik/Projects/pequod/.context/1-theme-2-tasks-brave-otter.brief.md.
   Check in with your orchestrator, 1-theme-1-orchestrator-amber-fox, before
   starting.
   ```

5. Ask the user to run `/clear` and paste the block.

In the new role, check in as `context-reset` describes for that role, then
start from the brief.
