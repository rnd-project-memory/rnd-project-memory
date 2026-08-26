# EXP-2026-08-26-prose-script-restatement

- **Date:** 2026-08-26 · **Status:** complete
- **Question:** Where a rule is stated in prose and re-implemented in a script, does anything in
  this repository detect the two disagreeing?

---

## Reproducibility

| Field | Value |
|-------|-------|
| Git SHA | `1898384` |
| Environment lock | n/a — no analysis stack; git, coreutils and bash only |
| Entry point | `./bootstrap-test.sh`, `./check.sh`, and `git log` over `skeleton/README.md` |
| Data source | this repository's own history and working tree |
| Snapshot date | 2026-08-26, at the SHA above |
| Filters / slice | commits touching `skeleton/README.md` since `bootstrap-test.sh` was added (`6d1a4a6`, 2026-08-25); `RETIRED` array against `MIGRATIONS.md`'s retired-terminology lists |
| Runtime / compute | n/a |
| Run duration | n/a — under a minute |
| Run ID (remote/async) | n/a — ran locally |

## Setup

Three restatements were named as at risk. Each was tested against evidence already in the
repository rather than argued from the design.

1. **`RETIRED` array in `check.sh` vs `MIGRATIONS.md`.** Compared the array's contents against
   every "Terminology retired" list, which the release procedure's step 3 says feeds it.
2. **`bootstrap-test.sh` vs `skeleton/README.md`.** Two measurements: how many commits touched
   the install steps without touching the script, and — the decisive one — whether any gate
   reports a step README states that the script does not perform.
3. **The counterfactual** ("a generator would have produced `-5` uniformly and made it
   invisible") was **not** tested. It cannot be: the script does not exist and the history it
   would have produced does not either.

Baseline for (2): the repository's own claim that `bootstrap-test.sh` "installs `skeleton/` into
a scratch repository **exactly as `skeleton/README.md` says**".

## Result

**1. `RETIRED` — no drift.** `v3.0.0` retired `owner token` and `<owner>`; both are in the
array, alongside `v2.0.0`'s three. Every retired string listed in prose is present in the script.
The two failures recorded this week (`docs/glossary.md` on 2026-08-26; the alignment audit the
same day) were **not** drift between the copies — both were the check matching literal strings
while the retired *idea* had been paraphrased. That is a coverage limit of the check's design, and
it was misattributed to duplication when this experiment was proposed.

**2. `bootstrap-test.sh` — divergence present, undetected.**

- Of three commits touching `skeleton/README.md` since the script existed, **two did not touch
  the script** (`242c2c9`, `2be75d1`). Neither, on inspection, needed to: `git config user.email`
  was in the script from its first commit, a day *before* README step 2 documented it. So the
  script led the prose rather than lagging it — divergence, in the unexpected direction.
- **README step 4 — rename `ai-sandbox/CHECKPOINT-thread.md` — is not performed by the script.**
  It is unconditional, mechanical, and stated for every adopter. After a by-the-book scripted
  install the file is still named `CHECKPOINT-thread.md`.
- **Nothing reports it.** `bootstrap-test.sh` passes all eight gates. The adopter's own
  `check.sh` goes further than silence: it prints
  `ok    ai-sandbox/CHECKPOINT-thread.md: 68` — reporting the unrenamed template as a healthy
  live checkpoint, because the line-limit check counts lines and the `Held by:` check skips
  placeholder values by design.
- Counting only unconditional mechanical steps, the script implements **4 of 5**. Step 3a is
  implemented **twice, in two different texts**: README gives a `grep | xargs sed` pipeline, the
  script a `while read` loop with a `case`. Editing step 3 on 2026-08-26 required editing both,
  by hand, in one sitting.

## Verdict

**supports, with one claim withdrawn** — a rule stated in prose and re-implemented in a script
diverges here, and no mechanism in the repository detects it. The specific worked example is
undetected today, in the working tree, without anything being staged to produce it.

What is **not** supported: that this has already caused a shipped defect. The step-4 gap costs
coverage, not correctness — a transformation that is never exercised, which is the exact class
`bootstrap-test.sh` was built for. And the `RETIRED` claim is withdrawn outright: those two
misses had a different cause.

## Verification

- **Verified by:** not verified
- **How verified:** not applicable

The measurements are mechanical and re-runnable from the entry points above, and the decisive one
is a single observable state of a scratch install. Nobody independent has re-derived them.

## What this changes

- Supplies the first evidence for `Q-who-keeps-the-history`'s third piece — that mechanics
  belong to a script — by showing what the *current* arrangement costs: two texts for one step,
  and one step with no text in the script at all.
- Names a concrete defect to fix independently of any of that: `bootstrap-test.sh` does not
  exercise README step 4, and `check.sh` reports the evidence of it as `ok`.
- Moves the `install.sh` proposal from prediction to remedy: extraction would make README point
  at the script and let `bootstrap-test.sh` run it, collapsing 4-of-5 and two-texts-for-one-step
  into one source. Whether it does is the next experiment, and it needs the extraction first.

## Threats to this result

- **One repository, one week.** `bootstrap-test.sh` has existed for two days and has seen three
  README changes. Three is not a rate.
- **The examiner wrote two of the three commits examined**, including the one that required
  editing both texts. The cost measured is partly the cost of the examiner's own change.
- **Step 4's omission may be deliberate and undocumented** rather than drift. Nothing in the
  script says so, which is itself the finding, but the two are not distinguishable from outside.
- **The negative result on `RETIRED` is the stronger half of this record.** A single positive on
  a component two days old, against a clean negative on the component with the longest history,
  is not a general law about prose and scripts. It is one instance.
