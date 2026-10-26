# 2026-10-26 · Accepting ADR-014 and shipping implementation packages as v3.7.0

- **Status:** closed
- **Configuration:** Author + reviewer + sign-off
- **Participants:** author — claude-opus-5-5; reviewer and signatory — esdevop
- **Signed off:** esdevop — `ADR-014`, given in conversation on 2026-10-26

---

## Objective

Record the author's sign-off of `ADR-014`, promote its decisions into `docs/method.md`, cut
`v3.7.0` from `next`, raise the root to it, and publish `main` per `AGENTS.md`, *Branches*.

## Reasoning

**Sign-off.** The author signed `ADR-014` in conversation, not in the file. The ADR's
`Signed off:` records that and points here. `Status:` is now `accepted`. Five of its decisions were
promoted into `docs/method.md`'s claims table, with `CLAIMS.md` rows, in the same commit
(`09b2655`), following `ADR-013`'s precedent:

- packages for changes executed elsewhere;
- status derived, never typed;
- review as a clean-checkout re-run;
- backward links;
- objective slugs.

**Cutting `v3.7.0`** (`MIGRATIONS.md`):

- **Step 2:** the hash list was already current.
- **Step 2a:** `bootstrap-test.sh` passes.
- **Step 2b:** the rules introduced are known to their artefacts. Packages, derived state, links
  and dependencies are known to `check.sh`, and the labels to `bootstrap-test.sh`. `Base:` and
  objective slugs are guidance, with no artefact to know them.
- **Step 3:** no retired vocabulary.
- **Step 3a:** MINOR. The release adds optional files, playbooks and checks, and existing records
  stay valid. A checkpoint's `Plan:` now means a package, which is inert for old values, since no
  check reads them.
- **Step 3b:** README Status raised to *eighteen releases*, with a paragraph on packages.
- **Step 4:** tag annotated on `fec1f2f`. Its notes name the changes to two new and four existing
  playbooks, and state that `RULES.md` changed only its procedures table.

**Raising the root** (`upgrade-template.md`):

- **Step 3:** mechanism matched the `v3.6.0` hashes.
- **Step 4:** six files replaced (`check.sh`, `RULES.md`, `RATIONALE.md`, `session-start.md`,
  `checkpoint.md`, `upgrade-template.md`) and six added (two playbooks, four package templates),
  plus `.template-hashes`. The root's `implementations/LOG.md`, created during the dogfood, already
  matches the release's preamble.
- **Step 5:** `RULES.md` changed only in its procedures table. The playbook changes are as named in
  the tag.
- **Scaffold**, by hand: INDEX's routing and artefact tables gained the package rows, and both
  checkpoints were rewritten where they named versions.
- **Step 7:** `check.sh` is clean, apart from this session being open.

## Decisions

- `ADR-014` accepted on the author's word.
- `v3.7.0` MINOR.
- `main` fast-forwarded only after the tag and the root raise.

## Next

Close issue #2 against `v3.7.0` (the author, from GitHub). Then the remaining design gaps: a home
for working decisions, an exit from staleness, a session-mode axis.
