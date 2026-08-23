# rnd-project-memory — Session Configurations

**Updated:** 2026-08-23

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

This project has so far run solo throughout — no independent-review configuration has actually
been exercised here. No project-specific rows yet.
