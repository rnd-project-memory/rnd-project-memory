# rnd-project-memory — Checkpoint · adopter-review

- **Held by:** esdevop@gmail.com · since 2026-10-25
- **Status:** active
- **Resume from:** Gap 1's two defects are fixed in `skeleton/` and not yet released. All six gaps
  have been triaged under `ADR-013` (`sessions/2026-10-25-adopter-review-triage.md`). Two are ready
  to build once the author decides: Gap 2, which needs a threshold, and Gap 5's check. The other
  three wait on design decisions, not on work.
  **Do not do until re-verified:** do not state any of these as general to adopters. They come from
  one project, one author, one snapshot, and two of them (Gaps 3 and 4) may be specific to a
  prototype-phase project. Do not quote, paraphrase or name anything identifying the adopter: its
  domain, people, addresses, infrastructure or code (`docs/constraints.md`). Do not read the
  snapshot's register state as a deletion history. Its git history is snapshots, so deletions are
  invisible. Do not add a rule to `RULES.md` for any gap here: none passes `ADR-013` gate 2.

> This file belongs to one thread, named for what is being worked on. Only whoever it names as
> `Held by:` writes it. Rewritten, never appended; only what is unsettled.

---

## Current state

| Item | Value | Source |
|------|-------|--------|
| Evidence | one adopter on `v3.5.0`, about 8 weeks, 66 sessions | `[S-adopter-snapshot-2026-10-25]` |
| Findings | what worked, what failed, mechanisms | `sessions/2026-10-25-adopter-example-review.md` |
| Triage | instrument chosen for each gap | `sessions/2026-10-25-adopter-review-triage.md` |
| Template changed | `skeleton/check.sh`, `skeleton/ai-sandbox/CAVEATS.yaml`, `bootstrap-test.sh`; unreleased | Gap 1 |
| Root | still runs `v3.5.0`'s `check.sh`; it takes the fix at the next upgrade, as vendoring requires | `AGENTS.md` |

---

## In progress

### Gap 1 — fixed, not released (priority: high)

- The tag-frequency check now matches bare and backticked tags in table rows, and says `no tags
  yet` when there are none.
- `check.sh` reports an unrenamed `CHECKPOINT-thread.md` as template residue instead of `ok`.
- The `CAVEATS.yaml` example is a comment.

`bootstrap-test.sh` passes, with two new gates covering both install paths. Open: the bump level,
and whether this ships alone or with Gap 2. The tag and residue checks report things the old
`check.sh` did not, so check the bump level against §15 before tagging.

### Gap 2 — `INDEX.md` *Current focus* has no write mode that holds (priority: high)

Instrument: an advisory line count in `check.sh`, plus `checkpoint.md` step 5 saying *rewrite*
where it now says *update*. The second fixes an ambiguity in the document and adds no rule.
Blocking: **the threshold**. The shipped guidance says 2–4 lines and the adopter reached about 300.
Nothing measured between those says where a warning starts being useful rather than noise. The
guidance itself should also move from the `<<FILL:` marker, which is deleted on fill, to text that
survives it.

### Gap 3 — no home for working decisions (priority: high, design)

Nothing moved to `docs/` after adoption, and decisions settled into `ASSUMPTIONS.md` and INDEX.
This is not detectable and is no rule's business. The question is whether a slot is missing (a
provisional decision, a light ADR, engineering facts allowed in `docs/`), or whether this is the
correct state of a project with no settled method yet. One snapshot cannot separate the two.

### Gap 4 — staleness without an exit (priority: medium, design)

`STALENESS_LOG.md` exists to validate its own 3-week threshold. The adopter gives the first outside
evidence: the notice fired every session and was deferred every time, by the assistant. That points
at the response, not at the number. The decision is the author's.

### Gap 5 — single-valued fields (priority: medium)

Instrument: extend §12's distribution check to `Configuration:` in session records. That is
detectable and clearable. Whether the schema gains a *session mode* axis, and whether `severity:`
is redefined, are design decisions and come after the check.

### Gap 6 — planned threads (priority: low, design)

Plan files with command-plus-expected-value gates and a model-handoff procedure are candidate
upstream material. Plan status drifted across three files in the adopter. Not started.

---

## Out of scope for this thread

- **Changing or advising the adopter's project.** This thread improves the template only.
- **Committing any part of the snapshot**, or a summary detailed enough to identify it.
- **Raising the root to the fixed `check.sh` by hand.** The root is vendored from a released tag.
