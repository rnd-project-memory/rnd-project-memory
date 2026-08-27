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

**`ADR-013` is signed and `v3.3.0` is released.** The instrument follows **detectability**, not
severity: a rule in `RULES.md` only where no check can see the failure, an advisory check where
late detection is a remedy, a blocking hook plus a rule where it is not. Three gates for any new
rule; two evidence asymmetries.

**It withdrew one of `v3.2.0`'s own rules a release later**, which is the point of having it.

Four things worth carrying:

- **A criterion is worth what it costs you, not what it costs others.** `ADR-013` flags two of the
  five edits in the release that prompted it, and the one failing its second gate is the one that
  regressed.
- **A rule can cost more than the failure it prevents.** Told to ask when `Owner:` had no name
  available, the next assistant judged that asking would block progress and skipped the register
  entirely. One wrong value in one field, traded for an unused register.
- **The defect under it was structural, not behavioural.** The preamble said the field is *always*
  filled and that blank means *nobody has claimed this*. Both cannot hold. Fixing the sentence is
  what removes the squeeze; the rule had been instructing people around it.
- **Two runs are pre-registered before either is performed**, with two binary outcomes fixed in
  advance — because after a result there is always a more convenient metric, and the file-count
  experiment already made that mistake.

`Q-who-keeps-the-history` 🟡 — install measured both ways, the recurring cost still not;
`Q-session-boundary` 🟡 open; `Q-unexercised-components` 🟡 untouched; `Q-oss-intake` and
`Q-contribution-flow` 🟢 need answers from outside this repository.

## What a new session does

1. Read this file — including the thread table — then the `CHECKPOINT-<thread>.md` file(s)
   relevant to today's focus, then `OPEN_QUESTIONS.md`.
2. Do not read `docs/` wholesale — open a document when it is actually needed.
3. Ask for the session focus if it was not given.
4. Close with `playbooks/checkpoint.md`.
