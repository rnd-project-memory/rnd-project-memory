# Playbook — Run and record an experiment

## 1. State the question first

One sentence, written before the run: what would this result change? An experiment without
a stated question cannot fail, and therefore teaches nothing.

State the expected outcome too. A result only surprises if there was a prior.

## 2. Fix the reproducibility triple

Before running, record: git SHA, `uv.lock` state, and the data source **with its snapshot
date**. Upstream Databricks tables are mutable — a table name alone does not identify the
data. See `DATA_ENVIRONMENT.md`.

Commit the analysis code before running it. A result tied to uncommitted code is not
reproducible.

## 3. Run

Keep the entry point a script in `src/experiments/`, not an ad-hoc notebook cell.
Notebooks are for exploration; anything producing a recorded result needs a file that
can be re-run.

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
