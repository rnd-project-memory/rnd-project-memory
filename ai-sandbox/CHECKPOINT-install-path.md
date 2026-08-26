# rnd-project-memory — Checkpoint · install-path

- **Held by:** esdevop@gmail.com · since 2026-08-26
- **Status:** active
- **Resume from:** `install.sh` exists and is what the guide points at; Gap 4 is closed and gated;
  the extraction's one measurement came out against the reasoning that motivated it. Four commits
  are in, nothing is released, one install defect of the original four remains.
  **Do not do until re-verified:** do not claim the new-project path works. It has been tested by
  `bootstrap-test.sh`, which is this repository installing its own skeleton — the same blind spot
  `ADR-008` exists for, one level up. No person has followed the rewritten step 3 from a clean
  start, and the one attempt that produced this thread was made against the *old* text.

> This file belongs to one thread, named for what is being worked on. Only whoever it names as
> `Held by:` writes it. Rewritten, never appended; only what is unsettled.

---

## Current state

| Item | Value | Source |
|------|-------|--------|
| Placeholder classes | three, named in `skeleton/README.md` step 3 | this session |
| Install-time blanks | 7 markers, 3 files, `<<FILL: …>>` | `grep -rn '<<FILL' skeleton/` |
| `check.sh` | counts unanswered markers; not yet at the root, which runs `v3.0.1` | `skeleton/check.sh` |
| `bootstrap-test.sh` | passes, 8 gates, 3 of them new | run 2026-08-26 |
| Session filenames | no counter; a suffix breaks a collision only | `checkpoint.md`, §4 |
| Enforcement of that rule | `check.sh`, pending files only | `sessions/2026-08-26-session-counter-check.md` |
| The install | `install.sh`, called by the gate, pointed at by the guide | `3c0da3d` |
| Extraction's measured cost | 3 files vs 2 — `contradicts` | `EXP-2026-08-26-install-extraction-cost` |
| Release | none cut; bump undecided | — |

---

## In progress

### Gap 1 — the bump is undecided (priority: high)

Three mechanism files have changed (`check.sh`, and the playbook `checkpoint.md`, plus the
installer and gate which are `norcopy` and reach nobody) and two behavioural rules with them: the
session filename carries no counter, and `<<FILL: …>>` marks an install-time blank. `ADR-004`
requires a release touching the rules to name each changed one in its notes, and `v2.3.0`'s
precedent settled a near-identical case as MINOR on the consumer's obligation. The remaining doubt
is only whether the two new advisory sections, both of which print `ok` on an already-filled
project, add anything. `ADR-011` bounds the discriminator to inert-or-expiring and has not been
applied.

### Gap 2 — one install defect left of the original four (priority: medium)

GitHub's *Use this template* copies the whole repository, this project's own live memory included.
`ADR-003` says distribution is a vendored copy, so the button is the wrong mechanism and nothing
says so. The other three are closed: the placeholder class, the guide that asked to be deleted
while being followed, and the absent path for a project with no history — `./install.sh <dest>
<name>` is that path and it `git init`s a destination that is not yet a repository.

Untested by anyone but this repository. `bootstrap-test.sh` installing the skeleton is still
self-hosting one level up.

### Gap 3 — the pre-registered next measurement (priority: medium)

`EXP-2026-08-26-install-extraction-cost` came out `contradicts` and retired its own metric.
The question it leaves, registered before it can be chosen to fit an answer: **does a change to
the install's mechanism alone — no instruction changed, no behaviour added — touch one file after
extraction where it touched two before?** Gap 4 could not answer it, having added a behaviour.

Not urgent. It needs a mechanism-only change to arrive on its own rather than be invented, which
is the same discipline that made Gap 4 a usable subject.

## Promotion candidates

None. Everything settled this session is either in the artefact itself or in the session record;
nothing here has stopped moving.

---

## Out of scope for this session

- The new-project experiment. It must run in a session with no access to this one, or it measures
  nothing — the same reason §11 step 5 cannot be run from inside the bootstrap session.
- Answering `Q-who-keeps-the-history` by reasoning. What it asks for is a timing, and reasoning
  harder about it is how it would get closed without one.
