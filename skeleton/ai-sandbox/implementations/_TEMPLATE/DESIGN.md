# IMP-<YYYY-MM-DD>-<slug> · Design

- **Status:** draft
- **Approved by:** <human name> · <YYYY-MM-DD>
- **Thread:** `<thread-slug>`
- **Supersedes:** —

> **The contract the plan is written against.** Drafted with the capable model, in sessions whose
> records hold the reasoning. It is approved by a named human, always: a design approved by nobody
> but its author has checked nothing. Then `Status:` becomes `approved`, and the file is never
> edited again. A change after approval is `DESIGN.r<n>.md`, with `Supersedes:` and a reason.
>
> Number the sections. Plan steps cite them in `Read:`, so an executor loads the sections its
> step needs and not this whole file. Settled decisions here are promoted to `docs/` when the
> package is accepted, not before.

---

## 1. Goal

<What the change delivers, and for whom. One paragraph.>

## 2. Contract

<Interfaces, data shapes, behaviour at the edges. Subsections 2.1, 2.2, … are what `Read:` cites.>

## 3. Out of scope

<What this change deliberately does not do.>

## 4. Decisions and alternatives

<Each choice that was contested: what was chosen, what was rejected, why. A decision that outlives
this package becomes an ADR at acceptance.>

## 5. Open questions

<Anything unresolved at approval, with where it is tracked — `OPEN_QUESTIONS.md` or a step's
`Stop if:`. An open question is not a blank. It is stated.>

## Does not license

<What approval of this design does not establish: performance, correctness beyond the gates,
production readiness.>
