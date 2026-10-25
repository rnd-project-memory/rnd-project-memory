# 2026-10-25 · Reviewing a real adopter's memory after eight weeks

- **Status:** closed
- **Configuration:** Solo
- **Participants:** author — claude-opus-5-5
- **Signed off:** no
- **Tags:** `#adoption` `#template` `#secrets`

> This session did not run `session-start.md` and had no file while it ran. This record was
> written at its close, from the commands it ran and the files it read. It is a reconstruction,
> not a running account.

---

## Objective

Read a snapshot of a real project that has run the template for about eight weeks, and record what
the memory system did well there and what failed. The example itself is not to be changed or
improved. Nothing project-specific may enter this repository.

## Reasoning

**What was read.** `[S-adopter-snapshot-2026-10-25]`: one working project on `v3.5.0`, adopted
before that release and raised to it. It covers 66 session records from 2026-08-30 to 2026-10-23,
12 experiment records, 6 live thread checkpoints, and every register. It was read in place and not
modified. `check.sh` was run against a throwaway copy outside both repositories.

**What the evidence cannot show.** The snapshot's git history is a sequence of snapshots, not the
project's own history. How often checkpoints were rewritten, and whether register entries were
ever deleted, cannot be seen. Everything below is read from the state of the files on one date.
The snapshot carries no `.githooks/`. The author confirmed it was removed when the snapshot was
prepared, so nothing is concluded about the hook.

**Confidentiality.** The project is an employer's. Its domain, names, addresses, infrastructure
identifiers and code are kept out of this record and every other file this session wrote, as
`docs/constraints.md` requires. Counts and structural observations only.

### What worked

1. **Checkpoints held their shape.** All six live ones are 31–80 lines. Their `Do not do until
   re-verified:` lines are specific prohibitions, not adjectives. One example: do not accept a
   remote job's terminal `SUCCESS` as evidence.
2. **The archive is intact.** All 66 session files are `closed` or `abandoned`, and every one has
   a `LOG.md` row. Two interrupted sessions were frozen as `abandoned` and not backfilled.
3. **Verdict ≠ verification paid off.** An independent review found that work an executor had
   reported as passed had no matching artefacts on disk. The project's response was the §3 rule
   for planned threads: status is read from artefacts, not from prose. This is the first external
   instance of §8's claim that self-report and verification diverge.
4. **`CAVEATS.yaml` is used as designed.** It holds 28 entries, 15 of them `kind: tool`, so
   instrument traps and data traps share one list.
5. **Source discipline held.** 31 of 32 sources are `reference-only`. Slug IDs are used
   throughout, and no counters were seen in any register.
6. **The project built what the template lacks.** These are candidate upstream inputs, not
   defects:
   - `PLAN-<thread>.md` files: a gated checklist where each gate is a command plus an expected
     value, written so work can be handed to another executor.
   - A local playbook for handing implementation between models mid-task. Its stated trigger is an
     AI-credit ceiling forcing a switch to a cheaper model.
   - Per-mode role prompts (brainstorm, implement, review), kept in a gitignored personal layer.

### What failed or drifted

1. **`INDEX.md` became a journal.** It is 368 lines and about 27 KB, loaded into every session.
   Its *Current focus* holds about 300 lines of dated paragraphs from 2026-09-02 to 2026-10-23,
   and older ones contradict newer ones. The shipped guidance, *2–4 lines*, lived only in the
   `<<FILL:` marker text, which is deleted when the blank is answered. `checkpoint.md` step 5
   says to update *Current focus* but not to rewrite it. Nothing checks INDEX size. This is the
   same class as the `v3.2.0` cause: a rule held in text that does not survive to where it is
   needed.
