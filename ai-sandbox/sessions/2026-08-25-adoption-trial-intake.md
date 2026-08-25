# 2026-08-25 · Template adoption trial — reading the results in

- **Status:** closed
- **Configuration:** Solo, except Author + reviewer + sign-off for `ADR-008`–`ADR-011`
- **Participants:** author — claude-opus-5 · high effort; reviewer — esdevop (human)
- **Signed off:** esdevop, for `ADR-008`–`ADR-011` only; nothing else in this session is signed
- **Tags:** `#template` `#versioning` `#upgrade` `#adoption`

---

## Objective

An adoption trial of `v2.1.0` was run by a separate executor session against a three-month-old
project (~9,400 lines across 12 files in its own `ai-sandbox/`, contents at repo root, GitHub
Copilot CLI toolchain, one commit tagged `before-adoption`). Its deliverable was a friction log,
not the adapted project.

This session receives that material. Step one — done — was reading the brief the executor was
given, to know the scope and the constraints the findings were produced under. The rest of the
context arrives in the next message; the objective will be revised once it is here.

Constraints carried from the brief that bind what can land in this repository:
- The trial project is private. Findings entering `docs/` or the skeleton must be shape, not
  instance — no table, column, person, or project names.
- The executor was to follow §11 as written and log rather than improve it. Interpretation of the
  findings is this side's job, not the executor's.

## Reasoning

Read on opening: `INDEX.md` (no threads open, no substantive work queued after `v2.1.0`),
`OPEN_QUESTIONS.md` (three open: `Q-unexercised-components` 🟡, `Q-oss-intake` 🟢,
`Q-contribution-flow` 🟢), `playbooks/session-start.md`, and handbook §11 lines 728–789 — the
section the trial was measuring.

`Q-unexercised-components` is the open question this trial speaks to most directly: it names
`DATA_ENVIRONMENT.md`, `ingest-source.md` with `SOURCES.md`, and the pre-commit secret scan as
never exercised, and says the rest "plausibly cannot be validated before first real use at work,
which makes the first work project a deliberate pilot rather than an adoption." §11 steps 3 and 7
touch three of those four components, so the friction log may carry the first evidence on them.

No interrupted session to freeze: the only `Status: open` match was `sessions/_TEMPLATE.md`.

### Second input: the friction log (F-000 – F-028 plus closing summary)

Received in-message, not as a file. It stays out of this repository verbatim — it is a private-repo
artefact and quoting it here would carry the trial project's fingerprints into a public upstream.

**Sensitivity scan, done on receipt.** No person, client, table, column, or project name appears in
the log; the executor's anonymisation held for names. What did survive is a second class of
identifier the brief's wording ("no table names, column names, person names, or the project's own
name") does not cover, and which must be scrubbed again before any of this reaches `docs/`,
`MIGRATIONS.md`, or the skeleton:

- **Fingerprint-grade counts.** Roughly two dozen exact figures — file line counts, section counts,
  citation counts, register sizes, artefact counts. Individually harmless; together they identify
  the repository to anyone who has seen it. Any that must survive into a public rationale should be
  rounded to an order of magnitude or replaced by the ratio that carries the argument.
- **The project's own conventions, quoted exactly.** Its identifier schemes, one register's
  duplicate ID, a filename prefix for drafts, and one tag from its backfilled log. These are
  reproducible strings, not shapes.
- **Domain silhouette.** Transcripts with internal participants, a weekly status workflow, wiki
  embedding, an issue tracker, stakeholder deliverables, a schema catalog. No single item names the
  work; the set narrows it. Findings should cite the mechanism, not the setting.

Recording this because the scan is itself a result: an anonymisation instruction phrased as a list
of name classes let a competent executor through with counts and conventions intact.

### Third input: the brief author's triage of the log

Also received in-message. It sorts the 29 findings into five buckets — fix now, one cheap addition,
decisions to take, record-but-don't-rush, don't-do — and adds a headline that is not in any bucket:
§11 describes the *start* of bootstrapping and reads as its *completion*. Carries the same
fingerprint-class figures as the log itself, so the same scrub applies.

Two things in it are new information rather than triage, and both are worth keeping:

