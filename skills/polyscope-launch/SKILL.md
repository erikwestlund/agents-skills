---
name: polyscope-launch
description: "Launch and inspect managed Polyscope workspaces with ps, including direct versus isolated workspaces, model selection, and provider profiles. Use when starting, checking, or choosing a model for a Polyscope workspace on this Mac."
---

# Polyscope Launcher

`ps` is the managed launcher for Polyscope workspaces on this Mac. Its source
is `~/System/config/bin/polyscope`. Use it when the user asks to start an
agent, select an agent model, or inspect a project's Polyscope workspaces.

## Choose a Workspace Mode

- `ps launch <project> [-m <model>] [--message <task> | prompt]` creates an
  isolated worktree. Use it for implementation work unless the user asks for
  a direct edit.
- `ps direct <project> [-m <model>] [--message <task> | prompt]` uses the
  project's existing main-checkout workspace. It opens Polyscope without a
  prompt, or sends the supplied prompt to that workspace.
- `ps<alias>` is the generated shorthand for `ps direct <alias>`.
- `ps status <project>` lists the project's workspaces.

Project identifiers are aliases or names from
`~/System/config/projects/projects.yml`. `p<alias>` remains the Positron
shortcut.

Use a complete task prompt when one is supplied. The launcher adds the project
context and, for R projects, directs the agent to load `r-stats`. A user who
asks only for a workspace has authorized a launch without an extra prompt; it
creates a ready workspace without sending an initial agent task.

## Orchestrated Teams

Treat `orchestrated team` as the user-facing term for a multi-agent effort. It
means an orchestrator, a plan/review workspace, one or more task workspaces,
and a reconcile workspace. When the user asks for one, load
`agent-orchestration` and `agent-communication` before launching agents.

The named work units are planning input. Ask the planner to check their
boundaries and dependencies before dispatching task agents. Use isolated
workspaces unless the user explicitly requests direct edits. Select direct
messages or context files from the actual harness capabilities; `Claude Code`
in the request identifies the agent runtime, not a required transport.

## Models and Providers

Run `ps models` before selecting a model when the request does not name a known
model. It reports the configured launcher names and whether each provider
profile is ready. The registry lives in
`~/System/config/agent-providers/providers.yml` under `launcher_models`.

Interpret these common model requests without asking the user to define them:

- `Terra` means `oa_terra` (`gpt-5.6-terra`).
- `Sol`, `Luna`, and `Astra` mean `oa_sol`, `oa_luna`, and `oa_astra`.
- `Claude Code DeepSeek Flash 4.1` and `DeepSeek Flash 4.1` mean `ds_flash`.
- `workspace` means an isolated `ps launch` workspace. Use `ps direct` only
  when the user says direct, main checkout, or equivalent.

Resolve the requested project through the project registry, then launch it:

```zsh
ps launch <project> --model oa_terra
```

Do not ask the user to restate a project or model that the registries resolve.

Pass a model with `-m` or `--model`:

```zsh
ps launch <project> --model oa_terra "Implement the requested change."
ps launch <project> --model ds_flash "Review the current implementation."
ps launch <project> -m oa_terra --message "Implement the requested change."
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

The current launcher passes a model identifier to Polyscope. It has no
reasoning-effort option. Do not claim that a prompt phrase such as "reason at
high effort" changes the actual reasoning setting. Check the Polyscope API and
the live capability catalog before adding or documenting effort control.

## Credentials and Managed State

The Polyscope API token comes from
`polyscope.mac_studio.api_token` in the System vault. The secrets role writes
it to `~/.config/polyscope/api-token` with mode `0600`.

- Do not print, read, copy, or commit the token.
- `POLYSCOPE_API_TOKEN` is an intentional one-shell override.
- If the managed token is missing or needs to change, load `system-config` and
  update the System source and secrets deployment. Do not create the token file
  by hand.

`ps launch` starts work and can incur model usage. Confirm the project, model,
and prompt with the user when they are ambiguous. `ps status` and `ps models`
are read-only.
