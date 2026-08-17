# 2026-08-17 · Step 7, and the first real upgrade

**Status:** closed

> Fourth session of the day. The first one opened at its start rather than reconstructed
> afterwards, and the first to exercise machinery rather than design it.

---

## Objective

Write the two artefacts §15 promised but did not have — `MIGRATIONS.md` and
`playbooks/upgrade-template.md` — then use them: release `v1.1.0` and raise this repository's own
memory layer to it.

## Reasoning

`MIGRATIONS.md` has no migrations in it, and writing it anyway was the point. The format is easier
to agree when nothing is at stake than in the moment a real migration is due, and one decision
inside it is much easier to make now than later: **`.template-version` is updated last**, as the
final step of an upgrade, so the recorded version always names a state that was actually reached.
An upgrade interrupted anywhere earlier stays visible instead of becoming a lie.

`upgrade-template.md` carries the step the whole delivery design leans on — diff `RULES.md` and
report every changed rule — plus one that had not been written down anywhere: check for local
edits to mechanism files **before** replacing them, and stop if there are any. Discovering that
someone's fix is about to be discarded is worth a person's attention; discovering it afterwards is
worth nothing.

Then the release. `v1.1.0` is MINOR: a new playbook, no structural change, no migration. Its tag
message names the `RULES.md` change in the form ADR-004 requires, which is the first time that
obligation has been met by an actual release rather than described.

## Decisions

None new. This session executed decisions already recorded in ADR-003 and ADR-004.

## Found along the way

**The upgrade caught a real defect on its first run, and it was ours.** Step 3 reported
`check.sh` and `.githooks/pre-commit` as differing from `v1.0.0`. They were not local edits: the
root had been vendored from a state *newer* than the tag it claimed. `v1.0.0` was tagged at the
commit that split `RULES.md`, and the two false-positive fixes landed in the next commit — the
same one that bootstrapped the root memory. So `.template-version` said `v1.0.0` while the tree
held `v1.0.0` plus two fixes, and nothing had noticed for the length of a session.

This is precisely the "recorded version disagrees with the structure" case `upgrade-template.md`
step 1 describes, encountered before anyone had a chance to encounter it accidentally. The upgrade
to `v1.1.0` resolves it: all fifteen mechanism entries now match the tag.

The process lesson is smaller than the finding: **tag when the artefact is actually finished, not
when it looks finished.** The tag was cut mid-session and the tree kept moving underneath it.

**The check that caught it does not exist yet.** ADR-003 says `check.sh` "gains an advisory check
that manifest-owned files match their released hashes". It has not been written, so step 3 was run
by hand with a shell loop. That loop is what found the discrepancy — which is a reasonable
argument for building the real thing.

**Fifteen mechanism entries, and the copy took one line.** Delete-and-copy behaved as ADR-002
claimed: no merge, no conflict, nothing to resolve. That half of the design now has one data point
instead of none.

## Next

- The manifest-hash check in `check.sh` (ADR-003), still unwritten. Step 3 of the upgrade playbook
  currently has no tool behind it.
- `Q-unexercised-components` is unchanged: `DATA_ENVIRONMENT.md`, `ingest-source.md` with
  `SOURCES.md`, and the hook firing on a real secret remain untouched by this repository and will
  stay that way. The first work project is their test.
- Sample IDs in `skeleton/docs/method.md` inside a `<placeholder>`, still cosmetic.