- **F-012's proposed check would have caught a real leak in this project's own trial setup** — a
  large volume of client data reached the index during preparation, because the guard was installed
  after the material. That is first-hand evidence for a three-line step, from outside the trial.
- **The generality filter.** One adopter, one atypical project. F-024 passes it (the mechanism is
  general even though the instance is not); the merge-point findings are judged instance-bound. This
  is the right axis and it belongs in whatever record of the decision lands.

### Independent verification of the log's mechanical claims

Ran against this repository rather than taking either document's word.

| Claim | Result |
|---|---|
| `.template-hashes` names the pre-rename path | Confirmed: `gitignore.template` at line 2; step 1 renames it |
| The cap check has no intake exemption | Confirmed: `check.sh:74` globs `CHECKPOINT-*.md`, no exclusion |
| `.template-version` has no shipped format | Confirmed: absent from `skeleton/`; format inferable only from `check.sh:21` and `:57` |
| The two copy-set instructions differ | Confirmed; §11's version is also unimplementable — `MANIFEST` holds globs, exclusions, and omits `.template-hashes` |
| Register check prints untruncated lines | Confirmed: `check.sh:97` |
| The commentary exclusion is blockquote-only | Confirmed: `check.sh:98` |

**Three things the trial did not find, found here.**

1. **The pre-commit hook blocks routine commits on an existing project from day one.** Tested in a
   scratch repository: a data-extension file committed *before* the hook is installed is `BLOCKED`
   on its next modification, because the hook filters `ACM`, not `A`. An existing project that
   tracks such files therefore meets the blocking check on ordinary work, and its escape is
   `--no-verify` — the failure `MANIFEST`'s own pre-commit note names as unrepairable. This is the
   loud half of what the trial logged only as a quiet future-ignoring problem.
2. **Self-hosting is blind to this class of defect by construction.** This repository keeps
   `gitignore.template` at its root as the artefact source, so its own `check.sh` reports
   `ok all match v2.1.0` while every consumer sees `FAILED`. All three fix-now defects live in the
   *transformation* from skeleton to consumer — the rename, the placeholder fill, the copy set —
   which is exactly the region dogfooding cannot reach. Bears directly on `Q-unexercised-components`.
3. **The identifier dependency is not unstated.** Both register preambles say it verbatim
   ("Deleting resolved entries would pit and reuse a numbered sequence"). The trial pasted those
   preambles into the project's files and still logged the dependency as absent — which relocates
   the finding rather than dissolving it.

### The F-005 fix was wrong, and why

Proposed repairing the hash-list entry by moving it to the consumer-side path. The owner rejected
it: the obvious fix reproduces the defect from the other side. Correct, and the mechanism is exact
— every adopter is told to merge their own lines into that file, so hashing it at the consumer path
turns "FAILED open or read" into "FAILED checksum" for the same population. There is no path at
which the entry works, because the file is simultaneously hash-checked and required to be edited.

So F-005 is not a path bug. It is F-006 seen from the tooling side, and the two cannot be fixed
independently.

**Applying the same test found a second instance.** `.githooks/pre-commit` is in the hash list and
`MANIFEST` explicitly designs it to be modified — "a profile APPENDS credential patterns here, it
never replaces the list." Any organisation that supplies a profile gets a permanent hash failure on
the one file whose integrity the check most wants to report.

**The criterion that falls out:** the hash list may contain only files no adopter is ever instructed
to modify. Two of sixteen entries violate it today. That is a rule worth stating in `MANIFEST`,
because it is what makes the check's output mean something.

## Decisions

**The hash-list criterion, in the owner's wording:** the list may contain only files installed
verbatim, subject to no transformation. Wider than "files nobody is told to edit", and better,
because the two violations differ in kind — one is renamed and merged, the other substituted — and
because it is mechanically checkable by the tier-0 harness: any listed file the installation touches
is a violation. Goes in `MANIFEST` as a rule; the existing note explains the `pre-commit` exception
without saying that its presence in the hash list is therefore an error.

- **`gitignore.template` — dropped from the hash list.** Its content is unhashable by design.
- **`.githooks/pre-commit` — stays listed; the extensible part moves out** to a profile-layer
  pattern file the hook reads as data (never sources). The asymmetry with `.gitignore` is technical,
  not stylistic: a shell script can include another file, an ignore file cannot. This keeps
  integrity checking on the one file `MANIFEST` calls unrepairable-if-it-fails.

