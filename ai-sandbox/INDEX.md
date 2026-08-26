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

**The install is now a script the guide points at, and the one measurement taken of that came out
against it.** `install.sh` performs what has one correct answer — copy set, rename, this clone's
settings, token substitution, `.template-version`, and the first thread when one is named — and
reports what it deliberately leaves. `bootstrap-test.sh` calls it instead of reproducing it;
`skeleton/README.md` describes no mechanical step in prose at all.

`EXP-2026-08-26-install-extraction-cost` **contradicts**. Replaying a queued change (Gap 4) touched
three files where the pre-extraction baseline touched two, against a prediction of one and a kill
criterion of two.

Four things worth carrying:

- **The metric was wrong, and visibly so before the run.** Counting files conflates copies of one
  fact with separate concerns. Extraction removes the first and increases the second, so the count
  rewards keeping concerns tangled. A post-hoc count showing the procedure fall from two places to
  one is recorded as weaker and its question pre-registered — not swapped in to rescue the result.
- **The extraction stands, the reasoning for it does not.** A gate that reimplements what it gates
  tests its own copy; that argument is unaffected. `Q-who-keeps-the-history` is explicitly *not*
  advanced, and says so, rather than quietly keeping the extraction as evidence.
- **The `<<FILL>>` marker names itself, and caught a third tool.** `check.sh`, then
  `bootstrap-test.sh`, then `install.sh` — three independent rediscoveries in one day, each found
  by running the tool, never by reading it.
- **A rule stated in prose and re-implemented in a script diverges here, undetected**
  (`EXP-2026-08-26-prose-script-restatement`) — but the `RETIRED` array, the oldest instance of
  that pattern, has not drifted at all. One positive, one clean negative. Not a law.

Unreleased: three mechanism changes and two rule changes sit in the tree, the bump is undecided,
and `check.sh` at the root still runs `v3.0.1`. `Q-who-keeps-the-history` and `Q-session-boundary`
🟡 open; `Q-unexercised-components` 🟡 untouched; `Q-oss-intake` and `Q-contribution-flow` 🟢 need
answers from outside this repository.

## What a new session does

1. Read this file — including the thread table — then the `CHECKPOINT-<thread>.md` file(s)
   relevant to today's focus, then `OPEN_QUESTIONS.md`.
2. Do not read `docs/` wholesale — open a document when it is actually needed.
3. Ask for the session focus if it was not given.
4. Close with `playbooks/checkpoint.md`.
