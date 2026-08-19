# rnd-project-memory — Session Index

**Updated:** 2026-08-19

Entry point for every session. Loaded automatically through `AGENTS.md`.

**This repository holds both the artefact and its own memory.** Everything below governs the
memory at the root. Files under `skeleton/` are the shipped template and are edited as an
artefact, never as working notes — see `AGENTS.md`.

---

## Routing rule

| What | Where |
|------|-------|
| Settled conclusion | `docs/` |
| In-flight reasoning | `CHECKPOINT-esdevop.md` |
| What happened in a session | `sessions/<date>-<slug>.md` |
| What an experiment produced | `experiments/EXP-<YYYY-MM-DD>-<slug>.md` |
| Where a fact came from | `SOURCES.md` |

`ai-sandbox/` is **not a second copy** of `docs/`. Matured conclusions move out.

---

## Artifacts

| File | Contents | Write mode |
|------|----------|-----------|
| `CHECKPOINT-esdevop.md` | Current unresolved state | rewrite, ≤150 lines |
| `OPEN_QUESTIONS.md` | Active questions (resolved are deleted) | edit |
| `ASSUMPTIONS.md` | What the design bets on | edit |
| `SOURCES.md` | Source register with IDs — empty; this project reasons rather than cites | append |
| `RULES.md` | The behavioural rules — upstream's, replaced on upgrade | do not edit |
| `RATIONALE.md` | Why each rule exists; failure modes | read on demand |
| `sessions/LOG.md` | One row per session | append only |
| `experiments/LOG.md` | One row per experiment | append only |

`DATA_ENVIRONMENT.md` is deliberately absent: this project has no data environment, and the
template's own rule says content that instructs falsely is worse than content that is missing.

---

## Current focus

The extraction sequence is complete: the repository is public under MIT, the skeleton is at
`v1.2.0`, the handbook describes what exists rather than what was intended, and the root memory
has been raised through `upgrade-template.md` twice. Everything ADR-002…004 promised now exists
and has run at least once.

No substantive work is queued. The open items are one cosmetic defect in `skeleton/docs/method.md`
and the components only a real work project can exercise.

Blocked on nothing. `Q-oss-intake` and `Q-contribution-flow` need answers from outside this
repository and block nothing today.

---

## What a new session does

1. Read this file, then `CHECKPOINT-esdevop.md`, then `OPEN_QUESTIONS.md`.
2. Do not read `docs/` wholesale — open a document when it is actually needed.
3. Ask for the session focus if it was not given.
4. Close with `playbooks/checkpoint.md`.
