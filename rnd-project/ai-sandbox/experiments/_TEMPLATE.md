# EXP-<YYYY-MM-DD>-<slug>

**Date:** <DATE> · **Status:** complete | aborted
**Question:** <the single question this run answers>

---

## Reproducibility

A field marked `n/a` is as informative as a filled one; a blank cannot be told from an
oversight. `DATA_ENVIRONMENT.md` states what this project's stack requires here.

| Field | Value |
|-------|-------|
| Git SHA | `<sha>` |
| Environment lock | `<lockfile hash>`, "unchanged since EXP-<YYYY-MM-DD>-<slug>", or `n/a` |
| Entry point | `<path to the committed script or query>` |
| Data source | `<identifier in the form this project uses — see DATA_ENVIRONMENT.md>` |
| Snapshot date | <when the data was read, or "immutable source"> |
| Filters / slice | <row and column selection> |
| Runtime / compute | <what identifies the execution environment: version, machine type, count> |
| Run duration | <time> |

## Setup

<What was varied, what was held fixed, and the baseline compared against.>

## Result

<The numbers, with uncertainty. State the metric and its definition.>

## Verdict

**supports | contradicts | inconclusive** — <one line>

## What this changes

<Which open question it touches, which assumption it moves, what it proposes for `docs/`.>

## Threats to this result

<Leakage, sample size, confounds, anything that would make it not replicate.>
