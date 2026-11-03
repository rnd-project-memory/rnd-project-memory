# rnd-project-memory — Checkpoint · adopter-review

- **Held by:** esdevop@gmail.com · since 2026-10-25
- **Status:** active
- **Resume from:** Gaps 4 and 5 are built on `next` and unreleased. Gap 3's design was revised by
  the author's observation, that R&D decisions mature by holding over time while their memory
  fades. The proposal is a working-decisions register in `ai-sandbox/` that matures into ADRs, and
  it awaits confirmation. Then build, and release.
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
| Shipped | Gaps 1, 2, 7 as `v3.6.0`; 5 (check) and 6 as `v3.7.0`, with `ADR-014`; root raised | `sessions/2026-10-25-v3-6-0-index-focus.md`, `sessions/2026-10-25-parallel-sessions-fix.md` |

---

## In progress

### Gap 3 — no home for working decisions (priority: high; design revised, awaiting confirmation)

Proposed: `ai-sandbox/DECISIONS.md`, `D-<slug>`. Written at the moment of decision, with what was
decided, why now, the alternatives rejected, who decided, and what would reopen it. It matures by
age unchanged, and `check.sh` lists long-held entries as ADR candidates. On maturity it moves into
an ADR. If dropped, it is deleted with a `LOG.md` row. Reasoning:
`sessions/2026-11-03-staleness-exit-and-session-mode.md`.

### Gap 5 — built on `next`, unreleased

`Mode:` on session records, counted by `check.sh`, and `severity:` redefined by consequence, with
old values kept.

### Gap 4 — built on `next`, unreleased

Only the holder defers, with a revisit date. `check.sh` reports stalled threads and honours only a
human's dated deferral.

---

## Out of scope for this thread

- **Changing or advising the adopter's project.** This thread improves the template only.
- **Committing any part of the snapshot**, or a summary detailed enough to identify it.
