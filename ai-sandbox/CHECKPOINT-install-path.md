# rnd-project-memory — Checkpoint · install-path

- **Held by:** esdevop@gmail.com · since 2026-08-26
- **Status:** active
- **Resume from:** the pre-registered design is closed. Three runs, both questions answered: the
  instrument repeats itself on coarse outcomes, cause A holds, and the third gate costs nothing
  (`EXP-2026-08-28-marker-flags`). Six findings remain and none needs an experiment.
  **Do not do until re-verified:** do not claim the template makes an assistant stop where it
  lacks information. Two assisted arms disagree, the one that outranks the other is the one that
  failed, and the one clean run is written up as *worked once*. Do not remove the marker flags
  before Run 1 — that is the baseline they are the treatment against. Do not read `12:11` as the cost of the manual path either — it is the cost of
  *installing*, by someone who had seen the project before, with seven blanks unanswered at the
  endpoint. And do not treat `3.49 AIC` as a saving against it: the cheap run is the one that
  invented.

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

### Gap 1 — six green-start findings, none needing an experiment (priority: high)

The pre-registered design is **closed**: three runs, both questions answered, nothing further to
run under it. What remains was found by the green starts and is ordinary work.

1. **`OPEN_QUESTIONS.md`'s example entry carries no marker**, so an untouched register cannot be
   told from a filled one. Run 2 left it standing beside three real entries and nothing said so.
2. **`install.sh`'s second argument** and the guide's example, which make the destination path and
   the project name read as one string. The manual arm supplied the folder name.
3. **No arm has produced a project `README.md`** — three assisted runs and one manual, four of
   four — and nothing explains its absence.
4. **Install guidance lives in three places**, one of which the install deletes.
5. **The `<<FILL:` marker can be half-removed**, and the anchored check does not see the remnant.
6. **Provider, interface and prompt phrasing are confounded** across the arms, and no single run
   separates them. *"Create a project"* invites completion; *"adopt this template"* might not, and
   that is cheap and untested.

Each is statable without naming a model, so `ADR-013`'s first gate is satisfied for all six; gate 2
sends most of them to a check or to prose rather than to `RULES.md`.

### Gap 2 — what the mechanical layer cannot see (priority: high)

`check.sh` was clean on the `v3.1.1` run that invented broadly and on all four that did not. The
boundary is recorded under `ADR-013` and none of the six findings closes it. On day one there is no
reviewer either — the project has no history and nobody has read anything yet.

### Gap 3 — the recurring cost, still unmeasured (priority: medium)

`Q-who-keeps-the-history` has the install measured both ways — 12:11 by hand, 3.49–4.88 AIC
assisted. The half that repeats every session, and where the availability dependency actually
lives, has never been timed by hand: a session record written, a checkpoint rewritten, the
registers swept.

## Promotion candidates

None. Everything settled this session is either in the artefact itself or in the session record;
nothing here has stopped moving.

---

## Out of scope for this session

- The new-project experiment. It must run in a session with no access to this one, or it measures
  nothing — the same reason §11 step 5 cannot be run from inside the bootstrap session.
- Answering `Q-who-keeps-the-history` by reasoning. What it asks for is a timing, and reasoning
  harder about it is how it would get closed without one.
