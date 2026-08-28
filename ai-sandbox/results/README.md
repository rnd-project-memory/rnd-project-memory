Evidence cited from experiment records: `<what-was-done>__<YYYYMMDD>T<HHMMSS>Z.json`, created
once, never edited afterwards. Not raw data — counts, hashes, shares, anything that lets a
result be checked without re-running against data that may not still be there.

---

## Why the green-start evidence is a summary and not the artefacts

`EXP-2026-08-26-green-start-assisted`, `-manual`, `EXP-2026-08-27-green-start-independent`,
`EXP-2026-08-28-probe-and-cause-a` and `EXP-2026-08-28-marker-flags` each cite a working directory
under `exp--project-memory-green-start/` that is **not in this repository**. `RULES.md` requires
that a cited file be here or that the record say why not; those records are immutable, so the
reason is stated once here instead, beside the evidence that stands in — the same device
`CONFIGURATIONS.md` uses for `ADR-007`'s basis.

**Two reasons, in order of weight.**

The raw logs carry employer-identifying strings: a work email domain in one log and in one working
tree's `.git/config`, and a work account name in four logs. `docs/constraints.md` binds this
public repository against that, *including in history*, on `ADR-005`. The `.githooks/pre-commit`
scan would not have stopped it — its patterns match credential **values**, not identifiers, and
that is deliberate, since a check that fires on documentation about passwords gets answered with
`--no-verify`. So the guard that exists is the wrong shape for this, and the constraint was met by
judgement rather than by machine.

And the seven installed trees are around 400 KB each of near-unmodified skeleton, reconstructible
from their `.template-version` and `install.sh`. What actually differs in each is five files, and
those differences are quoted in the records already.

`green-start-arms__*.json` is what §8 anticipates for exactly this case — a summary *"reproducible
without the raw, possibly gitignored, data behind it"*. It carries each arm's version, model,
interface, cost, both pre-registered outcomes, and the **sha256 of every raw file**, so that a
reader who has the raw evidence can confirm it is what these records cite, and a reader who does
not still has the outcomes.
