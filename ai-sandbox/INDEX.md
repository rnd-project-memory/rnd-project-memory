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

**The probe passed and cause A held.** Two runs of the identical condition, thirteen minutes
apart, agreed on both pre-registered outcomes, so the stopping rule did not fire and Run 2 is
authorised. Where the `v3.2.0` run left `OPEN_QUESTIONS.md` untouched, entries now appear in both
runs with `Owner:` blank — the named mechanism, in the predicted field, twice
(`EXP-2026-08-28-probe-and-cause-a`).

**`v3.4.0` ships Run 2's treatment**: the seven marker flags removed under `ADR-013`'s third gate.
Everything is in place; the run has not happened.

Four things worth carrying:

- **The choice of coarse outcomes decided the experiment.** The identical condition gave two
  register entries in one run and one with merged scope in the other. A count metric would have
  failed the probe and cancelled Run 2 **by the metric, not by the instrument** — and that could
  never have been decided honestly after seeing it.
- **The confound that materialised was the one nobody was watching.** `C-copilot-model-build` was
  written about an *invisible* model build; the CLI moved *visibly*, v1.0.80 → v1.0.81, between
  the baseline and the runs. An unobservable confound gets a caveat; an observable one gets
  forgotten. Cause A is supported-with-a-confound, not clean.
- **A pre-registration is worth most when it constrains you against your own interest.** The fine
  outcome disagreed and was simply out of scope.
- **Run 2 is not about seven lines of marker text.** It is the first test of `ADR-013`'s third
  gate: if removing a restatement costs behaviour, the gate has a price worth knowing before it is
  applied again.

`Q-who-keeps-the-history` 🟡 — install measured both ways, the recurring cost still not;
`Q-session-boundary` 🟡 open; `Q-unexercised-components` 🟡 — `CAVEATS.yaml` has now run its full
cycle, written and corrected; `Q-oss-intake` and `Q-contribution-flow` 🟢 need answers from outside.

## What a new session does

1. Read this file — including the thread table — then the `CHECKPOINT-<thread>.md` file(s)
   relevant to today's focus, then `OPEN_QUESTIONS.md`.
2. Do not read `docs/` wholesale — open a document when it is actually needed.
3. Ask for the session focus if it was not given.
4. Close with `playbooks/checkpoint.md`.
