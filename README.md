# Agent Skills

Cross-project skills for Claude Code and Codex. OpenCode reads
`~/.claude/skills` as well.

| Skill | For |
|---|---|
| `polyscope-workflow` | Route a Polyscope session to its role and supporting skills. |
| `polyscope-launch` | Launch and inspect managed Polyscope workspaces with `ps`. |
| `agent-orchestration` | Run an orchestrated team: roles, setup, planning, dispatch, and briefs. |
| `agent-reconcile` | The single Opus `0-reconcile` agent: merge, test, clean history, push. |
| `agent-plan-review` | The single Fable `0-plan-review` agent: write plans, review commits. |
| `plan-review-communication` | How to request plans and reviews from `0-plan-review`, and its replies. |
| `agent-task-work` | Task agents implementing a brief. |
| `agent-communication` | Shared agent protocol with direct and file-based transports. |
| `context-reset` | Reset a long session: a resume note, a block to paste back in, and check-ins. |
| `agent-repurpose-workspace` | Reuse a workspace for a new role: wrap up, rename, reset. |
| `commits` | No agent attribution in commits and PRs; loose conventional-commit style. |
| `writing` | House prose style and writing conventions. |
| `project-docs` | Dated work logs in `docs/work/`, pickup notes in `docs/notes/`. |
| `system-config` | Change the Mac only through `~/System`, never by hand. |
| `r-stats` | Statistical work in R: framework, readability, notebooks, scripts, plots. |

The harness can also route an agent to a third-party API instead of a Claude
model. Which models are in use changes over time; plan/review gets the stronger
one, and every other role the cheaper one.

## Terms

An **orchestrated team** is a multi-agent effort with an orchestrator,
plan/review, task executors, and reconciliation. A request may name proposed
work units. The planner checks their dependencies and file overlap before task
agents are dispatched. Claude Code names the requested agent runtime. The
running harness determines whether agents use direct messages or context files.

## Install

```bash
./install.sh
```

Run the installer from the canonical checkout at `~/Projects/agents-skills`.
It makes that checkout the sole source of user-installed system-wide skills in
`~/.claude/skills/` and `~/.codex/skills/`: stale links are removed, current
links are repaired, and harness-owned hidden entries are preserved. It refuses
to delete a real directory placed in either skills directory.

Edit the files in the canonical checkout and the links pick up the changes.
Re-run the installer after adding, renaming, or removing a skill. Repeated runs
leave the same installed state.

```bash
bash tests/install-test.sh
```

## Adding a skill

Create `skills/<name>/SKILL.md` with `name` and `description` frontmatter, and
keep it short. Skills about a single project belong in that project's
`.claude/skills/` instead.
