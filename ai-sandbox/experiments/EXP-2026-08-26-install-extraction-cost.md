# EXP-2026-08-26-install-extraction-cost

- **Date:** 2026-08-26 · **Status:** complete
- **Question:** After extracting `install.sh`, does a change to the install touch fewer texts than
  it did before?

---

## Reproducibility

| Field | Value |
|-------|-------|
| Git SHA | `3c0da3d` (extraction at `3c0da3d`; baseline change at `d974970`) |
| Environment lock | n/a — no analysis stack; git, coreutils and bash only |
| Entry point | `git show --name-only d974970`; `git status --short` after implementing Gap 4 |
| Data source | this repository's own history and working tree |
| Snapshot date | 2026-08-26 |
| Filters / slice | files whose edit was required for the instruction to be correct and `./bootstrap-test.sh` to pass |
| Runtime / compute | n/a |
| Run duration | n/a — one change, under an hour |
| Run ID (remote/async) | n/a — ran locally |

## Setup

**Metric, fixed before the run:** the number of distinct files that must be edited so that (a) the
instruction is correct and (b) `./bootstrap-test.sh` still passes.

**Baseline:** `d974970`, a change to the install procedure made *before* the extraction. Not a
reconstruction — git records which texts it touched: `skeleton/README.md` and
`bootstrap-test.sh`. **Before = 2.**

**Replayed change:** Gap 4 — make the install perform README's checkpoint rename. Chosen because
it was queued for other reasons the day before extraction was proposed, and had to be done
regardless, so it could not be selected to flatter the result.

**Prediction, recorded before the run:** 1 — `install.sh` only.

**Kill criterion, recorded before the run:** an after-count of 2 or more.

## Result

**After = 3.** `install.sh`, `skeleton/README.md`, `bootstrap-test.sh`. The handbook needed no
edit — it never mentions `CHECKPOINT-thread.md` — which was checked rather than assumed.

| | Before (`d974970`) | After (Gap 4) |
|---|---|---|
| Files edited | 2 | **3** |
| Prediction | — | 1 |

The prediction was wrong by two, and the kill criterion is met. **On its own stated metric this
experiment fails.** The three files are not redundant: one implements the step, one explains what
the install now does rather than leaves, one asserts the result. The prediction of 1 was simply
careless — it accounted for the implementation and forgot that changing what a script *does*
changes what the guide must *say*, and that a new behaviour needs a gate.

### A second measurement, taken after the fact and therefore weaker

Counting statements of the same procedure rather than files:

| Location | Before (`d974970`) | After |
|---|---|---|
| `skeleton/README.md` — install commands (`sed -i`, `xargs sed`) | 1 | **0** |
| `bootstrap-test.sh` — install operations (`sed -i`, `cp -r skeleton`) | 3 | **0** |
| `install.sh` | — | 1 |

The mechanical procedure was written in two places and is now written in one. For Gap 4
specifically, `bootstrap-test.sh` asserts the *result* of the rename rather than performing it,
so the step exists once.

**This measurement was not pre-registered and must not be read as rescuing the hypothesis.** It is
a different question — *how many copies of one fact* rather than *how many files a change
touches* — and choosing it after seeing the first result is the manoeuvre that makes experiments
worthless. It is recorded because it suggests the next question, not because it answers this one.

## Verdict

**contradicts** — a change to the install touched more files after extraction than before, against
a prediction of fewer and past a kill criterion fixed in advance.

## Verification

- **Verified by:** not verified
- **How verified:** not applicable

Both counts are mechanical and re-derivable from the SHAs above. Nobody independent has checked
the judgement of which files were *required* to change, which is the soft part: the claim that
`skeleton/README.md` had to be edited rests on it being wrong to leave an install guide silent
about a capability the installer has, and a stricter reader could count 2.

## What this changes

- **The file-count metric is retired for this question.** It conflates copies of one fact with
  separate concerns, and extraction moves cost in the second direction while removing it in the
  first. Counting files rewards keeping concerns tangled.
- `Q-who-keeps-the-history`'s third piece is **not** advanced by this run. That mechanics belong
  to a script may still be right; this experiment does not support it.
- The next question, pre-registered here so it cannot be chosen after the fact: *does a change to
  the install's **mechanism alone** — one that changes no instruction and adds no behaviour —
  touch one file after extraction where it touched two before?* Gap 4 was the wrong shape for
  that, because it changed what the install does.
- Gap 4 itself is closed and gated, independent of the measurement.

## Threats to this result

- **n=1, and the two changes are not the same shape.** `d974970` rewrote an explanation and an
  implementation; Gap 4 added a behaviour. Comparing their file counts may be comparing nothing.
- **The examiner made both changes, holds the hypothesis, and judged which files were required.**
- **The baseline is one commit.** Two install changes exist before extraction; only one was used.
- **The after-count was taken on a tree the examiner had restructured hours earlier**, so it
  measures the cost of changing something still fresh in memory. The cost that matters falls on
  someone who was not there.
