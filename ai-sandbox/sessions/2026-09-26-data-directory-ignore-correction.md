# 2026-09-26 · Remove the default data-directory ignore

- **Status:** closed
- **Configuration:** Solo
- **Participants:** author — current coding agent; no independent reviewer
- **Signed off:** no

## Objective

Apply the user's follow-up to issue #1: remove `data/` from the upstream ignore block for the same
reason as the generic data-file extensions. Data-directory ignore policy should be decided by each
adopting project rather than imposed by the template.

## Reasoning

The previous correction removed generic extension patterns but retained `data/` as a separate
protection. The user wants the same policy boundary for that directory. The `data/` line is removed
from root and skeleton ignore templates. Credential ignores remain. The pre-commit data-file block
also remains separate: a visible data path can be deliberately ignored or inspected by the user,
but known data-file extensions are still blocked from commit by default.

## Decisions

- Remove `data/` from `.gitignore`, `gitignore.template`, and `skeleton/gitignore.template`.
- Extend the bootstrap gate to verify both a CSV and a file under `data/` are visible.
- Preserve the pre-commit data-file safety block and credential scanning.
- Keep earlier closed sessions immutable; this record supersedes the prior policy correction.

## Next

Validation completed: the `data/` pattern is absent from root and skeleton ignore templates; the
bootstrap gate confirms both a CSV and a file under `data/` are visible; generic data-file commits
remain blocked by the pre-commit hook; shell syntax, `git diff --check`, `bootstrap-test.sh`, and
`check.sh` pass. No commit was made.
