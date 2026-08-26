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

**No counter.** The date and slug are the identifier (§4). A numeric suffix is added only to
break a genuine collision — a second session on the *same date* with the *same slug*, which
happens when a topic is reopened the same day. Several sessions in one day are not a
collision: their slugs already differ, and numbering them by order of arrival is a counter
allocated by scanning the directory for the highest number, which is the friction §4 removed
and the shared counter `docs/constraints.md` forbids. Two people would compute the same one.

## 2. Decide what graduates to `docs/`

Review the session's output for conclusions that have stopped moving. **List the candidates
for the user and wait for agreement** — `docs/` is never modified without it. On agreement,
follow `promote.md`.

Test: still true in a month → `docs/`. Might still turn over → checkpoint.

## 3. Update the thread checkpoint(s)

**A thread's checkpoint exists only while something produced is not yet promoted and not yet
closed.** For each thread this session touched, decide first whether there is anything left to
write down at all: if everything is already promoted (step 2) or already lives in
`CAVEATS.yaml` or a playbook, there is nothing to open a checkpoint for.

If there is something left, decide whether this is a **new** thread or a continuation of one
that already has a file:

- **New thread** — name it for what is being worked on, not who is doing it
  (`CHECKPOINT-<thread-slug>.md`). Set `Held by:` to the exact output of
  `git config user.email` in this clone — if it is empty, stop and ask rather than choosing one.
- **Continuing** — write only `CHECKPOINT-<thread-slug>.md` for a thread you hold. Other
  people's threads are read-only to you; taking one over is an event (see `RULES.md`), not a
  silent edit here.

### Rewriting (thread continues)

**Rewrite the whole file. Do not append.**

- Delete everything no longer true. Do not strike through or mark "outdated" — delete.
  Previous versions are in git and in the session file.
- Delete everything promoted in step 2.
- Keep only what is unresolved, and keep personal reasoning **out** — what was tried, what
  didn't make sense, what is suspected belongs in the session file, not here.
- Update `Resume from:` and `Do not do until re-verified:` to reflect exactly where this session
  left the thread — not what was done, the state of the break itself.
- **If the thread has a `Plan:` file**, do not restate it here. No task identifiers (`T-###`)
  in this header — state for a planned thread lives in the plan (contract), run artefacts (what
  happened, read from disk, not from the plan's table — the table is intent, the directory is
  fact), and this header (distrust and prohibitions only, since artefacts can't express those).
- Check the limit: `wc -l ai-sandbox/CHECKPOINT-<thread-slug>.md` ≤ 150.

**If it exceeds 150 lines**, something needs promoting — that is not a signal to shorten
the wording. Find the most settled part and move it to `docs/`. Compressing prose to fit
the cap is the exact failure this system exists to prevent. This only holds together with
step 2's evidence rule: raw numbers belong in `ai-sandbox/results/`, not copied into the
checkpoint as proof.

### Closing (nothing is left in progress on this thread)

Split what remains to **both** addresses at once — never a choice between them:

- Settled parts → `docs/`, via `promote.md`.
- Anything still hanging → **one** `OPEN_QUESTIONS.md` entry, not a restatement of the whole
  thread.
- Delete the checkpoint file.

This loses nothing for facts — each already had a single-purpose home to move to. It does lose
the value of holding several sessions' state together in one place; that synthesis has no other
home, and closing accepts it as a real, bounded cost rather than solving it.

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
- `INDEX.md` — update the date, the `## Threads` table (add, update, or remove the rows this
  session touched), and "Current focus". Leave the rest alone unless the structure genuinely
  changed: this file loads into every session and must stay small and stable.

## 6. Propose a commit

Conventional Commits. Show the message and **wait for confirmation — do not commit
unprompted.**

## Checklist

- [ ] Session file written
- [ ] Promotions agreed and applied
- [ ] Thread checkpoint(s) rewritten (≤150 lines) or closed to `docs/` + one `OPEN_QUESTIONS.md` entry
- [ ] Registers updated, resolved entries deleted
- [ ] `LOG.md` and `INDEX.md` (incl. thread table) updated
- [ ] Commit proposed
