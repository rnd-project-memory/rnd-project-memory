# 2026-08-27 · The independent arm, and what it did to yesterday's result

- **Status:** closed
- **Configuration:** Solo
- **Participants:** author — claude-opus-5 · high effort; esdevop (human) — ran the arm
- **Signed off:** no
- **Tags:** `#template` `#adoption`

---

## Objective

Read the second assisted arm — GPT-5.6 Luna, Copilot CLI, a different machine — against the same
frozen prompt, and record what it does to the pair.

## Reasoning

Yesterday's assisted arm supported the hypothesis and carried a caveat written into its own
record: same model family as the documentation's author, which `CONFIGURATIONS.md` rates *weak*.
This arm is the rung above. **It contradicts.**

The three sections the paragraph deliberately underdetermines were filled, confidently and in
detail — three numbered success criteria with named metrics, three stakeholder categories where
one was given, four scope exclusions. `OPEN_QUESTIONS.md` was left as the shipped template: zero
entries.

Not an oversight. The reasoning trace records the decision — *"The user didn't provide specific
prompts, so I can avoid creating new questions"* — and `docs/problem.md`'s own marker offers the
escape in so many words. It was read and the criteria were stated crisply instead.

**The trace is the most valuable artefact this experiment produced**, and it is a category of
evidence yesterday's arm did not supply. Three template defects were noticed and silently worked
around, each with a sentence: that `OPEN_QUESTIONS.md`'s example entry carries no marker and
"`check.sh` likely does not flag it" — correct; that a project without a `README.md` "might seem
odd … however, since the template is designed without one"; and that the template names `uv`
while lacking a `uv.lock`. Without the trace, all three would have been inferences about
behaviour rather than a record of a decision.

**One apparent invention is ours.** `AGENTS.md` naming a Python/uv stack is not fabrication: the
skeleton ships `DATA_ENVIRONMENT.md` asserting `uv` as fact, and `AGENTS.md`'s marker instructs
that whatever stack is named must match that file. The model obeyed a document that was wrong.
`ADR-002`'s criterion, turned on its author: this repository omits `DATA_ENVIRONMENT.md` for want
of a data environment and ships a skeleton that does not.

**The mechanism behind the whole failure is a layer mistake.** The rule the design rests on —
*"an assistant may fill these only from what you actually told it"* — exists in exactly one file,
`skeleton/README.md`, which `MANIFEST` marks `norcopy`. It never reaches a project. The markers
carry what to write and never the prohibition. Same shape as `v2.4.0`, where the instruction that
installs the secret-scan hook lived in the one file a second contributor never sees.

**And the boundary of the mechanical layer is now measured.** `check.sh` is clean on both arms —
one full of honest absences, one full of confident fiction. It can see that no marker remains and
cannot see what replaced it.

## Decisions

- **Recorded as a third experiment, verdict `contradicts`.** Yesterday's record is **not edited**:
  experiment records are immutable and corrections go into the next one. The pair is read in this
  record's Verdict.
- **The pair is not read as "one passed, one failed".** It is read as: the instruction not to
  invent is not load-bearing across providers, and a single run agreeing with it is not evidence
  that it binds.
- **Three findings added to the five already standing**, none acted on, for the same reason as
  yesterday: what the experiments found and what was done about it stay separable.

## Found along the way

- **An alternative explanation is untested and plausible.** The prompt says *"create a project"*,
  which invites completion. *"Adopt this template into a project"* might not. Interface is
  confounded too — Copilot CLI approves every command separately, Claude Code does not — so
  provider, interface and phrasing are three variables and two runs.
- **The independent arm was better than the same-family one at everything mechanical**: correct
  title, seven markers answered with no orphaned delimiters, `check.sh` clean. It failed only at
  the thing the experiment existed to test.
- **Second operand for the credit question:** 3.49 AIC for the assisted install, against 12:11 by
  hand.

## Next

- The eight findings, in one session.
- The two that outrank the rest: move the no-invention rule into a file that reaches a project,
  and stop shipping a stack as fact.
