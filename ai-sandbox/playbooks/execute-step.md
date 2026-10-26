# Playbook — Execute one step of a released plan

For an executor, often a cheaper model than the one that wrote the plan, and for a reviewer
accepting what an executor produced. Packages are opened and plans released by
`plan-implementation.md`.

**Read only:** the latest plan revision's header, your step's card, what the card lists under
`Read:`, and the runtime pointer. Not the whole design, not other cards, not other packages. The
card was written to be enough. Where it is not, that is a `blocked` report, not a reason to read
further and decide.

## 0. Start from the plan's base

Bring your clone or worktree to the plan header's `Base:` before reading anything else. A
worktree created from the default branch may not contain the package, or this playbook, at all.

## 1. Pick a step

`./check.sh` lists each open package's steps with a derived state. Take a step marked `ready`: no
attempt yet, and every dependency satisfied. A `mechanical` dependency is satisfied when it has
`passed`, a `judgement` one only when it is `accepted`. Use the highest `PLAN.r<n>.md`, or `PLAN.md`
if there is no revision.

## 2. Claim it

Create `runs/S-<nn>__<YYYYMMDD>T<HHMM>Z.md` from `implementations/_TEMPLATE/run.md`, in UTC, with
`Status: running` and `Session:` naming the session record this attempt runs under. That record
names the step as `IMP-<YYYY-MM-DD>-<slug>/S-<nn>`, so a search finds the attempt from either side.
**If you run inside another session**, as a subagent dispatched by a coordinator, that session's
record is the coordinator's to write. Name it in `Session:`, do not edit it, and report the step
back for the coordinator to record.

**Three commits, in order:** the claim; then the work; then the closed report. The claim file is
the report, so it is closed in place, and it is immutable from that commit on. Commit it, or push it, if other executors work in other clones.

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
- Commit the work **before** running the gates, and put that commit in `Commit:`, so a reviewer
  can re-run them at exactly what you ran them on. Fill `Evidence:` with the files the gates
  produced, or `—` when the observed values under *Gates* are the whole evidence.
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

The re-run is the review. A report says what the executor saw, and a re-run says what is true of
the commit it names. Only the second can be accepted.

1. **Check out exactly the report's `Commit:`, clean and separate**, for example
   `git worktree add --detach <tmp> <sha>`. Never re-run in the executor's working tree. A gate
   that passed on uncommitted work, under a `Commit:` that lacks it, passes again there and proves
   nothing. In a clean checkout it fails, and that failure is the finding.
2. **Re-run every gate before reading the reported values.** Then compare. Where a value
   legitimately differs between runs, such as a sha made fresh by the gate itself or a timestamp,
   compare its shape, and say so in the review.
3. **Read the commit's diff against the card.** Does it stay inside `Produces:` and clear of
   `Do not:`? A gate tests the result, not what else was touched.
4. **Ask whether each gate could have failed.** A gate that passes at any commit, such as one
   checking working-tree cleanliness, proves nothing. Re-run it in the form it should have had, and
   record the defect as the card's, not the executor's.
5. **Check `Evidence:`**: it exists and says what the gate expects.
6. **Check the notes against the re-run.** No check reaches prose, and a report can be right in
   every gate line and wrong in a note.
7. For a judgement step, judge the result against the design sections its card cites.
8. Write `reviews/S-<nn>__<YYYYMMDD>T<HHMM>Z.md` from `implementations/_TEMPLATE/review.md`:
   `accepted`, or `rejected` with what a new attempt must change. Record where the re-run ran and
   what it observed. Remove the checkout afterwards.

### Reviewing the whole package

Every step `accepted` does not mean the design is delivered. A design section no gate covered is
not checked by any of them.

- Write `reviews/package__<YYYYMMDD>T<HHMM>Z.md`. Its `Run reviewed:` is `—`, and `Reviews:` lists
  the step reviews it rests on.
- Map every design section to what delivered it and how that was checked, as a table.
- **For each section no gate covers, check it directly now**, and record how.

A reviewer of the same model family as the executor is not independent (`CONFIGURATIONS.md`). The
re-run, a check of a different kind, is what makes a review worth more than the report. Its verdict
does not license promotion to `docs/` on its own. That still goes through `promote.md` at package
acceptance.
