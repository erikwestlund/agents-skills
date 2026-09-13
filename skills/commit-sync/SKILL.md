---
name: commit-sync
description: "After creating a Git commit, check the current branch against its origin upstream and report the safe action needed to synchronize it."
---

# Commit Sync

Use this skill immediately after making a commit. Check whether the current
branch has an upstream branch and refresh remote tracking data with
`git fetch origin` before reporting its state.

- If the branch is ahead, tell the user that `git push` will synchronize
  `origin` and report the number of commits to push.
- If it is behind, tell the user it needs to incorporate the remote changes
  before a push. Do not choose merge, rebase, or reset unless the user asks.
- If it has diverged, report both commit counts and ask the user how they want
  to reconcile the histories.
- If it is synchronized, say so.
- If there is no upstream, report that and offer the appropriate
  `git push --set-upstream origin <branch>` command.

Do not push, pull, rebase, reset, or otherwise change branch history solely
because this skill ran. Follow the user's authorization for those actions.
