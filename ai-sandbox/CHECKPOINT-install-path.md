# rnd-project-memory — Checkpoint · install-path

- **Held by:** esdevop@gmail.com · since 2026-08-26
- **Status:** active
- **Resume from:** both green-start arms have run against `v3.1.1` and are recorded. Five findings
  are named and none is acted on. The install path is now evidenced from outside this repository
  for the first time.
  **Do not do until re-verified:** do not cite the assisted arm as independent evidence. It ran on
  a model of the same family as the documentation's author, which `CONFIGURATIONS.md` rates *weak*
  — nearer self-review than a test. And do not read `12:11` as the cost of the manual path: it is
  the cost of *installing*, by someone who had seen the project before, with seven blanks still
  unanswered at the endpoint.

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

### Gap 1 — five findings from the green start, none acted on (priority: high)

Deliberately left, so that what the experiments found and what was done about it stay separable.
Ordered by what they cost, not by effort:

1. **`Owner:` has two rules and no third exit** — *always filled in* and *not a git address* — and
   nothing says *ask*. The assisted arm took the forbidden value. Needs the third exit written into
   the register preamble and `RULES.md`, plus a check: `Owner:` containing `@`.
2. **The `<<FILL:` marker can be half-removed.** Two of seven were answered leaving their closing
   bracket, in the two files loaded into every session, and `check.sh` said `ok`. Both were
   multi-line. A closing token on its own line makes a remnant visible and exactly checkable —
   `>>` occurs nowhere else in the skeleton.
3. **`install.sh`'s second argument is unclear**, and the guide's example
   `./install.sh ../my-project my-project` makes the destination path and the project name read as
   one string. The manual arm supplied the folder name and got `# churn-signals` where the
   assisted arm got `# Churn Signals`. Nothing checks it.
4. **Neither arm produced a project `README.md`**, nothing explains its absence, and only the
   person noticed — after searching three documents.
5. **Install guidance lives in three places**, one of which the install deletes. The same
   duplication the installer extraction addressed, one level up.

### Gap 2 — the assisted arm was same-family (priority: medium)

`CONFIGURATIONS.md` rates a model of the same family as the documentation's author *weak*
evidence, and the documentation was written by an assistant. A second assisted arm on a different
provider costs nothing extra and moves the result a rung up the ladder. Until then the assisted
result is nearer self-review than an independent test, and should be cited that way.

### Gap 3 — the pre-registered measurement, still waiting (priority: low)

Does a change to the install's **mechanism alone** — no instruction changed, no behaviour added —
touch one file after extraction where it touched two before? It needs such a change to arrive on
its own rather than be invented. Finding 3 above may be it: renaming an argument changes the
mechanism *and* the guide, so probably not. Finding 2 might be, if the marker's form changes
without the instruction changing.

## Promotion candidates

None. Everything settled this session is either in the artefact itself or in the session record;
nothing here has stopped moving.

---

## Out of scope for this session

- The new-project experiment. It must run in a session with no access to this one, or it measures
  nothing — the same reason §11 step 5 cannot be run from inside the bootstrap session.
- Answering `Q-who-keeps-the-history` by reasoning. What it asks for is a timing, and reasoning
  harder about it is how it would get closed without one.
