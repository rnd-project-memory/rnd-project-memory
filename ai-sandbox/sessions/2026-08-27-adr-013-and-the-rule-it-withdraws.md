# 2026-08-27 · ADR-013, and the rule it immediately withdraws

- **Status:** closed
- **Configuration:** Author + reviewer + sign-off
- **Participants:** author — claude-opus-5 · high effort; reviewer and signatory — esdevop
- **Signed off:** esdevop — ADR-013, the decision and its text
- **Tags:** `#template` `#versioning` `#adoption`

---

## Objective

Settle when a behaviour becomes a rule, since the working answer had been *whenever a run
misbehaves*, and act on what the criterion says about the release that prompted it.

## Reasoning

**What made this contested is that the wrong response is the natural one.** A run behaves badly; a
firmer instruction is the obvious remedy; it costs nothing to write, and the run that prompted it
can never falsify it. Applied each time, `RULES.md` grows to chase a distribution that will not
hold still — two or three models testable, never all, and one model taking a different path on the
same prompt twice.

The criterion earns its place by catching **our own** error rather than a hypothetical one. Two of
`v3.2.0`'s five edits fail it, and the one that fails the second gate is exactly the one that
caused a regression. A criterion that only flags other people's mistakes is worth nothing.

### The withdrawal, and what it actually taught

The rule said: a field that must not be blank and has no correct value available is a stop, ask.
It was written for `Owner:`, after an assistant caught between *must be filled* and *must not be
the git address* took the address.

The next assistant read it, weighed it — *"asking could block progress"* — and **avoided raising
register entries at all** rather than raise one with a field it could not complete. The project's
open questions became prose in `docs/problem.md`, where nothing sweeps them. One wrong value in one
field, traded for an unused register.

Two things follow, and the second is the general one.

**The defect was structural.** `OPEN_QUESTIONS.md`'s preamble said `Owner:` is *always filled in*
and that blank means *nobody has claimed this*. Both cannot hold: if it is always filled, blank
never occurs and carries no signal. The assistant read the first sentence as absolute and had no
answer. The rule had been instructing people around a contradiction rather than removing it.

**And a rule was the wrong instrument regardless.** A git address in that field is trivially
detectable. Under `ADR-013` that makes it a check — which works on every reader and every run,
where the rule worked on neither and cost something besides.

`RATIONALE.md` keeps the withdrawn rule as a record of what it cost rather than deleting it. A
rule that lived one release and did damage is worth more as a record than as a gap.

### What was deliberately not done

The `v3.2.0` marker flags fail the third gate — one rule restated at seven points of use. They are
untouched, and the reason is `ADR-013`'s own evidence discipline: **the only configuration ever
measured includes them.** Removing them on principle would change the treatment and then declare
the result unchanged without a run.

The examiner also wrote the flags, which is a reason to be slower rather than faster about
removing them on a reading of the wording.

## Decisions

- **`ADR-013` accepted and signed off**, five claims into `docs/method.md` with `CLAIMS.md` rows.
- **`v3.3.0`, MINOR.** A rule relaxed, a check added, a scaffold preamble fixed. Nothing to do
  downstream.
- **The next two runs are pre-registered** in `CHECKPOINT-install-path.md` before either is run —
  outcomes fixed in advance, because after a result there is always a more convenient metric. That
  is the mistake the file-count experiment already made.

## Found along the way

- **A signed ADR immediately obliged undoing shipped work**, and naming that in its Consequences
  was what made it a decision rather than a preference. The cost of adopting a criterion after the
  fact is that it applies to what you already shipped.
- **Release step 2b earned itself again.** *Name the artefact that enforces the rule, and check
  that the artefact knows* — here the rule was **removed**, and the artefact that had to know was
  `RATIONALE.md`, which would otherwise have gone on explaining a rule that no longer exists.

## Next

- Run 1 and Run 2, per the pre-registration.
