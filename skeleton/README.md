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
2. Rename `gitignore.template` to `.gitignore`, then configure **this clone**:
   ```bash
   git config core.hooksPath .githooks        # runs the secret scan — nothing else does
   git config user.email "you@example.org"    # what `Held by:` takes
   ```
   Neither setting is copied by `git clone` — both live in `.git/config` — so these are run once
   **per clone, by every contributor**, and installing the hook protects only the clone it is run
   in. `AGENTS.md`'s "First run in a new clone" section is where the project keeps them for
   whoever clones next; this file never reaches them. If the project has CI, run the same secret
   scan there: it is the one layer that does not depend on how an individual clone is configured.
3. Fill in the project's own details. **Three different things in this tree wear angle brackets**
   and only two of them are yours to touch. Treating them as one class is how an install goes
   wrong, whoever or whatever performs it.

   **a. Mechanical tokens — `<PROJECT_NAME>` and `<DATE>`.** Twenty files, no decisions:

   ```bash
   grep -rlI --exclude-dir=.git -e '<PROJECT_NAME>' -e '<DATE>' . \
     | grep -v '_TEMPLATE\.md$' \
     | xargs sed -i "s/<PROJECT_NAME>/your-project/g; s/<DATE>/$(date +%F)/g"
   ```

   That leaves `.template-version` needing two fields by hand — the release you copied and the
   commit `skeleton/` was at. Its first field is what `check.sh` reports.

   **b. Blanks only a human can answer — written `<<FILL: …>>`.** Seven of them, in three files:

   ```bash
   grep -rn '<<FILL' .
   ```

   Answer each and delete the marker, including the angle brackets. `AGENTS.md` and
   `ai-sandbox/INDEX.md` are loaded into every session, so a marker left in either is not an
   empty section — it is text the assistant reads as instruction. `check.sh` counts what is
   left. An assistant may fill these only from what you actually told it: a plausible paragraph
   about a project nobody described is worse than the marker it replaced.

   **c. Everything else in angle brackets stays.** Around a hundred and seventy occurrences of
   `<slug>`, `<thread>`, `<YYYY-MM-DD>` and the section prompts in `docs/` are example field
   syntax and headings waiting for content — not blanks. `ai-sandbox/INDEX.md` carries all three
   classes within twenty lines of each other: `<PROJECT_NAME>` in its title goes,
   `CHECKPOINT-<thread>.md` in its routing table stays. Replacing the second destroys the table.

   Files named `_TEMPLATE.md` keep everything, including their `<PROJECT_NAME>` and `<DATE>` —
   they are copied per entry, not filled in place, which is why the command above skips them.
4. Rename `ai-sandbox/CHECKPOINT-thread.md` to `CHECKPOINT-<what-you're-working-on>.md` for your
   first thread, and set `Held by:` to the address you configured in step 2. There is nothing to
   declare in `AGENTS.md`: a thread's holder is named by the identity that signs this clone's
   commits, never by a token (`ADR-012`).
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
append-only or edited in localised spots. A second contributor runs **step 2 in their own clone**
— both settings live in `.git/config` and no clone inherits them, so a colleague who skips it has
no secret scan and no value for `Held by:` — and then either takes over an unattended thread (an
event, logged — see `RULES.md`) or opens a new one. Nothing about a person is declared in a shared
file, so there is no line for two people to overwrite (`ADR-012`).

Only one thing changes, and it doesn't touch a file:

- `docs/` review becomes a pull request rather than a self-review pass.

`session-start.md`'s step 0 already pulls before reading anything, specifically so two people
writing the same thread's checkpoint diverge visibly before work starts, not silently after.
