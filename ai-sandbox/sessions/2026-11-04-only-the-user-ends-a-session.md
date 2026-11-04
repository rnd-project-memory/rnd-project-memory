# 2026-11-04 · Only the user ends a session

- **Status:** closed
- **Configuration:** Solo
- **Mode:** design
- **Participants:** author — claude-opus-5-5
- **Signed off:** no
- **Tags:** `#template` `#adoption`

---

## Objective

The author reports that assistants close sessions on their own, when the author meant to go on in
the same session. Make saving and closing two gestures, and make closing the user's.

## Reasoning

**The template causes it.** `checkpoint.md` says *run at the end of a session, or at any point a
reliable save is wanted*, and its step 1 sets the record to `closed`, after which it is immutable.
An assistant wanting to save carefully is told, by the playbook, to close. This repository's own
assistant did exactly that throughout 2026-11-03: it closed every record itself, unasked, and the
day fragmented into eight session records. That is the *granular archive* direction of
`Q-session-boundary`, observed at a rate.

**`Q-session-boundary` is answered by the author's preference.** It asked whether closing is the
same gesture as saving, and offered *splitting the gesture* as the obvious repair, held back only
because steps 4–5 read as though the session were over. The answer: they are two gestures. *Save*
is the assistant's, at any time, and the record stays `open`. *Close* is the user's, and it freezes
the record and writes the `LOG.md` row.

**Instrument, under `ADR-013`.** Closing without the user's word cannot be detected from the
files. Gate 1 holds, since the defect is a property of the document: the playbook joins two
gestures. Gate 2 holds, since no check sees it. Gate 3 holds, since the rule lives in `RULES.md`
and the playbook points at it. So it is a rule, plus the playbook split that removes the cause.

**Built on `next`.**

- `checkpoint.md` is retitled *Save a session, and close it when the user says so*. A preamble
  separates the two gestures. Step 1 runs on the user's word only, step 5's `LOG.md` row at close
  only, and the checklist asks rather than closes.
- `RULES.md`: *only the user ends a session*; the procedures table reads *saving at any point;
  closing when the user ends the session*.
- `sessions/_TEMPLATE.md`: closed only when the user ends the session; saving leaves it `open`.
- Both INDEX files, step 4 of *What a new session does*: save as the work goes, close only on the
  user's word.
- Handbook §7's row, and a `RATIONALE.md` paragraph.
- `bootstrap-test.sh` passes. Hashes regenerated.

**`Q-session-boundary` deleted as answered.** The answer: two gestures, *save* the assistant's,
*close* the user's. Its `LOG.md` row comes with this session's close, under the new rule.

**The assistant's own memory** also carries it, as a feedback note, so the behaviour holds in
sessions that have not loaded this template's rules.

**Saved, not closed.** This record stays `open` until the author says the session is over.

**Released, on the author's word.** `v3.10.0`, MINOR. It carries this change and the 60-day
ripeness threshold. The tag names the `RULES.md` rule and the `checkpoint.md` split. The root was
raised: `check.sh`, `RULES.md`, `RATIONALE.md`, `checkpoint.md` and `sessions/_TEMPLATE.md` were
replaced. The root's INDEX and `DECISIONS.md` already carried the scaffold changes.
`.template-version` was updated last.

The release was recorded in this session rather than in a new one. Under the new rule, a new record
could only have been closed by asking again. The author's instruction (close, commit, release) is
carried out as one sequence, with the close last.

## Decisions

- Save and close are two gestures, and only the user closes.
- `Q-session-boundary` answered and deleted.
- `v3.10.0` released.

## Next

No thread is open. `Q-positioning-against-prior-art` is the live question.
