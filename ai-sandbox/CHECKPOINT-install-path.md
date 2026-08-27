# rnd-project-memory — Checkpoint · install-path

- **Held by:** esdevop@gmail.com · since 2026-08-26
- **Status:** active
- **Resume from:** three green-start arms have run against `v3.1.1` — two assisted, one manual —
  and all are recorded. Eight findings are named and none is acted on.
  **Do not do until re-verified:** do not claim the template makes an assistant stop where it
  lacks information. Two assisted arms disagree, and **the one that outranks the other is the one
  that failed**. Do not read `12:11` as the cost of the manual path either — it is the cost of
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

### Gap 1 — the two causes are fixed and unverified; six findings remain (priority: high)

Findings 1 and 2 shipped in `v3.2.0`. **Whether they change the behaviour they were written for is
unknown from here**, and the measurement belongs to whoever runs it: the same prompt, the same
provider, `v3.2.0`, with these two changes and nothing else. Six remain, untouched on purpose so
that re-run has one treatment rather than a bundle:

3. **`OPEN_QUESTIONS.md`'s example entry carries no marker.** An untouched register is
   indistinguishable from a filled one to every check — predicted correctly by the independent arm
   before it walked past it.
4. **`Owner:` has two rules and no third exit** — *always filled in* and *not a git address* — and
   nothing says *ask*. The same-family arm took the forbidden value. Needs the third exit written
   down, plus a check on `@`.
5. **The `<<FILL:` marker can be half-removed.** Two of seven left their closing bracket, in the
   two files loaded into every session, and `check.sh` said `ok`. Both were multi-line. A closing
   token on its own line makes a remnant visible and exactly checkable.
6. **`install.sh`'s second argument is unclear**, and the guide's example makes the destination
   path and the project name read as one string. The manual arm supplied the folder name.
7. **No arm produced a project `README.md`** — three for three — nothing explains its absence, and
   only the person noticed.
8. **Install guidance lives in three places**, one of which the install deletes.

### Gap 2 — what the mechanical layer cannot see (priority: high)

`check.sh` is clean on a repository of honest absences and on a repository of confident fiction.
That boundary is now measured rather than assumed, and no check proposed above closes it: finding 3
catches an *untouched* register, and nothing catches a *confidently wrong* one.

This is a limit to state in the handbook rather than a defect to fix. The design's answer has
always been that a person reviews `docs/` before it lands; what the experiments show is that on
day one there is no such review, because the project has no history and nobody has read anything
yet.

### Gap 3 — three variables, two runs (priority: medium)

Provider, interface and prompt phrasing are confounded. The prompt says *"create a project"*,
which invites completion; *"adopt this template"* might not, and that is untested and cheap to
test. Copilot CLI approves each command separately and Claude Code does not. Nothing here
separates the three.

### Gap 4 — the pre-registered measurement, still waiting (priority: low)

Does a change to the install's mechanism alone touch one file after extraction where it touched
two before? Findings 1 and 2 change instructions, so neither is the subject. Finding 5 might be.

## Promotion candidates

None. Everything settled this session is either in the artefact itself or in the session record;
nothing here has stopped moving.

---

## Out of scope for this session

- The new-project experiment. It must run in a session with no access to this one, or it measures
  nothing — the same reason §11 step 5 cannot be run from inside the bootstrap session.
- Answering `Q-who-keeps-the-history` by reasoning. What it asks for is a timing, and reasoning
  harder about it is how it would get closed without one.
