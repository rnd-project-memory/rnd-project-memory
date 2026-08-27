# ADR-013 · An instrument is chosen by detectability, and a rule is the last resort

- **Date:** 2026-08-27 · **Status:** accepted
- **Configuration:** Author + reviewer + sign-off
- **Participants:** author — claude-opus-5 · high effort; reviewer and signatory — esdevop
- **Signed off:** esdevop — the decision and this text

> **Does not license:** any claim that the rules in `RULES.md` produce a behaviour. They shift a
> distribution over readers we cannot enumerate. This ADR governs *when one may be written*, not
> what one achieves.

## Context

Three green starts against `v3.1.1` — one person, two assistants on different providers —
produced three different behaviours from the same documents. `v3.2.0` was the response: five
edits, two of which turn out to be wrong, in two different ways.

The `Owner:` stop-rule was written where a one-line check would have done, and it cost more than
it saved. Faced with a field it could not fill and a rule saying *ask*, the next assistant avoided
the register entirely — *"asking could block progress"* — and recorded the project's open
questions as prose in `docs/`, where nothing sweeps them. One wrong value in one field was traded
for an unused register.

The marker flags restate the same rule at seven points of use. No evidence supports them, and
some contradicts: the one marker that already carried its escape clause had it read and declined.

**What makes this contested is that the wrong response is the natural one.** A run misbehaves; a
firmer instruction is the obvious remedy; it costs nothing to write, and the run that prompted it
can never falsify it. Applied each time, the rule set grows to chase a distribution that will not
hold still: we can test two or three models, never all of them, and one model takes a different
path on the same prompt twice.

Left unstated, the working criterion is *"add a rule whenever something goes wrong"*, and it has
no stopping point.

## Decision

**1. The instrument is chosen by detectability, not by severity.**

| The failure is | Instrument |
|---|---|
| not detectable by any check | a rule in `RULES.md`, and nothing else can help |
| detectable, and catching it late is an acceptable remedy | an advisory check in `check.sh`. **No rule** |
| detectable, and catching it late is not a remedy | a blocking hook **and** a rule — the secret scan is the existing case |

The rule tier is not the mild one. It is the tier for failures nothing can see. Invention belongs
there because it is invisible, not because it is minor.

**2. A rule enters `RULES.md` only if all three gates hold.**

- **It is a property of the document.** The defect must be statable without naming a model or a
  run — "this sentence admits two readings", "this rule sits in a file no project receives".
  Finding it through one model is legitimate and is what the instrument is for; what is forbidden
  is a fix whose justification cannot be written down without the model in it. Test: write the
  defect in one sentence. If a model's name is load-bearing, it is an observation, not a defect.
- **No check could catch it**, or the failure is unrecoverable. A check is deterministic and
  applies to every reader and every run; a rule applies to neither with certainty.
- **It has one home.** Stated once in `RULES.md`, pointed at elsewhere, never restated. Two copies
  of a rule drift, and the copy at the point of use has not been shown to change anything.

**3. Evidence is read asymmetrically, in two directions.**

- **Failures generalise; successes do not.** One observed invention proves invention is possible
  and licenses a fix. One clean run proves nothing and may never be written up as "works" — only
  as "worked once".
- **Disagreement between providers is signal; disagreement between runs of one model is noise
  until it recurs.** Two providers are two draws from the population a document must survive; two
  runs are two draws from one distribution. Agreement is weak evidence in both cases — it may mean
  the document is clear, or that both readers share a bias.

**4. Every advisory warning must be clearable**, and disappear when acted on. A warning that fires
on a correct repository is not a weak warning, it is a lesson that warnings may be ignored —
priced already in `ADR-008`, where three such entries survived four releases and were fixed by
nobody.

**5. The elevation path is warning → blocking, never warning → rule.** They answer different
questions. A warning becomes a block when evidence shows the failure is unrecoverable in practice.

**6. Where neither a rule nor a check applies, the limit is recorded and left.** `check.sh` reports
clean on a repository of honest absences and on one of confident fiction; it sees that a blank was
answered, never whether the answer is true. That is a stated boundary, not a backlog item.

## Alternatives considered

| Option | Why not |
|--------|---------|
| Add a rule whenever a run misbehaves | What was being done. Unbounded, and it fits the model rather than the document. Two of `v3.2.0`'s five edits were made this way and both are defective |
| Make every rule a check instead | Impossible for the class that matters. No check judges whether an answer is true, and that is the failure the system exists to prevent |
| Test more models until behaviour is known | Converts a design question into a budget, and does not converge: one model is non-deterministic across runs, so no sample size settles it |
| Carry the rules in the markers, at the point of use | Tried in `v3.2.0`. The one marker that already carried its escape had it read and declined. It is also restatement, which this decision forbids |
| Leave it to judgement, case by case | The case-by-case answer is always "add a rule", because that is the cheapest thing to write and the hardest to argue against |

## Consequences

**This forbids acting on some real observations.** A single divergent run is not grounds for a
rule, even when the behaviour it showed is genuinely undesirable. The project will knowingly leave
some possible failures unaddressed, and that cost is accepted rather than mitigated.

**Two shipped edits must be revisited.** The `Owner:` rule fails gate 2 and becomes a check on
`@`; the marker flags fail gate 3 and are candidates for removal. This commits the project to
undoing work already released, which is the price of adopting a criterion after the fact rather
than before.

**`RULES.md` grows slowly and refuses most candidates.** That is the intent. A rule file that
accepts every good idea stops being read, and an unread rule is worth less than no rule, because
it looks like protection.

**The criterion cannot enforce itself.** No check catches a superfluous rule; nothing here is
mechanical. It applies only if whoever cuts a release reads it and applies it, which is the same
weakness every prose rule in this project has, and it is named rather than solved. The release
procedure's step 2b — *name the artefact that enforces the rule* — is where it will be felt.

**It changes what a release may claim.** A change made in response to an experiment is recorded as
addressing the defect the run exposed, never the behaviour it displayed, and a fix verified by one
clean run is written up as unverified.
