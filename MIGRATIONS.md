# Migrations

One section per MAJOR release, in order. A consumer upgrading from `<from>` to `<to>` executes
**every** section strictly between them — intermediate MAJORs are not skippable, because each
assumes the structure the previous one left.

This file is upstream's and is never copied into an adopting project. It is read at upgrade time,
by `ai-sandbox/playbooks/upgrade-template.md`.

## How a section is written

**As instructions to an assistant, not as a script.** The material being migrated is prose — a
register's entries, a claim's basis, the wording of a rule — and the steps that matter most are
exceptions a script would get wrong while reporting success. The canonical example: session and
experiment records are immutable, so a migration that renames a file must *not* fix the references
to the old name inside them. That mismatch is the historical record working correctly.

Each section states:

1. **Reason** — what failed under the old shape. Without it the migration reads as churn and gets
   deferred.
2. **Steps** — in order, with the exact commands where a command is exact.
3. **Exceptions** — what must *not* be touched, and why. Never omit this heading; write "none" if
   there are none, so its absence is always a defect rather than a judgement.
4. **Verification** — what `check.sh` should say afterwards, and what a correct diff looks like.

Release notes and the section here are the same text. One source, not two.

**If the release retires a term** — a filename pattern, a phrase like "one per owner" — name the
exact retired strings in the Reason above. That list is not just documentation: "Cutting a
release" step 2a below turns it directly into `check.sh`'s retired-vocabulary check, and Reason
is where those strings already have to be written out for the migration to make sense. Naming
them once here means not deciding it separately later.

## Cutting a release

1. Settle the tree first. **Tag when the artefact is finished, not when it looks finished** — the
   `v1.0.0` tag was cut mid-session, two fixes landed after it, and the root memory then claimed a
   version it did not have for a full session.
2. Regenerate the hash list that consumers check against:

   ```bash
   grep '^mechanism' MANIFEST | grep -v '# transformed on install' | awk '{print $2}' \
   | while read -r p; do
     [ -f "skeleton/$p" ] && (cd skeleton && sha256sum "$p")
   done > skeleton/.template-hashes
   ```

   Paths are relative to a consumer's repository root, which is what `skeleton/` becomes. The file
   does not list itself, and it excludes the mechanism entries `MANIFEST` marks
   `# transformed on install` — see the criterion at the top of `MANIFEST`. A file the install
   renames, substitutes into, or fills placeholders in cannot be hashed at the path it lands on,
   and listing it anyway puts a permanent `FAILED` on the first line of output every adopter sees.

2a. **Run `./bootstrap-test.sh`. It must pass.** It installs `skeleton/` into a scratch repository
   exactly as `skeleton/README.md` says and runs the `check.sh` that lands there. This repository's
   own `check.sh` cannot see any of that: self-hosting vendors the skeleton's files in place, so
   nothing is renamed, no placeholder is filled, and the copy set is never chosen. Every defect
   living in the transformation from skeleton to consumer is invisible here and unavoidable there.
   Three shipped for four releases before this test existed.
2b. **If the release introduces a rule, name the artefact that enforces it — and check that the
   artefact knows.** A field, a check, or a list; the question is deliberately not "which field",
   because two of the four times this has been missed the answer was not a field at all.

   | Missed | The artefact that had to know | What it was |
   |---|---|---|
   | the install renames one file | `.template-hashes` | a list |
   | the intake file is exempt from the cap | `check.sh` | a check |
   | a register may carry inherited numbered IDs | the register preambles | a field's meaning |
   | `CONFIGURATIONS.md` licenses the `ADR-` number | `docs/decisions/_TEMPLATE.md` | three fields |

   Every one of them was a rule stated in one file while the thing it governed was never told. The
   failure is silent in both directions: the artefact either reports a violation that is not one,
   or — worse, because nothing is ever annoying — it can never report anything at all.

