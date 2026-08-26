# rnd-project-memory — Open Questions

- **Updated:** 2026-08-26

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

- **Priority:** 🔴 high · 🟡 medium · 🟢 low

> **`Owner:` takes a human name, not a git address.** It names who is accountable for the
> entry — a possession that outlives any clone — and is deliberately not the `Held by:`
> value, which names a temporary write claim and is bound to `git config user.email`
> (`ADR-012`).
>
> **`Owner:` is always filled in, even working alone.** Blank must mean *nobody has
> claimed this* — the signal the field exists to carry. If solo-era entries are left
> blank, that meaning is destroyed the day a second person joins.

---

## Q-unexercised-components · How do the never-exercised components get validated? 🟡

- **Raised:** 2026-08-17 · **Owner:** esdevop (human)
- **Source:** ADR-006
- **Question:** `experiments/` with `run-experiment.md`, `DATA_ENVIRONMENT.md`, `ingest-source.md`
  with `SOURCES.md`, and the `pre-commit` secret scan are exercised by neither this repository nor
  the originating repository. How is their design checked before a real project depends on them?
- **Why it matters:** These are the components written for the work context and never run in anger.
  They are simultaneously the least tested and the ones whose failure is least recoverable — a
  secret scan that does not fire is discovered after the secret is in history.
- **Progress:** Partially answered. `experiments/_TEMPLATE.md` has now been used three times, by
  this repository, which exposed that it is fitted to data-analysis runs: 5 of its 8 reproducibility
  fields came back `n/a`. Not necessarily a defect, but it is why the template now requires `n/a`
  over a blank. Still unexercised: `DATA_ENVIRONMENT.md`, `ingest-source.md` with `SOURCES.md`, and
  the hook *firing on a real secret* — `EXP-2026-08-17-pattern-list-extraction` tested grep's
  behaviour on an empty pattern, which is adjacent but not the same thing. The hook can be tested
  directly and cheaply against crafted staged content, without a project. The rest plausibly cannot
  be validated before first real use at work, which makes the first work project a deliberate pilot
  rather than an adoption.
  Partly answered on 2026-08-25 by an external adoption trial, and not in the direction expected:
  the components that failed were not the ones named here. They were in the *installation* — a path
  this repository never takes — and that region now has an instrument (`bootstrap-test.sh`,
  `ADR-008`). The four components above remain unexercised; the trial did not reach them.

## Q-who-keeps-the-history · Who executes the record when the assistant is unavailable? 🟡

- **Raised:** 2026-08-26 · **Owner:** esdevop (human)
- **Source:** `sessions/2026-08-26-who-keeps-the-history.md`
- **Question:** Every write mode in this system — the rewritten checkpoint, the contemporaneous
  session file, the register deletions, the `LOG.md` row — is described as work an assistant does
  with a human steering. What happens to the record when the assistant is not available: a monthly
  credit ceiling reached, an outage, a workplace that withdraws the tool? Is there a defined
  reduced mode a human executes alone, and what does it cost?
- **Why it matters:** Ownership is already settled and is not what is at risk: `Held by:` is a
  human's `git config user.email` (`ADR-012`), `Owner:` is a human name, and an `ADR-` needs a
  named human's sign-off — the assistant is nowhere a subject of record. What is unsettled is
  execution. If the only practical path to a valid record runs through an assistant, the system
  has an availability dependency it never declared, and the failure is quiet: nobody writes a
  worse record, they write none, and the gap is indistinguishable from a quiet fortnight.
- **Progress:** Three candidate pieces, none tested.
  - **The executor is not binary.** Judgement (what has settled, what is unverified) is a human's;
    mechanics (`LOG.md` rows, dates, tags, the 150-line count, placeholder substitution) belong to
    a script and to nothing else; routing sits between and either can do it from §2's table. The
    ceiling only bites where mechanics still require an assistant — and `bootstrap-test.sh`
    already performs the whole mechanical install, so at least one such step is scripted today in
    a file labelled as a test.
  - **A criterion worth testing:** switching the assistant off makes the work *slower, not
    different*. Where the manual path yields a different artefact rather than a rougher one, the
    assistant is load-bearing rather than accelerating.
  - **A reduced mode, unspecified:** a session file in bullets, one `LOG.md` row, a rough
    checkpoint rewrite. Safe against this system's central failure only because both are
    immutable once written — a later assistant may structure around them but never restates them,
    which is the re-summarising the whole design exists to prevent.
- **What would answer it:** the manual path timed on a real session, against the same session
  performed with an assistant. Until that number exists, "a human can pick it up from any point"
  is an assertion, and the design cannot be steered by it.

## Q-oss-intake · Does the employer require an intake review for external open-source material? 🟢

- **Raised:** 2026-08-19 · **Owner:** esdevop (human)
- **Source:** ADR-005; the remaining part of the retired `Q-enterprise-access`
- **Question:** Is there a process for taking external open-source material into company work, and
  does an MIT-licensed documentation template need to pass it?
- **Why it matters:** Blocks nothing today and nothing for the author, who can already clone. It
  decides only whether a *colleague* needs a review before adopting, and running it once makes every
  later adoption routine.
- **Progress:** The licence exists and is MIT, which is what such a process asks for first. Not a
  question to answer from inside this repository.

## Q-contribution-flow · How do colleague improvements reach upstream? 🟢

- **Raised:** 2026-08-17 · **Owner:** esdevop (human)
- **Source:** ADR-005
- **Question:** A colleague improves the mechanism in an enterprise copy. By what route does that
  improvement reach this repository, given it was authored on company time and is company IP?
- **Why it matters:** Without an answer, either improvements are lost, or they are carried upstream
  informally and an IP question is created retroactively.
- **Progress:** Two candidate routes: keep such changes in the company profile layer only, where the
  question does not arise; or obtain explicit permission per change. Blocks nothing until a second
  adopter exists. Not a question to answer from first principles — it needs whoever owns the
  employment agreement.
