# rnd-project-memory — Checkpoint · install-path

- **Held by:** esdevop@gmail.com · since 2026-08-26
- **Status:** active
- **Resume from:** `v3.1.0` and `v3.1.1` are released and the root runs on `v3.1.1`. All four
  original install defects are closed, the documents have been audited against what the release
  does, and nothing is pushed. The next move is the new-project experiment, which this thread
  cannot perform.
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

### Gap 1 — nothing is published (priority: high)

Two tags and twelve commits are local. `v3.1.0` was re-cut once before publication, which the
`v1.2.0` precedent licenses, and `v3.1.1` followed as the alignment pass. Once pushed, neither can
be re-cut, so the question is only whether anything else should ride with them. The rehearsal that closed
that question — running `install.sh` from a clone — found the shallow-clone defect, which is fixed
and needs no release, `install.sh` being `norcopy`.

*Template repository* has been unticked and the button is gone, verified visually. The warning was
re-aimed rather than deleted, because **the switch is a repository setting that no check here can
read and that turning back on restores silently** — the first surface this project depends on that
nothing in it can watch. Published. The adopter's first move was then rehearsed from an environment with no credentials:
`git clone https://…` over HTTPS succeeds anonymously — the SSH `origin` in the author's own clone
is a property of that clone, not of the repository — and `install.sh` from the fresh clone records
`v3.1.1` correctly. The rehearsal found one defect and it was on the landing page: the clone
command read `git clone <this repository>`, an angle-bracket placeholder, in the project whose
last release was about angle brackets being misread. Fixed with the literal URL; it would have
stopped the experiment on its first command.

### Gap 2 — the experiment this thread exists to enable (priority: high)

A new project started from the template, by a session with no access to this one. It cannot be run
from here: whoever ran today's work has read the whole skeleton, knows the three bracket classes,
and wrote the installer, so a success measures memory rather than documentation — the same reason
§11 step 5 cannot be run from inside the bootstrap session.

Fixed in advance, or it measures nothing: the project paragraph written before either arm starts,
so both get the same input; two arms, assisted and unassisted, the second timed, which is the
number `Q-who-keeps-the-history` has been waiting for; and the primary measure is **invented
content**, not time — confident statements about the project in the finished repository that
nobody made.

### Gap 3 — all four install defects are closed and none is verified (priority: medium)

The placeholder class, the guide that asked to be deleted while being followed, the absent path
for a project with no history, and the *Use this template* button. Every one closed by the person
who found them, in the repository that cannot install anything.

`bootstrap-test.sh` is self-hosting one level up: it installs into a scratch directory, which is
why it passed all day while the blank check was reporting nine false positives here. Gap 2 is the
only instrument that reaches this.

### Gap 4 — the pre-registered next measurement (priority: low)

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
