# 2026-08-26 · v3.0.0 — the holder is the clone's git identity

- **Status:** closed
- **Configuration:** Author + reviewer + sign-off
- **Participants:** author — claude-opus-5 · high effort; reviewer — esdevop (human)
- **Signed off:** esdevop — `ADR-012`, reviewed alongside a plain-language walkthrough by the
  author; the migration itself executed afterwards and not separately reviewed
- **Tags:** `#template` `#versioning` `#upgrade` `#ownership`

---

## Objective

Draft `ADR-012` for review, then — once signed — execute the `v2.4.0 → v3.0.0` migration that
retires the declared per-person token and binds `Held by:` to `git config user.email`.

## Reasoning

The decision itself was settled across the two preceding sessions; this one wrote it down and
carried it out. Two things were still open when drafting began, and both were resolved in the ADR
rather than discovered during the migration.

**`Owner:` needed its own answer.** Retiring the token leaves `ASSUMPTIONS.md` and
`OPEN_QUESTIONS.md` with a field and no vocabulary. It is not the same concept — `RATIONALE.md`
has always said `Held by:` names a temporary state and `Owner:` a possession — so it takes a human
name, and one token becomes two conventions. That is a genuine cost of the decision and it is
written into `ADR-012`'s Decision section rather than left to be found by whoever next fills in a
register entry.

**The enforcement had to be described honestly.** A check comparing `Held by:` to the committer
passes for anyone who rewrites the field to their own address, which is exactly an unlogged
take-over. It catches the honest mistake and not the careless one. Stated in the ADR, in
`MIGRATIONS.md`'s Verification, and in the code comment, because a check whose limits are
undocumented is read as a guarantee within about a year.

The migration then ran mostly as planned. Two things it turned up:

- **`check.sh`'s retired-vocabulary check earned its keep immediately.** Adding `owner token` and
  `<owner>` to `RETIRED` flagged four files, two of which were prose written *this week* —
  `INDEX.md`'s own current-focus entry and `README.md`'s new Status paragraph, both describing the
  retirement using the retired words. Neither is a record describing a check, so both were reworded
  rather than left; the `v2.3.0` rule did not apply.
- **The placeholder-skip in the new check was necessary, not defensive.** `CHECKPOINT-thread.md`
  ships with `Held by: <your git config user.email>`, and `bootstrap-test.sh` sets a real address,
  so without the `<`-guard every clean adoption would open with a mismatch on the first line of
  output. Same trap `MANIFEST` names and this repository has now hit three times.

## Decisions

- **`ADR-012` accepted**, extending `ADR-007` rather than superseding it. The thread axis, the
  holder-writes rule and take-over-as-event are all unchanged; only the provenance of the field's
  value changes. `ADR-007` took the one edit an immutable record accepts — `extended by ADR-012`
  on its `Status:` line, body untouched.
- **MAJOR, and a migration section written.** Every live `Held by:` value stops conforming, which
  is `ADR-004`'s test. Steps cover the identity, the checkpoints, the `INDEX.md` table, the
  `AGENTS.md` deletion and the register conversion; Exceptions name what must *not* be rewritten.
- **Step 2 of the migration says to ask who holds each thread, not to derive it from the log.** The
  commit log names whoever last committed a checkpoint, which on a two-person project is regularly
  not its holder — deriving it would transfer the write right silently, which is the failure the
  whole release exists to remove.
- **`Q-held-by-identity-binding` deleted**, not marked resolved. Answered by `ADR-012`; the
  `LOG.md` row is what keeps the deletion discoverable.
- **The residual risk becomes `A-identity-is-the-person`** in `ASSUMPTIONS.md`, phrased as an
  assumption with what would settle it (signed commits, judged disproportionate) — a stated
  boundary rather than an open question, because nothing about it is unresolved.
- **`docs/glossary.md` gains two rows and loses one.** The retired term is replaced by `Held by:`
  and `Owner:` as separate entries, which is what the split into two conventions requires of the
  file whose job is settling what a word means.

## Found along the way

The two claims that landed in `docs/` this release were reviewed as a diff pass before commit, per
`RULES.md`. The `docs/method.md` addition (*a holder is named by the clone's git identity*) is
indexed in `CLAIMS.md` with `ADR-012` as its basis; the `docs/glossary.md` rewrite is definitional
and is not a claim, so it takes no index row — the same judgement recorded in the earlier glossary
session.

Worth noting for the next MAJOR: the whole of `v3.0.0` was produced by asking one plain question
about a two-person project and following what it exposed. Neither `v2.4.0` nor this release came
from a failure, a check, or an adopter's report. `README.md`'s Status says the multi-user half is
still reasoned rather than observed — that remains true, and it is now also the half that has
produced two releases in two days.

## Next

Nothing queued. `Q-unexercised-components` 🟡 is untouched by either release.
