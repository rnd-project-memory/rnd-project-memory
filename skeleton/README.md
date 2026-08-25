# R&D Project Skeleton

Copyable starting structure for the system described in `RND_PROJECT_MEMORY.md`.
That handbook is the authority; this tree is generated from it. **If the two disagree,
the handbook wins** — fix the skeleton, not the handbook.

## Use

1. Copy the contents of this directory into the project repository root — **except this
   `README.md`**, which is installation instructions rather than part of the system and would
   replace the project's own. That sentence is the whole copy set; `MANIFEST` in the template
   repository is about who owns which file on upgrade, not about what to copy. Nothing else here
   is meant to overwrite an existing file either: where one already exists, merge. `AGENTS.md` is
   the case that matters — the project's own content stays, and the two `@` import lines are added
   to it. The rules themselves are **not** copied into `AGENTS.md`: they live in
   `ai-sandbox/RULES.md`, which the import pulls in and an upgrade replaces wholesale.
2. Rename `gitignore.template` to `.gitignore`, then install the hooks — one line, and
   it is the only protection for the rule no later edit can repair:
   ```bash
   git config core.hooksPath .githooks
   ```
   If the project has CI, run the same secret scan there: it is the one layer nobody can
   forget to install.
3. Replace every `<PROJECT_NAME>` and `<PLACEHOLDER>` — around twenty files carry one, including
   `ai-sandbox/INDEX.md`, which is loaded into every session. `.template-version` takes the
   release you copied, the commit `skeleton/` was at, and today's date; its first field is what
   `check.sh` reports. Files named `_TEMPLATE.md` keep their placeholders.
4. Pick an **owner token** (your initials) and declare it in `AGENTS.md`. It identifies who can
   hold a thread — it no longer names a file. Rename `ai-sandbox/CHECKPOINT-thread.md` to
   `CHECKPOINT-<what-you're-working-on>.md` for your first thread, and set `Held by: <token>` in
   its header.
5. Delete `sources/` and `src/` if the project already keeps code and source material somewhere —
   **under any name.** The condition is whether these already have a home, not whether a directory
   of that exact name exists; creating them beside the project's own equivalents gives it two
   homes for each on day one.
6. Verify instruction loading: in a fresh Copilot CLI session, ask it to state a rule that
   appears only in `ai-sandbox/RULES.md`, then one that appears only in `ai-sandbox/INDEX.md`.
   If either fails, that `@` import in `AGENTS.md` is not resolving and every rule in the file
   is inert. `RULES.md` is the one that matters most — it holds every behavioural rule, and its
   silence looks exactly like correctness.
7. Follow `RND_PROJECT_MEMORY.md` §11 to bootstrap from existing material. **On a project that is
   already underway, read §11 before starting here** — it re-orders these steps and adds several
   that only apply when the repository already has history in it.

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

Nothing to change. The structure is already concurrency-safe: checkpoints are per thread and
only their holder writes them, no identifier uses a shared counter, and every other file is
append-only or edited in localised spots. A second contributor picks their own owner token and
either takes over an unattended thread (an event, logged — see `RULES.md`) or opens a new one.

Only one thing changes, and it doesn't touch a file:

- `docs/` review becomes a pull request rather than a self-review pass.

`session-start.md`'s step 0 already pulls before reading anything, specifically so two people
writing the same thread's checkpoint diverge visibly before work starts, not silently after.
