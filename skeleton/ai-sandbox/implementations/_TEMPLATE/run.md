# IMP-<YYYY-MM-DD>-<slug> · S-<nn> · attempt <YYYY-MM-DD>T<HHMM>Z

- **Status:** running
- **Plan:** `PLAN.md`
- **Executor:** <role — model · effort>
- **Commit:** <sha the gates ran against>
- **Evidence:** <paths to files the gates produced, or —>

> One attempt at one step, in `runs/S-<nn>__<YYYYMMDD>T<HHMM>Z.md`. Created when the step is claimed,
> with `Status: running`. Closed as `passed`, `failed` or `blocked`, and immutable from then on.
> Another attempt is another file, so a failed attempt keeps what it observed. Another executor's
> `running` file is not yours to change.
>
> Every gate in the card gets a line. `passed` means every gate is `pass`. Observed values are
> copied from the output, not paraphrased. On `fail` or `not run`, say what blocked it and what
> was tried: the next attempt starts from that, not from a repeat.

---

## Gates

- **Gate G-<nn>-1:** pass | fail | not run — observed: <excerpt of the actual output>
  - Blocked by: <for fail or not run>
  - Tried: <for fail or not run>

## Notes

<Anything the next executor or the reviewer needs: dependencies re-run first, surprises, a Stop if
that fired.>
