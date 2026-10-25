# 2026-10-25 · Adding the parallel-session collision to the adopter review

- **Status:** closed
- **Configuration:** Solo
- **Participants:** author — claude-opus-5-5
- **Signed off:** no
- **Tags:** `#adoption` `#template`

> A short session, written in one pass at its end rather than opened first and appended to.

---

## Objective

The author named two open issues on the remote and asked for the second to join the adopter review:
issue #3, *"The rule to have only one session with status 'open' is too strict"*, and issue #2,
*"AI Handoff mechanism for implementation work"*. Record both against the review's findings, and
correct the review where the new evidence contradicts it.

## Reasoning

**Issue #3 is in the snapshot, and it is not a single report.** `[S-adopter-snapshot-2026-10-25]`
shows the sequence in the adopter's own records:

1. A session opened with `session-start.md`, found another session file `Status: open`, applied
   the sweep's instruction that any other `open` file is an interrupted session, and froze it as
   interrupted.
2. That other session was live and deliberately parallel, on an unrelated topic. A later row in
   the adopter's `LOG.md` reopened it, recorded that the classification had been wrong, and the
   session then closed normally.
3. The freezing session recorded the cause itself: the sweep has no way to mark an intentional
   parallel session, and its blanket rule conflicts with the project's own rationale.

Two rules were broken in a row, and the second was forced by the first. A live session was frozen,
which costs it the contemporaneous record. Then a frozen record was edited, which `RULES.md`
forbids, because the only alternative was to lose the live session's remaining work. The adopter's
records also mention an explicitly parallel session on the following day, and that one was not
frozen. So parallel sessions are a working practice here, not a one-off.

**The cause is a contradiction in the template, not a model's reading.** Handbook §3 names a solo
author running several agents in parallel as the case the thread axis exists for. The
interrupted-session check in `session-start.md` assumes exactly one session is ever live, and it
orders a freeze. This is statable without naming a model, so it passes `ADR-013` gate 1.
Detectability is weak: nothing in a session file distinguishes *live elsewhere* from *cut short*.
The sweep is therefore exactly where a person has to be asked. A check cannot decide it, and a rule
telling the assistant to be careful is the instrument `ADR-013` puts last. The repair belongs in
the playbook's own instruction, which currently decides on the person's behalf.

Issue #3 also proposes a criterion: parallel sessions are fine when they do not touch the same
checkpoint. That fits the thread axis and holder-only writes. It is recorded as the reporter's
proposal, not adopted.

**Correction to `sessions/2026-10-25-adopter-example-review.md`.** Under *What worked*, item 2
says two interrupted sessions were frozen and not backfilled. That holds for the two still marked
`abandoned`. It omits a third freeze, of a live parallel session, which was wrong and was then
undone by editing a frozen record. The archive held for interruptions and failed for parallelism.
The earlier record is not edited.

**The author's account, given in this session.** The two remaining `abandoned` records are genuine
interruptions. The collision happened more than once, and each time the author corrected it at
once, so the snapshot holds no wrongly frozen session. The one trace in the files is a correction
the adopter's log happened to record. The files therefore understate how often it happened. The
rate is not known, only that it was more than one.

**Issue #2 is Gap 6.** It describes the shape the adopter built on its own: a design document, a
`PLAN-<thread-slug>.md` execution plan, and validation gates the implementation must pass, handed
to a cheaper model. Two sources now point at the same missing artefact, the adopter's practice and
the issue. They share an author, so they are not independent. It also bears on `Q-who-keeps-the-history`, whose 2026-10-25 progress note already
records the credit-ceiling handoff.

## Decisions

- Issue #3 becomes Gap 7 of `adopter-review`, priority high. The defect is in the template's own
  playbook. Its cost is a broken immutability guarantee, and it has now happened in practice.
- Gap 6 is linked to issue #2 and raised from low to medium on a second source. It is the same
  author's, so this is not independent confirmation.
- Neither is fixed in this session.

## Next

Gap 7 first: the sweep should report other `open` sessions and ask, rather than freeze. Consider
issue #3's same-checkpoint criterion as what the report shows. Then Gap 5.
