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

**Three green-start arms have run against `v3.1.1` from outside this repository — and the two
assisted ones disagree.** A same-family model produced honest absences and three open questions
(`EXP-2026-08-26-green-start-assisted`, *supports*). A different provider filled every
underdetermined section confidently and raised none
(`EXP-2026-08-27-green-start-independent`, *contradicts*). `CONFIGURATIONS.md` rates the second
higher. The manual arm completed in **12:11** (`EXP-2026-08-26-green-start-manual`, *supports*).

**Eight findings, none acted on** — deliberately. They are in `CHECKPOINT-install-path.md`, Gap 1,
and the first two are why the independent arm failed rather than consequences of it.

Four things worth carrying:

- **The rule the design rests on reaches no project.** *"An assistant may fill these only from
  what you actually told it"* lives in `skeleton/README.md` alone, which is `norcopy`. The markers
  say what to write and never the prohibition. `v2.4.0`'s shape exactly: the instruction that
  protects the system sits where the reader never goes.
- **One apparent hallucination was ours.** The skeleton ships `DATA_ENVIRONMENT.md` asserting
  `uv` as fact, and `AGENTS.md`'s marker says the stack named must match that file. The model
  obeyed a document that was wrong — `ADR-002`'s criterion turned on its author, who already
  applies it here by omitting that file.
- **`check.sh` is clean on a repository of honest absences and on one of confident fiction.** The
  boundary of the mechanical layer is now measured rather than assumed, and none of the eight
  findings closes it. On day one there is no reviewer either: the project has no history and
  nobody has read anything yet.
- **One run agreeing with a rule is not evidence that the rule binds.** The pair does not read as
  one pass and one fail; it reads as *not load-bearing across providers*.

`Q-who-keeps-the-history` 🟡 — the manual half is measured, the assisted half is now **less**
settled than it was yesterday, and the recurring cost of keeping the record by hand is still
unmeasured. `Q-session-boundary` 🟡 open; `Q-unexercised-components` 🟡 untouched;
`Q-oss-intake` and `Q-contribution-flow` 🟢 need answers from outside this repository.

## What a new session does

1. Read this file — including the thread table — then the `CHECKPOINT-<thread>.md` file(s)
   relevant to today's focus, then `OPEN_QUESTIONS.md`.
2. Do not read `docs/` wholesale — open a document when it is actually needed.
3. Ask for the session focus if it was not given.
4. Close with `playbooks/checkpoint.md`.
