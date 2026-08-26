# 2026-08-26 · Extracting the installer, and measuring what it changed

- **Status:** closed
- **Configuration:** Solo
- **Participants:** author — claude-opus-5 · high effort
- **Signed off:** no
- **Tags:** `#template` `#adoption`

> Opened at the start this time, and deliberately kept open across the extraction commit so that
> the experiment that follows belongs to the same session. The three preceding records were each
> forced by a close that turned out not to be the end — the case `Q-session-boundary` describes.
> Whether this is the repair or just a lucky guess is exactly what that question needs a week of
> evidence to say.

---

## Objective

Extract `install.sh` from `bootstrap-test.sh`, then measure — not assert — whether pointing at a
script instead of restating it reduces the number of texts a change to the install must touch.

## Reasoning

### The extraction

The boundary is the whole design: `install.sh` performs what has one correct answer derivable
from its arguments and the tree, and reports what it deliberately did not do. It never guesses.
An unset `user.email` is reported rather than invented, because `RULES.md` makes an empty one a
stop — an address taken from commit history names the wrong person in every `Held by:` written
afterwards, and nothing later distinguishes that from a correct one.

`bootstrap-test.sh` now calls it. A gate that reimplements what it gates tests its own copy and
passes while the thing it stands in for is wrong, which is what
`EXP-2026-08-26-prose-script-restatement` found. `skeleton/README.md` was rewritten to point:
the mechanical steps are described nowhere in prose now, on purpose, and the script is named as
the place to read if you would rather install by hand.

Two costs, both worth recording because both are evidence for the experiment below:

- **The rewrite broke nine cross-references** to "`skeleton/README.md` step N" across three files
  — the handbook, `install.sh` and `bootstrap-test.sh`. Removing the numbered list removed the
  citation surface other documents had been using. All nine were repaired.
- **The self-naming marker caught a third tool.** `install.sh` counted `check.sh` among the files
  carrying `<<FILL>>`, because `check.sh` names the marker in order to count it. `check.sh`
  excludes itself, `bootstrap-test.sh` had to learn the same exclusion on 2026-08-26, and now so
  did the installer. Three tools, three independent rediscoveries of one property.

### The experiment's design, settled before it was run

The naive form — invent a change, apply it before and after, count edits — is unusable here,
because the change would be chosen by someone who knows the hypothesis. The form used instead
replays a change that was **already queued and chosen for other reasons**: Gap 4, making the
install perform README's checkpoint rename. It was recorded yesterday as a defect found by
measurement, before extraction was proposed, and it has to be done regardless — so the
measurement costs nothing and is not steered by wanting an outcome.

The "before" number is not a reconstruction. `d974970` is a change to the install procedure made
*before* the extraction, and git records which texts it touched: `skeleton/README.md` and
`bootstrap-test.sh`. Two.

**What would kill the hypothesis:** an "after" count greater than or equal to two. That is a live
possibility rather than a formality — the nine broken references above are the mechanism by which
extraction could relocate cost instead of removing it.

**The two numbers must not be conflated.** The one-off cost of extracting (six files edited, one
added, nine references repaired) is not the recurring cost of changing the install. Only the
second is what the hypothesis is about. Conflating them would repeat exactly the error that cost
the `RETIRED` claim yesterday.

### What the experiment returned

**It failed on its own metric, and the prediction was wrong by two.** Gap 4 required three files
where the baseline change required two: `install.sh` implements the step, `skeleton/README.md`
says what the install now does rather than leaves, `bootstrap-test.sh` asserts the result. The
prediction of one accounted for the implementation and forgot that changing what a script *does*
changes what the guide must *say*, and that a new behaviour needs a gate.

The handbook needed no edit, which was checked rather than assumed: it never mentions
`CHECKPOINT-thread.md`.

A second count, taken after the fact and recorded as weaker for that reason, points the other way:
the mechanical procedure appeared as one command block in `skeleton/README.md` and three
operations in `bootstrap-test.sh` before extraction, and appears in `install.sh` alone after. So
copies of one fact fell from two places to one while files touched by a change rose from two to
three.

Both can be true because **the metric was the wrong one**, and it was wrong in a way that was
visible in advance and not seen: counting files conflates duplicated facts with separated
concerns, and extraction moves cost in the second direction while removing it in the first. A
metric that rewards keeping concerns tangled cannot answer a question about duplication.

The correct response is not to swap in the second count and declare success. It was chosen after
seeing the first result, which is the manoeuvre that makes an experiment worth nothing. The
question it belongs to is pre-registered in the record instead: does a change to the install's
*mechanism alone* — no instruction changed, no behaviour added — touch one file where it touched
two? Gap 4 could never answer that, because it added a behaviour.

## Decisions

- **`install.sh` extracted**, `bootstrap-test.sh` calls it, `skeleton/README.md` points at it and
  describes no mechanical step in prose. Registered `norcopy` in `MANIFEST`.
- **Gap 4 closed.** The install performs the checkpoint rename when given a thread slug, refuses
  it when the clone has no identity rather than writing a holder it guessed, and
  `bootstrap-test.sh` gates the result. Independent of the measurement, and correct regardless of
  how it came out.
- **`EXP-2026-08-26-install-extraction-cost` recorded, verdict `contradicts`**, marked
  `not verified`. The file-count metric is retired for this question, in the record, with the
  reason.
- **`Q-who-keeps-the-history` is not advanced by this run.** That mechanics belong to a script may
  still be right; this experiment does not support it, and the question's Progress says so rather
  than quietly keeping the extraction as evidence.

## Found along the way

- **The self-naming marker caught a third tool.** `install.sh` counted `check.sh` among the files
  carrying `<<FILL>>`, because `check.sh` names the marker in order to count it. `check.sh`
  excludes itself; `bootstrap-test.sh` learned the same exclusion this morning; the installer
  learned it this afternoon. Three tools, three independent rediscoveries, no shared mechanism —
  and each was found by running the tool, never by reading it.
- **Removing README's numbered steps broke nine cross-references** in three files. Repaired, but
  it is the concrete shape of how extraction can relocate cost rather than remove it, and it is
  why the kill criterion was a live possibility rather than a formality.
- **Keeping the session file open across a commit worked.** The three preceding records were each
  forced by a close that turned out not to be the end. One instance is not a repair, but it is the
  first evidence `Q-session-boundary` has.

## Next

- The pre-registered question: a mechanism-only change to the install, counted.
- The bump, still undecided, now over three mechanism changes and two rule changes.
- Of the original four install defects, one remains: GitHub's *Use this template* copying this
  repository's own memory. The other three are closed or addressed.
