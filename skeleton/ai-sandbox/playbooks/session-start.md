# Playbook — Open a session

## 0. Pull

`git pull` before reading anything else. A thread checkpoint is written by one holder, but
nothing in git enforces that — a conflict here is divergence caught **before** work starts
instead of discovered after two people wrote the same file.

## 0a. Check this clone

```bash
git config core.hooksPath   # expect .githooks
git config user.email       # expect an address
```

Both live in `.git/config`, which `git clone` does not copy. A fresh clone therefore has neither:
`.githooks/pre-commit` sits in the working tree and never runs, and git gives no warning that
anything is off. `./check.sh` reports both in its first section.

An empty hooks path is reported **before** anything else in the session and named as the first
thing to fix — the one check whose failure a later edit cannot repair is not running, which
outranks whatever the session was opened to do. An empty `user.email` is asked about, never
inferred from commit history or from another file.

## Read, in this order

1. `ai-sandbox/INDEX.md` — current focus, and the `## Threads` table
2. The `CHECKPOINT-<thread>.md` file(s) relevant to this session's focus — any thread may be
   read, but only the one(s) you hold in the thread table may be written. Skim the others if
   useful context: they are colleagues' in-flight work.
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

- **Stalled thread — report and count, do not force a verdict.** For each
  `CHECKPOINT-<thread>.md`, check its age against `sessions/LOG.md`. Anything 3+ weeks old
  prints one line and stops there:

  ```
  Stalled: CHECKPOINT-<thread>.md — 40 days, deferred twice.
  ```

  This check fires ahead of whoever opened the session, and under the thread axis that is
  usually not the thread's holder — demanding a verdict from someone who doesn't own the thread
  produces either a rubber-stamped extension or a closure nobody understood. "Deferred" is a
  legitimate outcome, not an evasion. Whatever is decided — deferred or closed — log it as one
  row in `ai-sandbox/STALENESS_LOG.md`: date, thread, age, decision, who. The count in the
  printed line comes from this log, and it is what keeps a repeated notice from going unread
  after two weeks the way an unchanging one does.
- **Aging numbers.** If the checkpoint holds figures marked unverified and the session
  touches them, offer to re-check against the data before reasoning on top of them.
- **Mutable sources.** If a claim in play cites a Confluence page read more than a few
  months ago, flag that the page may have changed.
