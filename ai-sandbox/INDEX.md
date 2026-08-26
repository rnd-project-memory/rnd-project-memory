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
| `install-path` | esdevop@gmail.com | active | 2026-08-26 |

The first thread open since `v2.0.0` shipped on 2026-08-23. Six releases were cut without one,
because everything each session produced either shipped or had a home. This one does not: an
unreleased change sits in the tree, three install defects are named but untouched, and the bump
is undecided.

---

## Current focus

**Starting a project from the skeleton, and who does the work.** A real attempt to start a new
project from the template failed, and the failure was in the install rather than in the system:
`skeleton/README.md` step 3 said *replace every `<PROJECT_NAME>` and `<PLACEHOLDER>`*, and there
is no such token — it occurred exactly once, in that sentence, where it looked like a string to
grep for.

Underneath it, one syntax carrying three things with three lifetimes:

| Class | Count | Lifetime |
|---|---|---|
| Mechanical token — `<PROJECT_NAME>`, `<DATE>` | 20 files | a `sed`, no decisions |
| Blank only a person can answer — now `<<FILL: …>>` | 7 | before the first commit |
| Example syntax and section prompts — `<slug>`, `<thread>` | ~170 | **never touched** |

`ai-sandbox/INDEX.md` carries all three within twenty lines. An install told to "replace every
placeholder" correctly destroys its routing table, and this file is loaded into every session, so
the damage reads as instruction from then on. `bootstrap-test.sh` now gates exactly that.

Three things worth carrying:

- **The question the failure raised is not about installing.** Ownership of the record is settled
  — `Held by:` is a human's git identity, `Owner:` a human name, an `ADR-` needs a human's
  sign-off, and the assistant is nowhere a subject of record. *Execution* is not settled, and a
  monthly credit ceiling turns that into an availability dependency nobody declared.
  `Q-who-keeps-the-history` 🟡 asks for a timing, not an argument.
- **The executor is not binary.** Judgement is a person's, mechanics belong to a script, routing
  either. `bootstrap-test.sh` already performs the whole mechanical install — the hardest step is
  scripted today, in a file named as a test.
- **A marker is checkable; a category is not.** Nothing could have flagged `<PLACEHOLDER>`,
  because it named a class rather than a string. `<<FILL: …>>` exists to be counted, and its
  boundary — *the install cannot proceed without a human answer* — is what keeps `check.sh` from
  printing a permanent `todo` at every young project that has not yet discovered its method.

Unreleased: the change above sits in the tree, the bump is undecided, and `check.sh` at the root
still runs `v3.0.1`. `Q-unexercised-components` 🟡 untouched; `Q-oss-intake` and
`Q-contribution-flow` 🟢 still need answers from outside this repository.

## What a new session does

1. Read this file — including the thread table — then the `CHECKPOINT-<thread>.md` file(s)
   relevant to today's focus, then `OPEN_QUESTIONS.md`.
2. Do not read `docs/` wholesale — open a document when it is actually needed.
3. Ask for the session focus if it was not given.
4. Close with `playbooks/checkpoint.md`.
