# Playbook — Run and record an experiment

## 1. State the question first

One sentence, written before the run: what would this result change? An experiment without
a stated question cannot fail, and therefore teaches nothing.

State the expected outcome too. A result only surprises if there was a prior.

## 2. Fix reproducibility before running

Record what it would take to re-run this exactly. `DATA_ENVIRONMENT.md` lists the fields this
project's stack requires; every project records at least the git SHA, the environment's locked
state, and the data source **with its snapshot date**.

A source that can change underneath you is not identified by its name alone — that is what the
snapshot date is for. Where a field genuinely does not apply, write that it does not apply
rather than leaving it blank: a later reader cannot otherwise distinguish "not applicable"
from "nobody filled this in".

Commit the analysis code before running it. A result tied to uncommitted code is not
reproducible.

## 3. Run

Keep the entry point a committed file that can be re-run — not an ad-hoc interactive session
such as a notebook cell, a REPL, or a query editor. Those are for exploration; anything
producing a recorded result needs a file. `DATA_ENVIRONMENT.md` names where those files live
and how they are run.

## 4. Write the record

`ai-sandbox/experiments/EXP-<YYYY-MM-DD>-<slug>.md`, using `experiments/_TEMPLATE.md`.
Immutable once written.

Fill in **Threats to this result** honestly — leakage, sample size, confounds. This section
is what stops a result from being over-claimed six months later by someone who has forgotten
its caveats, including you.

## 5. Give a verdict

**supports · contradicts · inconclusive.** "Inconclusive" is a legitimate and common outcome;
recording it prevents the experiment being re-run identically later.

**A negative result is a complete result.** Record it with the same care as a positive one
and keep it on file. Negative findings are the ones most reliably lost, and re-running a
known-failed approach is a standard way to lose a week.

## 6. Route it

- Adds a row to `experiments/LOG.md`.
- Changes what the method does → `promote.md` into `docs/method.md` or `docs/techniques/`.
- Settles an assumption → update `ASSUMPTIONS.md` (confirmed ones move to `docs/` and are deleted).
- Raises questions → `OPEN_QUESTIONS.md`.
