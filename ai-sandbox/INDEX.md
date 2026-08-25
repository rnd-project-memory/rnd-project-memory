# rnd-project-memory — Session Index

- **Updated:** 2026-08-25

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

| Thread | Held by | Status | Since |
|--------|---------|--------|-------|
| *(none open)* | | | |

No thread has been open since `v2.0.0` shipped on 2026-08-23. `v2.1.0` and `v2.2.0` were both
released without one: everything each session produced either shipped or had a home, which is the
condition under which a checkpoint is not opened.

---

## Current focus

`v2.2.0` has shipped and the root memory runs on it. It is the first release driven by evidence
from outside this repository: an adopter took `v2.1.0` into a project with three months of its own
history and kept a friction log. Four decisions came out of it — `ADR-008`–`ADR-011` — and they are
the first here to carry a named human sign-off.

The finding worth remembering: three defects had shipped through four releases because they live in
the *installation*, and this repository never installs anything. `bootstrap-test.sh` now performs
that installation at release time.

No substantive work is queued. `Q-marker-absence-reasons` 🟢 is a two-place wording fix waiting for
a release. `Q-oss-intake` and `Q-contribution-flow` still need answers from outside this repository
and block nothing. Roughly half the trial's findings were judged bound to that one project's shape
and left alone; re-opening them needs a second adopter rather than more reasoning about the first.

## What a new session does

1. Read this file — including the thread table — then the `CHECKPOINT-<thread>.md` file(s)
   relevant to today's focus, then `OPEN_QUESTIONS.md`.
2. Do not read `docs/` wholesale — open a document when it is actually needed.
3. Ask for the session focus if it was not given.
4. Close with `playbooks/checkpoint.md`.