**Verified the split before accepting it, and it needs two more lines than proposed.** Tested the
assembly snippet: a blank line in the pattern file produces an empty alternative that matches clean
prose — the exact failure `MANIFEST` warns of, arriving through the new file — and a malformed
regex makes `grep` exit 2, which the hook's `>/dev/null 2>&1` cannot distinguish from "no match",
silently disabling the content scan. Filtering blank/comment lines and validating the assembled
regex with a fall-back to the core restores the intended invariant in all five cases tested.

**Ordering accepted.** Tier 1 is now three decision-free items; F-005 merged with the ownership
question in tier 4.

### What was implemented

Tier 0 first, deliberately, so tiers 1–2 were verified by running rather than by reading.

- `bootstrap-test.sh` (new, `norcopy`) — installs `skeleton/` into a scratch repository per
  `skeleton/README.md` and fails if a hashed file did not survive, if `check.sh` reports a hash
  failure on a clean adoption, if `.template-version` never arrived, or if a placeholder is left
  outside a `_TEMPLATE.md`. Added to the release procedure as step 2a.
- Hash-list criterion written into `MANIFEST`; generator excludes `# transformed on install`.
- `gitignore.template` — project region above a marker, upstream block below; Python block moved
  into the project region; dropped from the hash list; `upgrade-template.md` step 4 replaces from
  the marker down.
- `.githooks/pre-commit` — substitution point moved out to `.githooks/patterns.profile` (profile
  layer, unhashed, read as data), with blank/comment filtering and regex validation; the hook is
  now verbatim and stays hashed.
- `RATIONALE.md` — `<PROJECT_NAME>` removed from its title.
- `check.sh` — intake exempted from the cap and reported on its dismantling date instead; marker
  check; profile-pattern check; long matches truncated; the self-hosting section no longer prints
  an empty heading on a consumer.
- `.template-version` now ships with its format; `skeleton/README.md` states the copy set as the
  authority and no longer implies rules are typed into `AGENTS.md`.
- §11 rewritten: eleven steps, opening with what one session buys and what stays open; new steps
  for the tracked-file scan, the inventory, the assistant-configuration sweep, and the placeholder
  return; the import test given its own step as a deliberate session break.
- §4 gains the invariant (delete-on-resolve requires non-reusable IDs; ADRs are the exception
  because nothing is deleted from `docs/decisions/`); §5 gains the mirror-image warning; §15's
  copy-set sentence and hash-list description corrected.
- `RULES.md` gains the adoption-note rule and the subject-naming clause for inherited counters;
  `RATIONALE.md` gains the reasoning and four failure-mode rows; both register preambles
  cross-reference §11.

### One-time redaction, at the owner's instruction

The originating repository was named in eighteen places across eight files, twice with its subject
domain attached. Both are information a reader of this repository cannot use: the repository is
private, so nobody can follow the reference, and its subject is irrelevant to every decision that
mentions it. Replaced with "the originating repository", and the two descriptive sentences
rewritten to say what actually mattered — a private repository of the author's, on an unrelated
subject.

**This edits immutable records** — four session files and three ADRs. Done knowingly, on
instruction, as a one-time action and not a rule: the immutability rule protects the historical
record from being improved after the fact, and it is not a reason to keep an identifier in a public
repository. Nothing about what was decided or why has changed. The name survives in git history and
was not pursued there.

## Found along the way

**The harness earned its place on its first run.** It failed immediately on
`ai-sandbox/RATIONALE.md` — mechanism, hashed, and carrying `<PROJECT_NAME>` in its H1, so step 3
breaks its hash for every adopter. A third violation of the criterion, in a file nobody had
looked at, found by executing the install rather than reasoning about it.

**Edited the vendored `check.sh` at the root instead of the artefact in `skeleton/`.** Caught by
`git diff --stat`, moved, root restored to its released hash. Exactly the confusion `AGENTS.md`
names in its second paragraph, made while working on the file that detects drift.

### Raising the root memory, v2.1.0 → v2.2.0

