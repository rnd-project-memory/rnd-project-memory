# IMP-<YYYY-MM-DD>-<slug> · Plan r1

- **Status:** draft
- **Released:** <YYYY-MM-DD> by <who>
- **Design:** `DESIGN.md`
- **Supersedes:** —
- **Changed steps:** —
- **Runtime:** <pointer to `DATA_ENVIRONMENT.md` or `playbooks/local/<recipe>.md` — cited, never copied here>

> **Steps and gates. No status.** Written by the capable model from the approved design. When
> `Status:` becomes `released`, the file is fixed: steps, gates and expected values never change.
> What happened lives in `runs/`, what was accepted in `reviews/`, and `check.sh` derives status
> from them. A wrong gate or a missing step is a revision, `PLAN.r<n>.md`: a full copy with
> `Supersedes:`, the reason, and `Changed steps:`. Unchanged steps keep their IDs. A changed step
> gets a new one, and an ID is never reused. Work the plan did not foresee is a new package that
> names the step it unblocks.
>
> **A card is the executor's context budget.** An executor reads this header, its own card, what
> the card lists under `Read:`, and the runtime pointer. Nothing else. Write the card so that is
> enough. Steps are listed in an order they can run in, and `Depends on:` names only earlier steps.
> Steps with no dependency between them can run in parallel.
>
> **A gate is a command or an artefact assertion, plus an expected value.** The expected value is
> what a weaker executor cannot invent. `Handoff: judgement` marks a step whose result needs a
> capable model or a person: no gate can fully decide it, and it counts as done only once reviewed.
> Executors follow `playbooks/execute-step.md`.

---

## Steps

### S-01 · <title>

- **Depends on:** —
- **Handoff:** mechanical
- **Read:** <DESIGN §…, files>
- **Produces:** <files or artefacts>
- **Do:** <what to do, concretely>
- **Do not:** <the tempting things outside this step>
- **Stop if:** <conditions under which the executor stops and reports `blocked`, rather than improvises>
- **Gate G-01-1:** `<command>` → <expected value>

### S-02 · <title>

- **Depends on:** S-01
- **Handoff:** judgement
- **Read:** <DESIGN §…>
- **Produces:** <…>
- **Do:** <…>
- **Do not:** <…>
- **Stop if:** <…>
- **Gate G-02-1:** `<command>` → <expected value>
