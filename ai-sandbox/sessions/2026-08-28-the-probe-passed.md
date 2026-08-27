# 2026-08-28 · The probe passed, and cause A held

- **Status:** closed
- **Configuration:** Solo
- **Participants:** author — claude-opus-5 · high effort; esdevop (human) — ran both arms
- **Signed off:** no
- **Tags:** `#template` `#adoption`

---

## Objective

Read Run 1 and Run 1′ against the outcomes fixed before either was performed, and record what the
probe says about the instrument.

## Reasoning

**Both pre-registered outcomes came out identical**, so the stopping rule does not fire and Run 2
is authorised. That is the probe's own result and it was worth one run: `ADR-013` has said "noise
until it recurs" since the day it was signed, without anyone knowing how noisy.

**Cause A held, and the shape of the confirmation is what matters.** The `v3.2.0` trace had
reasoned aloud about the preamble's *"always filled in"*, concluded that keeping the register as a
shipped template was best, and put the project's gaps into `docs/` prose instead. The preamble now
leads with blank meaning unclaimed and says to raise the entry anyway — and in both runs entries
appear with `Owner:` blank. Not "better in general": the named mechanism, in the predicted field,
twice.

### The choice of coarse outcomes decided the experiment

The identical condition produced two register entries in one run and one with merged scope in the
other. Real variance in the fine outcome, none in the coarse one.

Had the pre-registration measured *how many entries*, **the probe would have failed and Run 2 would
have been cancelled — by the metric, not by the instrument.** The decision to fix binary outcomes
in advance repaid itself on its first use, and it would have been impossible to make honestly
after seeing this.

### The confound that materialised was the one nobody was watching

`C-copilot-model-build` was written the day before, about an **invisible** model build. What
actually moved was the **visible** CLI version, v1.0.80 → v1.0.81, between the recorded baseline
and these runs. Cause A's measurement is confounded and cannot be un-confounded.

The argument for A is specificity, and it is an argument rather than a control: a minor harness
bump producing exactly the behaviour the amended preamble sanctions, in the field the previous
trace had named, would be a coincidence of an unusual size. Recorded as supported-with-a-confound,
not as clean.

The general form is worth keeping: **an unobservable confound gets a caveat written about it; an
observable one gets forgotten.** The caveat is widened to say record the harness version with every
run, not only the model name.

## Decisions

- **`EXP-2026-08-28-probe-and-cause-a` recorded, verdict `supports`** for both questions, with the
  CLI confound in Threats.
- **Run 2 authorised**, under the rule as written, with no amendment.
- **`C-copilot-model-build` corrected in place**, not rewritten — the register's own rule: a trap
  does not stop being true when it is addressed.

## Found along the way

- **A pre-registration is worth most when it constrains you against your own interest.** The fine
  outcome disagreed. Under any metric chosen after the fact, that disagreement would have been
  either evidence of something or a reason to look again; under the metric fixed in advance it was
  simply out of scope, and the design proceeded.
- `CAVEATS.yaml`, empty since 17 August, has now been both written to and corrected — the register
  has run its full cycle for the first time.

## Next

- Remove the marker flags under `ADR-013`'s third gate, release, and run Run 2.
