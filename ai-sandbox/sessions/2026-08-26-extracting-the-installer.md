# 2026-08-26 · Extracting the installer, and measuring what it changed

- **Status:** open
- **Configuration:** Solo
- **Participants:** author — claude-opus-5 · high effort
- **Signed off:** no

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

