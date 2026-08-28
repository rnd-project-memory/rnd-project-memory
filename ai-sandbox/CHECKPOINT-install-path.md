# rnd-project-memory — Checkpoint · install-path

- **Held by:** esdevop@gmail.com · since 2026-08-26
- **Status:** active
- **Resume from:** the green-start programme is finished. Six arms run, five releases cut
  (`v3.1.0`–`v3.4.0`), the root on `v3.4.0`, and `origin/main` is up to date — `467c6b3` and
  `b2f209f` were pushed outside a session, so the prior checkpoint read stale for whoever opened
  it next. Six findings remain and none needs an experiment.
  **Do not do until re-verified:** do not claim the template makes an assistant stop where it
  lacks information. Two assisted arms on different providers disagreed, the one that outranks the
  other is the one that failed, and every clean run since is written up as *worked once*. Do not
  read `12:11` as the cost of the manual path — it is the cost of *installing*, by someone who had
  seen the project before, with seven blanks unanswered at the endpoint. Do not treat `3.49 AIC`
  as a saving against it: the cheap run is the one that invented. Do not revive the 1-2-3
  register-entry trend; it is refused on the record in `EXP-2026-08-28-marker-flags`.

> This file belongs to one thread, named for what is being worked on. Only whoever it names as
> `Held by:` writes it. Rewritten, never appended; only what is unsettled.

---

## Current state

| Item | Value | Source |
|------|-------|--------|
| Template | `v3.4.0`, root vendored at the same | `.template-version` |
| The install | `install.sh`; the guide points, describes no step in prose | `v3.1.0` |
| Install-time blanks | 7 markers, 3 files, `<<FILL:` at line start | `grep -rn '^<<FILL' skeleton/` |
| Rule against invention | `RULES.md`, loaded every session; no restatement anywhere | `v3.2.0`, `v3.4.0` |
| `DATA_ENVIRONMENT.md` | ships an example, asserts no stack | `v3.2.0` |
| `Owner:` | blank is legitimate; a `@` in it is a check, not a rule | `v3.3.0`, `ADR-013` |
| `bootstrap-test.sh` | 9 gates, passes; runs `install.sh` rather than reproducing it | run 2026-08-28 |
| Green-start evidence | summarised in `results/`, raw deliberately outside | `results/README.md` |
| `origin/main` | up to date with local `HEAD`, nothing to push | `git status` 2026-08-28 |

---

## In progress

### Gap 1 — six findings, none needing an experiment (priority: high)

The pre-registered design is closed: three runs, both questions answered, nothing further under
it. What remains is ordinary work. Each is statable without naming a model, so `ADR-013`'s first
gate is satisfied for all six; the second sends most to a check or to prose rather than `RULES.md`.

1. **`OPEN_QUESTIONS.md`'s example entry carries no marker**, so an untouched register cannot be
   told from a filled one. Run 2 left it standing beside three real entries and nothing said so.
2. **`install.sh`'s second argument** and the guide's example make the destination path and the
   project name read as one string. The manual arm supplied the folder name and got a wrong title
   that nothing detected.
3. **No arm produced a project `README.md`** — four of four — and nothing explains its absence.
4. **Install guidance lives in three places**, one of which the install deletes.
5. **The `<<FILL:` marker can be half-removed**; the anchored check does not see the remnant. Two
   of seven were left that way in the first assisted arm, in the two session-loaded files.
6. **Provider, interface and prompt phrasing are confounded** across the arms. *"Create a project"*
   invites completion; *"adopt this template"* might not, and that is cheap and untested.

### Gap 2 — what the mechanical layer cannot see (priority: high)

`check.sh` was clean on the arm that invented broadly and on all five that did not. It sees that a
blank was answered, never whether the answer is true. Recorded under `ADR-013` as a boundary
rather than a defect; none of the six findings closes it, and on day one there is no human
reviewer either, the project having no history and nobody having read anything yet.

### Gap 3 — the recurring cost, still unmeasured (priority: medium)

`Q-who-keeps-the-history` has the *install* measured both ways — 12:11 by hand, 3.49–4.88 AIC
assisted. The half that repeats every session has never been timed by hand: a session record
written, a checkpoint rewritten, the registers swept. That is where the availability dependency
actually lives, and it is why the question is still open with its install half answered.

---

## Promotion candidates

None. `ADR-013` is the one thing that settled hard enough to move, and it moved on 2026-08-27 —
five claims into `docs/method.md` with `CLAIMS.md` rows.

---

## Out of scope for this thread

- **Answering `Q-who-keeps-the-history` by reasoning.** It asks for a timing of the recurring half.
  Reasoning harder is how it gets closed without one.
- **`Q-oss-intake` and `Q-contribution-flow`.** Neither is answerable from inside this repository.
- **Mechanising the employer-identifier check.** A pattern for one domain protects one project; a
  general one for addresses fires on every register entry naming a person. Considered and left.
