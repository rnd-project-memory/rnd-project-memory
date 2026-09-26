# 2026-09-26 · Safe installer collisions and Owner attribution

- **Status:** closed
- **Configuration:** Solo
- **Participants:** author — current coding agent; no independent reviewer
- **Signed off:** no

> This session changes the installer contract and register guidance. It does not modify the
> `install-path` checkpoint because that thread is held by another Git identity.

## Objective

Resolve two user-requested defects in the copyable `rnd-project-memory` artefact:

1. Make installation into an existing Git-tracked project non-destructive, using Git diffs to
   report per-file collisions for human resolution.
2. Make the register Owner workflow ask for a human owner before filling `Owner:` and never use
   the clone's Git identity as a substitute; preserve the ability to record an explicitly
   unowned entry.

## Reasoning

The old installer copied `skeleton/.` directly into the destination with `cp -r`, then removed
`README.md`. That could overwrite existing files and delete an adopter's README. The replacement
builds the transformed candidate in a temporary tree, compares candidate paths against existing
paths with `git diff --no-index`, and aborts before writing when a differing path or unsafe parent
is found. Identical files are left in place; only absent files are installed. A collision fixture
is added to `bootstrap-test.sh`.

The old register wording in `ASSUMPTIONS.md` required `Owner:` to be filled while also forbidding
Git addresses. The new wording asks before filling; if the user says no owner is assigned or does
not provide one, the field remains blank and the entry is still recorded. This is deliberately
non-blocking and is not the withdrawn blanket stop rule described by ADR-013.

## Decisions

- Collision status is exit code `2`; the installer makes no project-file or Git-config changes
  after detecting a collision.
- Existing `README.md` is not part of the candidate and is never removed.
- The transformed candidate, not the raw skeleton, is what gets compared and installed.
- Register preambles, the handbook, and the self-hosted register copies carry the ask-before-fill
  workflow. The existing advisory `@` check remains as a backstop.

## Found along the way

- The collision gate must use a tracked existing `AGENTS.md` to prove the diff is visible while
  also checking that an existing README survives.
- The installer is idempotent when existing candidate files are byte-identical.

## Next

Validation completed: `bash -n`, `git diff --check`, `./bootstrap-test.sh`, and `./check.sh` all
completed without blocking failures; the advisory output retains the pre-existing colleague-held
checkpoint notice and old unverified-experiment notices. The colleague-held checkpoint was not
edited. No commit was made; propose one only after the user reviews the diff.
