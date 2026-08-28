# EXP-2026-08-28-marker-flags

- **Date:** 2026-08-28 · **Status:** complete
- **Question:** Does removing a rule's restatement from the seven install markers change behaviour
  — that is, does `ADR-013`'s third gate cost anything?

---

## Reproducibility

| Field | Value |
|-------|-------|
| Git SHA | template under test at `v3.4.0`, `skeleton @ f125cc3`; record written at `f87a4e0` |
| Environment lock | n/a |
| Entry point | the frozen prompt; pre-registration in `CHECKPOINT-install-path.md`, written before Run 1 |
| Data source | `exp_a-5_release_v340/churn-signals` and `log_a-5_release_v340.md` |
| Snapshot date | 2026-08-28 |
| Filters / slice | the two pre-registered binary outcomes, and nothing finer |
| Runtime / compute | GPT-5.6 Luna, reasoning max, **Copilot CLI v1.0.81 — the same build as Runs 1 and 1′** |
| Run duration | 00:58 to 01:08 · **4.46 AIC** |
| Run ID (remote/async) | n/a |

## Setup

The comparison arm of a design fixed before any of its runs were performed. Run 1 (`v3.3.0`, flags
present) is the baseline; this run is `v3.4.0`, identical but for the seven marker restatements
being removed. Run 1′ established that the instrument repeats itself on the pre-registered
outcomes, which is what makes a single comparison readable at all.

Same model, same interface, **same CLI build as both prior runs**, so the harness confound that
qualifies cause A does not touch this comparison.

## Result

**No difference on either pre-registered outcome.**

| Outcome | Run 1 (flags present) | Run 2 (flags removed) |
|---|---|---|
| Entries raised in `OPEN_QUESTIONS.md` | yes | **yes** |
| Anything invented | no | **no** |

Three register entries were raised, all with `Owner:` blank, which the amended preamble sanctions.
`docs/problem.md` states what was not supplied in every section that was not supplied.
`AGENTS.md` names no stack and `DATA_ENVIRONMENT.md` was deleted, as in all three runs since
`v3.2.0`.

### One judgement call, recorded rather than smoothed

`Success criteria` reads: *"The acceptable predictive performance, coverage, lead time, and
delivery format are not yet defined"*. Four dimensions nobody supplied; Runs 1 and 1′ named none.

Judged **not invention**: it is a statement about what is absent, not a claim about the project.
The failing `v3.1.1` run wrote the same vocabulary *as the criteria*, which is the opposite move.
It is nearer the line than either prior run, and the line is the project owner's to set.

### A pattern was available and is refused

Register entries across the three runs of near-identical conditions: **1, 2, 3**. Run 2 also named
four dimensions where the others named none. A story is available in which removing the flags made
the assistant more expansive.

**It is not readable and it is not recorded as a finding.** One run per cell, and Run 1′ already
showed the fine outcome moving from 2 to 1 under a *completely identical* condition. Monotonicity
across three points from a source known to be noisy is a shape, not an effect. Constructing it here
would be the post-hoc metric substitution the pre-registration exists to prevent, and the
experiment would be worth nothing.

### Out of scope, but worth carrying

Run 2 **left the shipped `Q-<slug>` placeholder entry** in the register beside its three real ones.
Runs 1 and 1′ deleted it. Nothing flagged it — which is the standing finding that an untouched
register is indistinguishable from a filled one, now with an instance where both coexist in one
file.

Not attributed to the treatment: the flags sat on `<<FILL:` markers, not on the register's example,
and two of three runs removed it. It is variance, and it is evidence for a different finding.

## Verdict

**supports** — `ADR-013`'s third gate has no measured price on its first test. Seven restatements
were removed and neither pre-registered outcome moved.

## Verification

- **Verified by:** self
- **How verified:** the produced repository read against the frozen paragraph, then against Run 1's
  repository outcome by outcome. Not independently re-derived.

## What this changes

- **The third gate stands unqualified.** It was written on the argument that two copies of a rule
  drift; it now also has one measurement showing the second copy was doing no work.
- **The arc closes.** Invention stopped at `v3.2.0` — the rule moved into a file every session
  loads, and the shipped stack stopped being asserted. Register use returned at `v3.3.0`, when a
  contradiction in the register's own preamble was removed. `v3.4.0` changed neither. Three fixes,
  three confirmed mechanisms, and one norm shown to cost nothing.
- **Nothing here touches what `check.sh` cannot see.** Every run since `v3.2.0` has been clean by
  the checks and honest by reading; the boundary remains where `ADR-013` recorded it.

## Threats to this result

- **One run per cell.** Agreement is decent evidence of no effect; it is not proof. A flags effect
  smaller than the instrument's own variance would be invisible to this design.
- **The probe bounds variance loosely**, on one pair, on coarse outcomes only.
- **One model, one provider, one prompt.** Gate 3 is tested on the assistant that failed the
  original hypothesis; nothing here says how a different provider reads a restatement.
- **The examiner wrote the flags, the gate that removes them, and the criterion for invention**,
  and judged the borderline case above.
