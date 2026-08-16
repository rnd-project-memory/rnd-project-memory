# R&D Project Skeleton

Copyable starting structure for the system described in `RND_PROJECT_MEMORY.md`.
That handbook is the authority; this tree is generated from it. **If the two disagree,
the handbook wins** — fix the skeleton, not the handbook.

## Use

1. Copy the contents of this directory into the project repository root.
2. Rename `gitignore.template` to `.gitignore`.
3. Replace every `<PROJECT_NAME>` and `<PLACEHOLDER>`.
4. Pick an **owner token** (your initials), declare it in `AGENTS.md`, and rename
   `ai-sandbox/CHECKPOINT-owner.md` to `CHECKPOINT-<token>.md`.
5. Delete `sources/` and `src/` if the project already has its own.
6. Verify instruction loading: in a fresh Copilot CLI session, ask it to state a rule
   that appears only in `ai-sandbox/INDEX.md`. If it cannot, the `@` import in
   `AGENTS.md` is not resolving and every rule below it is inert.
7. Follow `RND_PROJECT_MEMORY.md` §11 to bootstrap from existing material.

Files named `_TEMPLATE.md` are copied per entry, not filled in place.

## Working with colleagues

Nothing to change. The structure is already concurrency-safe: checkpoints are per owner, no
identifier uses a shared counter, and every other file is append-only or edited in localised
spots. A second contributor picks their own owner token, creates their own checkpoint, and
starts — no renaming, no migration. See `RND_PROJECT_MEMORY.md` §14 for the short list of what
does change — essentially only that `docs/` review becomes a pull request.
