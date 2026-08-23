# 2026-08-23 · Skeleton v2.0.0 — thread checkpoints and negative knowledge

**Status:** closed
**Configuration:** Solo
**Participants:** author — Sonnet 5 · high
**Signed off:** no

---

## Objective

Implement all thirty techniques (`P-101`–`P-130`) from an external design review against a real
closed project's three months of memory files, as a single `v2.0.0` release of `skeleton/` — one
MAJOR, not six, per the review's own instructions — then run `upgrade-template.md` against this
repository's own root memory.

## Reasoning

The review document (not committed — disposable working input, deleted once this work landed)
gave a work order in its §2.11: implement everything MINOR-grade first with no migration
required, then three technique bundles that only make sense landed atomically together
(`P-101/103`+`P-106/107`; `P-115`+`P-120`; `P-119` after `P-115`), then the remaining standalone
MAJOR items. Followed that order exactly.

Six independent bases justified MAJOR: the checkpoint rename from owner to thread axis, trap
routing out of `DATA_ENVIRONMENT.md` into a new `CAVEATS.yaml`, an evidence-in-repository
requirement on experiment records, `DATA_ENVIRONMENT.md`'s schema at scale, `INDEX.md`'s
single-owner framing replaced by a thread table, and a registry-vs-journal declaration mechanism.
Wrote one `MIGRATIONS.md` section covering all six, since the contract requires every
intermediate MAJOR section to run in full and six separate ones would have meant six sequential
migrations for a structurally coherent change.

Asked the user one scoping question before starting: whether to self-upgrade this root memory in
the same pass, or leave it for later. They asked for the self-upgrade, and specifically for this
session's own record to be written directly in the new `v2.0.0` shape rather than in the
outgoing `v1.2.0` shape and then converted — the session that builds the new format is its own
first real user of it. Agreed: writing it twice would have been pure overhead with nothing
gained, since nothing about *this* session's content depended on the old schema.

Closing `CHECKPOINT-esdevop.md` rather than renaming it: under the new `P-102` opening/closing
rule, a thread checkpoint exists only while something produced has no other home yet. Everything
that file held was already historical narrative with exactly one live item (a stray sample
citation in `skeleton/docs/method.md`, fixed directly in this session). Nothing was left in
progress once that was fixed, so no new `CHECKPOINT-<thread>.md` was opened for it — the
narrative moved into `docs/decisions/ADR-007-threads-and-negative-knowledge.md` and this record
instead.

## Decisions

- `skeleton/` carries all thirty techniques; see `MIGRATIONS.md`'s `v1.2.0 → v2.0.0` section for
  the full per-file account, and `docs/decisions/ADR-007-threads-and-negative-knowledge.md` for
  the two decisions that reopened an existing ADR rather than only adding a field.
- Root's mechanism layer replaced wholesale from the new skeleton; new scaffold files
  (`CAVEATS.yaml`, `PUBLICATIONS.md`, `CONFIGURATIONS.md`, `STALENESS_LOG.md`,
  `ai-sandbox/results/README.md`, `ai-sandbox/playbooks/local/_TEMPLATE.md`) seeded, all
  legitimately empty except `CONFIGURATIONS.md`'s seeded rows — this project has no data
  environment and publishes nothing externally.
- `CHECKPOINT-esdevop.md` closed and deleted, not renamed — see Reasoning.
- `docs/CLAIMS.md` gains rows for the claims this session and ADR-007 establish (below).
- `.template-version` updated last, as its own step, per `upgrade-template.md`'s own rule.

## Found along the way

Root's three existing experiment records already satisfy the new evidence-in-repository
requirement (`P-106`/`P-107`) — they cite files that are already in the repository, being about
the template itself rather than external data. The new `Verified by:` / `Run ID` fields are
additive per `MIGRATIONS.md`'s Exceptions and were not backfilled into them.

## Next

None queued. `Q-oss-intake` and `Q-contribution-flow` remain open, blocked on information outside
this repository, unaffected by this release.
