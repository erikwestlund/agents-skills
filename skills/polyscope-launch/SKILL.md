---
name: polyscope-launch
description: "Launch and inspect managed Polyscope workspaces with ps, including direct versus isolated workspaces, model selection, and provider profiles. Use when starting, checking, or choosing a model for a Polyscope workspace on this Mac."
---

# Polyscope launcher

`ps` is the managed launcher for Polyscope workspaces on this Mac. Its source
is `~/System/config/bin/polyscope`. Use it when the user asks to start an
agent, select an agent model, or inspect a project's Polyscope workspaces.

## Choose a workspace mode

- `ps launch <project> [-m <model>] [--message <task> | prompt]` creates an isolated
  worktree. Use it for implementation work unless the user asks for a direct
  edit.
- `ps direct <project> [-m <model>] [--message <task> | prompt]` uses the project's existing
  main-checkout workspace. It opens Polyscope without a prompt, or sends the
  supplied prompt to that workspace.
- `ps<alias>` is the generated shorthand for `ps direct <alias>`.
- `ps status <project>` lists the project's workspaces.

Project identifiers are aliases or names from
`~/System/config/projects/projects.yml`. `p<alias>` remains the Positron
shortcut.

Use a complete task prompt when one is supplied. The launcher adds the project
context and, for R projects, directs the agent to load `r-stats`. A user who
asks only for a workspace has authorized a launch without an extra prompt; it
creates a ready workspace without sending an initial agent task.

## Agent workflows

When the user asks to organize or launch coding agents, load `workflow-select`
first. It selects the single-simple, single-complex, multi-simple, or
multi-complex shape and requires model confirmation where appropriate. The
rest of this section describes the multi-complex orchestrated-team shape.

## Orchestrated teams

Treat `orchestrated team` as the user-facing term for a multi-agent effort.
Organize the requested work into task groups. Each group has a separate
planner/reviewer, orchestrator, and one or more task workspaces. `0` is
reserved for reconciliation. For `G` groups, the initial team has exactly
`1 + (3 × G)` workspaces: `0-reconcile`, plus a planner/reviewer, an
orchestrator, and a waiting task worker per group. Task groups start at `1`.
When an initiative has one task, use one `0-…-tasks` workspace that also
reconciles its own change. When the user asks to start an orchestrated team,
load `agent-based-polyscope-launching` and `polyscope-team-launch`, then use
`agent-orchestration` inside each group.

The launcher gives each planner a complete planning assignment, which
authorizes planning. Workers start only after their parent gives them a
complete implementation brief. Use isolated workspaces unless the user
explicitly requests direct edits. Select the claude-code harness or default
polyscope communication medium from actual capabilities; `Claude Code` in the
request identifies the agent runtime, not a required transport.

For example:

```text
Start an orchestrated Claude Code team for academic.page using DeepSeek Flash 4.1.
Plan and execute these work units: sign-up, import, and demos.
```

This resolves the project to `peq` and the model to `ds_flash`. Each named work
unit becomes a task group unless the user groups them differently.

## Models and providers

Run `ps models` before selecting a model when the request does not name a
known model. It reports the configured launcher names and whether each provider
profile is ready. The registry lives in
`~/System/config/agent-providers/providers.yml` under `launcher_models`.

Interpret these common requests without asking the user to define them:

- `Terra` means `oa_terra` (`gpt-5.6-terra`).
- `Sol`, `Luna`, and `Astra` mean `oa_sol`, `oa_luna`, and `oa_astra`.
- `Claude Code Opus` and `Opus` mean `claude_opus`, which selects the native
  Claude profile and a live Opus model together.
- `Claude Code DeepSeek Flash 4.1` and `DeepSeek Flash 4.1` mean
  `ds_flash`.
- `Pequod`, `academic.page`, and `academic.test` mean project `peq`.
- `workspace` means an isolated `ps launch` workspace. Use `ps direct` only
  when the user says direct, main checkout, or equivalent.

For example, launch the easy case directly:

```zsh
ps launch peq --model oa_terra
```

Thus, for “launch a Terra Polyscope workspace for Pequod/academic.page”, run
that command immediately. Do not ask what Terra means, whether the workspace
is direct, or for a task prompt: the mappings above settle those choices.

Pass a model with `-m` or `--model`:

```zsh
ps launch peq --model oa_terra "Implement the requested change."
ps launch peq --model ds_flash "Review the current implementation."
ps launch peq -m oa_terra --message "Implement the requested change."
```

The final quoted text is optional. When it is present, send it as the first
agent task. `--message` is the explicit equivalent. Do not combine it with a
final prompt, and do not invent a task from the workspace request alone.

The launcher accepts a configured launcher name, a ready Claude provider
profile, or an exact model ID returned by Polyscope. Provider-backed selections
are applied to the worktree before its initial agent prompt. For a direct
workspace, the agent must be idle before changing its provider profile.

Do not infer a model ID from a provider or model family. The live Polyscope
catalog decides what can launch. Use the registry's provider namespace:
`oa_` for OpenAI, `claude_` for native Claude, `ds_` for DeepSeek's own
platform, `fw_` for Fireworks, and `zai_` for Z.ai.

## Agent runtime

The selected model also determines the agent runtime. This is not cosmetic.

- A launcher selection with a managed `claude_profile` runs the Claude Code
  CLI. That includes `claude_*`, `ds_*`, `fw_*`, and `zai_*` registry entries.
  Use Claude Code's installed skills, provider profiles, and normal Claude Code
  messaging behavior.
- An `oa_*` selection chooses an OpenAI model in Polyscope and runs
  Polyscope's native OpenAI agent, not the Claude Code CLI. Do not ask it to
  run `claude`, change a Claude profile, rely on Claude-specific tools, or
  assume Claude skills are available. Give it a self-contained brief and use
  Polyscope workspace messages for coordination.

Default to Claude Code whenever the chosen model has a Claude Code provider
profile. Use the native Polyscope agent for OpenAI models. State the runtime in
each launch summary, especially for a mixed-model team.

The current launcher passes a model identifier to Polyscope. It has no
reasoning-effort option. Do not claim that a prompt phrase such as "reason at
high effort" changes the actual reasoning setting. Check the Polyscope API and
the live capability catalog before adding or documenting effort control.

## Credentials and managed state

The Polyscope API token comes from
`polyscope.mac_studio.api_token` in the System vault. The secrets role writes
it to `~/.config/polyscope/api-token` with mode `0600`.

`ps launch` and `ps direct` record Claude's folder-trust decision for their
registered worktree before sending an agent task. This skips Claude Code's
per-worktree trust prompt while preserving normal tool-permission rules.
`claude-trust-workspace <path>` applies the same setting to one explicit path.
It updates Claude Code's undocumented `~/.claude.json` state and must run
before the first Claude session in that path.

- Do not print, read, copy, or commit the token.
- `POLYSCOPE_API_TOKEN` is an intentional one-shell override.
- If the managed token is missing or needs to change, load `system-config` and
  update the System source and secrets deployment. Do not create the token file
  by hand.

`ps launch` starts work and can incur model usage. Confirm the project, model,
and prompt with the user when they are ambiguous. `ps status` and `ps models`
are read-only.
