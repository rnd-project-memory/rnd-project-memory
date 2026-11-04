# 2026-11-04 · A plan revision follows its design revision, and an edited plan is seen

- **Status:** open
- **Configuration:** Solo
- **Mode:** implement
- **Participants:** author — claude-opus-5-5
- **Signed off:** no
- **Tags:** `#template` `#adoption`

---

## Objective

The author met this at work, in a project using implementation packages. The design was revised
mid-execution into `DESIGN.r1.md`, but the plan was changed in place in `PLAN.md`, so the reports
of steps already done no longer matched the plan they cite. Fix the template, and release, since
the cost is already paid.

## Reasoning

**What failed.** The template already forbids editing a released plan. An agent did it anyway, and
`check.sh` sees such an edit only while it is uncommitted. The author's proposal is that the plan
for `DESIGN.r1.md` be `PLAN.r1.md`. A first answer agreed and added a shared revision counter. On
the author's request it was re-examined against the scenario, and found to be insufficient alone:

1. Naming cannot stop an in-place edit. Detection can, and the edit can then be recovered from git.
2. While a design revision has no matching plan, executors must stop. `check.sh` was still marking
   the old plan's steps `ready`.
3. A step whose card did not change can still have changed in meaning, because its `Read:` cites
   design sections that the revision rewrote. No check can see that. So the revision author must
   say which steps carry, change and drop, and carried steps' gates are re-run at the revision.
4. A step can vanish from a revision without being accounted for. That is detectable.
5. A shared counter leaves gaps in design numbering after a plan-only revision. The gap is accepted,
   and explained by the log's `revised` row.

Also: the template titled the original plan *r1*, which would collide with the first revision's
`.r1` suffix. It becomes r0. And a plan may only rest on an *approved* design, which is checkable.

**Built.**

- **Templates.**
  - The original plan is revision 0, and its title loses *r1*.
  - The plan header gains `Carried steps:` and `Dropped steps:` beside `Changed steps:`.
  - The plan's preamble states the shared number and the pairing.
  - The design template says a revision is released with `PLAN.rN.md` and nothing executes until
    then.
- **`plan-implementation.md` step 5.**
  - Design revision: execution stops at once, until the paired plan is released.
  - Plan-only revision: takes the next N.
  - Every superseded step is accounted for, and a carried step whose `Read:` sections changed is
    a changed step.
  - Carried gates are re-run and recorded as `reviews/revision-rN__…`.
  - Recovery for an in-place edit: restore from the release commit, revise, commit.
- **`execute-step.md` step 1.** A halted package has no ready step: stop and report.
- **`check.sh`.** Any of these halts the package, and its line says why:
  - the latest design is ahead of the plan's `Design:`;
  - the plan rests on an unapproved design;
  - a released design or plan differs from its release commit.

  It also warns of an unpaired older `DESIGN.rN.md`, and of a step of the superseded plan found in
  neither the new plan nor its changed or dropped lists.

**Two mistakes of mine, both caught by the gate.**

- The first version counted commits since release, so restoring the file, itself a commit, never
  cleared the halt. That is a warning that cannot clear (`ADR-013` §4). It now compares content
  with the release.
- The vanished-step warning was written before the step loop reset `warn`, and was lost. Moved.

The gate itself first edited a released revision in place, and `check.sh` rightly halted it. The
fixture was corrected to check the accounting before the revision is committed.

**The gate.** `bootstrap-test.sh` plays the author's scenario: a released plan with one step
accepted; a design revision, which halts; `PLAN.md` edited in place and committed, which is
reported; restore plus `PLAN.r1.md` with a step missing from its accounting, which is reported;
then the accounting fixed, with the carried step still accepted and the revised one ready. It
passes.

**Recorded** as `D-paired-design-plan-revisions`, decided by esdevop. Documented in handbook §3
and §4, and a `RATIONALE.md` paragraph. The work project is described only in general terms.

**Released.** `v3.11.0`, MINOR, at once under `D-batch-template-releases`: a fix for a cost paid
at work. The tag names the two changed playbooks. `RULES.md` is unchanged. Root raised: `check.sh`,
`RATIONALE.md`, both playbooks and the design and plan templates replaced. This repository's one
package, accepted, shows no halt, since its released files were never edited. Saved, not closed:
the record stays open until the author ends the session.
