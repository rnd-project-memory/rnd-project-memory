# rnd-project-memory — Checkpoint · install-path

- **Held by:** esdevop@gmail.com · since 2026-08-26
- **Status:** active
- **Resume from:** the green-start programme is finished. Three releases have shipped since:
  `v3.5.0` on 2026-09-26, in sessions that deliberately left this file alone because it is held
  here, then `v3.6.0` on 2026-10-25 and `v3.7.0` on 2026-10-26, both from the `adopter-review`
  thread. The root runs `v3.7.0`. None of them touched findings 1–6 below, which stand as written
  on 2026-08-28, and none needs an experiment. Finding 7, added on 2026-10-26, was closed the same
  day. `v3.5.0` opened one gap of its own: the six commits it arrived in carry a work identity as
  author (Gap 4). Push state is not recorded here — it has gone
  stale three times — so read it from `git status`.
  **Do not do until re-verified:** do not claim the template makes an assistant stop where it
  lacks information. Two assisted arms on different providers disagreed, the one that outranks the
  other is the one that failed, and every clean run since is written up as *worked once*. Do not
  read `12:11` as the cost of the manual path — it is the cost of *installing*, by someone who had
  seen the project before, with seven blanks unanswered at the endpoint. Do not treat `3.49 AIC`
  as a saving against it: the cheap run is the one that invented. Do not revive the 1-2-3
  register-entry trend; it is refused on the record in `EXP-2026-08-28-marker-flags`. Do not
  restore or re-publish anything from the pre-2026-11-03 backup bundle: it carries the work
  identities (Gap 4).

> This file belongs to one thread, named for what is being worked on. Only whoever it names as
> `Held by:` writes it. Rewritten, never appended; only what is unsettled.

---

## Current state

| Item | Value | Source |
|------|-------|--------|
| Template | `v3.7.0`, root vendored at the same | `.template-version` |
| The install | `install.sh`; builds a candidate tree, stops with exit `2` on any differing path | `v3.5.0` |
| Install-time blanks | 7 markers, 3 files, `<<FILL:` at line start | `grep -rn '^<<FILL' skeleton/` |
| Rule against invention | `RULES.md`, loaded every session; no restatement anywhere | `v3.2.0`, `v3.4.0` |
| `DATA_ENVIRONMENT.md` | ships an example, asserts no stack | `v3.2.0` |
| `Owner:` | ask for a human before filling; blank stays valid when none is given | `v3.5.0`, `ADR-013` |
| Data ignores | none shipped; each project adds its own, the hook still blocks data files | `v3.5.0` |
| `bootstrap-test.sh` | passes, 29 checks; runs `install.sh` rather than reproducing it | run 2026-10-25 |
| Green-start evidence | summarised in `results/`, raw deliberately outside | `results/README.md` |

---

## In progress

### Gap 1 — one finding left, and it is an experiment (priority: medium)

Findings 1–5 and 7 are closed on `next`, unreleased (`sessions/2026-11-03-install-findings-1-to-6.md`).
Finding 6 remains: provider, interface and prompt phrasing are confounded across the green-start
arms. *Adopt this template* against *create a project*, on one provider, is cheap and untested.
The thread is ready to close, with this finding as one open question. See *Promotion candidates*.

### Gap 2 — what the mechanical layer cannot see (priority: high)

`check.sh` was clean on the arm that invented broadly and on all five that did not. It sees that a
blank was answered, never whether the answer is true. Recorded under `ADR-013` as a boundary
rather than a defect; none of the open findings closes it, and on day one there is no human
reviewer either, the project having no history and nobody having read anything yet.

### Gap 3 — the recurring cost, still unmeasured (priority: medium)

`Q-who-keeps-the-history` has the *install* measured both ways — 12:11 by hand, 3.49–4.88 AIC
assisted. The half that repeats every session has never been timed by hand: a session record
written, a checkpoint rewritten, the registers swept. That is where the availability dependency
actually lives, and it is why the question is still open with its install half answered.

### Gap 4 — closed 2026-11-03, with residue outside the repository

The history was rewritten and force-pushed, the identity guard shipped in `v3.8.0` and is on
here, and `ADR-015` is accepted. The verified state is in
`sessions/2026-11-03-no-work-identity-in-public-history.md`. What remains is the author's, at the
host: a cache-purge request to GitHub Support, and any old-commit links in issues.
---

## Promotion candidates

The *Do not do* prohibitions above are knowledge with no other home. Proposed for
`docs/method.md`, *Known limitations*, before this file is deleted. The proposal awaits the
author.
---

## Out of scope for this thread

- **Answering `Q-who-keeps-the-history` by reasoning.** It asks for a timing of the recurring half.
  Reasoning harder is how it gets closed without one.
- **`Q-oss-intake` and `Q-contribution-flow`.** Neither is answerable from inside this repository.
- **Mechanising the employer-identifier check.** A pattern for one domain protects one project; a
  general one for addresses fires on every register entry naming a person. Considered and left.
