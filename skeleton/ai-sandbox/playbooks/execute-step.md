# Playbook — Execute one step of a released plan

For an executor, often a cheaper model than the one that wrote the plan, and for a reviewer
accepting what an executor produced. Packages are opened and plans released by
`plan-implementation.md`.

**Read only:** the latest plan revision's header, your step's card, what the card lists under
`Read:`, and the runtime pointer. Not the whole design, not other cards, not other packages. The
card was written to be enough. Where it is not, that is a `blocked` report, not a reason to read
further and decide.

## 1. Pick a step

`./check.sh` lists each open package's steps with a derived state. Take a step marked `ready`: no
attempt yet, and every dependency satisfied. A `mechanical` dependency is satisfied when it has
`passed`, a `judgement` one only when it is `accepted`. Use the highest `PLAN.r<n>.md`, or `PLAN.md`
if there is no revision.

## 2. Claim it

Create `runs/S-<nn>__<YYYYMMDD>T<HHMM>Z.md` from `implementations/_TEMPLATE/run.md`, in UTC, with
`Status: running` and `Session:` naming this session's record. In the session record, name the
step as `IMP-<YYYY-MM-DD>-<slug>/S-<nn>`, so a search finds the attempt from either side. Commit it, or push it, if other executors work in other clones.

**Another executor's `running` file is not yours to change.** It is either live in parallel or was
cut short, and only the person can say which, the same rule as session files (`RULES.md`). Pick
another step, or ask.

## 3. Re-run what you build on

Before starting, run the gates of each dependency's accepted or passed attempt. A report says what
happened then, and a re-run says what is true now. If one fails, do not build on it: close your
attempt as `blocked`, citing the dependency and the observed value.

## 4. Do the step

Within `Do:` and `Do not:`. When a `Stop if:` condition holds, stop. Close the attempt as `blocked`
and say which condition fired and what you saw. Never edit `DESIGN.md` or any `PLAN*.md`. A plan
that looks wrong is reported, not repaired, and `plan-implementation.md` step 5 revises it.

## 5. Run every gate and report it

Every gate in the card gets a line: `pass`, `fail` or `not run`, with the observed value copied
from the output.

- **`passed` only if every gate is `pass`.** One `fail` or `not run` makes the attempt `failed`, or
  `blocked` if something outside the step stopped it.
- **On `fail` or `not run`, record what blocked it and what was tried.** The next attempt starts
  from that, not from a repeat of yours.
- Fill `Commit:`, the commit the gates ran against, and `Evidence:`, the files the gates produced.
- Run `./check.sh` before committing. While the report is uncommitted, it catches a `passed` with a
  failing gate, a commit that does not exist, and an evidence path that does not.

The report is immutable once closed. Another attempt is another file.

A judgement step closes the same way. It counts as done only once a reviewer accepts it.

## 6. Record a change of executor

If the model running this session changes mid-step, because of a credit ceiling or a handover,
note it in the session record. The leaving and arriving models, and the step in progress, are a
change of configuration (`CONFIGURATIONS.md`). The arriving executor starts at step 3: re-run, then
continue.

---

## Reviewing an attempt

1. Re-run the reviewed attempt's gates against its `Commit:`, without reading its claims first.
2. Compare what you observe with what it reported. Check its `Evidence:` exists and says what the
   gate expects.
3. For a judgement step, judge the result against the design sections its card cites.
4. Write `reviews/S-<nn>__<YYYYMMDD>T<HHMM>Z.md` from `implementations/_TEMPLATE/review.md`:
   `accepted`, or `rejected` with what a new attempt must change.

A reviewer of the same model family as the executor is not independent (`CONFIGURATIONS.md`). The
re-run is what makes a review worth more than the report. Its verdict does not license promotion
to `docs/` on its own. That still goes through `promote.md` at package acceptance.
