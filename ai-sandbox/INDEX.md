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
| `DECISIONS.md` | Choices taken, too young for an ADR; mature by holding | add; edit when revised; move to an ADR when it has held |
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

No thread is open. `install-path` and `adopter-review` both closed on 2026-11-03. Their
prohibitions are in `docs/method.md` and `docs/constraints.md`. `install-path`'s last finding is
`Q-prompt-phrasing-confound`.

---

## Current focus

> **2–4 lines, rewritten at every checkpoint, never appended.** Where the work stands now and what
> is blocking it. What happened belongs in `sessions/`, what is unresolved in a thread checkpoint.
> This file loads into every session; `check.sh` reports this section past 15 lines.

**No thread is open.** Both closed on 2026-11-03, with everything they found shipped through
`v3.9.0`. On `next`, unreleased: working decisions ripen at 60 days.

**`Q-positioning-against-prior-art` 🔴** is the live question: does this add anything over
shipped memory and spec-driven tools, settled by a pre-registered comparison.
`Q-who-keeps-the-history` and `Q-unexercised-components` 🟡 remain, as do
`Q-prompt-phrasing-confound` 🟢 and two questions answerable only outside this repository.
---

## Latest completed session

2026-11-03: `adopter-review` closed, its scope limit moved to `docs/method.md`. Working decisions
ripen at 60 days, the author's choice (`D-decisions-ripen-at-60-days`), on `next` for the next
release. Earlier the same day: `v3.9.0`, and `install-path` closed.

## What a new session does

1. Read this file — including the thread table — then the `CHECKPOINT-<thread>.md` file(s)
   relevant to today's focus, then `OPEN_QUESTIONS.md`.
2. Do not read `docs/` wholesale — open a document when it is actually needed.
3. Ask for the session focus if it was not given.
4. Save with `playbooks/checkpoint.md` as the work goes. Close only when the user says the session
   is over, and ask rather than close when it looks done.
