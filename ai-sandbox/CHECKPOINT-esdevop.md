# rnd-project-memory — Checkpoint · esdevop

**Updated:** 2026-08-17 · **Limit: 150 lines**

> **This file belongs to one person.** Other `CHECKPOINT-*.md` files are read-only to you.
>
> Only what is **in progress and not yet settled** in `docs/`.
> This file is **rewritten**, not appended. Delete what is no longer true — do not strike it out.
> An entry unchanged for 3+ weeks is a conclusion, not a process: promote it.
> Write each entry so someone who missed the session could act on it — in three months,
> that someone is you.

---

## Where the work stands

The design is recorded as ADR-001…006, and this repository now runs the system it defines. Steps
1–6 of the extraction sequence are done: the repository exists, is public under MIT, the skeleton
is tagged `v1.0.0`, and this memory layer is vendored from it and seeded.

What remains is one large reconciliation and two artefacts.

## Current state

| Item | Value | Source |
|------|-------|--------|
| Skeleton files | 32, all audited | `sessions/…-ownership-audit-2.md` |
| Files needing a true profile | 1 (`DATA_ENVIRONMENT.md`) | `EXP-…-misdirection-recheck` |
| Files needing nothing structural | 9 register files, `scaffold` | same |
| Root memory vendored from | `v1.0.0`, skeleton @ `1c3dde0` | `.template-version` |
| Experiments run | 3, all recorded | `experiments/LOG.md` |
| Handbook sections reconciled | the `AGENTS`/`RULES` set and §9; the rest outstanding | Gap 1 |

---

## Landed during the bootstrap, worth not rediscovering

Running the checks against real content found **two more false positives of the family fixed
earlier**, bringing the total to five. Both had the same root cause — a check reading
instructional text as content.

- `check.sh` reported `sessions/_TEMPLATE.md` as an interrupted session, because the template
  ships with `Status: open` by design. Now excluded.
- `.githooks/pre-commit` **blocked this bootstrap commit**, matching its own vendored pattern list
  and the experiment record that quotes it. `aws_secret_access_key` and `AccountKey=` matched the
  *name* of a credential rather than a value, so any documentation about secret scanning tripped
  them. Both now require an adjacent value; all six real credential forms still match, verified
  by hand.

The second one matters beyond tidiness: it is the blocking check, and
`EXP-2026-08-17-pattern-list-extraction` predicted precisely this failure mode — a noisy blocking
check is answered with `--no-verify`, after which it is dead while still appearing installed. The
prediction arrived from the other direction than expected, and using `--no-verify` here would have
proved it.

Handbook §12 describes both scripts and has not been updated for either fix.

---

## In progress

### Gap 1 — the handbook still describes an earlier design (priority: high)

`RND_PROJECT_MEMORY.md` is 682 lines. The parts touched by the rules split and by the embedded
`.gitignore` are fixed. What remains:

| | Sections | Size |
|---|---|---|
| Intact, no change needed | §1–3, §12–14 | — |
| Edits in place | §4, §6, §7, §8, §10, §11, Origin | ~30 lines across 7 sections |
| Missing entirely | ADR-002/003/004/005 have no representation | new §15, ~70–90 lines |

Specifics worth not rediscovering: §7 still says "the five procedures" and will be six once
`upgrade-template.md` exists; §8's mandatory-fields table still names `uv.lock` and
`Cluster / runtime` and lacks the `n/a`-over-blank rule; §10 describes `DATA_ENVIRONMENT.md` as
the project's own notes rather than the substituted profile layer; §11 has no `.template-version`
and no MANIFEST-driven copy.

`skeleton/README.md` says the handbook wins where the two disagree, so every unreconciled section
is a live instruction to do the wrong thing. This is the largest remaining piece and the easiest
to defer.

### Gap 2 — step 7 artefacts (priority: medium)

`MANIFEST` has landed. `MIGRATIONS.md` and `playbooks/upgrade-template.md` have not.
`upgrade-template.md` has one required step recorded in ADR-004 that is easy to omit: diff the
incoming `RULES.md` and report every changed rule, because a rule delivered by file replacement
arrives silently.

### Gap 3 — sample IDs in the skeleton's `docs/` (priority: low)

`skeleton/docs/method.md` line 19 carries `[EXP-2026-05-04-ablation-c, …]` inside a
`<placeholder>`. `check.sh` no longer reports it, but a project that fills in `method.md` without
deleting the sample line inherits citations to experiments that never existed.

---

## Promotion candidates

None. Everything settled so far is already in `docs/decisions/`.

---

## Out of scope for this session

Building the enterprise copy before a colleague needs it. Designing the company profile beyond
ADR-005's note that it is a `DATA_ENVIRONMENT.md` variant plus a secret-scan pattern extension.
Answering `Q-enterprise-access` or `Q-contribution-flow` from first principles — both need
information from outside this repository.
