# rnd-project-memory — Session Index

- **Updated:** 2026-10-25

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
| A change designed here and executed by others | `implementations/IMP-<YYYY-MM-DD>-<slug>/` |
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
| `CAVEATS.yaml` | Tool traps from the experiment harness; no data environment here | append, corrected in place |
| `PUBLICATIONS.md` | What was published externally — empty; nothing published externally | edit |
| `CONFIGURATIONS.md` | Named session configurations | edit |
| `RULES.md` | The behavioural rules — upstream's, replaced on upgrade | do not edit |
| `RATIONALE.md` | Why each rule exists; failure modes | read on demand |
| `sessions/LOG.md` | One row per session | append only |
| `experiments/LOG.md` | One row per experiment | append only |
| `implementations/IMP-…/` | Design and plan, fixed once approved and released; one report per attempt; reviews | design and plan fixed, revised by new file; runs and reviews immutable |
| `implementations/LOG.md` | One row per package event | append only |

`DATA_ENVIRONMENT.md` is deliberately absent: this project has no data environment, and the
template's own rule says content that instructs falsely is worse than content that is missing.

---

## Threads

| Thread | Held by (`user.email`) | Status | Since |
|--------|---------|--------|-------|
| `install-path` | esdevop@gmail.com | active | 2026-08-26 |
| `adopter-review` | esdevop@gmail.com | active | 2026-10-25 |

Both threads hold work that has nowhere else to live yet. `install-path` covers installing the
template, and `adopter-review` covers what real adopters' memories show.

---

## Current focus

> **2–4 lines, rewritten at every checkpoint, never appended.** Where the work stands now and what
> is blocking it. What happened belongs in `sessions/`, what is unresolved in a thread checkpoint.
> This file loads into every session; `check.sh` reports this section past 15 lines.

**Two threads are open.** `install-path` holds six open install findings, none of which needs an
experiment, and Gap 4: a work identity in published commit history, which is undecided.
`adopter-review` holds what one adopter's memory showed after eight weeks. `v3.6.0` shipped the
detectable part, and the session-start sweep no longer freezes live parallel sessions (issue #3).
`v3.7.0` shipped implementation packages (`ADR-014`, issue #2) and the configuration
distribution. Still design: working decisions, staleness, a session-mode axis.

The green-start programme is closed. Its arc and lessons are in
`sessions/2026-08-28-the-gate-costs-nothing.md`. `check.sh` still cannot tell honest absence from
confident fiction, a boundary `ADR-013` recorded.

**`Q-positioning-against-prior-art` 🔴** asks whether this adds anything over shipped memory and
spec-driven tools, to be settled by a pre-registered comparison. `Q-who-keeps-the-history` and
`Q-session-boundary` 🟡 now have adopter evidence.
`Q-unexercised-components` 🟡 is down to the hook. `Q-oss-intake` 🟡 and `Q-contribution-flow` 🟢
need answers from outside this repository.

---

## Latest completed session

2026-10-25: `v3.6.0` was cut and the root raised to it. `check.sh` now reports an over-long
*Current focus*, an unrenamed checkpoint template and bare log tags, all from
`[S-adopter-snapshot-2026-10-25]`. The same day `CHECKPOINT-install-path.md` was rewritten against
`v3.5.0`, and its Gap 4 opened.

## What a new session does

1. Read this file — including the thread table — then the `CHECKPOINT-<thread>.md` file(s)
   relevant to today's focus, then `OPEN_QUESTIONS.md`.
2. Do not read `docs/` wholesale — open a document when it is actually needed.
3. Ask for the session focus if it was not given.
4. Close with `playbooks/checkpoint.md`.
