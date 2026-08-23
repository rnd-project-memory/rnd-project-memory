# ADR-007 · Threads replace owners; negative knowledge gets an explicit home

**Date:** 2026-08-23 · **Status:** accepted

## Context

A design review against a real closed project's three months of memory files (documented
externally, not committed to this repository) found thirty candidate improvements by reading
where hand-written values escaped the vocabulary a register declared for them — the same method
ADR-002's `check.sh` findings were an early instance of, generalised. Two findings changed the
design at the level of an existing ADR rather than adding a field:

**Ownership by filename doesn't survive concurrency it wasn't designed for.** ADR-002 gave each
`CHECKPOINT-<owner>.md` to one person specifically to avoid the worst possible git-merge shape —
a wholesale rewrite conflicting across an entire file. In the real project, though, one person
running several agents in parallel produced multiple *threads* of work pausing and resuming
independently (a delivery, a schema catalog, a stakeholder question — different days, different
models, no relation to each other), all landing in one owner's single file. The owner axis didn't
prevent the diverging-copies failure ADR-002 was written to avoid; it just moved it one level
down, from "two people, two files" to "two unrelated threads, one file."

**Distrust and prohibition had no address.** The same review found that what stopped a mistake
from repeating — "don't mark this task done until re-verified", "this relationship is unproven,
don't cite it" — was never a field. It was always prose, usually buried in whichever file was
open at the time, and it was the single highest-value class of writing in the whole memory: an
artefact can record what happened, but it cannot record what to disbelieve about what happened,
and no existing file in this design claimed that job.

## Decision

**The checkpoint axis becomes the thread, not the person.** `CHECKPOINT-<owner>.md` is renamed
`CHECKPOINT-<thread-slug>.md`; ownership becomes a `Held by:` field, read by anyone, written only
by whoever currently holds it, with a take-over recorded as an event rather than a silent edit.
The property ADR-002 actually wanted — no two people rewriting the same file concurrently — is
preserved: it now reads "no two people holding the same *thread* concurrently," which is the
correct scope, since the object in danger of diverging is the thread's state, not the person's.

**Negative knowledge is named as a first-class category with three forms, each with an
address**: distrust (a checkpoint's `Do not do until re-verified:` field), scope limits (`Does
not license:` on a claim or assumption), and legitimate absence (a mandatory pointer field
accepting `—` as a real value, never the nearest similar ID). All three follow the same rule of
form: written as a prohibition or the name of a specific check, never as a confidence adjective —
adjectives degrade silently over months in a way a named check cannot.

Both decisions ship as part of `v2.0.0`, alongside a broader set of additive changes (evidence
requirements on experiment records, a traps registry, a publications register, session
configuration tracking) — see `MIGRATIONS.md`'s `v1.2.0 → v2.0.0` section for the full,
per-file account.

## Alternatives considered

| Option | Why not |
|--------|---------|
| Keep owner-named checkpoint files | Already shown to reproduce the exact silently-diverging-copies failure it exists to prevent, one level down, inside a single person's own concurrent work |
| `CHECKPOINT-<thread>-<owner>.md` per person per thread | The same failure again: nothing reconciles two people's parallel copies of one thread's state, and determining which reflects reality requires reading both in full |
| A `Confidence:` field for negative knowledge, matching a pattern already in `ASSUMPTIONS.md` | The evidence this review reads from is exactly this pattern's failure mode elsewhere: a confidence field in the source project's real registers converged to one value in the overwhelming majority of entries within months, carrying no information by the time it mattered |
| Leave negative knowledge in prose, relying on "write for a reader who missed the session" | Already the standing rule, and it was not sufficient in the source material: the same prohibition was independently duplicated across three files rather than reliably found in any one of them |

## Consequences

- Closing a thread (splitting its remainder to `docs/` plus one `OPEN_QUESTIONS.md` entry, then
  deleting the file) loses the value of holding several sessions' state together in one place.
  Every fact has another home to move to; the synthesis of holding them together does not. This
  is accepted as a real, bounded cost — not solved by this design.
- The staleness check that used to demand a verdict from a checkpoint's own owner now only
  reports and counts, because under the thread axis the person opening a session is often not
  the thread's holder. `ai-sandbox/STALENESS_LOG.md` exists to make that reporting checkable
  later, and is deliberately temporary — deleted once the 3-week threshold `session-start.md`
  uses is validated against enough real closures to say whether it was right.
- `RATIONALE.md` carries the fuller argument for negative knowledge as one principle rather than
  three unrelated fields, and the diagnostic (a field's hand-appended values name the missing
  axis; a field collapsing onto one value asks the wrong question) that found both gaps in the
  first place — see `docs/CLAIMS.md` for the resulting claims and their basis.
