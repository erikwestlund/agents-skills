---
name: r-stats
description: "How to do statistical work in R: readable code, functions, Quarto notebooks, scripts, and plots. Load before writing or reviewing R analysis code, notebooks, or plots."
---

# Statistical work in R

Readability comes first in all statistical code. A person should be able to
read the code and follow the analysis without running it. Use clear names and
one step per line, and choose plain code over clever or compact code. Comment
on why you made a statistical choice, not on what the code does.

## Framework projects

If the project uses the framework package (it has a `settings.yml` and calls
`scaffold()`), follow its conventions: https://framework.table1.org. Start
notebooks and scripts with `library(framework)` and `scaffold()`, read and save
data with `data_read()` and `data_save()`, and use its directories.

## Where code goes

- **Functions:** Use functions for anything that is reused or not trivial. If a
  `functions/` directory exists, put them there. Framework sources it on
  `scaffold()`, so those files should hold definitions only.
- **Notebooks:** Put presentable work, such as analyses, results, and reports,
  in Quarto notebooks (in `notebooks/` when it exists). Render them to
  `outputs/`, ideally by setting `output-dir` once in a `_quarto.yml` instead
  of in each file.
- **Scripts:** Use R scripts for tasks that repeat but aren't presentable, such
  as cleaning, builds, and exports. Put them in `scripts/` or the project's
  equivalent.

Keep files small and to the point: one analysis per notebook, one task per
script, and related functions together.

## Plots

Use `theme_minimal()` by default in ggplot. If the project defines its own
theme, use that instead.

## Checking work

Use adversarial subagents for the scientific side of complex work. Have them
challenge whether the method fits the question, whether the model's
assumptions hold, what confounding or bias could explain the result, and
whether the interpretation claims more than the analysis supports. Fix what
they find before you report results.

On the data side, only complex joins get this check. For those, have the
subagent verify row counts, key uniqueness, and rows that were dropped or
duplicated. Don't use subagents for simple joins, summaries, plots, or other
routine steps.
