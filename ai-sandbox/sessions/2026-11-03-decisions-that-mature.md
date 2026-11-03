# 2026-11-03 · A home for decisions too young for an ADR

- **Status:** closed
- **Configuration:** Solo
- **Mode:** implement
- **Participants:** author — claude-opus-5-5
- **Signed off:** no
- **Tags:** `#adoption` `#template`

---

## Objective

`adopter-review` Gap 3, as the author confirmed: a working-decisions register in `ai-sandbox/`,
written when a decision is taken, maturing by age unchanged, moved into an ADR once it has held.
Then release `v3.9.0`.

## Reasoning

**The register.** `skeleton/ai-sandbox/DECISIONS.md` (scaffold), with entries `D-<slug>`.

- **Fields:** `Decided … by:` (a human), *Why now*, *Decision*, *Rejected*, *Reopen if*, *Basis*.
  The shape sits in a blockquote, like every register since this release.
- **Write modes:**
  - *add* at the moment of deciding;
  - *revise* in place, with `Decided:` reset, since maturity counts from the last change;
  - *move* into an ADR once it has held;
  - *drop* if abandoned, deleting it.

  Both deletions get a `LOG.md` row.
- **Wiring:**
  - `check.sh` lists entries held 28+ days as *ripe*. The number is a starting guess, and says so;
  - a `RULES.md` routing rule;
  - `checkpoint.md` step 4 and `promote.md` step 5;
  - INDEX's artefact table, handbook §2, §4 and §6, `MANIFEST`, and a `RATIONALE.md` paragraph;
  - two bootstrap gates: a 40-day decision ripe, a 3-day one not.

  `ADR-013` gate 2 holds for the rule: no check can see a decision that was never written down.

**`v3.9.0`**, MINOR, on `c810a64`. It ships the install findings, Gaps 3–5 and the register
examples. The tag names four rule changes: `RULES.md`'s routing rule, plus `session-start.md`,
`checkpoint.md` and `promote.md`.

**Root raised.** Seven mechanism files were replaced. By hand: `DECISIONS.md` created,
`STALENESS_LOG.md` taken from the release (it had no rows), `SOURCES.md` and `PUBLICATIONS.md`
examples moved into blockquotes, the `CAVEATS.yaml` severity definition updated, and INDEX's
artefact table extended.

**The register, used at once.** Three decisions the author took in these sessions were recorded,
each with its reasons, from the records where they were taken:

- `D-current-focus-bound-15-lines`;
- `D-batch-template-releases`;
- `D-all-work-on-next`.

The 28-day ripeness threshold is not among them. I chose it, and an assistant never decides, so it
waits for the author.

## Decisions

- `DECISIONS.md` built as confirmed, and `v3.9.0` released.

## Next

Close `adopter-review`, since all its gaps have shipped. The author decides the 28-day threshold.
