# ADR-011 · The bump level is steerable by wording, within one bound

- **Date:** 2026-08-25 · **Status:** accepted
- **Configuration:** Author + reviewer + sign-off
- **Participants:** author — claude-opus-5 · high effort; reviewer — esdevop (human)
- **Signed off:** esdevop — the decision; this text was written afterwards and unreviewed

## Context

`v2.2.0` settled its version number twice on how a rule was phrased rather than on what changed.

| Change | Wording | Bump |
|---|---|---|
| `.gitignore` ownership | cheap variant — marker warned, not required | MINOR |
| | structural variant — marker required | MAJOR |
| ADR template fields | "every ADR carries these fields" | MAJOR |
| | "new ADRs carry them; existing ones predate the requirement" | MINOR |

Same diff, same code, different number, chosen by the author. That is the shape of a criterion
that has stopped constraining anything — the same disease as a confidence column whose value is
assigned by the person being checked. Twice in one release is the point at which it is worth
deciding whether the criterion is weak or whether it is doing something the objection misses.

`ADR-004`'s discriminator is not about the diff. It asks a question about the **consumer's**
repository after an upgrade: *will my existing entries stop conforming?* The wording is what
determines the answer, because the wording is what determines the consumer's obligation:

| Wording | What the consumer must do |
|---|---|
| every ADR carries the fields | fill in seven existing files |
| new ones carry them, old ones predate the rule | nothing |

Those are two different releases with two different costs, and they deserve different numbers. The
criterion is not yielding to the author; it is forcing the author to decide whether they are
imposing retroactive work, and then pricing that decision. What feels like wordplay is the design
fork itself.

The real risk is elsewhere. If "declare an exception" is always available, **MAJOR becomes
unreachable** — every breaking change de-escalates behind a grandfather clause, and the version
number stops carrying the information §15 says it carries.

## Decision

**The bump level depends on how the rule is worded, and that is correct.** The wording is the
consumer's obligation, not a description of the diff.

**One bound. An exception that keeps a release MINOR must be inert or expiring.**

- **Inert** — it costs nothing downstream and nobody maintains two shapes. Old ADRs simply lack
  three informational fields that no code reads.
- **Expiring** — a fallback with a check beside it that keeps reporting that the old shape is
  still present, so the exception is a migration prop with an end rather than a permanent fork.
  An ignore file with no region marker is this: `upgrade-template.md` has a path for it and
  `check.sh` says it is missing every run.

**An exception that requires both populations to be supported indefinitely is not an exception. It
is a deferred MAJOR, and it is called MAJOR now** — by whoever is shipping it, not by whoever is
unlucky enough to be holding it in two years.

Both of `v2.2.0`'s cases were tested against this and pass, which is why the release is MINOR on
the criterion rather than on leniency.

This is the same discipline `ADR-010` applies one level down: an adoption note is legitimate only
when it names what would close it. A temporary allowance — in a record or in a release — is
legitimate only when it carries its own end.

## Alternatives considered

| Option | Why not |
|--------|---------|
| Treat the steerability as a defect; derive the bump from the diff | The diff does not determine what the consumer must do. The same code can ship with or without retroactive work, and only the wording says which. A criterion computed from the diff would price two different releases identically. |
| Forbid grandfather clauses; every rule binds all existing entries | Every field addition becomes MAJOR with a migration. Upgrades get expensive enough not to be performed, which §15 opens by naming as equivalent to having no upgrade path at all. |
| Leave it unstated, as it was | It has now happened twice in one release and was noticed only because someone was counting. The third time nobody notices it is the third time, and by then the pattern is precedent. |
| Bound it with a numeric limit — at most one exception per release | Arbitrary, and it prices the wrong thing. Two inert exceptions cost nothing; one permanent fork costs forever. |

## Consequences

- §15 carries the rule beside the discriminator it bounds, so it is read where the decision is
  actually made. `MIGRATIONS.md`'s "Cutting a release" step 3a applies it before tagging.
- `ADR-004` is marked `extended by ADR-011`. Its body is untouched — the discriminator it states
  is unchanged and still correct; what this adds is a bound on one way of satisfying it.
- `docs/decisions/_TEMPLATE.md` declares `extended by` in its `Status:` vocabulary. It was in use
  here before it was declared, which would have been a fifth instance of the pattern this release
  exists to close: a rule applied to an artefact that does not know about it.
- The judgement is not mechanical, and no check is proposed for it. "Inert or expiring" is a
  question a person answers at release time; what this ADR provides is that the question is asked
  in the same place the temptation appears.
- The rule was raised by the reviewer, and the author's objection concerned only where it should
  be recorded — an edit to `ADR-004`'s body would have broken the immutability rule this session
  had just enforced against `ADR-007`. The pointer edit resolves it, which is what the `Status:`
  line exists for.
