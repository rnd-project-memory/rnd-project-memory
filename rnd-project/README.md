# R&D Project Skeleton

Copyable starting structure for the system described in `RND_PROJECT_MEMORY.md`.
That handbook is the authority; this tree is generated from it. **If the two disagree,
the handbook wins** — fix the skeleton, not the handbook.

## Use

1. Copy the contents of this directory into the project repository root.
2. Rename `gitignore.template` to `.gitignore`, then install the hooks — one line, and
   it is the only protection for the rule no later edit can repair:
   ```bash
   git config core.hooksPath .githooks
   ```
   If the project has CI, run the same secret scan there: it is the one layer nobody can
   forget to install.
3. Replace every `<PROJECT_NAME>` and `<PLACEHOLDER>`.
4. Pick an **owner token** (your initials), declare it in `AGENTS.md`, and rename
   `ai-sandbox/CHECKPOINT-owner.md` to `CHECKPOINT-<token>.md`.
5. Delete `sources/` and `src/` if the project already has its own.
6. Verify instruction loading: in a fresh Copilot CLI session, ask it to state a rule
   that appears only in `ai-sandbox/INDEX.md`. If it cannot, the `@` import in
   `AGENTS.md` is not resolving and every rule below it is inert.
7. Follow `RND_PROJECT_MEMORY.md` §11 to bootstrap from existing material.

Files named `_TEMPLATE.md` are copied per entry, not filled in place.

`ai-sandbox/ASSISTANT_PROFILE.md` is optional; if you fill it in, `@`-import it from
`AGENTS.md` or it will sit there having no effect.

Run `./check.sh` any time — it is advisory, always exits 0, and never blocks a commit.

## Where the reasoning lives

`ai-sandbox/RATIONALE.md` travels with this skeleton and holds why each rule exists plus the
failure-mode table. Read it on demand; do not import it.

The handbook (`RND_PROJECT_MEMORY.md`) stays in the template repository — it is a textbook for
whoever sets the system up, not an operational file. Everything needed while *running* the
system is in this directory.

## Working with colleagues

Nothing to change. The structure is already concurrency-safe: checkpoints are per owner, no
identifier uses a shared counter, and every other file is append-only or edited in localised
spots. A second contributor picks their own owner token, creates their own checkpoint, and
starts — no renaming, no migration.

Only two things change, and neither touches a file:

- `docs/` review becomes a pull request rather than a self-review pass.
- Pull before closing a session — `checkpoint.md` step 5 touches shared `LOG.md` and `INDEX.md`,
  and two assistants running at once have nothing coordinating them.
