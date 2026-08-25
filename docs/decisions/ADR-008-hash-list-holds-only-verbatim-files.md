# ADR-008 · The hash list holds only files installed verbatim

- **Date:** 2026-08-25 · **Status:** accepted
- **Configuration:** Author + reviewer + sign-off
- **Participants:** author — claude-opus-5 · high effort; reviewer — esdevop (human)
- **Signed off:** esdevop — the decision; this text was written afterwards and unreviewed

## Context

`.template-hashes` exists so a consumer can be told, offline and before an upgrade, that someone
has edited a file upstream owns. Its value rests entirely on its output meaning something: the
check runs first, and it is the first line of `check.sh` an adopter ever reads.

An external adoption trial — one adopter, one existing project, following the handbook without
access to its author — reported that this check fails on a clean, correct adoption. It does, and
for a reason that generalises past that project. The list was generated from `MANIFEST`'s
`mechanism` entries and their paths inside `skeleton/`, on the stated assumption that "paths are
relative to a consumer's repository root, which is what `skeleton/` becomes". That assumption is
false for any file the installation transforms. Three entries broke it, in three different ways:

| Entry | Transformation | Result at the consumer |
|---|---|---|
| `gitignore.template` | renamed to `.gitignore` by install step 2 | `FAILED open or read`, permanently |
| `.githooks/pre-commit` | a profile appends its own credential patterns to it | `FAILED` for any organisation with a profile |
| `ai-sandbox/RATIONALE.md` | carried `<PROJECT_NAME>` in its title; install step 3 fills it | `FAILED` for every adopter, before the first commit |

**None of the three was visible to this repository.** Self-hosting vendors the skeleton's files in
place: nothing is renamed, no placeholder is filled, and the copy set is never chosen. The root
keeps `gitignore.template` at its own root as the artefact source, has no profile, and has no
`<PROJECT_NAME>` left to fill — so its `check.sh` reported `ok all match` through four releases
while every consumer saw a failure on line one. The defects live in the transformation from
skeleton to consumer, and this repository never performs that transformation.

What that costs is not the individual false positives. It is that an adopter's first contact with
the tooling teaches them that failing checks are normal — after which the check has no value left
to lose, including on the day it is right.

## Decision

**The hash list may contain only files installed verbatim, subject to no transformation.**

Not "files nobody is told to edit". The three transformations differ in kind — a rename, a
substitution, a placeholder fill — and only the consequence is shared, so the criterion is stated
over the installation rather than over anyone's intentions.

Three things carry it:

- `MANIFEST` states the criterion and tags any mechanism entry the install transforms with
  `# transformed on install`. The generator in `MIGRATIONS.md` excludes exactly those, and nothing
  else may be excluded.
- `bootstrap-test.sh` installs `skeleton/` into a scratch repository per `skeleton/README.md` and
  fails the release if any hashed path did not survive byte-for-byte. That is the criterion
  restated as an executable test, and it is the only place in this repository where the
  transformation is performed at all. It runs as step 2a of "Cutting a release".
- The three violations are repaired rather than tolerated. `gitignore.template` is tagged and
  excluded; `RATIONALE.md`'s title placeholder is removed, since a file upstream owns has no
  business being personalised; and `.githooks/pre-commit` is made verbatim by moving the profile's
  substitution point out into `.githooks/patterns.profile`, which the hook reads as data and which
  is itself unhashed. The existing claim that the profile *appends* to the secret-scan list and
  never replaces it is unchanged — only the file it appends to is new.

## Alternatives considered

| Option | Why not |
|--------|---------|
| Move the entry to the consumer-side path (`.gitignore`) | Reproduces the defect from the other side. Every adopter is instructed to merge their own patterns into that file, so the check becomes `FAILED` on checksum rather than on open, for the same population, on the same line. There is no path at which the entry works, because the file is simultaneously hash-checked and required to be edited. This was the obvious fix and it is the one that looks most harmless. |
| Hash a stable region of a transformed file | Needs the checker to parse file structure — more machinery than this system has anywhere else, and it survives only as long as the region markers do. For `pre-commit` the split removed the need entirely; for `.gitignore` it remains available later, since the region below the marker is verbatim by construction. |
| Keep the entries and document the failure as expected | An expected failure on the first line is what teaches an adopter to stop reading the output. This is the outcome the trial actually observed. |
| Drop `.githooks/pre-commit` from the list | It is the file `MANIFEST` itself calls the one whose failure a later edit cannot repair. Losing integrity reporting on it to fix a reporting defect is the worst of the three outcomes. |

## Consequences

- The hash list shrinks by one entry and gains a rule that decides membership at every future
  release, rather than being reconsidered case by case.
- A new profile file, `.githooks/patterns.profile`, ships and is deliberately unhashed. Because it
  is read as data, a supplied file that is blank-padded or malformed can no longer reach the core
  pattern: blank and comment lines are dropped (an empty alternative matches every line, blocks
  every clean commit, and trains `--no-verify`), and a file that does not compile is discarded with
  a warning (a malformed pattern makes `grep` exit 2, which the hook could not tell apart from
  "found nothing", silently disabling the scan). The failure mode improves rather than moving.
- `check.sh` reports whether that file is present, since nothing else would notice its absence.
- `gitignore.template`'s exclusion leaves its ownership open; that is settled separately by the
  two-region layout, and this ADR does not decide it.
- **Dogfooding is now known to have a blind region, and its shape is stated:** anything that only
  happens during installation. `bootstrap-test.sh` is the only instrument that reaches it, which
  makes it a release gate rather than a convenience. This bears directly on
  `Q-unexercised-components`, which asked how components this repository never exercises get
  validated; the answer for this class is *by installing into a scratch repository*, and for the
  rest it is still open.
- The evidence is one adopter on one project. The criterion is adopted anyway because the
  mechanism is general — the check is upstream's, the installation is upstream's, and neither
  depends on the adopting project's shape. Findings from the same trial that were bound to that
  project's particulars were not acted on.
