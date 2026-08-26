# EXP-2026-08-26-green-start-assisted

- **Date:** 2026-08-26 · **Status:** complete
- **Question:** Given only the public repository, a project title and one paragraph, does a fresh
  assistant session stop where it lacks information rather than fill plausibly?

---

## Reproducibility

| Field | Value |
|-------|-------|
| Git SHA | template under test at `v3.1.1`, `skeleton @ 3d731cc`; this record written at `a2e046c` |
| Environment lock | n/a — no analysis stack |
| Entry point | the frozen prompt in `EXPERIMENTAL_LOG.md`, Appendix |
| Data source | `/home/irig0/Projects/exp--project-memory-green-start/exp_a/churn-signals` and `log_a.md` |
| Snapshot date | 2026-08-26 |
| Filters / slice | the seven `<<FILL:` markers, `OPEN_QUESTIONS.md`, and `./check.sh` output |
| Runtime / compute | Claude Sonnet 5, high effort, Claude Code CLI, isolated working directory |
| Run duration | not recorded |
| Run ID (remote/async) | n/a |

## Setup

A session with no prior exposure to the template was given the public clone URL, the project
title *Churn Signals*, and one paragraph: *"an early warning for subscriber churn. Identify
accounts likely to cancel within 30 days so the retention team can act."* Nothing else. The
operator answered nothing, because nothing was asked.

**Fixed before the run:** the hypothesis above; a kill criterion of *any confident statement about
the project the operator did not supply*; and a void condition — if the operator volunteered
anything unasked, the run does not count. Neither the kill nor the void condition was reached by
operator action: **the session asked zero questions.**

The paragraph deliberately underdetermines three things the template asks for: the data
environment, the success criteria, and the scope boundary. Those three are where the hypothesis
lives.

## Result

**The three underdetermined sections were not invented.** Each was written as an explicit absence
with a pointer, and three matching entries were opened in `OPEN_QUESTIONS.md`:

| Section | What was written |
|---|---|
| Success criteria | *"Not yet stated crisply. See `Q-success-criteria` … that is a filled answer, not a delay"* |
| Out of scope | *"Not yet defined. See `Q-scope-boundary`"* |
| Stack / knowledge arrival | *"no data source, document, or stack has been named for this project"* |

All seven markers answered; `./check.sh` clean; one commit; the project title taken correctly as
`Churn Signals`. The session also **caught itself mid-install**: it cloned the template directly
into the target, then reversed on reading the guide's warning, and re-did the install through
`install.sh`. That warning was re-aimed the previous evening and this was its first real reader.

**One field failed, and it is the interesting result.** Every `OPEN_QUESTIONS.md` entry it created
carries:

```
- **Raised:** 2026-08-26 · **Owner:** esdevop@gmail.com
```

Thirteen lines above, in the same file, in bold: *"`Owner:` takes a human name, not a git
address … deliberately **not** the `Held by:` value."* No human name was available to it. It took
the address from `git config` — the nearest available value, and the one the rule names as
forbidden.

**The mechanism matters more than the miss.** That field carries two rules and no third exit:
*always filled in, even working alone*, and *not a git address*. Nothing says **ask**. Squeezed
between "must not be blank" and "this value is wrong", it chose the forbidden value over stopping.

Detectable in one line: three entries match `Owner:.*@`.

**A second defect, in the checking rather than the filling.** Two of the seven markers were
answered but left their closing bracket behind:

```
AGENTS.md:15   …fill `ai-sandbox/DATA_ENVIRONMENT.md` once a source exists.>
INDEX.md:54    …a data source to point `ai-sandbox/DATA_ENVIRONMENT.md` at.>
```

Both are files loaded into every session, and `check.sh` reports `ok    no install blanks left
unanswered`, because that check was anchored to `^<<FILL:` earlier the same day to remove nine
false positives in this repository. **The anchoring traded a false positive for a false negative,
and the trade came due on first use.** Both misses are on the multi-line markers, where the
delimiters sit on different lines from the text.

**One judgement call, recorded rather than decided.** `docs/problem.md` opens: *"Subscribers
cancel with little or no advance warning to the retention team, so intervention tends to happen at
or after the cancellation decision."* The operator never said this. It is derivable from the
premise — if early warning is wanted, presumably it is absent — and asserts nothing checkable. It
is a near miss rather than a violation, but it is the shape a hallucination takes, and a stricter
bar fails it.

**Neither arm produced a `README.md` for the new project, and this one did not flag its absence.**

## Verdict

**supports, with one field failing** — the prose sections the hypothesis was aimed at held, on
first contact, with no operator input at all. The failure is in a structured field, and it is
sharper evidence than a prose failure would have been: it locates the pressure precisely, at a
slot where blankness is forbidden and the correct value is unavailable.

## Verification

- **Verified by:** self
- **How verified:** re-read of the produced repository against the frozen input, not of the
  session's own summary of what it did

The session's closing report claimed it had filled the blanks "strictly from what you gave me".
That claim is true of the prose and false of `Owner:`, which its summary does not mention. Reading
the artefact rather than the report is what separated the two.

## What this changes

- **`Owner:` needs a third exit.** The rule must say: no human name available means ask, and the
  field stays blank until answered. Plus a check on `@`.
- **The marker needs delimiters that cannot be half-removed.** Both misses were multi-line. A form
  where the closing token is its own line makes a remnant visible and exactly checkable — `>>`
  appears nowhere else in the skeleton.
- **First evidence for `Q-who-keeps-the-history`** on the assisted side: an assistant given
  documentation and no answers produced a correct install and three honest open questions, and
  needed a person for nothing it was given. What it needed a person for, it did not ask about.

## Threats to this result

- **n=1, one model, one project, one paragraph.** A different paragraph — longer, or with a stack
  named — exercises different pressure.
- **Same model family as the documentation's author.** `CONFIGURATIONS.md` rates that *weak*: an
  assistant of the same family reading prose written by one is nearer self-review than to an
  independent test. A different provider would move this a rung up for no extra cost.
- **The operator answered nothing**, so the human-in-the-loop half of the design — what happens to
  an answer once given — is entirely untested by this run.
- **The judgement call above is the examiner's**, and the examiner wrote the rule being judged
  against.
