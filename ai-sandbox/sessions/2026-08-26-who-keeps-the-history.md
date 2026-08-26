# 2026-08-26 · Who keeps the history, and the install that made the question urgent

- **Status:** closed
- **Configuration:** Solo
- **Participants:** author — claude-opus-5 · high effort
- **Signed off:** no
- **Tags:** `#template` `#adoption`

> **The first section of Reasoning is a reconstruction.** This file was opened partway through
> the session, after the discussion that produced the question had already happened —
> `session-start.md` was not run. Everything from "Placeholder classes" down was written as it
> happened. A later reader should know which half is which.
>
> **It was also closed once before it was finished.** `checkpoint.md` ran at what looked like the
> end; the session then continued, and the counter finding below was written into a file already
> marked `closed`. Nothing had been committed, so no reader was ever shown the frozen version and
> nothing needed backfilling — but the rule says immutable once closed, and this is what actually
> happened. It is the fourth divergence today between a rule written in prose and what was done
> under it, and the only one nothing would have caught.

---

## Objective

Two things, in order. Record the question of who authors and who executes the project history,
given that an AI assistant can become unavailable mid-project. Then fix the install-time
placeholder convention, which is the concrete failure that raised the question.

## Reasoning

### Where the question came from (reconstruction)

Starting a *new* project from the skeleton failed in practice. Four separate defects, found by
attempting it rather than by reading:

1. GitHub's "Use this template" copies the whole repository, including this project's own live
   memory. `ADR-006` makes the repository host the system on itself, so the artefact is a
   subdirectory and the template button is the wrong distribution mechanism — `ADR-003` already
   says distribution is a vendored copy. Nothing warns about it.
2. `skeleton/README.md` step 1 instructs the reader to delete the file they are reading. The
   install guide lives inside the thing being installed.
3. Step 3 says *"Replace every `<PROJECT_NAME>` and `<PLACEHOLDER>`"*. There is no literal
   `<PLACEHOLDER>` token in the skeleton — it appears exactly once, in that sentence, where it
   looks like a string to grep for. It is a category name wearing a token's clothes.
4. There is no path for a project with no history. §11 is written for a project already
   underway; the new-project case has only the six numbered steps in the install guide.

The discussion that followed was about authorship rather than installation. The distinction that
resolved it: **who owns the history is a different question from whose fingers type it.** The
system has already answered the first — `Held by:` is a human's `git config user.email`
(`ADR-012`), `Owner:` is a human name, an `ADR-` needs a named human's sign-off. The assistant is
never a subject of record anywhere in the design. What is unanswered is the second, and the
constraint that makes it urgent is that an assistant can stop being available — a monthly credit
ceiling, an outage, a change of employer's tooling.

The candidate answer, not yet tested: the debate "human or AI" hides a third executor. Work
divides into judgement (only a human), routing (either), and mechanics (a script, and nothing
else should be doing it). The credit ceiling only bites where mechanics require an assistant.
The criterion that would follow — **switching the assistant off must make the work slower, not
different** — is recorded in the question rather than adopted, because nothing has measured the
cost of the manual path.

### Placeholder classes

The install failure above is not a wording problem. One syntax, `<…>`, carries three things with
three different lifetimes, and no mechanical rule separates them:

| Class | Count in `skeleton/` | Lifetime |
|---|---|---|
| Mechanical token — `<PROJECT_NAME>`, `<DATE>`, `<VERSION>`, `<SHA>` | 20 files / 22 occurrences | replaced by `sed`, zero decisions |
| Blank only a human can fill | 7 | answered before the first commit |
| Example field syntax and section prompts — `<slug>`, `<thread>`, `<Intuitive picture first…>` | ~150 | **never touched at install** |

`ai-sandbox/INDEX.md` carries all three within twenty lines of each other: `<PROJECT_NAME>` in
the title must go, `CHECKPOINT-<thread>.md` in the routing table must stay, and *Current focus*
needs a human. An assistant told to "replace every placeholder" will correctly and confidently
destroy the routing table. That the AI struggled here is not evidence about the AI; the
instruction has no consistent reading.

### What the marker had to be

`<<FILL: …>>` rather than a fourth flavour of single angle bracket. Three properties decided it:
it does not collide with anything already in the tree; `grep -rn '<<FILL'` finds it with no
regex; and it survives being read aloud in an instruction — *"answer every `<<FILL>>`"* has one
reading, where *"replace every placeholder"* has three.

Its boundary is what makes it checkable, and the boundary is **"the install cannot proceed
correctly without a human answer"**, not "nobody has written here yet". So the section prompts in
`docs/method.md` and the empty tables in `docs/glossary.md` deliberately do **not** get a marker.
They are legitimately empty on day one of a project whose method is not yet discovered, and
marking them would put a permanent `todo` in the output of every young project's first check —
teaching that this check is noise, which is the exact cost `ADR-008` priced when it removed three
entries from the hash list.

Seven markers, in three files: `AGENTS.md` (2), `ai-sandbox/INDEX.md` (1), `docs/problem.md` (4).
Both of the first two are `@`-imported into every session, which is why the check names them
differently from the third.

### Two defects the change found in itself

Neither was predicted, and both are the same shape as ones this repository has already shipped.

