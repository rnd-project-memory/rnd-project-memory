# 2026-11-03 · An exit from staleness, and a session mode

- **Status:** closed
- **Configuration:** Solo
- **Mode:** implement
- **Participants:** author — claude-opus-5-5
- **Signed off:** no
- **Tags:** `#adoption` `#template`

---

## Objective

`adopter-review` Gaps 4 and 5, with the solutions the author approved:

- only a human defers a stalled thread, and only with a revisit date;
- a `Mode:` field on session records;
- `CAVEATS.yaml` `severity:` redefined by consequence, softly.

## Reasoning

**Gap 4: an exit from staleness.**

- The evidence pointed at the response, not the threshold. The adopter deferred every thread at
  every session, as the assistant, several rows a session.
- Now an assistant reports a stalled thread and stops. Only the holder writes a
  `STALENESS_LOG.md` row, and a deferral carries a revisit date in a new *Revisit* column.
- `check.sh` gains *Stalled threads*. Age is days since the checkpoint's last commit, which nobody
  can type. A thread 21+ days old is reported unless its latest row defers it with a date still
  ahead, by someone who is not an assistant. Older rows without the column count as no deferral.
- Every notice clears: the holder closes the thread, touches it, or defers it with an end.
- The same device as the intake file's dismantling date and the adoption note's third part:
  something that holds a known imperfection names what ends it.
- Written in `session-start.md`, the `STALENESS_LOG.md` preamble, the handbook's §7 row, a
  `RATIONALE.md` failure row, and §12's list. Four bootstrap gates: never deferred reported, an
  assistant's deferral ignored, the holder's deferral honoured, a lapsed deferral reported again.

**Gap 5: the schema half.**

- `sessions/_TEMPLATE.md` gains `Mode:` (`explore | design | implement | execute | review | admin`),
  and `check.sh`'s distribution counts it. It is optional and new, so old records stay valid.
- `CAVEATS.yaml` `severity:` is redefined by what a miss costs: `invalidates-results |
  costs-a-rerun | minor`. The old scale defined `critical` as *fails silently*, which is the
  definition of every caveat. Entries written earlier keep their values, which is inert under §15.
- This record carries `Mode:` itself, ahead of the root receiving the template.

**Gap 3, revised by the author's observation.** In R&D a decision matures by holding unchanged
over time, and by then the memory of why it was taken has faded. So the missing piece is a cheap
place to write a decision at the moment it is taken, and a measure of maturity by age. A
provisional ADR does not fit: `docs/` is reviewed before every landing, and R&D decisions are taken
and revised continually. I proposed instead a working-decisions register in `ai-sandbox/`
(`DECISIONS.md`, `D-<slug>`). Its decisions mature by age unchanged and are moved, not copied, into
an ADR. The author's confirmation is awaited.

`bootstrap-test.sh` passes. Hashes regenerated. Not released.

## Decisions

- Gaps 4 and 5 built to the approved solutions.
- Gap 3's design is revised and awaits confirmation.

## Next

Confirm Gap 3's register, then build it.
