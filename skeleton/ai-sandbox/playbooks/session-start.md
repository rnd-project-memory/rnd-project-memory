# Playbook — Open a session

## Read, in this order

1. `ai-sandbox/INDEX.md` — current focus
2. `ai-sandbox/CHECKPOINT-<owner>.md` — what is in progress. If other `CHECKPOINT-*.md`
   files exist, skim them too: they are colleagues' in-flight work, read-only to you
3. `ai-sandbox/OPEN_QUESTIONS.md` — active questions

**Do not** read `docs/` in full, and do not read `sessions/LOG.md` in full. Open a
specific document when the discussion actually needs it. The point of the index is to
avoid loading the whole knowledge base into every session.

## Check for an interrupted session

```bash
grep -l 'Status:.*open' ai-sandbox/sessions/*.md
```

`open` belongs to the current session only. Any other match is a session that was cut
short — context ran out, the user left, `checkpoint.md` never ran.

Freeze it: set `**Status:** abandoned`, add a `sessions/LOG.md` row with the outcome
"interrupted", and **change nothing else**. Do not backfill from memory — the value of the
record is that it shows what was actually captured before the interruption. This also makes
interruptions visible instead of leaving them traceless.

## Open this session's file

Create `ai-sandbox/sessions/YYYY-MM-DD-<slug>.md` from `_TEMPLATE.md` with
`**Status:** open`, and fill in the objective once the focus is agreed. Append to it as the
session runs.

Writing the record at the end instead — after context has compacted — reproduces the lossy
re-summarising this system exists to prevent, inside the one file declared to hold full
detail.

## Report back, ~10 lines maximum

- where the last session stopped
- what is currently in progress
- the 2–3 highest-priority open questions
- a proposed focus for this session

Then **stop and wait** for confirmation or redirection. Do not start work unprompted.

## Search before you conclude

Before calling anything unknown, new, or unresolved, check whether it has already been
answered. The archive is only worth writing if something triggers reading it:

```bash
rg -i "<topic>" ai-sandbox/sessions/LOG.md ai-sandbox/experiments/LOG.md
rg -i "<topic>" docs/ ai-sandbox/OPEN_QUESTIONS.md
```

Search the two `LOG.md` files first — that is what they are for, and it is how "find the row
by topic or date" is meant to be done without reading them whole. A hit gives a filename;
open that file, not the log.

If the topic has been named differently before, the tag column in each log is the fallback:
`rg '#<tag>' ai-sandbox/*/LOG.md`.

## Staleness checks

- **Stalled entry.** If a `CHECKPOINT-<owner>.md` entry has not changed in 3+ weeks (check
  `sessions/LOG.md`), flag it as a promotion candidate: it is a conclusion, not a process.
- **Aging numbers.** If the checkpoint holds figures marked unverified and the session
  touches them, offer to re-check against the data before reasoning on top of them.
- **Mutable sources.** If a claim in play cites a Confluence page read more than a few
  months ago, flag that the page may have changed.
