# Playbook — Close a session

Run at the end of a session, or at any point a reliable save is wanted.
Follow the steps **in order**.

## 1. Close and freeze the session file

The file already exists — `session-start.md` created it and the session has been appending
to it. This step **closes** it; it does not compose it from memory.

- Fill any gaps in **Decisions** and **Next** that the session did not write as it went.
- Set `**Status:** closed`.
- Add the tag(s) you will use in the `LOG.md` row.

**From this point the file is immutable.** Errors are corrected in the *next* session, not
edited retroactively.

If no session file exists — the session began without `session-start.md` — create it now and
say so plainly in the record, because what it holds is a reconstruction rather than a
contemporaneous account, and a later reader should know which they are looking at.

Several sessions in one day get a numeric suffix (`-2`).

## 2. Decide what graduates to `docs/`

Review the session's output for conclusions that have stopped moving. **List the candidates
for the user and wait for agreement** — `docs/` is never modified without it. On agreement,
follow `promote.md`.

Test: still true in a month → `docs/`. Might still turn over → checkpoint.

## 3. Rewrite `CHECKPOINT-<owner>.md`

**Rewrite the whole file. Do not append.** Write only `CHECKPOINT-<owner>.md` — the file
named by the owner token in `AGENTS.md`. Other people's checkpoints are never edited.

- Delete everything no longer true. Do not strike through or mark "outdated" — delete.
  Previous versions are in git and in the session file.
- Delete everything promoted in step 2.
- Keep only what is unresolved.
- Check the limit: `wc -l ai-sandbox/CHECKPOINT-<owner>.md` ≤ 150.

**If it exceeds 150 lines**, something needs promoting — that is not a signal to shorten
the wording. Find the most settled part and move it to `docs/`. Compressing prose to fit
the cap is the exact failure this system exists to prevent.

## 4. Update the registers

`OPEN_QUESTIONS.md` — **delete** on either exit, never mark resolved:
- **answered** — the answer goes to the session record and, if durable, to `docs/`;
- **obsolete** — it stopped mattering (scope moved, branch died, wrongly posed). Log it as
  *"dropped: no longer blocks anything"* plus one clause of why.

Both need a `LOG.md` row, which is what makes the deletion discoverable. Also add questions
raised this session. Sweep for questions whose `Raised:` date is months old and which nothing
now depends on — those are the obsolete exit's usual catch.

`ASSUMPTIONS.md` — an assumption that has been verified is promoted to `docs/` (with basis
`EXP-…` or `S-…`) and **deleted** here; there is no `CONFIRMED` resting state, only the move; one proven false is deleted, with its consequence recorded in the
checkpoint as a gap; add new assumptions surfaced this session.

`SOURCES.md` — add any source consulted this session that is not yet registered.

## 5. Update the log and index

- `sessions/LOG.md` — one row: date, topic, outcome, link to the session file. The outcome
  names **what was resolved**, not just what was worked on: this row is the only cue a later
  reader gets that a deleted question ever had an answer.
- `experiments/LOG.md` — a row for each experiment run this session.
- `INDEX.md` — update the date and "Current focus". Leave the rest alone
  unless the structure genuinely changed: this file loads into every session and must
  stay small and stable.

## 6. Propose a commit

Conventional Commits. Show the message and **wait for confirmation — do not commit
unprompted.**

## Checklist

- [ ] Session file written
- [ ] Promotions agreed and applied
- [ ] `CHECKPOINT-<owner>.md` rewritten, ≤150 lines
- [ ] Registers updated, resolved entries deleted
- [ ] `LOG.md` and `INDEX.md` updated
- [ ] Commit proposed
