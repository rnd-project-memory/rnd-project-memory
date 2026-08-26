# 2026-08-26 · Testing the prose-and-script claim instead of asserting it

- **Status:** closed
- **Configuration:** Solo
- **Participants:** author — claude-opus-5 · high effort
- **Signed off:** no
- **Tags:** `#template` `#adoption`

> Third session record of the day, and the third time the boundary was awkward — see
> **Found along the way**.

---

## Objective

A design position had been stated with the caveat that none of it was tested. Test the parts that
can be tested against evidence already in the repository, and say plainly which parts cannot.

## Reasoning

Three restatements had been named as at risk of silent divergence. Two were checkable today from
the repository's own history and working tree; one was a counterfactual and is not checkable at
all. Splitting them that way was most of the work, because the untestable one had been carrying
rhetorical weight it had not earned.

The decisive design choice was **not to inject a divergence**. A synthetic one proves only that a
synthetic one is undetected. If the claim is true, an unforced instance should already exist —
so the test became a search for one, which is a stronger form of the same question and cannot be
gamed by how the divergence is constructed.

It found one immediately, and the finding is worse than "undetected": after a by-the-book scripted
install, `ai-sandbox/CHECKPOINT-thread.md` is still named that, because the script never performs
README step 4 — and the adopter's own `check.sh` prints
`ok    ai-sandbox/CHECKPOINT-thread.md: 68`, reporting an unfilled template as a healthy live
checkpoint. Two checks each behave correctly in isolation: the line-limit check counts lines, and
the `Held by:` check skips placeholder values deliberately, so that a clean adoption does not open
with a mismatch. Their intersection is a file that is invisible to both.

The negative result matters more than the positive one. `check.sh`'s `RETIRED` array is in sync
with every retired-terminology list in `MIGRATIONS.md`, and it is the restatement with the longest
history and an explicit manual sync step. **The two failures cited when this claim was made were
misattributed**: both were the check matching literal strings while the retired *idea* had been
paraphrased — a coverage limit of the check's design, nothing to do with two copies diverging.
That claim is withdrawn.

Which leaves an honest position much narrower than the one it replaces: one instance, on a
component two days old, two of whose three commits the examiner wrote — against a clean negative
on the oldest instance of the same pattern.

## Decisions

- **`EXP-2026-08-26-prose-script-restatement` recorded**, verdict *supports, with one claim
  withdrawn*, marked `not verified`. Nothing from it moves to `docs/` — the rule forbids it, and
  the result is not strong enough to want to.
- **The `RETIRED` claim is withdrawn**, in the record rather than quietly dropped.
- **`install.sh` stays a proposal.** It now has a concrete defect to remedy rather than a
  prediction to prevent, but that extraction collapses the duplication is itself untested, and
  asserting it here would repeat the error this session exists to correct.

## Found along the way

- **A defect worth fixing on its own**, independent of any argument about prose and scripts:
  `bootstrap-test.sh` does not exercise README step 4, and `check.sh` reports the evidence of that
  omission as `ok`. The second half is the more interesting one — it is not a missing check but
  two correct checks whose exemptions overlap.
- **The session boundary has now been awkward three times in one day.** Closed early and written
  into; opened for four lines of shell; opened again for one experiment. The previous record left
  this at "one day's evidence, not acted on". Three instances in one day is a rate, and it is
  raised as `Q-session-boundary` rather than carried a third time.

## Next

- Fix step 4 in `bootstrap-test.sh`, and decide whether `check.sh` should recognise an unrenamed
  `CHECKPOINT-thread.md` at all — it is scaffold, so upstream cannot rely on the name surviving.
- `install.sh`, and the experiment that would show whether extraction collapses the duplication:
  make the same change twice, before and after, and count the texts that had to be edited.
- The bump, still undecided, now over two mechanism changes.
