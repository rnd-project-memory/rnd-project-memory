# rnd-project-memory — Session Index

- **Updated:** 2026-08-27

Entry point for every session. Loaded automatically through `AGENTS.md`.

**This repository holds both the artefact and its own memory.** Everything below governs the
memory at the root. Files under `skeleton/` are the shipped template and are edited as an
artefact, never as working notes — see `AGENTS.md`.

---

## Routing rule

| What | Where |
|------|-------|
| Settled conclusion | `docs/` |
| In-flight reasoning | `CHECKPOINT-<thread>.md` (one per thread, see below) |
| What happened in a session | `sessions/<date>-<slug>.md` |
| What an experiment produced | `experiments/EXP-<YYYY-MM-DD>-<slug>.md` |
| Where a fact came from | `SOURCES.md` |

`ai-sandbox/` is **not a second copy** of `docs/`. Matured conclusions move out.

---

## Artifacts

| File | Contents | Write mode |
|------|----------|-----------|
| `CHECKPOINT-<thread>.md` | Current unresolved state, one per thread | rewrite, ≤150 lines, holder only |
| `OPEN_QUESTIONS.md` | Active questions (resolved are deleted) | edit |
| `ASSUMPTIONS.md` | What the design bets on | edit |
| `SOURCES.md` | Source register with IDs — empty; this project reasons rather than cites | append |
| `CAVEATS.yaml` | Data/tool traps — empty; no data environment here | append, corrected in place |
| `PUBLICATIONS.md` | What was published externally — empty; nothing published externally | edit |
| `CONFIGURATIONS.md` | Named session configurations | edit |
| `RULES.md` | The behavioural rules — upstream's, replaced on upgrade | do not edit |
| `RATIONALE.md` | Why each rule exists; failure modes | read on demand |
| `sessions/LOG.md` | One row per session | append only |
| `experiments/LOG.md` | One row per experiment | append only |

`DATA_ENVIRONMENT.md` is deliberately absent: this project has no data environment, and the
template's own rule says content that instructs falsely is worse than content that is missing.

---

## Threads

| Thread | Held by (`user.email`) | Status | Since |
|--------|---------|--------|-------|
| `install-path` | esdevop@gmail.com | active | 2026-08-26 |

The first thread open since `v2.0.0` shipped on 2026-08-23. Six releases were cut without one,
because everything each session produced either shipped or had a home. This one does not: an
unreleased change sits in the tree, three install defects are named but untouched, and the bump
is undecided.

---

## Current focus

**The pre-registered design is closed.** Three runs, both questions answered. The instrument
repeats itself on coarse outcomes; cause A holds; and removing the seven marker restatements
changed neither outcome, so `ADR-013`'s third gate has no measured price on its first application
(`EXP-2026-08-28-marker-flags`, *supports*).

**The arc, one fix at a time:**

| Version | Invention | Register |
|---|---|---|
| `v3.1.1` | broad | 0 entries |
| `v3.2.0` | none | 0 — register avoided, because of the `Owner:` rule |
| `v3.3.0` Runs 1 / 1′ | none | 2 / 1 |
| `v3.4.0` Run 2 | none | 3 |

Invention stopped when the rule moved into a file every session loads and the shipped stack stopped
being asserted. Register use returned when a contradiction in the register's own preamble was
removed. Removing the restatements changed neither.

Four things worth carrying:

- **A pre-registration proves itself by what it forbids.** Twice in three days it made an
  attractive reading unavailable: the file-count metric, and a 1-2-3 trend across three noisy
  cells. Both would have been written up confidently. The refusal is on the record in the
  experiment, not left as an absence.
- **The instrument is bounded in both directions.** Identical conditions gave different fine
  outcomes; different conditions gave identical coarse ones. That pair is what makes the coarse
  outcomes defensible rather than merely convenient.
- **An unobservable confound gets a caveat; an observable one gets forgotten.**
  `C-copilot-model-build` was written about an invisible model build, and the CLI moved visibly
  underneath the cause-A comparison.
- **`check.sh` was clean on the run that invented broadly and on all four that did not.** The
  boundary of the mechanical layer is where `ADR-013` recorded it, and nothing since has moved it.

Six findings remain and none needs an experiment. `Q-who-keeps-the-history` 🟡 — install measured
both ways, the **recurring** cost still not; `Q-session-boundary` 🟡 open;
`Q-unexercised-components` 🟡 — `CAVEATS.yaml` has run its full cycle; `Q-oss-intake` and
`Q-contribution-flow` 🟢 need answers from outside this repository.

## What a new session does

1. Read this file — including the thread table — then the `CHECKPOINT-<thread>.md` file(s)
   relevant to today's focus, then `OPEN_QUESTIONS.md`.
2. Do not read `docs/` wholesale — open a document when it is actually needed.
3. Ask for the session focus if it was not given.
4. Close with `playbooks/checkpoint.md`.
