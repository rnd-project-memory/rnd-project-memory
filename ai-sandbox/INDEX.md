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

**The template has been installed from outside this repository for the first time**, twice: once
by a fresh assistant given only the public URL, a title and one paragraph, and once by a person
unassisted with a stopwatch. Both against `v3.1.1`. Records:
`EXP-2026-08-26-green-start-assisted` (*supports, with one field failing*) and
`EXP-2026-08-26-green-start-manual` (*supports*, **12:11**).

**Five findings, none acted on** — deliberately, so that what the experiments found and what was
done about it stay separable. They are in `CHECKPOINT-install-path.md`, Gap 1.

Four things worth carrying:

- **Prose gave the assistant an escape and it used it; a structured field gave it none and it
  took the forbidden value.** Where the paragraph underdetermined the project, it wrote explicit
  absences and opened three questions — exactly the documented pattern, with no operator input and
  no questions asked. Then it stamped every one `Owner: <a git address>`, thirteen lines under a
  bold rule forbidding that. The field carries *always filled in* and *not an address* and nothing
  says **ask**.
- **A fix that removes a false positive can install a false negative in the same stroke.** The
  blank check was anchored to `^<<FILL:` in the morning to clear nine false positives here; by
  evening two half-answered markers in the two session-loaded files were passing as `ok`. The
  second failure is the more expensive: the first is loud, the second looks like success.
- **The assistant beat the person at the one parameter whose documentation is ambiguous.** The
  guide's example makes the destination path and the project name read as the same string; the
  person supplied the folder name and got `# churn-signals`, the assistant read the title and got
  `# Churn Signals`. Nothing checks it.
- **Same-family evidence is weak evidence.** `CONFIGURATIONS.md` says so, the documentation was
  written by an assistant, and the assisted arm ran on one of the same family. Cite it as nearer
  self-review than a test until a second provider runs it.

`Q-who-keeps-the-history` 🟡 has its first number and a sharper remaining question: the install is
measured, the **recurring** cost of keeping the record by hand is not, and that is where the
availability dependency actually lives. `Q-session-boundary` 🟡 open;
`Q-unexercised-components` 🟡 untouched; `Q-oss-intake` and `Q-contribution-flow` 🟢 need answers
from outside this repository.

## What a new session does

1. Read this file — including the thread table — then the `CHECKPOINT-<thread>.md` file(s)
   relevant to today's focus, then `OPEN_QUESTIONS.md`.
2. Do not read `docs/` wholesale — open a document when it is actually needed.
3. Ask for the session focus if it was not given.
4. Close with `playbooks/checkpoint.md`.
