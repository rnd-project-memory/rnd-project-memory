# 2026-11-03 · Decisions ripen at 60 days; adopter-review closed

- **Status:** closed
- **Configuration:** Solo
- **Mode:** admin
- **Participants:** author — claude-opus-5-5
- **Signed off:** no
- **Tags:** `#adoption` `#template`

---

## Objective

Two decisions by the author. Working decisions ripen for an ADR at 60 days, not the 28 the assistant
had guessed. And `adopter-review` closes, its scope prohibition moving into `docs/method.md`.

## Reasoning

**Ripeness at 60 days.**

- The author set it, replacing the assistant's guess of 28.
- Changed in `skeleton/check.sh` (section title, comment, comparison), in both `DECISIONS.md`
  preambles (the skeleton's and this repository's, which is scaffold and the project's own), and in
  the bootstrap fixture. That fixture now has a 70-day decision listed as ripe, and a 40-day one
  not.
- Recorded as `D-decisions-ripen-at-60-days`, by esdevop, with its reasons, the register's first
  use for a choice about itself.
- It is an improvement, not a fix for a paid cost, so it waits on `next` under
  `D-batch-template-releases`. The root's vendored `check.sh` keeps 28 until the next release, and
  nothing is ripe at either threshold today.

**`adopter-review` closed**, by the checkpoint rule:

- the scope prohibition moved to `docs/method.md` *Known limitations*, as the author approved:
  adopter evidence rests on one project, one author, one snapshot. It has a `CLAIMS.md` row;
- the confidentiality prohibition already lives in `docs/constraints.md`;
- the *no rules for these gaps* prohibition lapsed, since every gap has shipped, and none added to
  `RULES.md` except the `DECISIONS.md` routing rule, which passed `ADR-013`'s gates;
- nothing remained open, so no open question was needed;
- the checkpoint was deleted, and INDEX's thread table is empty.

The thread ran from 2026-10-25 to 2026-11-03 and shipped `v3.6.0` to `v3.9.0`. Its findings came
from one snapshot, and the new limitation says so.

## Decisions

- Working decisions ripen at 60 days.
- `adopter-review` closed.

## Next

No thread is open. The live question is `Q-positioning-against-prior-art`.
