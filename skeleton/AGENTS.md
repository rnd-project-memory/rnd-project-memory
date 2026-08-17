# <PROJECT_NAME>

## About this project

<One paragraph: what is being researched or designed, and for whom.>

R&D project. The method is being discovered, not implemented from a specification.

<How knowledge arrives — documentation, wiki pages, call transcripts, discussion — and what
the analysis runs on. Whatever stack is named here must match `ai-sandbox/DATA_ENVIRONMENT.md`,
which is the one file that describes it in detail.>

## Session entry point

@ai-sandbox/INDEX.md

## Working rules

- **Owner token:** `<owner>` — my checkpoint is `ai-sandbox/CHECKPOINT-<owner>.md`. Write to
  that file only; other `CHECKPOINT-*.md` files belong to other people.
- `docs/` is the permanent knowledge base: settled conclusions only. **Changes to `docs/` are
  reviewed before they land** — propose the change, then apply it once approved. Working alone
  that means a deliberate diff pass; with colleagues it means a pull request.
- `ai-sandbox/` is working memory. It is *not* a second copy of `docs/`. A matured
  conclusion moves and is deleted from the sandbox, never copied.
- `CHECKPOINT-<owner>.md` is rewritten, never appended, and capped at 150 lines. Over the cap
  means something needs promoting to `docs/` — not that the prose needs shortening.
- Write every entry for a reader who missed the session. In three months that reader is me.
- The session file is created at the **start** of a session (`Status: open`) and appended
  to as it runs; `checkpoint.md` closes it. Immutable once closed. An `open` file from any
  earlier session was interrupted — freeze it as `abandoned`, do not backfill.
- Experiment records are immutable once written. Corrections go into the next one.
- Register entries are **deleted**, never marked resolved — whether answered or gone
  obsolete. The `LOG.md` row names the outcome, which is what keeps the deletion
  discoverable.
- Every claim promoted into `docs/` gets a row in `docs/CLAIMS.md` with its basis
  (`EXP-…`, `S-…`, `sessions/…`, or `ADR-…`), written in the same change.
- Search before concluding something is unknown: `rg -i "<topic>" ai-sandbox/*/LOG.md docs/`.
- Every number that enters `docs/` carries a date and a source.
- Never commit credentials, tokens, PII, or raw extracted data. See `ai-sandbox/SOURCES.md`.

## Why these rules

Each rule above has a stated failure mode in `ai-sandbox/RATIONALE.md`, together with the
failure-mode table for auditing the system. **Read it on demand — do not import it.** It is
reference material, not behavioural instruction, and loading it every session wastes context.

Consult it when a rule looks arbitrary or you are about to make an exception.

## Procedures

Ask to follow one of these by path:

| Playbook | When |
|----------|------|
| `ai-sandbox/playbooks/session-start.md` | Opening a session |
| `ai-sandbox/playbooks/checkpoint.md` | Closing a session, or any save point |
| `ai-sandbox/playbooks/promote.md` | Moving a conclusion into `docs/` |
| `ai-sandbox/playbooks/ingest-source.md` | Adding a PDF, Confluence page, or transcript |
| `ai-sandbox/playbooks/run-experiment.md` | Running and recording an analysis |

## Commits

Conventional Commits. Types used here: `docs`, `feat`, `fix`, `chore`, `exp`.
