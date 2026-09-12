# Claude Code Communication

Use this transport when `ListAgents` and `SendMessage` are available and the
recipient is reachable through them.

1. Use `ListAgents` to resolve the recipient's exact workspace name and active
   session.
2. Send the complete message with `SendMessage`.
3. Address replies through the same direct channel.

Direct messages are the preferred transport between Claude Code agents. They
remove the need to create, watch, and poll live message files. Lasting project
notes still belong in `docs/` under the `project-docs` skill.

Use the shared message, handoff, review, and merge-request formats from
`agent-communication`. If the recipient is absent, unreachable, or running in
an incompatible harness, read
[`file-based.md`](file-based.md) and use its fallback.
