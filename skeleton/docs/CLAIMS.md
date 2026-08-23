# <PROJECT_NAME> — Claims Index

**Updated:** <DATE>

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

- **`sessions/…` basis and the claim now matters** — name the specific experiment that would
  settle it **at the point you notice this**, not as a reminder to figure out later. A
  confidence adjective degrades quietly; a named check either exists or it doesn't.
- **`S-…` basis from a mutable source** (Confluence) read long ago — re-verify.
- **Superseded** — mark the row `superseded by <shorthand>`; leave it, do not delete.

**This file is deliberately a journal for superseded rows, not a pure registry** — the one
place in this system where history is kept on purpose rather than deleted (`P-024` does not
apply here): a claim's history is what tells you the question was already considered. Every
other register in this system follows the opposite rule; if one of them starts accumulating
rows the way this file does, it has quietly become a journal too and needs the same declaration
this file already carries — not a silent drift.

---

| Claim | File | Date | Basis | Does not license |
|-------|------|------|-------|-------------------|
| <shorthand, ~8 words> | `docs/method.md` | <DATE> | `EXP-…` \| `S-…` \| `sessions/…` \| `ADR-…` | <optional — blank means no narrower scope to flag> |
