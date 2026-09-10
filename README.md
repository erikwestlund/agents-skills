# Agent Skills

Cross-project skills for Claude Code and Codex. OpenCode reads
`~/.claude/skills` as well.

| Skill | For |
|---|---|
| `agent-orchestration` | The orchestrator: plan, brief, review, integrate. |
| `agent-task-work` | Task agents implementing a brief. |
| `agent-communication` | Workspace names, channels, context files, handoffs. |

## Install

```bash
./install.sh
```

This links each `skills/<name>` into `~/.claude/skills/` and `~/.codex/skills/`.
Edit the files here and the links pick up the changes. Re-run it after adding a
skill.

## Adding a skill

Create `skills/<name>/SKILL.md` with `name` and `description` frontmatter, and
keep it short. Skills about a single project belong in that project's
`.claude/skills/` instead.
