# <PROJECT_NAME> — Session Configurations

- **Updated:** <DATE>

> A short, named catalog of how a session can be staffed, cited by name from
> `sessions/_TEMPLATE.md`'s **Configuration:** field. Not `content` — this is a portable way of
> working, not a project fact. Not `mechanism` either — a project may add its own rows in
> `playbooks/local/`; this file just names the defaults and states what basis each one may
> claim.
>
> **Why configuration, not model.** A model name answers "how capable was the check", not "was
> it independent" — and independence is what determines what a result is allowed to claim.
> Recording the configuration, plus who filled each role when a check step exists, answers the
> question a model name cannot.
>
> **Independence ladder**, weakest to strongest: an agent checking its own work is not
> independent; a different model of the same family is weak — related models share training
> data, post-training, and architecture, and so share blind spots; a different provider is
> meaningfully better; a check of a **different kind** — a deterministic test, a re-derivation
> from raw data, a human — is strongest, and often cheapest, because it runs at zero model cost.
>
> **Review by a model of the same family is not independent verification.** It does not satisfy
> a sign-off requirement, and a result checked only this way may not be cited as verified.

| Configuration | Roles | What a result may claim |
|---|---|---|
| Solo | one agent, no check | `sessions/…` — reasoning, re-examinable |
| Author + AI reviewer | author; reviewer (different provider), no human sign-off | still `sessions/…` — two rounds of reasoning are not a fact |
| Author + reviewer + sign-off | author; reviewer; a named human signs off | `ADR-<nnn>` |
| Oracle + executor with recount | executor produces; oracle independently recomputes | task manifest; `EXP-…` if it is a measurement |

Project-specific configurations (e.g. a particular pairing this project actually uses) get added
as new rows here, or as their own procedure in `playbooks/local/` if the check itself needs
steps spelled out.
