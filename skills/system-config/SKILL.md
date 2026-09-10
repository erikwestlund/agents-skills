---
name: system-config
description: Change this Mac only through the ~/System repo, using its Ansible roles and config/ directory, never by hand. Load before installing or removing packages or apps, or editing dotfiles, shell config, aliases, macOS preferences, LaunchAgents, or anything else on the machine outside a project.
---

# System config

`~/System` manages this Mac with Ansible. Every change to the system goes
through it, so the repo stays a complete record of how the machine is set up.
A project's own dependencies, such as renv or npm packages inside a project,
aren't system changes.

**First, check whether an agent is already running in `~/System`, especially a
Claude session. If one is, message it directly** (in Claude Code, find it with
`ListAgents`, then use `SendMessage`). Say what you need changed and why, and
let it make and deploy the change. If no agent is running, make the change
yourself as follows:

- Read `~/System/AGENTS.md` and `~/System/README.md` first and follow them.
- Make the change in the repo: packages and apps go in the Ansible roles, and
  config files go under `config/`. Don't run `brew install` or
  `defaults write`, and don't edit a live dotfile by hand.
- If the repo manages a live file, either as a symlink into the repo or as a
  copy, edit the source in `~/System`, not the live file.
- Deploy with the repo's aliases: `mac-sys` for everything, or a narrower one
  such as `mac-packages`, `mac-dotfiles`, or `mac-prefs`.
- Update `README.md` when the system's behavior changes.
- If Ansible can't manage something, note it in `AGENTS.md` and tell the user.