Ran `playbooks/upgrade-template.md` in order. Fourth self-upgrade, and the first to exercise the
`.gitignore` branch that shipped in this release.

- **Step 2** — no MAJOR between the versions, so no migration; file replacement only.
- **Step 3** — `check.sh` reported `ok all match v2.1.0` before anything was replaced. No edits to
  files upstream owns, so nothing was about to be discarded.
- **Step 4** — nine mechanism files replaced, five already identical.
  `.githooks/patterns.profile` installed as new (profile layer, nothing to overwrite).
- **Step 5** — two rule changes reported: the adoption-note rule (new) and the subject-naming
  clause on register deletion for inherited numbered IDs (amended). Both bind future behaviour
  only; every existing entry here still conforms.
- **Step 7** — clean, including the new checks. The tracked-file scan §11 step 2 introduces
  returned nothing, so adopting the never-commit list stranded no file that is already committed.

**The `.gitignore` decision, and what running it exposed.** The root had no `UPSTREAM BLOCK`
marker — but not for the reason step 4's fallback assumes. Its `.gitignore` held *none* of
upstream's patterns: three project lines and a comment saying the ignore list was "for adopting
projects". The fallback is written for a file whose two halves are indistinguishable; this was a
file that had never taken the upstream half at all. `check.sh` cannot tell those apart either, and
its message — "your patterns and upstream's are indistinguishable" — was simply untrue here.

Resolved by adopting the block, on the owner's decision. The root is now a real consumer of the
ignore list, which removes one of the divergences that made `ADR-008`'s defect invisible here: a
repository that ships a never-commit list and does not run it is not running the system it ships
(`ADR-006`). The extra patterns are inert — no data environment, no Python — but the credential
lines are live, and this repository is public.

**Recorded as a finding, not fixed:** step 4's fallback and the marker check both assume the only
reason a marker is missing is age. "Never adopted the block" is a second reason, and the wording
should distinguish them. Not changed in this release — it arrived after the tag.

## Next

Three decisions taken here are ADR-shaped. One is now signed off and written:

- **`ADR-008` — the hash list holds only files installed verbatim.** Reviewed and signed off by
  esdevop on 2026-08-25. Claims added to `docs/method.md` and `docs/CLAIMS.md` in the same change,
  and `docs/method.md`'s dogfooding limitation sharpened: the blind region is installation, and
  `bootstrap-test.sh` is the only instrument that reaches it.

- **`ADR-009` — `.gitignore` is owned by region, and region splitting is an exception.** Reviewed
  and signed off by esdevop on 2026-08-25, with the clarification that made it a decision rather
  than a repair: the two-region layout introduces a **third ownership shape** into a model that had
  two, so it is declared an exception with an explicit condition — *a file is split into regions
  only where an include mechanism is unavailable; where a file can import another, the
  `AGENTS.md`/`RULES.md` device is used.* Without that condition, a marker becomes the comfortable
  answer whenever the mechanism/scaffold choice is awkward. `bootstrap-test.sh` now fails the
  release if a second installed file grows a region marker, so the exception stays bounded by a
  gate rather than by memory.

- **`ADR-010` — the adoption note, and the boundary that keeps it from becoming an excuse.**
  Reviewed and signed off by esdevop on 2026-08-25. Sanctioned because the trial invented the
  device under pressure and the next adopter will invent a different one — differently shaped,
  differently placed, and unrecognisable to any check. The reviewer supplied the boundary nobody
  had named: **an adoption note is a bootstrap artefact**, covering what the project inherited on
  the day it adopted the template and nothing after. Without it a live project starts writing notes
  instead of following rules, each exception individually reasonable. The boundary is about when a
  note is *written*, not how long it lives — one declaring closure unavailable stays as long as the
  divergence does.

- **`ADR-011` — the bump level is steerable by wording, within one bound.** Raised by the reviewer,
  written up here, signed off 2026-08-25. Records that `ADR-004`'s discriminator asks a question
  about the *consumer's* repository, so the wording is the obligation rather than a description of
  the diff — and bounds the one way that could be abused: an exception keeping a release MINOR must
  be **inert or expiring**, otherwise it is a deferred MAJOR called MAJOR now. Both of `v2.2.0`'s
  cases were tested against it and pass.

  Two mechanical consequences, and the second is the more interesting. `ADR-004` is marked
  `extended by ADR-011` — a pointer edit, legitimate precisely because the `Status:` line is the one
  line of an accepted record that may change, and the body is untouched. And `extended by` had to be
  **declared in the ADR template's `Status:` vocabulary in the same change**, because using a value
  the template does not know about would have been the fifth instance of the very pattern this
  release closes. The reviewer caught that; I would have shipped it.

