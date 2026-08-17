# 2026-08-17 · Testing the profile remedies, and what they cost

**Status:** closed

> Third session of the day. Recorded retroactively, for the same reason as the first two.

---

## Objective

Settle `A-profile-indirection` by running the test its register entry named, then follow the
result wherever it went.

## Reasoning

Three experiments, each prompted by the previous one's stated threat.

**First**, the assumption's own test: rewrite `run-experiment.md` and `experiments/_TEMPLATE.md`
under the indirection and judge whether they still instruct. They do — both came out longer and
slightly better. But the reason was not the one the design predicted. Almost every stack mention
turned out to be a *concrete instance of a generic principle*, needing only that the principle be
stated with the instance kept as an example. Genuine deferral was needed twice in two files. The
audit's two-remedy split largely collapsed into one.

**Second**, the threat that closed the first: the two files where the content is a list of
patterns, where no generic form exists to state. The prediction was right about the mechanism and
wrong about the conclusion — no generic form is needed, because those files were never leaking in
the sense that matters. `dapi` is one of five vendors in a secret-scanning corpus, and vendor
enumeration is what such a corpus is. This produced the misdirection criterion, and a hard result
underneath it: extracting the pattern list into a profile file would leave an empty regex on a
missing file, which matches every line, blocks every commit, and trains the user into
`--no-verify`. Extraction would silently disarm the only blocking check in the system.

**Third**, the threat that closed the second: a criterion invented on the files it exonerates
deserves re-application to everything classified before it existed. It reclassified the nine
preamble files wholesale. A stale rule is not a wrong rule; what genuinely changes in those files
changes at MAJOR anyway; and the fence was internally inconsistent, adding markers whose only
consumer is a tool the design declines to build.

Two decisions followed rather than being tested. Step 4 survives, but on a different
justification — the cost of dropping it had been overstated, since thirteen other mechanism files
exercise the upgrade regardless, so the choice rests only on rule delivery, where a mechanism file
beats a migration. And ADR-004's gap turned out to be two gaps: which bump a rule change earns, and
the fact that a rule arriving by file replacement arrives silently and must be named in the release
notes.

## Decisions

- ADR-002 revised again: fencing withdrawn, four dispositions, the misdirection criterion, the
  profile appends to the secret-scan list rather than replacing it.
- ADR-004 revised: rule-change rows keyed on whether existing entries still conform; rule changes
  named in release notes at every level; `upgrade-template.md` gains a `RULES.md` diff step.
- Step 4 kept, reduced to the `AGENTS.md` → `RULES.md` split.
- `A-profile-indirection` confirmed and retired; `A-misdirection-criterion` raised in its place.

## Found along the way

- **An empty extended regex matches every line.** Reproduced rather than assumed, and it is what
  makes the pattern-list question decisive instead of a matter of taste.
- **The scope collapsed by roughly an order of magnitude** — from "eleven leaking plus nine mixed"
  to one profile file and five local edits. Both reductions came from asking what breaks rather
  than counting occurrences.
- **The experiment machinery got its first use**, and it does not fit non-data experiments well:
  5 of 8 reproducibility fields were `n/a`. The `n/a`-over-blank rule added during the first
  experiment is what keeps those records legible, which is a small argument that the rule is real
  rather than stylistic.
- **A criterion that keeps saying "less work" is suspicious.** Recorded as
  `A-misdirection-criterion` rather than resolved, because the honest defence is asymmetry — the
  omission is reversible — not confidence.
- **A third `check.sh` false positive** appeared when the fixes were applied: the EXP-citation
  check read a `<placeholder>` in `docs/method.md` and reported two experiments that never
  existed. All three had one root cause and one fix.
- **The handbook reconciliation found a live defect.** §9 embedded a copy of `.gitignore` that had
  drifted ten lines from the skeleton, seven of them the extracted-data extensions the same
  section forbids committing — so the handbook, which its own README declares authoritative,
  shipped a weaker guard than the skeleton. §6 states the no-copies rule twice and §9 broke it.
- **The first commit is not what ADR-001 assumed.** It added templates brought *from* the work
  project, later deleted wholesale. The provenance claim was restated to the weaker, true one.

## Next

Supersedes the sequence in `2026-08-17-ownership-audit-2.md`.

| # | Step | State |
|---|------|-------|
| 1–3 | Extract, licence and organisation, restructure | **done** |
| 4 | `AGENTS.md` → `RULES.md` split | **done** |
| 4a | README install defect | **done**, in CGS before extraction |
| 4b | Five local edits under the profile indirection | **done** |
| 4c | Three `check.sh` false positives | **done** |
| 5 | Bootstrap the root memory, tag `v1.0.0` | **done** |
| 6 | Seed the memory | **done** — this file is part of it |
| 7 | `MIGRATIONS.md`, `playbooks/upgrade-template.md` | `MANIFEST` landed; the rest outstanding |
| 8 | Enterprise copy | not before a real colleague needs it |

Outstanding beyond the sequence: the handbook still has no representation for ADR-002/003/004/005 —
a new §15 of roughly 70–90 lines, plus about 40 lines of edits across nine sections. That is the
largest remaining piece and the easiest to defer.
