# 2026-10-26 · Slugs that name the objective

- **Status:** closed
- **Configuration:** Solo
- **Participants:** author — claude-opus-5-5
- **Signed off:** no
- **Tags:** `#template` `#adoption`

---

## Objective

At the author's proposal, make package slugs, and session slugs, name what the work is for.

## Reasoning

**Why the objective, not the solution.** A slug never changes (§4), and a plan revision may replace
the approach while the objective stands. A slug naming the approach turns false at the first
revision, and can never be corrected. A slug naming an activity or a person says nothing in a
listing and cannot be searched by topic. In `[S-adopter-snapshot-2026-10-25]`, 15 of 66 session
slugs named an activity (brainstorming, follow-up, review, continuity, walkthrough), and some named
a person instead of a topic.

**Sessions differ in one way.** The file is created before the focus is agreed, so its slug is
chosen early. Renaming it before the first commit costs nothing, the moment-it-is-free principle
the counter check already uses. After that, it is fixed.

**Not a check.** Whether a name states an objective is a judgement. A heuristic for the obvious
failures, a lone ticket number or a bare activity word, would misfire on legitimate slugs, and
`ADR-013` §4 forbids a warning that fires on correct records. Guidance only.

**Written in:** handbook §4 (the home: *For work, the identity is the objective*);
`plan-implementation.md` step 1; `session-start.md` *Open this session's file*; and `ADR-014`
point 1, still `proposed`.

**Applied to ourselves, honestly.** Several of this repository's own slugs from today name the
activity, not the objective: `dogfood-install-label`, `adopter-review-triage`,
`planned-threads-options`. So does the package `install-unreleased-label`, by half-naming its
solution. All are committed and keep their names, which is the rule's own cost made visible.

## Decisions

- The slug names the objective, for packages and sessions. Guidance, not a check.

## Next

`ADR-014` sign-off, then `v3.7.0`.
