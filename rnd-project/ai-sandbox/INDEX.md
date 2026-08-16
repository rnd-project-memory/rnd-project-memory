# <PROJECT_NAME> — Session Index

**Updated:** <DATE>

Entry point for every session. Loaded automatically through `AGENTS.md`.

---

## Routing rule

| What | Where |
|------|-------|
| Settled conclusion | `docs/` |
| In-flight reasoning | `CHECKPOINT-<owner>.md` (one per person) |
| What happened in a session | `sessions/<date>-<slug>.md` |
| What an analysis produced | `experiments/EXP-<YYYY-MM-DD>-<slug>.md` |
| Where a fact came from | `SOURCES.md` |

`ai-sandbox/` is **not a second copy** of `docs/`. Matured conclusions move out.

---

## Artifacts

| File | Contents | Write mode |
|------|----------|-----------|
| `CHECKPOINT-<owner>.md` | Current unresolved state | rewrite, ≤150 lines |
| `OPEN_QUESTIONS.md` | Active questions (resolved are deleted) | edit |
| `ASSUMPTIONS.md` | What the method bets on | edit |
| `SOURCES.md` | Source register with IDs | append |
| `DATA_ENVIRONMENT.md` | Databricks, uv, run recipes | edit |
| `RATIONALE.md` | Why each rule exists; failure modes | read on demand |
| `sessions/LOG.md` | One row per session | append only |
| `experiments/LOG.md` | One row per experiment | append only |

---

## Current focus

<2–4 lines: the live question, and what is blocking it.>

---

## What a new session does

1. Read this file, then your `CHECKPOINT-<owner>.md`, then `OPEN_QUESTIONS.md`.
2. Do not read `docs/` wholesale — open a document when it is actually needed.
3. Ask for the session focus if it was not given.
4. Close with `playbooks/checkpoint.md`.
