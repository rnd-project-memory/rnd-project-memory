# <PROJECT_NAME> — Assumption Register

**Updated:** <DATE>

> What the method **bets on, and where it could be wrong**. Not "what I understood about the
> project" — that belongs in `docs/`. The test: *if this turned out false, what breaks?*
>
> Two resting types: `ASSUMED` (plausible, unverified) · `INFERRED` (derived logically).
>
> **There is no `CONFIRMED` entry in this file.** Confirmation is a transition, not a state:
> the moment an assumption is verified it becomes a fact, moves to `docs/`, and is deleted
> from here. `checkpoint.md` performs that move. Anything sitting here is by definition still
> unverified — which is what keeps the register bounded and worth reading.
>
> **IDs are slugs, not numbers** — `A-keeper-latency`, not `A4`. Same reason as
> `OPEN_QUESTIONS.md`: deletion pits a numbered sequence and old cross-references silently
> point at the wrong entry.

> **`Owner:` is always filled in, even working alone.** Blank must mean *nobody has
> claimed this* — the signal the field exists to carry. If solo-era entries are left
> blank, that meaning is destroyed the day a second person joins.

---

## A-<slug> · <statement> — `ASSUMED`

**Raised:** <DATE> · **Owner:** <owner>
**Basis:** <what it rests on — source ID, reasoning, or convention>
**If false:** <what breaks, and how badly>
**What would settle it:** <the check that would confirm or kill it>
