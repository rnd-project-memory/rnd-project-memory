# rnd-project-memory — Session Index

**Updated:** 2026-08-17

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

Bootstrapping finished; the design is recorded as ADR-001…006 and the memory is seeded. The next
substantive work is the remainder of the handbook reconciliation — `RND_PROJECT_MEMORY.md` still
has no representation for ADR-002/003/004/005, which is a new §15 of roughly 70–90 lines. After
that, `MANIFEST`, `MIGRATIONS.md` and `playbooks/upgrade-template.md` (step 7).

Blocked on nothing. `Q-enterprise-access` and `Q-contribution-flow` need answers from outside this
repository and block nothing today.

---

## What a new session does

1. Read this file, then `CHECKPOINT-esdevop.md`, then `OPEN_QUESTIONS.md`.
2. Do not read `docs/` wholesale — open a document when it is actually needed.
3. Ask for the session focus if it was not given.
4. Close with `playbooks/checkpoint.md`.
