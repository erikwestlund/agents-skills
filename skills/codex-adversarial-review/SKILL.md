---
name: codex-adversarial-review
description: "Use the Codex plugin for an independent adversarial review of work produced by a non-OpenAI model, including Claude Code sessions."
---

# Codex adversarial review

Before approving or reconciling work produced by a non-OpenAI model, request
an adversarial review through the installed Codex plugin. Treat a Claude Code
runtime as eligible even when its model is served through an Anthropic or a
third-party provider.

Choose the Codex reviewer to match the model whose work is being reviewed:

| Source model | Codex reviewer |
|---|---|
| Fable | Astra |
| Opus | Sol |
| Sonnet or worker-tier model | Terra |

Give the reviewer the task brief or acceptance criteria, the relevant diff or
commit range, tests run, and any known risks. Ask it to look for correctness
issues, missed requirements, regressions, security concerns, and inadequate
tests. Treat its findings as review input: verify each one against the code,
fix valid issues, and explain declined findings in the review record.

Use the plugin only for review. The Codex reviewer does not replace the owner
of the work, the assigned plan/reviewer, or the required tests. If the plugin
or requested reviewer is unavailable, report that limitation before approval
or reconciliation.
