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

| Thread | Held by | Status | Since |
|--------|---------|--------|-------|
| *(none open)* | | | |

No thread has been open since `v2.0.0` shipped on 2026-08-23. `v2.1.0` and `v2.2.0` were both
released without one: everything each session produced either shipped or had a home, which is the
condition under which a checkpoint is not opened.

---

## Current focus

`v2.4.0` has shipped and the root memory runs on it. It came out of a question about the owner
token — with two contributors, whose token appears in `Held by:`? — which exposed something larger
than the thing it asked about.

Two things worth carrying:

- **`git clone` does not copy `.git/config`.** The hook *file* travels with the repository; the
  setting that runs it does not. So every contributor except the adopter has `.githooks/pre-commit`
  sitting inert in their working tree, with no warning from git, and `skeleton/README.md` — where
  the install instruction lives — is `norcopy`, so it never reaches them either. Demonstrated in a
  scratch repository rather than argued. `v2.4.0` puts the two commands in `AGENTS.md`, the check
  first in `check.sh`, and step 0a in `session-start.md`.
- **A fix's reach is decided by its layer, not by its intent.** The `AGENTS.md` section was the
  point of the change and reaches new adoptions only, because `AGENTS.md` is `scaffold`. The
  `check.sh` section was the supporting half and is `mechanism`, so it is the part that actually
  reaches an existing project's second contributor. Worth asking of the next fix before writing it.

`Q-held-by-identity-binding` 🟡 is queued and evaluated: retire the owner token, bind `Held by:`
to `git config user.email`. MAJOR, deliberately not bundled with `v2.4.0` — the security half was
separable and should not have waited for it.

`Q-unexercised-components` 🟡 is untouched by this release;
`Q-oss-intake` and `Q-contribution-flow` 🟢 still need answers from outside this repository.

## What a new session does

1. Read this file — including the thread table — then the `CHECKPOINT-<thread>.md` file(s)
   relevant to today's focus, then `OPEN_QUESTIONS.md`.
2. Do not read `docs/` wholesale — open a document when it is actually needed.
3. Ask for the session focus if it was not given.
4. Close with `playbooks/checkpoint.md`.
