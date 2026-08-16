# EXP-<YYYY-MM-DD>-<slug>

**Date:** <DATE> · **Status:** complete | aborted
**Question:** <the single question this run answers>

---

## Reproducibility

| Field | Value |
|-------|-------|
| Git SHA | `<sha>` |
| `uv.lock` | `<hash>` or "unchanged since EXP-<YYYY-MM-DD>-<slug>" |
| Entry point | `src/experiments/<file>.py` |
| Data source | `<catalog.schema.table>` |
| Snapshot date | <date the data was read — upstream tables mutate> |
| Filters / slice | <row and column selection> |
| Cluster / runtime | <DBR version, node type, count> |
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
