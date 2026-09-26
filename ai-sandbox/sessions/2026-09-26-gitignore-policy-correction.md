# 2026-09-26 · Make data-file ignores project-controlled

- **Status:** closed
- **Configuration:** Solo
- **Participants:** author — current coding agent; no independent reviewer
- **Signed off:** no

## Objective

Revise the issue-#1 implementation after user feedback. Do not impose a synthetic-fixture naming
scheme. Remove the upstream extracted-data extension block from the generated `.gitignore` and
leave each adopting project to decide which data-file patterns it wants to ignore.

## Reasoning

The synthetic sidecar convention solved visibility and commitability by adding a second policy, but
it still made the template decide which data files were acceptable. The requested policy is simpler:
remove the `*.csv`, `*.parquet`, `*.pkl`, `*.pickle`, `*.xlsx`, `*.feather`, and `*.h5` block from
`gitignore.template` and generated `.gitignore`. Keep `data/` and credential patterns as separate
protections. Keep the pre-commit data-file block as a separate safety control: visibility/ignore
policy is user-controlled, while committing known data-file formats remains intentionally blocked.

## Decisions

- Remove the extracted-data extension block and synthetic exceptions from root and skeleton ignore
  templates.
- Remove the synthetic fixture special case from the hook and advisory checker.
- Add a bootstrap gate proving a CSV is visible for the adopter to track or ignore.
- Preserve the generic pre-commit block for known data-file formats and the credential scanner.
- Keep the earlier installer collision and Owner workflow changes; do not edit their closed session
  record.

## Found along the way

Removing `.gitignore` patterns alone would not make a CSV commit normally succeed because the
pre-commit hook independently blocks data-file extensions. That distinction is documented here so
future work does not mistake “visible/unignored” for “approved to commit.”

## Next

Validation completed: the extracted-data extension block is absent from the root and skeleton ignore
files; a CSV is visible in the bootstrap gate; generic data-file commits remain blocked by the
pre-commit hook; `bootstrap-test.sh`, `check.sh`, shell syntax, and `git diff --check` pass. The
prior synthetic-fixture session remains immutable historical record. No commit was made.
