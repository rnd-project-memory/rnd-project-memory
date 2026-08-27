# EXP-2026-08-28-probe-and-cause-a

- **Date:** 2026-08-28 · **Status:** complete
- **Question:** Two, pre-registered together: is the instrument steady enough to read a one-run
  comparison, and did fixing the register's preamble restore use of the register?

---

## Reproducibility

| Field | Value |
|-------|-------|
| Git SHA | template under test at `v3.3.0`, `skeleton @ 7fff20b`; record written at `8a15178` |
| Environment lock | n/a |
| Entry point | the frozen prompt, `EXPERIMENTAL_LOG.md` Appendix; pre-registration in `CHECKPOINT-install-path.md` |
| Data source | `exp_a-4-1_release_v330/` and `exp_a-4-2_release_v330/`, with `log_a-4-1`, `log_a-4-2` |
| Snapshot date | 2026-08-28 |
| Filters / slice | the two pre-registered binary outcomes, and nothing finer |
| Runtime / compute | GPT-5.6 Luna, reasoning max, **GitHub Copilot CLI v1.0.81** |
| Run duration | Run 1 started 00:15, Run 1′ 00:28 · **4.88 and 3.89 AIC** |
| Run ID (remote/async) | n/a |

## Setup

Two runs of the **identical** condition — `v3.3.0`, marker flags present — thirteen minutes apart.
The design, its two binary outcomes and its stopping rule were written into the thread checkpoint
before either was performed.

The probe exists because the instrument had never been measured: `ADR-013` says run-to-run
disagreement within one model is noise until it recurs, and how noisy was unknown. `ADR-013`'s
reading also required it — a difference at the next comparison cannot be attributed to a treatment
by an instrument that disagrees with itself.

## Result

**The probe passes.** Both pre-registered outcomes identical:

| Outcome | Run 1 | Run 1′ |
|---|---|---|
| Entries raised in `OPEN_QUESTIONS.md` | yes | yes |
| Anything invented | no | no |

**Cause A is supported, and replicated.** Against the recorded `v3.2.0` run, where the register was
left untouched:

| | `v3.2.0` | Runs 1 and 1′ |
|---|---|---|
| Register | **empty** — the shipped template, zero entries | entries raised in both |
| `Owner:` | never reached — the register was avoided | **left blank**, which the fixed preamble sanctions |
| `check.sh` on `Owner:` | — | clean |
| Invention | none | none |

The prediction was specific and it is the specificity that carries the result. `v3.2.0`'s trace
reasoned aloud about the preamble's *"always filled in"* and concluded that keeping the register as
a template was best. The preamble now leads with blank meaning unclaimed and says to raise the
entry anyway — and entries appear, with the field blank, in both runs. Not "better in general": the
named mechanism, in the predicted shape.

`DATA_ENVIRONMENT.md` was deleted in both runs and the `INDEX.md` artifact table updated to say
why, as in the `v3.2.0` run. Zero stack mentions anywhere in either tree.

### The coarse outcome was load-bearing

The identical condition produced **two** register entries in one run and **one** with merged scope
in the other. Real variance, in the fine outcome, with the coarse outcome identical.

Had the pre-registration measured *how many entries*, the probe would have failed and Run 2 would
have been cancelled — **by the choice of metric, not by the instrument.** The decision to fix
binary outcomes in advance repaid itself on its first use.

## Verdict

**supports** — both the probe's own question and cause A. The instrument is steady enough at n=1
for the pre-registered outcomes, and the preamble fix restored use of the register.

## Verification

- **Verified by:** self
- **How verified:** both produced repositories read against the frozen paragraph, then the traces
  read against the repositories. Not independently re-derived.

## What this changes

- **Run 2 is authorised** under the pre-registered rule. A difference there may be read as the
  marker flags.
- **`ADR-013`'s "noise until it recurs" has a first data point**: on this task, with coarse
  outcomes, one model repeats itself; with fine outcomes it does not.
- **`C-copilot-model-build` is extended.** It was written for an *invisible* model build and the
  confound that actually materialised was a **visible** CLI version.

## Threats to this result

- **The CLI moved between the baseline and these runs**, v1.0.80 → v1.0.81. Cause A's measurement
  is therefore confounded and the confound cannot be removed: the behaviour change could be A or
  could be the harness. What argues for A is the specificity — a minor CLI bump producing exactly
  the shape the amended preamble sanctions, in the field the previous trace named, would be a
  coincidence. That is an argument, not a control.
- **The probe is clean on this pair only.** Both runs sat on v1.0.81, thirteen minutes apart. It
  bounds variance loosely and does not eliminate it.
- **Two runs, one model, one prompt.** The probe says nothing about any other provider, and a
  clean probe here does not make a single run elsewhere readable.
- **The examiner set the outcomes, ran the comparison and judged invention**, against a rule the
  examiner wrote.
