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

**`v3.2.0` is released and the root runs on it.** It fixes the two green-start findings that could
have changed the result, and only those, so that a re-run measures them rather than a bundle.

- **The no-invention rule now reaches a project.** It lived in `skeleton/README.md` alone, which
  is `norcopy` — an absent rule after the install, not a weak one. Now: authority in
  `ai-sandbox/RULES.md`, pointer in the guide, short form at each marker. The marker form is
  deliberately not relied on; one marker already carried its escape and the independent arm read
  it and declined.
- **`DATA_ENVIRONMENT.md` no longer asserts a stack**, and `AGENTS.md` no longer orders a match
  against it. The assistant that named Python/`uv` for a project that never mentioned one **was
  obeying us**.

Three things worth carrying:

- **The artefact was wrong and the authority was right.** The handbook has forbidden shipping a
  stack the project does not have for four releases; the skeleton shipped it anyway. First time
  `skeleton/README.md`'s handbook-wins rule has run in that direction.
- **A rule in a `norcopy` file binds nobody.** `v2.4.0` found the same shape with the secret-scan
  hook. Reach is decided by layer, not by how emphatically a thing is written.
- **What `check.sh` cannot see is now a stated boundary**, not an open task: it sees that a blank
  was answered, never whether the answer is true. The design's reviewer is a person, and on day
  one there is not one.

**Nothing here is verified.** The two fixes are reasoning about a failure, not a measurement of a
repair, and the thread says so. `Q-who-keeps-the-history` 🟡 — the manual half is measured, the
assisted half is less settled than it was; `Q-session-boundary` 🟡 open;
`Q-unexercised-components` 🟡 untouched; `Q-oss-intake` and `Q-contribution-flow` 🟢 need answers
from outside this repository.

## What a new session does

1. Read this file — including the thread table — then the `CHECKPOINT-<thread>.md` file(s)
   relevant to today's focus, then `OPEN_QUESTIONS.md`.
2. Do not read `docs/` wholesale — open a document when it is actually needed.
3. Ask for the session focus if it was not given.
4. Close with `playbooks/checkpoint.md`.
