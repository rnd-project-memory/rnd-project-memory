# rnd-project-memory — Session Configurations

- **Updated:** 2026-08-25

> Named session configurations, cited by name from `sessions/_TEMPLATE.md`'s **Configuration:**
> field. A model name answers "how capable was the check"; a configuration name plus its
> participants answers "was it independent" — which is what determines what a result may claim.
>
> **Independence ladder**, weakest to strongest: an agent checking its own work is not
> independent; a different model of the same family is weak; a different provider is
> meaningfully better; a check of a **different kind** (a deterministic test, a re-derivation
> from raw data, a human) is strongest, and often cheapest.
>
> **Review by a model of the same family is not independent verification** and does not satisfy
> a sign-off requirement.

| Configuration | Roles | What a result may claim |
|---|---|---|
| Solo | one agent, no check | `sessions/…` — reasoning, re-examinable |
| Author + AI reviewer | author; reviewer (different provider), no human sign-off | still `sessions/…` |
| Author + reviewer + sign-off | author; reviewer; a named human signs off | `ADR-<nnn>` |
| Oracle + executor with recount | executor produces; oracle independently recomputes | task manifest; `EXP-…` if measured |

`Author + reviewer + sign-off` was exercised here for the first time on 2026-08-25: an AI author,
a human reviewer who is also the signatory, decision by decision. Everything before that date ran
solo. No project-specific rows yet.

## What the existing decision records rest on

The `ADR-` number is licensed by the table above, and until 2026-08-25 the ADR template had no
field in which to record the configuration that licensed it. That gap is closed for new records
(`docs/decisions/_TEMPLATE.md`); it cannot be closed for old ones, because records here are not
backfilled. What follows is the basis of each, stated once, beside the rule that governs it.

> **Adoption note.** The rules say an `ADR-<nnn>` requires a named human sign-off, recorded in the
> record's own `Signed off:` field. `ADR-001`–`ADR-006` carry no such field and no such sign-off:
> they were written on 2026-08-17, before this table existed and before session records had a
> `Configuration:` field at all, so their basis is `sessions/2026-08-17-*` and cannot be
> reconstructed further. **This does not close.** Backfilling would mean editing immutable records
> and inventing a review that never happened; the records stand as they are and this note is the
> only correction available.

`ADR-007` is **not** covered by that note, and is listed separately on purpose. It was written on
2026-08-23, in the same session that introduced this table — so conforming was possible, and the
test in `ADR-010` is whether the record could have conformed when it was written. It could.
Its own session record says `Configuration: Solo` and `Signed off: no`, which licenses
`sessions/…` and not an `ADR-` number.

> `ADR-007` · basis `sessions/2026-08-23-skeleton-v2-thread-checkpoints.md` · does not meet the
> sign-off requirement introduced in the same release.

It is not rewritten and not renumbered — the decision it records is in force and the work rests on
it. What is corrected is the claim its status implies. This is the system's first recorded case of
a rule failing to apply to the change that introduced it, and it is cheap to find only because the
session record carried the two fields the ADR did not.
