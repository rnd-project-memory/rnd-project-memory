# Playbook — Close a session

Run at the end of a session, or at any point a reliable save is wanted.
Follow the steps **in order**.

## 1. Write the session file

`ai-sandbox/sessions/YYYY-MM-DD-<slug>.md`, slug in lowercase with hyphens.

Contents: objective, how the reasoning went, decisions, incidental findings, what is next.
Full detail belongs here — this file is its only home. Several sessions in one day get a
numeric suffix (`-2`).

**Once written, this file is immutable.** Errors in it are corrected in the *next* session,
not edited retroactively.

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

`OPEN_QUESTIONS.md` — **delete** answered questions (do not mark them resolved); add
questions raised this session.

`ASSUMPTIONS.md` — an assumption that became `CONFIRMED` is promoted to `docs/` and
**deleted** here; one proven false is deleted, with its consequence recorded in the
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
