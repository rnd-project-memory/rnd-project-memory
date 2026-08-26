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

**`v3.1.0` is released and the root memory runs on it.** The install stops being prose: mechanical
steps live in `install.sh`, which `skeleton/README.md` points at and `bootstrap-test.sh` calls;
blanks only a person can answer are marked `<<FILL:` and counted; session filenames carry no
counter. Details in the tag.

**The next thing is an alignment audit**, before any new project is started from the template — the
same pass `v3.0.1` was, and for the same reason: a release changes what the system does, and the
documents that *instruct* are the layer replacement does not reach.

Three things worth carrying:

- **The release's own procedure found three defects that reading found none of.** Two in
  `upgrade-template.md`, which never said to copy `.template-hashes` and diffed `RULES.md` alone
  while this release delivered two rules through a playbook. Both had been handled correctly by
  hand every previous time and written down at none.
- **A check can be right for the adopter and wrong for the author.** The blank check matched prose
  about the marker, so it was noisy only in the repository that ships it. That is the usual
  self-hosting asymmetry reversed, and worse for it: the person able to fix a false alarm is the
  one being taught to ignore it. Anchoring to the line start is the same repair the `.gitignore`
  check already carried.
- **Two instruments, two blind spots, neither redundant.** `bootstrap-test.sh` passed throughout
  and could not have caught that: a scratch install contains no prose about the marker. It took
  running the upgrade here.

`Q-who-keeps-the-history` and `Q-session-boundary` 🟡 open; `Q-unexercised-components` 🟡 untouched;
`Q-oss-intake` and `Q-contribution-flow` 🟢 need answers from outside this repository.

## What a new session does

1. Read this file — including the thread table — then the `CHECKPOINT-<thread>.md` file(s)
   relevant to today's focus, then `OPEN_QUESTIONS.md`.
2. Do not read `docs/` wholesale — open a document when it is actually needed.
3. Ask for the session focus if it was not given.
4. Close with `playbooks/checkpoint.md`.
