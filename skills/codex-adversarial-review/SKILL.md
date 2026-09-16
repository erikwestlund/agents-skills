---
name: codex-adversarial-review
description: "Use the Codex plugin for an independent adversarial review of work produced by non-flagship models, such as DeepSeek or GLM."
---

# Codex adversarial review

This is required only for work produced by a non-flagship model, such as
DeepSeek or GLM. Do not invoke it merely because a session uses Claude Code,
and do not invoke it for work produced by an OpenAI or Anthropic flagship
model.

For eligible work, request an adversarial review through the installed Codex
plugin.

Choose the Codex reviewer to match the model whose work is being reviewed:

| Source model | Codex reviewer |
|---|---|
| Fable | Astra |
| Opus | Sol |
| Sonnet or worker-tier model | Terra |

This mapping selects a reviewer only after the non-flagship requirement is
met. It does not make a flagship model eligible for this review.

Give the reviewer the task brief or acceptance criteria, the relevant diff or
commit range, tests run, and any known risks. Ask it to look for correctness
issues, missed requirements, regressions, security concerns, and inadequate
tests. Treat its findings as review input: verify each one against the code,
fix valid issues, and explain declined findings in the review record.

Use the plugin only for review. The Codex reviewer does not replace the owner
of the work, the assigned plan/reviewer, or the required tests. If the plugin
or requested reviewer is unavailable, report that limitation before approval
or reconciliation.
