# rnd-project-memory — Assumption Register

- **Updated:** 2026-08-17

> What the method **bets on, and where it could be wrong**. Not "what I understood about the
> project" — that belongs in `docs/`. The test: *if this turned out false, what breaks?*
>
> Two resting types: `ASSUMED` (plausible, unverified) · `INFERRED` (derived logically).
>
> **There is no `CONFIRMED` entry in this file.** Confirmation is a transition, not a state:
> the moment an assumption is verified it becomes a fact, moves to `docs/`, and is deleted
> from here. `checkpoint.md` performs that move. Anything sitting here is by definition still
> unverified — which is what keeps the register bounded and worth reading.
>
> **IDs are slugs, not numbers** — `A-keeper-latency`, not `A4`. Same reason as
> `OPEN_QUESTIONS.md`: deletion pits a numbered sequence and old cross-references silently
> point at the wrong entry.

> **`Owner:` takes a human name, not a git address.** It names who is accountable for the
> entry — a possession that outlives any clone — and is deliberately not the `Held by:`
> value, which names a temporary write claim and is bound to `git config user.email`
> (`ADR-012`).
>
> **`Owner:` is always filled in, even working alone.** Blank must mean *nobody has
> claimed this* — the signal the field exists to carry. If solo-era entries are left
> blank, that meaning is destroyed the day a second person joins.

---

## A-vendor-no-drift · Consumers will not edit files they do not own — `ASSUMED`

- **Raised:** 2026-08-17 · **Owner:** esdevop (human)
- **Basis:** ADR-002/ADR-003 reasoning. The whole no-conflict argument rests on manifest-owned files
  being untouched downstream.
- **If false:** Upgrades stop being delete-and-copy and become merges, at which point they stop
  happening — the exact failure ADR-002 was written to avoid, arrived at by a different route. The
  symptom is silent: a consumer's local fix is destroyed by an upgrade, and the person who made it
  concludes upgrading is unsafe.
- **What would settle it:** The `check.sh` hash comparison from ADR-003, observed over the first few
  upgrades. A consumer editing an owned file is exactly what it reports.

## A-prose-migrations · An assistant executes prose migrations reliably — `ASSUMED`

- **Raised:** 2026-08-17 · **Owner:** esdevop (human)
- **Basis:** ADR-004. Assumed, not demonstrated; no migration has ever been run. What rests on this
  **decreased** the same day: rules moved into a mechanism file, so the common rule change is a file
  replacement rather than a migration, and the withdrawn preamble fences no longer need an assistant
  to apply region diffs. Migrations now carry structural change only.
- **If false:** A half-applied migration is worse than none — the repository claims a version it does
  not structurally have, and the next migration builds on a false base. Failure is likely partial and
  quiet rather than loud, because the steps that get skipped are the exceptions ("do not touch
  immutable files"), which are also the ones nothing checks.
- **What would settle it:** The first real v1 → v2 migration executed against this repository under
  ADR-006, with `check.sh` run before and after and the diff reviewed by hand.

## A-misdirection-criterion · Content that does not instruct falsely is safe to leave — `ASSUMED`

- **Raised:** 2026-08-17 · **Owner:** esdevop (human)
- **Basis:** `EXP-2026-08-17-pattern-list-extraction` and `EXP-2026-08-17-misdirection-recheck`. The
  criterion was formulated during the first of those, on the two files it exonerated, and it has
  since reduced the design's scope twice. That provenance is a reason to hold it loosely.
- **If false:** Content that does misdirect was classified as harmless and left in place — most
  plausibly in the nine register files, which were assessed as a class rather than individually. The
  symptom would be an adopting project quietly following a rule the template no longer holds.
- **What would settle it:** The first upgrade of a project that has been running on an older version
  for months, watched specifically for whether stale preamble text changed anyone's behaviour. Until
  then the asymmetry is what justifies acting on it: leaving these files alone is reversible,
  fencing them is nine files of work against no evidence.

## A-dogfood-coverage · The half dogfooding exercises is the half most likely to be wrong — `INFERRED`

- **Raised:** 2026-08-17 · **Owner:** esdevop (human)
- **Basis:** Inferred from where design churn has concentrated: routing, checkpoint discipline,
  promotion, and the upgrade machinery — all exercised by this repository. The unexercised components
  (data environment, source ingestion, secret scanning) have been comparatively stable.
- **If false:** Confidence accumulates precisely where it is not warranted. A clean `check.sh` and a
  smooth run of sessions here would be read as "the system works", while the components that fail at
  the first work project were never touched.
- **What would settle it:** First real use at work, treated as a pilot — see
  `Q-unexercised-components`. Until then this assumption should be restated whenever the system is
  described as validated.
- **Evidence, 2026-08-25:** An external adoption trial confirmed the consequence and sharpened the
  statement. Three shipped defects (`ADR-008`) lived not in the *unexercised* half but in a third
  category the inference missed: components dogfooding appears to exercise while taking a different
  path through them. This repository never installs the skeleton, so its own `check.sh` reported
  `ok` for four releases while every adopter saw a failure on line one. "Exercised" and "exercised
  the way a consumer exercises it" are different claims. That region is now instrumented by
  `bootstrap-test.sh`; the originally-named components remain untouched.

## A-personal-provenance · The core is personal work, not work-for-hire — `ASSUMED`

- **Raised:** 2026-08-17 · **Owner:** esdevop (human)
- **Basis:** ADR-001, restated the same day after reading the first commit instead of assuming it.
  The history does **not** show the system predating its use at work — that was the first, wrong
  reading. It shows six generic templates brought *from* the work project, deleted wholesale, and the
  current system created in their place inside a personal repository. What the evidence supports is
  that everything from that commit onward is new work done here; it says nothing about whether that
  work is within an employer's IP reach.
- **If false:** An employment agreement claiming work-derived IP could reach the core, undermining
  both the MIT licence and the right to use it in personal projects. Two routes make it more
  plausible than the first framing suggested: the predecessors came from the job, and the design has
  been shaped throughout by the intention to use it there. Consequences are legal rather than
  technical and would surface only when expensive.
- **What would settle it:** Reading the actual employment agreement, and asking if it is ambiguous.
  Not resolvable by reasoning here — this entry records that the system is betting on it, not that
  the bet is safe. The scan of the superseded files (ADR-001) addresses confidentiality and is not
  evidence either way on this question; do not let the clean scan stand in for the answer.

## A-identity-is-the-person · The git identity in a clone is the person working in it — `ASSUMED`

- **Raised:** 2026-08-26 · **Owner:** esdevop (human)
- **Basis:** `ADR-012`. `Held by:` is bound to `git config user.email`, so every layer that checks
  a holder is really checking a clone's configuration. Two of the three ways an identity goes wrong
  fail safe — unset returns empty, and a fabricated or unfamiliar address does not match anyone —
  but an address configured for somebody else resolves cleanly and looks correct everywhere.
- **If false:** A thread is attributed to a person who never held it, with no signal anywhere: the
  git log, the checkpoint and `INDEX.md` all agree, because they are all reading the same wrong
  configuration. `RULES.md` then grants the write right to the wrong person, and the next session
  reads it as fact. The concrete case is one contributor working from another's machine.
- **What would settle it:** Signed commits with per-person keys, which is the only mechanism that
  binds a commit to a person rather than to a configuration. Judged disproportionate for a project
  of this size; recorded here as the stated boundary of the binding rather than as an open question,
  because nothing about it is unresolved — the cost was weighed and the risk accepted.
