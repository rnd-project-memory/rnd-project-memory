# R&D Project Skeleton

Copyable starting structure for the system described in `RND_PROJECT_MEMORY.md`.
That handbook is the authority; this tree is generated from it. **If the two disagree,
the handbook wins** — fix the skeleton, not the handbook.

## Use

```bash
./install.sh ../my-project my-project you@example.org [first-thread-slug]
```

Run from a clone of the template repository. `install.sh` performs every part of the install that
has one correct answer — the copy set, the `gitignore.template` rename, this clone's
`core.hooksPath` and `user.email`, the token substitution across twenty files, and
`.template-version` — then prints what it did, and after that what it deliberately did not.

**Read it before running it.** It is short and does nothing clever, and it is also the
instruction: those steps are described in one place, so there is no second description to fall
out of date with it. If you would rather install by hand, read the script rather than looking for
prose that repeats it.

It never guesses. An unset `user.email` is reported, not invented — a wrong address there names
the wrong person in every `Held by:` written afterwards, and nothing later tells that apart from a
correct one.

## What it leaves for you, and why

**1. The blanks only a person can answer.** Three different things in this tree wear angle
brackets and only one of them is a blank:

| Class | Count | What happens to it |
|---|---|---|
| Mechanical token — `<PROJECT_NAME>`, `<DATE>` | 20 files | `install.sh` does it |
| A blank only you can fill — `<<FILL: …>>` | 7 | **you answer it** |
| Example field syntax and section prompts — `<slug>`, `<thread>` | ~170 | **never touched** |

```bash
grep -rn '<<FILL' .
```

Answer each and delete the marker, brackets included. `AGENTS.md` and `ai-sandbox/INDEX.md` load
into every session, so a marker left in either is not an empty section — it is text the assistant
reads as instruction. `check.sh` counts what is left. An assistant may fill these only from what
you actually told it: a plausible paragraph about a project nobody described is worse than the
marker it replaced.

The third class is why this is a table rather than a sentence. `ai-sandbox/INDEX.md` carries all
three classes within twenty lines: `<PROJECT_NAME>` in its title goes, `CHECKPOINT-<thread>.md` in
its routing table stays. An instruction to "replace every placeholder" reads as covering both, and
destroys the routing table every session then loads. Files named `_TEMPLATE.md` keep everything —
they are copied per entry, not filled in place.

**2. Your first thread — unless you named it.** Naming a thread is a judgement: it says what the
work is about. Give the install a fourth argument and it performs the rename and fills `Held by:`
from this clone's identity; give it none and `ai-sandbox/CHECKPOINT-thread.md` is left for you to
rename to `CHECKPOINT-<what-you're-working-on>.md` by hand. Without an identity it refuses either
way rather than writing a holder it guessed — a checkpoint naming nobody reads as unattended, and
an unattended thread is one anyone may take over.

There is nothing to declare in `AGENTS.md`: a thread's holder is named by the identity that signs
this clone's commits, never by a token (`ADR-012`).

**3. `sources/` and `src/`, if the project already keeps those somewhere — under any name.** The
condition is whether they already have a home, not whether a directory of that exact name exists;
creating them beside the project's own equivalents gives it two homes for each on day one.

**4. Verifying that the instructions load.** In a *fresh* assistant session, ask it to state a
rule that appears only in `ai-sandbox/RULES.md`, then one that appears only in
`ai-sandbox/INDEX.md`. If either fails, that `@` import in `AGENTS.md` is not resolving and every
rule in the file is inert. `RULES.md` matters most — it holds every behavioural rule, and its
silence looks exactly like correctness. **No script can do this**: a session cannot measure its
own imports from the inside, which is why it is here rather than in `install.sh`.

**5. Merging, where a file already exists.** Nothing here is meant to overwrite one. `AGENTS.md`
is the case that matters: the project's own content stays and the two `@` import lines are added
to it. The rules themselves are **not** copied into `AGENTS.md` — they live in
`ai-sandbox/RULES.md`, which the import pulls in and an upgrade replaces wholesale.

**6. On a project already underway, read `RND_PROJECT_MEMORY.md` §11 before any of this.** It
re-orders these steps and adds several that only apply when the repository already has history.

## Per clone, by every contributor

`core.hooksPath` and `user.email` live in `.git/config`, which **`git clone` never copies**. The
install sets them in the clone it runs in and in no other. A colleague who clones from you has
`.githooks/pre-commit` sitting in their working tree doing nothing, with no warning from git:

```bash
git config core.hooksPath .githooks        # runs the secret scan — nothing else does
git config user.email "you@example.org"    # what `Held by:` takes
```

`AGENTS.md`'s "First run in a new clone" section is where the project keeps this for whoever
clones next; **this file never reaches them.** If the project has CI, run the same secret scan
there: it is the one layer that does not depend on how an individual clone is configured.

Run `./check.sh` any time — it is advisory, always exits 0, and never blocks a commit.

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
append-only or edited in localised spots. A second contributor runs **the two commands above in their own clone**
— both settings live in `.git/config` and no clone inherits them, so a colleague who skips it has
no secret scan and no value for `Held by:` — and then either takes over an unattended thread (an
event, logged — see `RULES.md`) or opens a new one. Nothing about a person is declared in a shared
file, so there is no line for two people to overwrite (`ADR-012`).

Only one thing changes, and it doesn't touch a file:

- `docs/` review becomes a pull request rather than a self-review pass.

`session-start.md`'s step 0 already pulls before reading anything, specifically so two people
writing the same thread's checkpoint diverge visibly before work starts, not silently after.
