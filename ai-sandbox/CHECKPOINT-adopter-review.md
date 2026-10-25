# rnd-project-memory — Checkpoint · adopter-review

- **Held by:** esdevop@gmail.com · since 2026-10-25
- **Status:** active
- **Resume from:** Gaps 1, 2 and 7 shipped in `v3.6.0`, and the root runs it. Gap 5's check is
  built in `skeleton/` and unreleased. Every remaining item is a design decision for the author:
  Gaps 3, 4 and 6, and Gap 5's schema half. Triage is in
  `sessions/2026-10-25-adopter-review-triage.md`.
  **Do not do until re-verified:** do not state any of these as general to adopters. They come from
  one project, one author, one snapshot, and two of them (Gaps 3 and 4) may be specific to a
  prototype-phase project. Do not quote, paraphrase or name anything identifying the adopter: its
  domain, people, addresses, infrastructure or code (`docs/constraints.md`). Do not read the
  snapshot's register state as a deletion history. Its git history is snapshots, so deletions are
  invisible. Do not add a rule to `RULES.md` for any gap here: none passes `ADR-013` gate 2.

> This file belongs to one thread, named for what is being worked on. Only whoever it names as
> `Held by:` writes it. Rewritten, never appended; only what is unsettled.

---

## Current state

| Item | Value | Source |
|------|-------|--------|
| Evidence | one adopter on `v3.5.0`, about 8 weeks, 66 sessions | `[S-adopter-snapshot-2026-10-25]` |
| Findings | what worked, what failed, mechanisms | `sessions/2026-10-25-adopter-example-review.md` |
| Triage | instrument chosen for each gap | `sessions/2026-10-25-adopter-review-triage.md` |
| Shipped | Gaps 1, 2 and 7, as `v3.6.0`; root raised | `sessions/2026-10-25-v3-6-0-index-focus.md`, `sessions/2026-10-25-parallel-sessions-fix.md` |

---

## In progress

### Gap 3 — no home for working decisions (priority: high, design)

Nothing moved to `docs/` after adoption, and decisions settled into `ASSUMPTIONS.md` and INDEX.
This is not detectable and is no rule's business. The question is whether a slot is missing (a
provisional decision, a light ADR, engineering facts allowed in `docs/`), or whether this is the
correct state of a project with no settled method yet. One snapshot cannot separate the two.

### Gap 4 — staleness without an exit (priority: medium, design)

`STALENESS_LOG.md` exists to validate its own 3-week threshold. The adopter gives the first outside
evidence: the notice fired every session and was deferred every time, by the assistant. That points
at the response, not at the number. The decision is the author's.

### Gap 5 — single-valued fields (priority: medium)

The check is built and unreleased: §12's distribution now counts session `Configuration:`
values, with no mark on values outside the dictionary, since those sit in immutable records
(`sessions/2026-10-25-configuration-distribution.md`). Left for design: whether the schema gains a
*session mode* axis, and whether `severity:` is redefined.

### Gap 6 — planned threads and model handoff (priority: medium, design; issue #2)

Plan files with command-plus-expected-value gates, and a procedure for handing implementation to a
cheaper model. The adopter built both unprompted, and issue #2 proposes the same shape: a design,
then `PLAN-<thread-slug>.md` with validation gates. Two sources, but one author, so not
independent. In the adopter, plan status drifted across three files. Bears on
`Q-who-keeps-the-history`. Not started.

---

## Out of scope for this thread

- **Changing or advising the adopter's project.** This thread improves the template only.
- **Committing any part of the snapshot**, or a summary detailed enough to identify it.
