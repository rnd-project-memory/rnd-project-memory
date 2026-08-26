# rnd-project-memory — Session Index

- **Updated:** 2026-08-26

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
| *(none open)* | | | |

No thread has been open since `v2.0.0` shipped on 2026-08-23. `v2.1.0` and `v2.2.0` were both
released without one: everything each session produced either shipped or had a home, which is the
condition under which a checkpoint is not opened.

---

## Current focus

`v3.0.0` has shipped and the root memory runs on it. Two releases in two days from one question —
with two contributors, whose name belongs in a thread's `Held by:`?

- **`v2.4.0`** — `git clone` does not copy `.git/config`. The secret-scan hook is a tracked file
  and travels; `core.hooksPath`, which runs it, does not. So it protected the adopter and nobody
  who cloned from them, silently, for six releases. `AGENTS.md` now carries the per-clone commands,
  `check.sh` reports them first, `session-start.md` has step 0a.
- **`v3.0.0`** — the declared per-person token is retired. `Held by:` is the exact output of
  `git config user.email` in the clone where the work happens (`ADR-012`, extending `ADR-007`).
  A per-person value in a per-project file has one slot and N contributors, and the obvious repair
  merges *cleanly* the wrong way.

Three things worth carrying:

- **A fix's reach is decided by its layer, not its intent.** `AGENTS.md` is `scaffold` and reaches
  new adoptions only; `check.sh` and the playbooks are `mechanism` and reach projects already
  running. Twice now the supporting half turned out to be the half that protects anyone.
- **Delete the shared field rather than manage it.** The roster that mapped tokens to identities
  worked and was the first draft; binding to a value each clone already has removes the field
  instead, which is why it is the better answer.
- **The retired-vocabulary check matches strings, not meanings.** `docs/glossary.md` carried the
  pre-`v2.0.0` definition for four releases because it paraphrased the retired idea in words no
  migration had listed. Fixed on 2026-08-26; not mechanised, on one instance.

`Q-unexercised-components` 🟡 is untouched by this release;
`Q-oss-intake` and `Q-contribution-flow` 🟢 still need answers from outside this repository.

## What a new session does

1. Read this file — including the thread table — then the `CHECKPOINT-<thread>.md` file(s)
   relevant to today's focus, then `OPEN_QUESTIONS.md`.
2. Do not read `docs/` wholesale — open a document when it is actually needed.
3. Ask for the session focus if it was not given.
4. Close with `playbooks/checkpoint.md`.