All four ADR-shaped decisions from this session are now signed. Nothing else in the session is.

### The fourth instance, and what it turned into

The reviewer found a defect none of the three ADRs had covered: `CONFIGURATIONS.md` licenses the
`ADR-` number with a human sign-off, and the ADR template has no field to record one. So a decision
that met the bar and one written by a single agent in ten minutes are indistinguishable on the
page. Sharper than F-005's class and in the opposite direction — that check fired always and was
disarmed; this rule fires **never**, so nothing is annoyed and the appearance of order persists.

Four instances of one shape, so it became a release-procedure step rather than a fourth patch. The
reviewer widened my framing, correctly: two of the four were not fields — the hash list is a list,
the intake exemption is a check — so the question at release time is *"a release introduces a rule;
which artefact enforces it, and does it know? Field, check, or list."* The narrow "which field"
version would have caught two of four.

**Checked rather than assumed, and it changed the retrospective half.** `ADR-001`–`ADR-006` come
from sessions that have no `Configuration:` field at all — it arrived with `v2.0.0` — so their
basis is genuinely unreconstructable. `ADR-007` is different: its session records
`Configuration: Solo` and `Signed off: no`, in the same release that introduced the requirement.
That is not "impossible to distinguish"; it is documented non-conformance, one grep away, and it
is the system's first case of a rule failing to apply to the change that created it.

**Which forced the boundary in `ADR-010` to be restated by reason rather than by enumeration.**
"Files inherited at adoption" was too narrow — a project's own records fall out of conformance the
first time an upgrade brings a rule they predate. The reviewer's formulation: a note covers records
the rule cannot reach *because they are older than it*, and the test is whether the file could have
conformed when it was written. `ADR-001`–`ADR-006` pass and get a note; `ADR-007` fails and gets an
honest basis line instead. The loose version would have excused exactly the case worth naming.

**And a rule about version classification, because twice in one release the bump turned on
wording.** `.gitignore` (cheap variant MINOR, structural MAJOR) and the ADR fields (all records
MAJOR, new records only MINOR). The reviewer's answer is that this is the criterion working — the
wording *is* the consumer's obligation, and the two wordings are two different releases — with one
guard: **an exception that keeps a release MINOR must be inert or expiring.** One that requires
both populations to be maintained indefinitely is a deferred MAJOR. Both of today's pass. Recorded
in §15 beside the discriminator and in the release procedure, so the next person reaching for a
grandfather clause meets the constraint next to it.

**F-028 closed without new checking code.** The sanctioned form opens `> **Adoption note.**`, so
the register check's existing blockquote exclusion already skips it — verified against a note
containing the exact words that check greps for. That only works because the form is fixed; the
trial's own note was a numbered list and was reported as the violation it documented.

### What the next session picks up

`v2.2.0` is tagged and the root is running on it. Nothing is left in progress, so no thread
checkpoint was opened — the same outcome as the `v2.0.0` session, and for the same reason:
everything produced either shipped or has a home.

Two things carried forward, neither blocking:

- **`Q-marker-absence-reasons`** — the `.gitignore` marker check and `upgrade-template.md`'s
  fallback both assume a missing marker means the file predates the layout. Found by running the
  upgrade against this repository, where the second reason applied and the tooling asserted the
  first. A wording fix in two places, after the tag.
- **`Q-unexercised-components`** has its first evidence from outside this repository, and it is
  partial: the installation region is now instrumented by `bootstrap-test.sh`, and the rest of the
  question — data environment, source ingestion, the secret scan firing on a real secret — is
  untouched by this release.

Not carried forward, and worth saying so: the trial produced 29 findings and this release acted on
roughly half. The ones left were judged bound to that project's particular shape rather than to the
template, and re-opening them needs a second adopter, not more reasoning about the first.