2. **Nothing reached `docs/` after install day.** `method.md` is still the shipped template.
   There are no ADRs and no technique records. All three `CLAIMS.md` rows are dated the day of
   adoption. In 19 places a session or log row explicitly records that nothing was promoted.
   Settled knowledge accumulated instead in INDEX, `ASSUMPTIONS.md`, `CAVEATS.yaml` and plan files
   of up to about 1,100 lines. The likely mechanism is that `docs/` is shaped for settled *method*,
   and an R&D project in a prototype phase has little of that. It has plenty of settled
   engineering facts and working decisions that are taken until revisited. All 11
   `ASSUMPTIONS.md` entries read as decisions the user took, not as bets. Most experiment
   questions are of the form *can X execute?*, not questions about the method.
3. **The staleness check became a ritual.** `STALENESS_LOG.md` gained 20 rows in four days. All
   were *deferred, outside this session's scope*, all recorded by the assistant. Five threads sat
   30–50 days without a session and stayed `active`. No thread was ever closed. One thread
   absorbed three plans, a design file and unrelated runtime work. Report-and-count with no
   threshold turned into deferral with no end.
4. **Install residue persists.** The shipped `CHECKPOINT-thread.md`, with placeholder `Held by:`,
   was still present after 54 days. The staleness sweep logged it as a stalled thread twice, and
   `check.sh` reported it `ok` for size. The `C-<slug>` example entry remains in `CAVEATS.yaml`.
   `install.sh` leaves the checkpoint when given no thread argument. It says so once, and nothing
   afterwards does.
5. **Single-valued fields.**
   - `Configuration: Solo` appears on all 66 sessions, including sessions with a stakeholder
     present and sessions split between an executor and a reviewer. The free-text
     `Participants:` field meanwhile collected about twenty distinct role strings. This is §12's
     diagnostic firing, and the missing axis is *session mode*.
   - `CAVEATS.yaml` `severity:` is `critical` on 21 of 28 entries. `critical` is defined as *fails
     silently*, which is also the definition of a caveat, so the field asks the wrong question.
6. **Session fragmentation.** There were eight sessions on one day and eleven log rows on
   another. This is direct evidence for `Q-session-boundary`.
7. **Tags failed, and the check could not see it.** There are 152 distinct tags, 93 used once,
   including plan-step IDs and model names. `check.sh`'s tag-frequency section printed nothing,
   because it matches only backticked tags and this log writes them bare. Its empty output reads
   as *clean*.
8. **Plan status drifted across files.** For one gate, the plan header said *not started*, INDEX
   said *complete*, and the plan body said both. §3 says status comes from artefacts, not the plan
   table. Nothing enforces that, and `PLAN-`/`DESIGN-` files are absent from the template's
   artefact table.

### Bearing on this repository's open items

- `Q-session-boundary`: fragmentation now has a rate from a second project, not one day here.
- `Q-who-keeps-the-history`: a real availability event was observed (a credit ceiling forcing a
  model switch), and the adopter answered it with a procedure.
- `Q-unexercised-components`: `CAVEATS.yaml`, `SOURCES.md` with ingestion, `DATA_ENVIRONMENT.md`
  and `experiments/` have now run in a real project. The hook remains unobserved.
- Gap 2 of `install-path`: `check.sh` was clean on every section bearing on the failures above.

## Decisions

- The review enters as this record plus a source entry, not as `docs/` content. It is one adopter
  and one snapshot.
- The example is registered as `S-adopter-snapshot-2026-10-25`, with the snapshot date in the
  slug. The project keeps evolving, so the date is part of what was read. A later review of the
  same project gets its own dated entry. A commit date here would not do the job: it records when
  this repository was written, not which state was read, and a rebase changes it.
- The findings open a new thread, `adopter-review`. They are unresolved and have no other home.
- No template fix in this session. The three plain defects (findings 4 and 7) are recorded in the
  checkpoint and not repaired.

## Found along the way

The first draft of the source ID carried a numeric suffix. That is a counter, which §4 and
`docs/constraints.md` forbid. It was caught by the author's question about recoverability, before
anything was written.

## Next

Triage the `adopter-review` findings under `ADR-013`: which are checks, which are prose, and
which need a new home.
