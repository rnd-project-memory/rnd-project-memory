# rnd-project-memory — Claims Index

**Updated:** 2026-08-23

> **An index, not a second copy.** One line per claim: a shorthand, the file it lives in, when
> it landed, and what it rests on. The claim's actual wording stays in its file — restating it
> here would create the drift this system exists to prevent, exactly as `sessions/LOG.md`
> indexes session files without duplicating them.
>
> **Written as part of promotion, never as separate housekeeping.** `promote.md` step 3 updates
> this file in the same change as `docs/`. An index maintained by good intentions goes stale,
> and a stale index is worse than none, because `promote.md` step 2 has started trusting it.

---

## Why the basis column exists

`ASSUMPTIONS.md` distinguishes `ASSUMED` from `INFERRED`. Once a conclusion moves into `docs/`
that distinction is lost: a claim verified by experiment and a claim reasoned from one call
transcript read with identical authority, and six months later nobody can tell them apart — while
decisions get made on both.

The basis column restores it, at the cost of one field.

## Basis vocabulary

Exactly one of these. **A claim with no basis does not belong in `docs/`.**

| Basis | Meaning | Strength |
|-------|---------|----------|
| `EXP-<date>-<slug>` | Measured. Cite every relevant run, including contradicting ones | strongest |
| `S-<slug> §<loc>` | Stated by an external source | inherits that source's reliability |
| `sessions/<file>` | **Reasoned** in a session — no external source, no measurement | weakest; re-examinable |
| `ADR-<nnn>` | A decision taken, not a fact discovered | binding, not true |

The third entry closes a real gap: reasoning in session is the *primary* way knowledge is
produced here, yet `ingest-source.md` correctly refuses to register an AI conversation as a
source. Without a legitimate basis for reasoned conclusions, an assistant either invents a source
ID or leaves the number bare. A session file is the honest answer — it is a real, immutable,
citable artifact, and labelling a claim as reasoned rather than measured is information, not an
admission.

Prefer the strongest basis available; if a claim rests on several, list them.

## Review triggers

- **`sessions/…` basis and the claim now matters** — worth an experiment. This is how the index
  surfaces what to measure next.
- **`S-…` basis from a mutable source** (Confluence) read long ago — re-verify.
- **Superseded** — mark the row `superseded by <shorthand>`; leave it, do not delete. Unlike
  register entries, a claim's history is what tells you the question was already considered.

---

**ADRs are not indexed here.** `docs/decisions/ADR-NNN-<slug>.md` names its own subject, and the
basis vocabulary treats `ADR-<nnn>` as *a decision taken, not a fact discovered* — a row whose
basis was itself would be circular. Rows index claims in ordinary `docs/` files that rest on them.

| Claim | File | Date | Basis |
|-------|------|------|-------|
| Every file is owned by exactly one of four layers | `docs/method.md` | 2026-08-17 | `ADR-002` |
| Content is a defect only when it instructs falsely | `docs/method.md` | 2026-08-17 | `ADR-002`, `EXP-2026-08-17-pattern-list-extraction` |
| `DATA_ENVIRONMENT.md` is the only true profile file | `docs/method.md` | 2026-08-17 | `ADR-002`, `EXP-2026-08-17-profile-indirection` |
| Register files need no fencing; a stale rule is not a wrong rule | `docs/method.md` | 2026-08-17 | `ADR-002`, `EXP-2026-08-17-misdirection-recheck` |
| The profile appends to the secret-scan list, never replaces it | `docs/method.md` | 2026-08-17 | `EXP-2026-08-17-pattern-list-extraction` |
| Consumers vendor a pinned copy; upstream never merges | `docs/method.md` | 2026-08-17 | `ADR-003` |
| A rule change is MAJOR only if existing entries stop conforming | `docs/method.md` | 2026-08-17 | `ADR-004` |
| Handbook and skeleton share one tag | `docs/method.md` | 2026-08-17 | `ADR-004` |
| A thread's checkpoint belongs to whoever it names `Held by:`, not to a filename | `docs/method.md` | 2026-08-23 | `ADR-007` |
| Negative knowledge (distrust, scope limits, legitimate absence) needs its own field, not prose | `docs/method.md` | 2026-08-23 | `ADR-007` |