3. **If the section's Reason names retired terminology, add it to `check.sh`'s `RETIRED` array**
   (in the "Retired vocabulary" check). A rename this size lands correctly in the mechanism files
   upstream ships by construction — the hash check already covers those — but strays into
   playbook prose and scaffold tables by hand, and nothing else catches that. This is exactly the
   class of miss found after `v2.0.0` shipped: three stray `CHECKPOINT-<owner>.md` references
   survived in files the hash check doesn't see, in two dogfooded copies that agreed with each
   other, wrongly. Regenerate the hash list again after this edit, since `check.sh` is itself
   mechanism.
3a. **Settle the bump level against §15 before tagging.** If what keeps the release MINOR is an
   exception — "new records carry the field, existing ones predate it" — check that the exception
   is **inert or expiring**. Inert: nothing downstream costs anything and nobody maintains two
   shapes. Expiring: a fallback with a check beside it that keeps saying the old shape is still
   there. An exception that requires both populations to be supported indefinitely is a deferred
   MAJOR and is called MAJOR now. Without this, MAJOR becomes unreachable: every breaking change
   de-escalates behind a grandfather clause.

3b. **Update `README.md`'s Status section.** It is the only description of this project a reader
   meets before deciding whether to adopt it, it names a version, and nothing else in this
   procedure points at it — which is why it sat two releases stale. State the current version, what
   has actually been exercised, and what is still narrow. It is not release notes; the tag carries
   those.

4. Tag, with notes that **name every changed rule** if the diff touches `ai-sandbox/RULES.md`, one
   line per rule, at any bump level. If it does not, say so explicitly: "no rule changes" is
   information, and its absence is indistinguishable from an oversight.
5. Add the section here if the bump is MAJOR.

## Partial application

A migration interrupted halfway leaves the repository in a state that claims one version and has
the structure of another. `upgrade-template.md` therefore updates `.template-version` **last**, as
its final step — so the recorded version always names a state that was actually reached, and an
interrupted upgrade is visible rather than silent.

If you find a repository whose `.template-version` disagrees with its structure, trust the
structure and re-run the migration from the version the structure implies.

---

## v1.2.0 → v2.0.0

**This is the first real migration** — every release before it either changed no structure or
was itself the tooling that makes migrations possible at all. Read every step; nothing here is
skippable within the section even though it is a single MAJOR.

### Reason

Six independent bases justify MAJOR on their own (see the design notes for the full case); they
ship together as one section rather than six because `MIGRATIONS.md`'s own contract requires
every intermediate MAJOR to be executed in full, and six MAJORs between two points would mean
six sequential migrations for what is, structurally, one coherent change.

1. **Ownership axis.** `CHECKPOINT-<owner>.md` is renamed to `CHECKPOINT-<thread-slug>.md`.
   Ownership becomes a `Held by:` field in the header, not part of the filename. A project with
   one person and several concurrently-paused threads was producing, under the owner axis, the
   exact silently-diverging pair of files this design exists to prevent — just one level down,
   inside a single person's own work.
2. **Trap routing.** Data and tool traps move out of `DATA_ENVIRONMENT.md`'s "Known data traps"
   section into the new `ai-sandbox/CAVEATS.yaml`. A project's traps are no longer where the old
   structure said they were.
3. **Evidence requirement.** An experiment record that cites a file now makes that file real —
   in the repository, or the record says why not and names a substitute (typically a
   `results/*.json` summary). Records that cite only a gitignored path with nothing standing in
   for it stop conforming.
4. **`DATA_ENVIRONMENT.md` schema.** `Access` becomes a repeated block, one per source, each
   carrying a `Status:` field. `Tables in use` becomes a pointer to a generated catalog plus a
   short curated working set, not a hand-maintained table.
5. **`INDEX.md` meaning change.** The single "current focus" / one-checkpoint framing is
   replaced by a `## Threads` table. Any existing row describing "current focus" in terms of one
   person's state stops matching the new structure.
