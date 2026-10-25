# 2026-10-25 · Triaging the adopter findings, and fixing the two plain defects

- **Status:** closed
- **Configuration:** Solo
- **Participants:** author — claude-opus-5-5
- **Signed off:** no
- **Tags:** `#adoption` `#template`

---

## Objective

Sort the six gaps in `CHECKPOINT-adopter-review.md` under `ADR-013`, deciding for each whether it is
a check, prose, a new home, or nothing. Then fix Gap 1's two plain defects in `skeleton/`.
Cutting a release is not in scope unless the author asks for it.

## Reasoning

**Gap 1, first defect: the tag check.** `check.sh` matched only the backticked `` `#tag` `` form.
Its fallback `|| echo "no tags yet"` could never fire either, because a pipeline's status is that
of `sed`, which succeeds on empty input. A log written with bare tags therefore produced an empty
section that read as clean. The check now reads table rows only, matches a tag with or without
backticks, and prints `no tags yet` when there are none. Against the adopter copy it lists the tags
instead of nothing. Against this repository its counts are identical to the old check's, diffed
line by line, apart from the backticks no longer being printed.

**Gap 1, second defect: install residue.** Two different shapes, so two different instruments.

- `CAVEATS.yaml`'s example entry was live YAML, so it counted in the `severity:` distribution and
  stayed an entry. It is now a comment, which removes the defect by construction with no check
  needed. This repository's own register already had it that way.
- `CHECKPOINT-thread.md` cannot be made inert: it is the file the adopter is meant to rename. The
  checkpoint-size section of `check.sh` reported it as `ok`, and the identity section skipped it
  by design, so no section ever reported it. The size section now reports it as `?` with what
  to do, and the warning clears when the file is renamed or deleted (`ADR-013` §4). The identity
  section's skip stays as it was. Its reasoning still holds: a placeholder is not a mismatch.

`bootstrap-test.sh` gains two gates. An install with no thread slug must get the new report, and
the named-thread install must not. Both exercise the installer an adopter runs. `check.sh` is
mechanism, so `skeleton/.template-hashes` was regenerated (one line, `check.sh`). The gate passes.

**Correction to `sessions/2026-10-25-adopter-example-review.md`.** That record gives the adopter's
tags as 152 distinct, 93 used once. The new matcher counts 151 distinct in the session log. The
earlier grep also matched a bare `#` in the file's heading. 93 stands. The record is not edited.

**Triage of Gaps 2–6 under `ADR-013`.**

| Gap | Detectable? | Instrument | State |
|---|---|---|---|
| 2 — INDEX *Current focus* grows | yes, line count | advisory check, plus `checkpoint.md` step 5 saying *rewrite* instead of *update*. The wording fixes an ambiguity in the document; it adds no rule | proposed; needs a threshold the evidence does not supply |
| 3 — no home for working decisions | no | a design question, not a rule or a check | open; one snapshot cannot tell a missing slot from a correct absence |
| 4 — staleness without exit | the count is; the rubber stamp is not | `STALENESS_LOG.md` exists to validate its own threshold, and this is the first outside evidence for that | input recorded; the decision is the author's |
| 5 — single-valued fields | yes, §12 distribution | extend the distribution check to `Configuration:`. Changing the schema is design | proposed |
| 6 — planned threads | partly | upstream design material | not started |

No rule enters `RULES.md` for any of them: none passes gate 2.

## Decisions

- Gap 1 fixed by two instruments: the `CAVEATS.yaml` example made inert by construction, and the
  checkpoint residue reported by an advisory, clearable check.
- The comments in `skeleton/check.sh` describe the adopter evidence in general terms. They do not
  cite `S-adopter-snapshot-2026-10-25`, which would not resolve in any project that installs them.
- Nothing released, and the root not raised. Both wait for the author.

## Found along the way

The old tag check could not have printed its own fallback. `cmd | sort | uniq -c | sed || echo`
takes the status of `sed`, which succeeds on empty input. So *no tags yet* was unreachable, and that
is part of why the empty section looked clean.

## Next

The author decides three things: Gap 2's threshold, whether Gap 1 ships alone, and the bump level.
Gap 5's check can then be built alongside.
