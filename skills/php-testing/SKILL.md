---
name: php-testing
description: "Run and diagnose PHP tests, preferring laravel/pao when it is installed and parallel execution when the project supports it."
---

# PHP Testing

Use this skill for PHP test runs and test-failure investigation.

## PAO

Check the project's Composer dependencies and test commands for `laravel/pao`.
When it is installed, use the project's PAO-enabled Pest, PHPUnit, Paratest,
PHPStan, Rector, or Artisan command so the agent receives its compact JSON
result. Read that JSON directly. Do not parse it by grepping for conventional
human-readable test output or by truncating the command's output.

Do not add PAO as a dependency solely to run tests. Use the project's existing
test setup when PAO is unavailable.

## Parallel execution

Prefer the project's supported parallel test command for runs that include
multiple independent tests. For example, use the configured Pest parallel
option or Paratest command when the repository provides one.

Keep a test run serial when parallel execution is unsupported, when a focused
single-test run gains nothing from it, or when tests share state or external
resources that make concurrent execution unreliable. If a parallel-only
failure occurs, rerun the affected test serially to distinguish a test defect
from concurrency or isolation problems. Report which mode ran and any fallback
used.
