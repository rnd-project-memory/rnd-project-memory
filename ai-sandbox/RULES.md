# Working rules

> **This file is upstream's.** It is replaced wholesale when the template is upgraded, so a local
> edit here is lost at the next version — and lost silently. Anything specific to this project
> belongs in `AGENTS.md`, which is yours. `RATIONALE.md` explains why each rule below exists;
> read it on demand and do not import it.

- **A thread's checkpoint is `ai-sandbox/CHECKPOINT-<thread-slug>.md`**, named for what is being
  worked on, not who is working on it. Only whoever it names as `Held by:` writes it — everyone
  else reads. Taking over a thread is an event: write it into your session file and add a
  `sessions/LOG.md` row, not a silent edit of the field.
- **A thread's checkpoint exists only while something produced is not yet promoted and not yet
  closed.** If everything a session left behind already has a home in `docs/`, `CAVEATS.yaml`, or
  a playbook, there is no checkpoint to open for it.
- `docs/` is the permanent knowledge base: settled conclusions only. **Changes to `docs/` are
  reviewed before they land** — propose the change, then apply it once approved. Working alone
  that means a deliberate diff pass; with colleagues it means a pull request.
- `ai-sandbox/` is working memory. It is *not* a second copy of `docs/`. A matured conclusion
  moves and is deleted from the sandbox, never copied.
- The checkpoint is rewritten, never appended, and capped at 150 lines. Over the cap means
  something needs promoting to `docs/` — not that the prose needs shortening.
- Write every entry for a reader who missed the session. In three months that reader is you.
- The session file is created at the **start** of a session (`Status: open`) and appended to as it
  runs; `checkpoint.md` closes it. Immutable once closed. An `open` file from any earlier session
  was interrupted — freeze it as `abandoned`, do not backfill.
- Experiment records are immutable once written. Corrections go into the next one.
- **A conclusion resting on an experiment marked `not verified` does not move to `docs/`.**
- **If an experiment record cites a file, that file is in the repository** — or the record says
  why not and names what stands in as evidence instead.
- Register entries are **deleted**, never marked resolved — whether answered or gone obsolete.
  The `LOG.md` row names the outcome, which is what keeps the deletion discoverable.
  `ai-sandbox/CAVEATS.yaml` is the one register exempt from this: a trap does not stop being true
  when addressed, so it is corrected or marked gone, never deleted.
- Data and tool traps go in `ai-sandbox/CAVEATS.yaml`, found by subject — not read start to end.
- Every claim promoted into `docs/` gets a row in `docs/CLAIMS.md` with its basis (`EXP-…`,
  `S-…`, `sessions/…`, or `ADR-…`), written in the same change.
- Search before concluding something is unknown: `rg -i "<topic>" ai-sandbox/*/LOG.md docs/`.
- Every number that enters `docs/` carries a date and a source.
- Never commit credentials, tokens, PII, or raw extracted data. See `ai-sandbox/SOURCES.md`.

## Procedures

Ask to follow one of these by path:

| Playbook | When |
|----------|------|
| `ai-sandbox/playbooks/session-start.md` | Opening a session |
| `ai-sandbox/playbooks/checkpoint.md` | Closing a session, or any save point |
| `ai-sandbox/playbooks/promote.md` | Moving a conclusion into `docs/` |
| `ai-sandbox/playbooks/ingest-source.md` | Adding a PDF, wiki page, or transcript |
| `ai-sandbox/playbooks/run-experiment.md` | Running and recording an analysis |
| `ai-sandbox/playbooks/upgrade-template.md` | Raising the project to a later template release |
