# 2026-08-19 · Enterprise access confirmed

**Status:** closed

---

## Objective

Record a fact that arrived from outside the repository: the public repository can be cloned from
inside the work network.

## Reasoning

`Q-enterprise-access` asked three things. The confirmation settles the one that mattered and makes
a second one moot.

**Can the enterprise environment reach public GitHub?** Yes. Verified by cloning, which is the
exact operation adoption requires — not a proxy for it.

**Can it fork across the boundary?** Moot. ADR-005 rules out forking on its own grounds: a fork
wires a bidirectional relationship where only one direction is wanted. The question existed only
as a fallback in case cloning were blocked, and it is not.

**Is there an intake process for external open-source material?** Still open, now on its own as
`Q-oss-intake`, and demoted to 🟢 — it blocks nothing for the author and only decides whether a
colleague needs a review before adopting.

What this removes is the manual carry-in path. ADR-005 hedged that a colleague might have to
obtain the template by hand; they can clone it themselves. Nothing in the design changes — it was
built to route around the answer — but the awkward branch of it is gone.

It also removes the strongest argument for building an enterprise copy. ADR-005 gates that on
three conditions and the first was "EMU actually blocks access". That condition is now false.

## Decisions

None. A fact arrived; the register moved.

## Found along the way

Nothing. This is the first session all week that did not turn up a defect, which is worth one line
because the previous five each did.

## Next

Propose the ADR-005 update — the context table row and the consequence about manual carry-in. It
is a factual correction, not a reversal of the decision, and `docs/` changes are reviewed before
they land.