**The check could not be written naively, because it names what it looks for.** The first draft
of `bootstrap-test.sh`'s new step rewrote every file containing the marker — including the
installed `check.sh`, whose comment explains the marker. `awk` to a temp file plus `mv` replaced
the script's mode with the temp file's, so the next line of the test reported
`./check.sh: Permission denied`, and the adopter-facing output section printed nothing at all.
`check.sh` already excludes itself from its own retired-vocabulary scan for exactly this reason;
the new code had to learn it again. Fixed by an exclusion and by writing through the existing
inode rather than replacing it.

**A mechanism file may not contain a token the install substitutes.** The new comment in
`check.sh` spelled `<PROJECT_NAME>` out to explain what the marker is *not*. Step 3's `sed`
rewrote it, and `bootstrap-test.sh` reported a hash failure — correctly, and on the first gate.
This is `ADR-008`'s criterion catching a fresh instance of the class that produced it:
`ai-sandbox/RATIONALE.md` shipped four releases with the same token in its title. Worth stating
because the two cases arrived by different routes — one from a title, one from an explanation —
and the rule that covers both is about the file's *layer*, not about where in it the token sits.
The comment now names the tokens in words and says why it does not spell them.

## Decisions

- **The three placeholder classes are named in `skeleton/README.md` step 3**, with a command for
  the mechanical class, a `grep` for the human class, and an explicit "everything else stays" for
  the third — including the concrete example of what replacing it destroys.
- **`<<FILL: …>>` marks an install-time blank.** Its boundary is "the install cannot proceed
  correctly without a human answer", not "not yet written".
- **An assistant may fill a marker only from what it was actually told.** Written into step 3 and
  into the handbook: a plausible paragraph about a project nobody described is worse than the
  marker it replaced. Same rule `ADR-002` applies to files — content that instructs falsely is
  worse than content that is missing — applied to who is holding the pen.
- **`check.sh` counts unanswered markers** and reports the two session-loaded files differently
  from the rest. Excluded: itself, `_TEMPLATE.md` files, and `skeleton/`, where an unfilled marker
  is the shipped artefact.
- **`bootstrap-test.sh` gains three gates**: markers exist to be answered, none survive step 3,
  and — the one that matters — `ai-sandbox/INDEX.md` still documents `CHECKPOINT-<thread>.md`
  after the install. That last is the silent failure written down as a test: it hashes to nothing,
  carries no marker, and reads as prose, so nothing else in the suite would have noticed.
- **The session filename carries no counter.** A numeric suffix breaks a genuine collision — same
  date, same slug — and nothing else. Numbering the day's sessions in order of arrival is a shared
  counter: it is allocated by scanning the directory for the highest number, and two people would
  compute the same one. Fixed in `playbooks/checkpoint.md` and stated in §4, which had said only
  "no counter" and so did not cover the case that actually arises.
- **`Q-who-keeps-the-history` raised** 🟡, with what would answer it named: the manual path timed
  against the assisted one.

## Found along the way

- **This session's own filename was wrong, and the playbook is why.** It was written
  `…-who-keeps-the-history-5.md` — the fifth session of the day — by copying the neighbouring
  filenames and following `checkpoint.md`'s *"Several sessions in one day get a numeric suffix
  (`-2`)"*. §4 says sessions carry **no counter** and `docs/constraints.md` binds *no shared
  counter in any identifier*, so the playbook contradicts both, and the practice violates the
  constraint: allocating `-5` required scanning the directory for the highest number, which is
  exactly the lookup §4 exists to remove. It is also applied inconsistently — 2026-08-17 numbered
  all five in order, while 2026-08-26 left the first two bare and resumed at `-3`, so the sequence
  is not even a reliable ordinal. Renamed here because nothing had cited it yet; the eight
  historical files keep their suffixes, since a slug once assigned is never changed and `LOG.md`
  links every one of them. **Third instance today of the same shape**: an instructing document
  disagreeing with the authority while `check.sh` reports clean, because it matches strings and
  not meanings. Found by a human reading a filename, which is the only instrument that has caught
  any of the three.
- **§12's `check.sh` row had fallen three releases behind.** It listed thirteen checks and omitted
  five that ship: this clone's settings and the `Held by:` comparison (`v2.4.0`, `v3.0.0`), the
  `.gitignore` upstream block, the profile-layer credential patterns, adoption notes, and sessions
  left open. Corrected in the same edit, since the table is in the document `skeleton/README.md`
  names as the authority. The 2026-08-26 alignment audit did not reach it — it checked whether
  sentences had stopped being true, and this row was never a sentence.
- **`bootstrap-test.sh` is an installer wearing a test's name.** It performs the whole mechanical
  install — copy set, rename, hooks, both tokens, `.template-version` — and now the blanks too.
  Extracting it as `install.sh` would remove the assistant from the one step where an assistant is
  least useful and most likely to invent. Not done here; it belongs to `Q-who-keeps-the-history`,
  whose whole argument is that mechanics belong to a script.
- **Three of the four install defects are untouched.** GitHub's "Use this template" copying this
  repository's own memory; step 1 instructing the reader to delete the file they are reading; and
  the absence of any path for a project with no history. Only the placeholder one is fixed.

## Next

- Decide the bump and cut the release. The scaffold half (`AGENTS.md`, `INDEX.md`, `problem.md`)
  reaches new adoptions only; the mechanism half (`check.sh`) reaches projects already running,
  which is the half that decides the number.
- The remaining three install defects, and whether they are one change or three.
- Design the new-project experiment: fresh session, no access to this one, two arms — assisted and
  unassisted — and count invented content as the primary measure, not a footnote.
