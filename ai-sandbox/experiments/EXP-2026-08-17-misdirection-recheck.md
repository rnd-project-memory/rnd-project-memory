# EXP-2026-08-17-misdirection-recheck

**Date:** 2026-08-17 · **Status:** complete
**Question:** Applied to the nine preamble files and the three remaining Group A files, does the
misdirection criterion reclassify any of them?

---

## Reproducibility

| Field | Value |
|-------|-------|
| Git SHA | `9d547dc` |
| Environment lock | `n/a` |
| Entry point | `n/a` — analysis of files already read in full |
| Data source | all 12 files named below, at `9d547dc` |
| Snapshot date | 2026-08-17 |
| Filters / slice | `n/a` |
| Runtime / compute | `n/a` |
| Run duration | `n/a` |

## Setup

`EXP-2026-08-17-pattern-list-extraction` produced the criterion — *stack content is a defect when
it instructs wrongly, not when it merely sits there* — and flagged as its own primary threat that
it had been formulated on the two files it exonerated. This run re-applies it to the twelve files
classified before it existed.

The criterion needed restating to cover the preamble files, whose problem is ownership rather than
stack. Its general form: **what specifically goes wrong if this content is one version old?**

## Result

### The three remaining Group A files

| File | What goes wrong if stale | Disposition |
|------|--------------------------|-------------|
| `DATA_ENVIRONMENT.md` | `uv sync`, `uv run python`, `uv add`, Unity Catalog naming — a project on another stack is given instructions that are simply false | **True profile.** Confirmed, unchanged |
| `AGENTS.md` | "data analysis against Azure Databricks … Python, managed with `uv`" sits in *About this project*, which the adopter rewrites — but it carries no `<placeholder>`, so it reads as fact and survives a careless fill-in | One line: make it a placeholder |
| `INDEX.md` | One table cell describes `DATA_ENVIRONMENT.md` as "Databricks, uv, run recipes" — wrong for another stack, but only as a description of another file | One cell: describe the file's purpose, not its current contents |

One genuine profile file. Two one-line fixes.

### The nine preamble files

Working through what actually happens when a preamble is one version behind:

**A stale rule is not a wrong rule.** It is the previous version of a rule that was acceptable when
it shipped. The failure mode of a stale preamble is *missing a newly added rule*, not *following a
false one* — which is a much weaker harm than the audit assumed when it made fencing a
prerequisite.

**The exception is a rule revised because the old one was harmful** — and that case is already
covered elsewhere. If v2 forbids something v1 permitted because v1 caused damage, the project also
needs its existing entries repaired, which is a MAJOR bump with a migration entry by ADR-004's own
table. The migration handles the preamble and the damage together.

**Everything else that changes in these files changes at MAJOR anyway.** Vocabulary (the
`CLAIMS.md` basis list), schema (a new `LOG.md` column), filenames — all are "a register's schema
changed" or "a file moved", both MAJOR, both migrated.

What is left for a fence to deliver is PATCH-level prose improvement: a better-worded explanation
of why deletion beats marking-resolved. Slightly older but correct prose misdirects nobody.

### The fence is also internally inconsistent

ADR-002 introduces markers, then states that the upgrade does not auto-replace the region — an
assistant applies the diff. But an assistant does not need markers to find a preamble: in all nine
files it is the blockquote block above the first `---`, and `git diff` against the released
skeleton already shows what changed. Markers are only required by a tool doing automatic
replacement, and ADR-002 explicitly declines to build one.

A prose migration can address these files by description — *"the `OPEN_QUESTIONS.md` preamble
changed in v2; here is the new text; replace yours and keep your entries"* — which is exactly the
mechanism ADR-004 already commits to, with no new syntax in nine files.

## Verdict

**contradicts** — the fencing prerequisite does not survive its own criterion. Of the twelve files
re-examined, one is a genuine profile file, two need a single line each, and nine need no
structural change at all.

## What this changes

**The scope collapses.** The audit reported eleven leaking files plus nine mixed files. After both
experiments and this recheck:

| Disposition | Files |
|-------------|------:|
| True profile — substituted | 1 |
| Local edit — one line to one section | 5 |
| Leave alone — vendor enumeration is the correct form | 1 |
| No structural change; preamble updates ride on prose migrations | 9 |

**ADR-002 loses the fencing mechanism** and the `region:` scope column in `MANIFEST`. The nine
files become `scaffold`: seeded at bootstrap, owned by the project thereafter, updated by
migration when a rule change warrants one.

**Step 4 may collapse entirely, and this needs a decision rather than an inference.** Step 4 grew
from "split `AGENTS.md` into `RULES.md`" to "fence nine files"; the fence is now gone, and the
split's justification — that `AGENTS.md` must be project-owned while consuming upstream rules —
dissolves too if `AGENTS.md` is simply scaffold. But the split also served ADR-006: dogfooding was
meant to exercise the upgrade machinery, and scaffold files are never upgraded. Dropping the split
buys simplicity and costs exercise of the mechanism that most needs it. That trade is a judgement
call about what the repository is for, not something this experiment settles.

**ADR-004 has a gap.** A new or changed *behavioural rule* — not a rename, not a schema change, not
an optional addition — fits none of MAJOR, MINOR, or PATCH as defined. It is precisely the change
that must reach existing projects, since an assistant operating without it violates it. The version
table needs a row for it, and the answer is probably MAJOR-with-a-prose-migration.

## Threats to this result

- **The criterion was mine, and it has now shrunk the design twice in a row.** A test that keeps
  concluding "less work than we thought" deserves more suspicion than one that does not. The
  structural check that partly offsets this: not fencing is reversible. If preamble drift turns
  out to matter at v3, fencing can be added then, against real evidence. Building it now costs
  edits in nine files against no evidence. The asymmetry favours the smaller design regardless of
  whether the criterion is exactly right.
- **No project has yet lived through an upgrade.** Every claim here about what a stale preamble
  does is reasoning, not observation. The first real migration under ADR-006 is what tests it, and
  it should be watched specifically for preamble drift.
- The nine files were assessed as a class after the first three were assessed individually. If one
  of them carries something operative that the others do not, class-level reasoning would miss it.
  `CLAIMS.md` is the likeliest candidate — its basis vocabulary is consumed by `promote.md` step 3
  — and it was checked individually for that reason, but the other eight were not.
- `n/a` on reproducibility fields throughout: this is analysis, not measurement. Its verdict is an
  argument, and a reader who disagrees with the argument should discard the verdict.
