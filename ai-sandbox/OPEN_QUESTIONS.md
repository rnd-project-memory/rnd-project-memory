# rnd-project-memory — Open Questions

**Updated:** 2026-08-17

> **Open questions only.** A question leaves this file in one of two ways, and both are
> deletions — status `Resolved` is never used, because a register of resolved entries is one
> nobody reads.
>
> **Answered** — the answer goes into the session record and, if durable, into `docs/`.
>
> **Obsolete** — it stopped mattering: the scope moved, the branch died, or the question was
> wrongly posed. Delete it with a `LOG.md` row reading *"dropped: no longer blocks anything"*
> and one clause of why. Projects abandon questions more often than they answer them, and
> without this exit the register fills with zombie 🟢 entries — the same landfill, built from
> dead questions instead of resolved ones.
>
> Either way the `LOG.md` row is what keeps the deletion discoverable.

**IDs are slugs, not numbers** — `Q-latency-budget`, not `Q3`. Deleting resolved entries
would pit and reuse a numbered sequence, so `Q3` cited in an old session file would later
resolve to a different question. A slug, once assigned, is never changed.

**Priority:** 🔴 high · 🟡 medium · 🟢 low

> **`Owner:` is always filled in, even working alone.** Blank must mean *nobody has
> claimed this* — the signal the field exists to carry. If solo-era entries are left
> blank, that meaning is destroyed the day a second person joins.

---

## Q-unexercised-components · How do the never-exercised components get validated? 🟡

**Raised:** 2026-08-17 · **Owner:** esdevop
**Source:** ADR-006
**Question:** `experiments/` with `run-experiment.md`, `DATA_ENVIRONMENT.md`, `ingest-source.md`
with `SOURCES.md`, and the `pre-commit` secret scan are exercised by neither this repository nor
CGS. How is their design checked before a real project depends on them?
**Why it matters:** These are the components written for the work context and never run in anger.
They are simultaneously the least tested and the ones whose failure is least recoverable — a
secret scan that does not fire is discovered after the secret is in history.
**Progress:** Partially answered. `experiments/_TEMPLATE.md` has now been used three times, by
this repository, which exposed that it is fitted to data-analysis runs: 5 of its 8 reproducibility
fields came back `n/a`. Not necessarily a defect, but it is why the template now requires `n/a`
over a blank. Still unexercised: `DATA_ENVIRONMENT.md`, `ingest-source.md` with `SOURCES.md`, and
the hook *firing on a real secret* — `EXP-2026-08-17-pattern-list-extraction` tested grep's
behaviour on an empty pattern, which is adjacent but not the same thing. The hook can be tested
directly and cheaply against crafted staged content, without a project. The rest plausibly cannot
be validated before first real use at work, which makes the first work project a deliberate pilot
rather than an adoption.

## Q-enterprise-access · What does the employer's GitHub actually permit? 🟡

**Raised:** 2026-08-17 · **Owner:** esdevop
**Source:** ADR-005
**Question:** Can the enterprise environment reach public GitHub at all, can it fork across the
boundary, and is there an intake process for external open-source material?
**Why it matters:** ADR-005 routes around the answer deliberately, so nothing is blocked today.
But it decides how a colleague physically obtains the template — self-service clone versus a
manual carry-in — and whether an intake review must happen before the first colleague adopts it.
**Progress:** GitHub Enterprise Server cannot fork from github.com at all — separate instances.
Enterprise Cloud with Managed Users very likely blocks it, as EMU accounts are isolated from
public GitHub. Enterprise Cloud without EMU may permit it subject to organisation policy.
Unverified against the actual configuration.

## Q-contribution-flow · How do colleague improvements reach upstream? 🟢

**Raised:** 2026-08-17 · **Owner:** esdevop
**Source:** ADR-005
**Question:** A colleague improves the mechanism in an enterprise copy. By what route does that
improvement reach this repository, given it was authored on company time and is company IP?
**Why it matters:** Without an answer, either improvements are lost, or they are carried upstream
informally and an IP question is created retroactively.
**Progress:** Two candidate routes: keep such changes in the company profile layer only, where the
question does not arise; or obtain explicit permission per change. Blocks nothing until a second
adopter exists. Not a question to answer from first principles — it needs whoever owns the
employment agreement.