6. **Registry genre.** A register (`ASSUMPTIONS.md`, `OPEN_QUESTIONS.md`, or a project's own) that
   has gone months without a deletion is not broken — it has become a journal, and now has to say
   so explicitly rather than keep the registry label while behaving like something else.

Alongside these, a larger set of MINOR additions ships in the same release: `PUBLICATIONS.md`,
`CAVEATS.yaml`, `CONFIGURATIONS.md`, `STALENESS_LOG.md` (new files), verification fields on
experiment and session records, scope and basis fields on claims and assumptions, and advisory
`check.sh` checks. These do not invalidate any existing entry and need no per-entry migration —
only the file replacement in step 4 below, same as any MINOR.

**Retired vocabulary** (per "Cutting a release" step 3, and `check.sh`'s "Retired vocabulary"
check): `CHECKPOINT-<owner>`, `one per person`, `per-owner`. Found necessary the hard way — three
stray instances of the first survived this release's own rollout, in files the hash check does
not cover, present identically in both of this repository's dogfooded copies.

### Steps

1. **Rename the checkpoint(s).** For each `ai-sandbox/CHECKPOINT-<old-owner>.md`, decide what it
   actually holds:
   - If it is one coherent live thread, rename it to `ai-sandbox/CHECKPOINT-<thread-slug>.md`
     (name it for the work, not the person) and rewrite its header to the new shape: `Held by:
     <owner token> · since <date>`, `Status: active | paused`, `Plan:` (only if a plan file
     exists), `Resume from:`, `Do not do until re-verified:`. Move any personal reasoning
     ("what I tried", "what I suspect") out into the current session's record — the new
     checkpoint holds thread facts only.
   - If it covers more than one independent thread, split it into one `CHECKPOINT-<slug>.md`
     per thread — this is the situation the rename exists to fix, so do not force multiple
     threads back into one file to make the rename mechanical.
   - If, once personal reasoning and already-promoted content are removed, nothing is left in
     progress, do not create a new checkpoint at all: promote what's settled (`promote.md`), file
     one `OPEN_QUESTIONS.md` entry for anything still hanging, and delete the old file. A thread
     checkpoint that would open empty should not open.
2. **Move traps.** Cut `DATA_ENVIRONMENT.md`'s "Known data traps" section into
   `ai-sandbox/CAVEATS.yaml`, one entry per trap, using the new file's field shape (`id`,
   `subject`, `kind`, `severity`, `what`, `found`, `basis`). Replace the section in
   `DATA_ENVIRONMENT.md` with the one-line pointer. Existing prose severity language ("this will
   silently break X") maps directly to `severity: critical`.
3. **Restructure `DATA_ENVIRONMENT.md`.** Split the existing flat `Access` section into one block
   per source, in the new field order, and add `Status:` (`alive` by default unless something is
   actually known to be winding down). Replace the hand-written `Tables in use` list with the new
   four-line pointer shape if the project has a generation script; if it does not, keep the table
   but apply the new inclusion criterion (a decision depends on the row, not merely "queried
   once") and drop rows that fail it.
4. **Replace the mechanism layer.** Copy every path `MANIFEST` marks `mechanism` from the new
   skeleton, wholesale, as in any release (`upgrade-template.md` step 4). This alone brings in
   the new `RULES.md` bullets, the rewritten `checkpoint.md` and `session-start.md`, and the new
   `sessions/_TEMPLATE.md` / `experiments/_TEMPLATE.md` fields.
5. **Seed the new scaffold files.** `CAVEATS.yaml` (populated in step 2), `PUBLICATIONS.md`,
   `CONFIGURATIONS.md`, `STALENESS_LOG.md`, `ai-sandbox/playbooks/local/` (just `_TEMPLATE.md` if
   the project has no procedures of its own yet), `ai-sandbox/results/README.md`. A project with
   nothing to put in one of these yet seeds it empty — an empty `PUBLICATIONS.md` is not a gap,
   the same way an empty `SOURCES.md` already isn't.
6. **Update `INDEX.md`.** Rename the checkpoint row, add the `## Threads` table (one row per
   surviving `CHECKPOINT-<thread>.md`: thread, held by, status, since), and update "What a new
   session does" step 1 to read the thread table before picking a checkpoint.
7. **Check registry genre.** For `ASSUMPTIONS.md`, `OPEN_QUESTIONS.md`, and any project-specific
   register: if it has gone materially longer than three months without a deletion, decide
   whether it is actually a journal now and, if so, say so in its own preamble and split off a
   separate current-state file — do not silently leave the registry framing in place.
8. **Sweep existing entries for the new optional fields — do not backfill them.** `Does not
   license:`, `Verified by:`, `Configuration:` and friends are additive; existing rows and
   records stay valid without them (see Exceptions). Only fill them going forward.

### Exceptions

- **Session and experiment records are immutable.** A reference to `CHECKPOINT-<old-owner>.md`
  inside an already-closed session file is **not** rewritten to the new thread-based name — that
  mismatch is the historical record working correctly, not a stale citation to fix.
- **No retroactive backfill of new fields.** `Does not license:` in `ASSUMPTIONS.md`/`CLAIMS.md`,
  `Verified by:` / `How verified:` / the run-ID row in existing experiment records, and
  `Configuration:` / `Participants:` / `Signed off:` in existing session records are not added to
  entries that predate this release. They are MINOR-grade additions; an existing entry without
  them remains valid, exactly as `MIGRATIONS.md`'s own contract treats any additive field.
- **A thread's synthesis is not reconstructed.** Step 1's checkpoint split or closure may lose
  the value of having several sessions' state held together in one place — that has no other
  home in this design (see `RATIONALE.md`, "negative knowledge needs a home") and is an accepted,
  bounded cost of the rename, not a defect to work around during migration.
- **`docs/CLAIMS.md`'s new `Does not license` column** is additive to the table; existing rows
  get a blank cell, not a retroactively inferred value.

### Verification

- `./check.sh` run before step 1 and again after step 8. Every finding present only in the
  "after" run should trace to something this migration actually changed (a renamed checkpoint
  file, a newly-seeded empty register) — anything else is the migration's fault until shown
  otherwise.
- No file named `CHECKPOINT-<old-owner>.md` remains, except inside `sessions/*.md` /
  `experiments/*.md` citations, which stay as-is per Exceptions.
- `ai-sandbox/CAVEATS.yaml` has at least as many entries as `DATA_ENVIRONMENT.md`'s old traps
  section had traps.
- `INDEX.md`'s `## Threads` table has one row per surviving `CHECKPOINT-*.md` file, and no
  checkpoint file exists without a matching row (or vice versa).
- `sha256sum -c .template-hashes` reports every `mechanism` file matching, confirming step 4 was
  applied wholesale rather than merged.

---

## No migrations before this

`v1.0.0` is the first release. `v1.1.0` added a playbook and changed no structure. `v1.2.0` added
a check and changed no structure it needed a migration for.

This file existed before it was needed on purpose: the format was easier to agree on when
nothing was at stake than in the moment a real migration was due.

---

## v2.4.0 → v3.0.0

### Reason

`ADR-007` made ownership a field, `Held by:`, and did not say where its value comes from.
`AGENTS.md` answered with an **owner token** — initials, declared once, in a file that is
committed and shared. That has one slot, and a project has N contributors.

The failure is not the missing slot; it is what the obvious repair does. A second contributor who
edits the declared value produces a one-line change to a shared file, which merges *cleanly* — last
writer wins, no conflict marker, and the other person's identity is gone. That is the
silently-diverging-copies failure `ADR-002` and `ADR-007` both exist to prevent, one level up.

Underneath it: the token is a value an assistant must *supply*, and one that cannot resolve it has
three plausible wrong answers within reach — the only declared token, the only `Held by:` already
present, the commit log. All three name the project's first contributor. A newcomer is therefore
the case most likely to be misattributed, and `RULES.md` grants the write right to whoever the
field names, so a wrong value is a false authority claim rather than a wrong byline.

`Held by:` is now the exact output of `git config user.email` in the clone where the work happens.
The owner token is retired.

**Terminology retired** (fed into `check.sh`'s `RETIRED` array by step 3 of "Cutting a release"):
`owner token`, `<owner>`.

### Steps

1. **Set the clone's identity, if `v2.4.0`'s step did not already.**

   ```bash
   git config user.email        # if this prints nothing:
   git config user.email "you@example.org"
   ```

   Do this before anything below — every step that writes a `Held by:` needs it, and an empty
   result is a stop rather than a value to invent.

2. **Rewrite `Held by:` in every live checkpoint.** For each `ai-sandbox/CHECKPOINT-*.md`, replace
   the initials with the holder's git address. **Ask who holds each thread rather than deriving
   it** — the commit log names whoever last *committed* the file, which on a two-person project is
   frequently not its holder, and a wrong answer here silently transfers the write right.

   ```
   - **Held by:** es · since 2026-08-24
   - **Held by:** es@example.org · since 2026-08-24
   ```

   `since` is unchanged: the holder did not change, only how the record names them. This is **not**
   a take-over and gets no `sessions/LOG.md` row.

3. **Update the `## Threads` table in `ai-sandbox/INDEX.md`** to the same addresses, and widen the
   column header to name the field's source (`Held by (user.email)`). The table and the checkpoint headers must agree —
   `session-start.md` reads the table to decide what a session may write.

4. **Delete the `## Owner token` section from `AGENTS.md`.** Nothing replaces it. If the project
   added prose elsewhere explaining its token, delete that too; a retired concept left described in
   a loaded instruction file misdirects in `ADR-002`'s sense.

5. **Convert `Owner:` on register entries to human names.** In `ai-sandbox/ASSUMPTIONS.md` and
   `ai-sandbox/OPEN_QUESTIONS.md`, entries reading `**Owner:** es` become `**Owner:** <the
   person's name>`. This field is **not** the git address: it names who is accountable for the
   entry, which is a possession and outlives any clone, where `Held by:` names a temporary write
   claim. One token becomes two conventions, deliberately — see `ADR-012`.

6. **Replace the mechanism files** as usual (`ai-sandbox/RULES.md`, `RATIONALE.md`, the playbooks,
   `check.sh`), then verify against `.template-hashes`.

### Exceptions

- **Session and experiment records are immutable.** A `Held by: es` inside `sessions/*.md` or
  `experiments/EXP-*.md` stays exactly as written. It records what the field held at the time,
  which is the archive working correctly.
- **ADRs are historical.** `ADR-007` receives one pointer edit — `extended by ADR-012` on its
  `Status:` line — and its body is not touched. No other ADR changes.
- **`MIGRATIONS.md` keeps the retired vocabulary on purpose**, in this section and in earlier
  ones. It is how a reader arriving from an old version finds the term they know.
- **`docs/` claims that survive are not restated.** *A thread's checkpoint belongs to whoever it
  names `Held by:`, not to a filename* is unchanged by this release; only the provenance of the
  value changes.
- **Do not add an equality check to `.githooks/pre-commit`.** It is absent in every clone but the
  adopter's (`core.hooksPath` is per-clone and never cloned), so it would enforce nothing for the
  population this release is about, and a false positive there is answered with `--no-verify`,
  which also disables the secret scan sharing that hook.

### Verification

`./check.sh` should report:

- **This clone's settings** — `user.email` present, and one line per live checkpoint reading
  `held by you` or naming a colleague's address. No line should show initials.
- **Retired vocabulary** — `clean`. A hit means `owner token` or `<owner>` survives in prose
  somewhere the hash check cannot see; that is the class of miss `v2.1.0` was cut to catch.
- **Mechanism files** — `all match v3.0.0`.

A correct diff touches checkpoints, `INDEX.md`, `AGENTS.md`, both registers, and the mechanism
files. It touches nothing under `sessions/`, `experiments/`, or `docs/decisions/` except the one
pointer edit on `ADR-007`.

**The check is weaker than it looks, by design.** It compares `Held by:` to this clone's identity,
so it catches a checkpoint still naming someone else — and passes for anyone who rewrites the
field to their own address, which is exactly an unlogged take-over. It reports the honest mistake;
the careless one remains a matter of the rule, not the check.
