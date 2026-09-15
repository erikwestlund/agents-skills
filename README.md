# Agent Skills

Cross-project skills for Claude Code and Codex. OpenCode reads
`~/.claude/skills` as well.

| Skill | For |
|---|---|
| `polyscope-workflow` | Route a Polyscope session to its role and supporting skills. |
| `polyscope-launch` | Launch and inspect managed Polyscope workspaces with `ps`. |
| `polyscope-team-launch` | Provision a Polyscope team before group orchestration begins. |
| `agent-based-polyscope-launching` | Launch and activate every role in a Polyscope team. |
| `agent-orchestration` | Run an orchestrated team: roles, setup, planning, dispatch, and briefs. |
| `agent-reconcile` | The single `0-reconcile` agent: merge, test, clean history, push. |
| `agent-plan-review` | Planning and review within one task group. |
| `plan-review-communication` | How to request plans and reviews within one task group. |
| `agent-task-work` | Task agents implementing a brief. |
| `agent-communication` | Shared agent protocol with direct and file-based transports. |
| `context-reset` | Reset a long session: a resume note, a block to paste back in, and check-ins. |
| `agent-repurpose-workspace` | Reuse a workspace for a new role: wrap up, rename, reset. |
| `commits` | No agent attribution in commits and PRs; loose conventional-commit style. |
| `commit-sync` | After a commit, check the branch against `origin` and report how to synchronize it. |
| `codex-adversarial-review` | Use Codex to independently review work from non-OpenAI models. |
| `php-testing` | Run PHP tests with installed PAO support and parallel execution where supported. |
| `writing` | House prose style and writing conventions. |
| `project-docs` | Dated work logs in `docs/work/`, pickup notes in `docs/notes/`. |
| `system-config` | Change the Mac only through `~/System`, never by hand. |
| `r-stats` | Statistical work in R: framework, readability, notebooks, scripts, plots. |

The harness can also route an agent to a third-party API instead of a Claude
model. Which models are in use changes over time; plan/review gets the stronger
one, and every other role the cheaper one.

## Agent runtimes

Model namespace also selects the runtime. `claude_*`, `ds_*`, `fw_*`, and
`zai_*` models use Claude Code by default through a managed provider profile.
`oa_*` models run Polyscope's native OpenAI agent, not the Claude Code CLI.
OpenAI workspaces need self-contained briefs and Polyscope messages; do not
give them Claude CLI, profile, or Claude-only-skill instructions.

## Terms

An **orchestrated team** divides the requested work into task groups. Each
group has a planner/reviewer, an orchestrator, and one or more task executors.
`0` is the initiative-level namespace for reconciliation when several groups
exist. Task groups start at `1`. A one-task initiative uses a single
`0-…-tasks` workspace that reconciles its own change. The planner makes the
group plan; the orchestrator checks dependencies and file overlap, then
dispatches its task agents from that plan. Claude Code names the requested
agent runtime. The running harness determines whether agents use direct
messages or context files.

For `G` requested groups, an orchestrated team initially has `1 + (3 × G)`
workspaces: `0-reconcile`, then a planner/reviewer, orchestrator, and waiting
task worker for every group. Two groups therefore start seven workspaces.
`agent-based-polyscope-launching` activates each one and carries `PLAN READY`
from planner to orchestrator, then the plan-derived task brief from
orchestrator to worker. For “planners run Opus; the rest run DeepSeek Flash,”
planners use `claude_opus` and orchestrators, workers, and reconcile use
`ds_flash`.

The number after the task-group name is a sorting sequence: `1` is
plan/review, `2` is orchestrator, and tasks start at `3` (`4+` for added
workers). It is not a task ID, but it is required so each group reads top to
bottom in Polyscope.

New teams begin **dormant**. Their initial messages permit orientation and
partner check-ins only—never planning, code changes, tests, dispatch, commits,
merges, or pushes. Erik directly messages a planner to authorize the first
group plan; only its resulting handoff activates the group orchestrator and
task worker.

Every activation brief begins with its assigned branch name and an instruction
to rename both the git branch and Polyscope database row before any other work.
This is mandatory for plan/review workspaces as well as the other roles.

`ps launch` and `ps direct` preapprove Claude Code folder trust for the
registered workspace before its first agent task. This leaves normal
tool-permission rules in place.

For example: “Start an orchestrated Claude Code team for academic.page using
DeepSeek Flash 4.1. Plan and execute these work units: sign-up, import, and
demos.”

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
