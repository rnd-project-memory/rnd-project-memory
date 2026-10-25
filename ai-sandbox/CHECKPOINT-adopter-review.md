# rnd-project-memory — Checkpoint · adopter-review

- **Held by:** esdevop@gmail.com · since 2026-10-25
- **Status:** active
- **Resume from:** eight findings from one real adopter's snapshot are recorded and none is
  triaged. The next step is to sort each under `ADR-013`'s gates: check, prose, new home, or
  nothing. No template change has been made.
  **Do not do until re-verified:** do not state any of these as general to adopters. They come from
  one project, one author, one snapshot, and two of them (findings 2 and 3) may be specific to a
  prototype-phase project. Do not quote, paraphrase or name anything identifying the adopter: its
  domain, people, addresses, infrastructure or code (`docs/constraints.md`). Do not read the
  snapshot's register state as a deletion history. Its git history is snapshots, so deletions are
  invisible.

> This file belongs to one thread, named for what is being worked on. Only whoever it names as
> `Held by:` writes it. Rewritten, never appended; only what is unsettled.

---

## Current state

| Item | Value | Source |
|------|-------|--------|
| Evidence | one adopter on `v3.5.0`, about 8 weeks, 66 sessions | `[S-adopter-snapshot-2026-10-25]` |
| Full account | what worked, what failed, mechanisms | `sessions/2026-10-25-adopter-example-review.md` |
| Template changed | no | — |

---

## In progress

### Gap 1 — two plain defects in the template (priority: high)

Cheap to fix and the evidence settles them on its own.

1. **`check.sh` tag frequencies** match only backticked tags. A log written with bare tags prints
   nothing, and the empty output reads as *clean*.
2. **Install residue nothing flags later.** `CHECKPOINT-thread.md`, with a placeholder `Held by:`,
   survives indefinitely when `install.sh` gets no thread argument. The staleness sweep then
   treats it as a thread, and `check.sh` counts it toward checkpoint size. The shipped `C-<slug>`
   example entry in `CAVEATS.yaml` survives the same way.

### Gap 2 — `INDEX.md` *Current focus* has no write mode that holds (priority: high)

The *2–4 lines* guidance lives only in the `<<FILL:` marker and disappears once the blank is
answered. `checkpoint.md` step 5 says to update it but not to rewrite it. Nothing measures it. In
the adopter it grew to about 300 lines in a file loaded every session. Candidates: a rewrite
instruction in step 5, a size line in `check.sh`, or both.

### Gap 3 — no home for working decisions and settled engineering facts (priority: high)

Nothing moved to `docs/` after adoption, and decisions settled into `ASSUMPTIONS.md` and INDEX
instead. Open: is this a missing slot (a provisional decision, a light ADR, engineering facts
allowed in `docs/`), or the correct behaviour of a project with no settled method yet? One
snapshot cannot separate the two.

### Gap 4 — staleness without an exit (priority: medium)

Twenty *deferred* rows in four days, all recorded by the assistant, and no thread ever closed.
Report-and-count was chosen so that a non-holder is never forced into a verdict. What is missing
is a point at which deferral stops being available to the assistant on its own.

### Gap 5 — single-valued fields (priority: medium)

`Configuration:` was `Solo` on every session while `Participants:` carried about twenty role
strings, which points to a missing *session mode* axis. `CAVEATS.yaml` `severity: critical` sits
on 21 of 28 entries because its definition coincides with the definition of a caveat.

### Gap 6 — planned threads (priority: medium)

The adopter built plan files with command-plus-expected-value gates, and a model-handoff
procedure. Plan status still drifted across three files. The template names neither `PLAN-` nor
`DESIGN-` files in its artefact table, and enforces nothing of §3's *status from artefacts*.
Candidate upstream material, not yet assessed.

---

## Feeds other items

- `Q-session-boundary`, `Q-who-keeps-the-history`, `Q-unexercised-components`: progress recorded
  there on 2026-10-25.
- `install-path` Gap 2: the adopter's `check.sh` was clean on every section bearing on these
  findings.

---

## Out of scope for this thread

- **Changing or advising the adopter's project.** This thread improves the template only.
- **Committing any part of the snapshot**, or a summary detailed enough to identify it.
