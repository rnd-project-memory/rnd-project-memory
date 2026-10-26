# 2026-10-26 · Moving development to a `next` branch

- **Status:** closed
- **Configuration:** Solo
- **Participants:** author — claude-opus-5-5
- **Signed off:** no
- **Tags:** `#template` `#versioning` `#distribution`

> A short session, written in one pass at its end rather than opened first and appended to.

---

## Objective

The author asked whether two or more MINOR releases a day make sense, or whether changes should
accumulate. Settle that, and make the answer the push strategy.

## Reasoning

**Batching is cheap for adopters, and frequent releases are expensive for us.** Adopters vendor
the template and may skip MINORs, since §15 obliges them to run only MAJOR migrations in order.
So a release's cost falls mostly here: regenerated hashes, tag notes, README Status, the root
raise and its record. On 2026-10-25 that was about a third of the day's work, and `v3.6.0` had to
be re-cut when Gap 7 arrived after it. The rule adopted: a fix for a defect with a cost already
paid ships at once, as Gap 7 did. A diagnostic or improvement accumulates, as Gap 5 now does.

**Batching on `main` would break installs.** `install.sh` takes the files from the working tree
and the version from `git describe --tags --abbrev=0`. A skeleton change pushed to `main` between
releases is installed as `v3.6.0  skeleton @ <later commit>`: a release name on content that is not
that release. `upgrade-template.md` then upgrades from the wrong base. It had not happened yet,
because the commit carrying Gap 5 (`612589b`) was still local.

**Hence one working branch, not split ones.** Template work on `next` with memory on `main` was
considered and rejected. A session record would then describe changes absent from its own branch,
and every mixed commit would need splitting. Instead all work lands on `next`. `main` is
fast-forwarded at release, after the tag and the root raise, so `skeleton/` on `main` is always a
tagged release, and on `main` the `check.sh` drift section reads `ok`. An urgent fix while `next`
is unshippable branches from `main` and is merged back.

**Done.** `next` was created at `612589b`. Local `main` returned to `origin/main` (`7d3bd83`) with
`reset --keep`, after checking the tree was clean and nothing but `612589b` was ahead. The rule is
written into `AGENTS.md`, *Branches*, which every session loads, including a session-start branch
check. It also changes step 6 of *Cutting a release* in `MIGRATIONS.md`: fast-forward `main`,
push both.

**The installer defect is the template's, not only this repository's.** Anyone keeping their own
copy of the template hits it. It is recorded as finding 7 of `install-path`. The branch rule
protects this repository's `main` and fixes nothing for them.

## Decisions

- All work on `next`. `main` moves only at a release.
- Gap 5 waits on `next` for the next release, `v3.7.0`.
- `install.sh`'s labelling of unreleased content is recorded, not fixed.

## Next

Push `next` on the author's word. Then design options for Gap 6 (issue #2).
