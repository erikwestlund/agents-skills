---
name: writing
description: "Apply the house prose style and writing conventions. Load before drafting or editing user-facing copy, UI text, documentation, plans, briefs, messages, commit messages, or other prose."
---

# Writing

These rules apply to all prose. A project's style guide can add rules for its
own domain and deliverables.

## Governing Principle

Strip away the writer performing until the prose serves the reader. Write plain
declarative sentences. Let evidence and organization carry the argument. Do not
manage the reader with cleverness, drama, self-commentary, callbacks,
metaphors, overselling, over-defending, or emotional framing.

When a sentence is in doubt, ask whether the writer is performing or the
reader is using. Keep only the latter.

## Register And Voice

- Prefer a clear, measured register over punchiness or marketing language. For
  academic and technical subjects, lean lightly academic.
- State the fact without performing it.
- Explain a concept before giving its example.
- Use ordinary sequential sentences with one claim per sentence. Avoid
  compressed, slogan-like parallelism.
- Use bullets for enumerations with parallel stems. Use paragraphs for
  arguments.
- Use concrete subjects. Attach the explanation to the thing it describes.
- Use American English spellings: `catalog`, `color`, `gray`, `artifact`, and
  `favor`.

## Oxford Comma

Always put a comma before the final `and` or `or` in a list of three or more.

- Yes: "The study, its team, and its findings are made up for this demo."
- No: "The study, its team and its findings are made up for this demo."
- Two items take no comma: "The course and its materials."

This applies to UI copy, documentation, plans, briefs, agent messages, and
commit messages.

When fixing existing text, change only the commas unless the task calls for a
broader edit. Do not sweep generated or seeded content unless the task includes
it.

## Banned LLM Patterns

Treat every pattern below as a firm ban.

- **`X, not Y` antithesis.** State the fact once. Do not add a contrast for
  rhythm.
- **Dramatic reversal.** Avoid constructions such as "It is not X. It is Y."
- **Callback narration.** Do not tell readers that the prose is returning to
  an earlier question. State the question or claim directly.
- **Self-approving narration.** Do not tell readers why the sentence they are
  reading matters or why the handling inspires trust.
- **Sloganized closers.** End when the information ends. Do not append a
  call-to-action rhythm line or punchy kicker.
- **Epigrams and coined metaphors.** Replace clever formulations with plain
  terms or remove them.
- **Throat-clearing openers.** Delete phrases such as "The first thing to know
  is," "The question worth answering is," "One point of care applies," and
  "The catch is."
- **Comma overuse.** Join short paired clauses with a bare `and`. Use fewer
  colons and semicolons.
- **Em dash overuse.** Prefer a second sentence or parentheses. Use an em dash
  occasionally.
- **Relationship or defensive framing toward the reader.** Describe the
  operation factually.
- **Metaphors for technical or statistical concepts.** Use the domain's actual
  terms.
- **Fragment-style drama.** Write complete sentences.

## Sentence Construction

- Give a count its own short declarative sentence instead of appending it as a
  trailing aside.
- End a sentence when its information ends. Remove trailing flourishes.

## Final Check

Before returning a draft:

1. Search it for every banned pattern above.
2. Remove performance, throat-clearing, callbacks, and trailing flourishes.
3. Check American spelling and the Oxford comma.
4. Confirm that each sentence makes one useful claim.
