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

The design is recorded as ADR-001…006, and this repository runs the system it defines. **The
extraction sequence is complete.** The repository is public under MIT, the skeleton is at
`v1.2.0`, the handbook describes what exists rather than what was intended, and this memory layer
is vendored from `v1.2.0` — reached through the upgrade playbook twice, not by hand.

Everything ADR-002 through ADR-004 promised now exists and has been exercised at least once:
`MANIFEST`, `MIGRATIONS.md`, `upgrade-template.md`, `.template-version`, `.template-hashes` and
the check that reads it.

What remains is one cosmetic item and one question that cannot be answered here.

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

## The first upgrade found a defect, and it was ours

`.template-version` claimed `v1.0.0` while the tree held `v1.0.0` plus two fixes: the tag was cut
mid-session and `check.sh` and `pre-commit` changed in the next commit. Nothing noticed for the
length of a session; `upgrade-template.md` step 3 caught it on its first run.

Resolved by the upgrade to `v1.1.0` — all fifteen mechanism entries now match the tag. The lesson
is one line: **tag when the artefact is finished, not when it looks finished.**

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

### Gap 1 — sample IDs in the skeleton's `docs/` (priority: low)

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
