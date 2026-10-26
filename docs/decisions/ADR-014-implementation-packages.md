# ADR-014 · Changes executed by others run through implementation packages

- **Date:** 2026-10-26 · **Status:** accepted
- **Configuration:** Author + reviewer + sign-off
- **Participants:** author — claude-opus-5-5; reviewer and signatory — esdevop
- **Signed off:** esdevop — the decision and this text, 2026-10-26, given in conversation and
  recorded in `sessions/2026-10-26-v3-7-0-implementation-packages.md`

> **Does not license:** any claim that packages make a cheaper executor reliable. They make its
> failures visible and recoverable. Nor does it license a claim that the shape works in general:
> at the time of writing it has been exercised on fixtures and on one dogfood package
> (`IMP-2026-10-26-install-unreleased-label`), small, in the repository that designed it, with no
> revision or branch needed. Its first release has not shipped.

## Context

**The workflow being supported** (issue #2; the author, `sessions/2026-10-26-planned-threads-options.md`).
It is spec-driven development for spending tokens efficiently.

1. A capable model and a person discuss a design carefully until it is final and confirmed.
2. The capable model writes an execution plan of steps. Each step has a description and gates, the
   conditions whose fulfilment shows the step was implemented correctly.
3. Execution goes to cheaper models. Dependent steps run in sequence, and independent ones run in
   parallel on different executors.
4. The plan and its status are kept afterwards, so a reviewer can validate the work and the
   development can be reconstructed later.

**The author's requirements.** A gate's definition never changes. How it was fulfilled is recorded
beside it, because steps do fail partly, and without that record the task must be repeated to find
out why.

**What the template had.** Handbook §3 named the principle: the plan is a contract, artefacts are
fact, and status is read from artefacts, never from the plan's table. It had no file, template,
gate format, procedure or check for any of it.

**What one adopter built without it** (`[S-adopter-snapshot-2026-10-25]`, structure only). Plans
had a design part and a gated checklist. Gates were a command plus an expected value. Each item
carried `Status`, a `Handoff: mechanical | judgement` tag, `Stop` conditions and an observed-value
line. A local playbook covered handing work to a cheaper model when a credit ceiling was hit. It
worked well enough to keep, and it failed in ways that recur:

- **Status typed into the plan drifted.** One item read *done* and *not done* at once, while the
  thread checkpoint and INDEX disagreed with the plan.
- **Executors reported passes with nothing behind them.** An execution review found gates marked
  passed whose artefacts were absent. Re-running the gates caught it, and the marks did not.
- **Instructions were unclear, or not followed by a weaker executor**, the author reports.
- **Execution forced revisions and branches.** A corrections plan referenced its *original
  contract*, and a runtime-compatibility plan its parent step. That made three plans in one thread,
  none in INDEX's thread table.
- **Runtime instructions were copied into each plan**, and the design took more than half of a
  file an executor had to load to reach one step.

## Decision

**1. A change designed in one place and executed in another is an implementation package**,
`ai-sandbox/implementations/IMP-<YYYY-MM-DD>-<slug>/`. A change one session can finish needs none.
The slug names the objective, what will be true once the package is accepted, never the approach:
a revision may replace the approach, and the slug cannot change. Handbook §4 states this for
session slugs too. The dogfood package's own slug, `install-unreleased-label`, half-names its
solution. It predates the guidance and keeps its name.

**2. The package separates four things with four write modes.**

| File | Written by | Write mode |
|------|-----------|-----------|
| `DESIGN.md` | capable model and a person | fixed once a **named human** approves it; a change is `DESIGN.r<n>.md` |
| `PLAN.md`: step cards, dependencies, gates with expected values | capable model | fixed once released; a change is `PLAN.r<n>.md`, a full copy with `Supersedes:`, the reason and `Changed steps:` |
| `runs/<step>__<utc>.md`: one attempt, every gate's observed value, what blocked a failure, what was tried | executor | immutable, one file per attempt |
| `reviews/<step>__<utc>.md`: gates re-run, accepted or rejected | reviewer | immutable |

This is §1's separation, state against history, applied to delivery. The author's fulfilment field
is the per-gate block of an attempt report. It sits in a different file from the gate's definition
so that recording one can never alter the other.

**3. Status is derived, never typed.** `check.sh` derives each step's state from `runs/` and
`reviews/`: `accepted`, `passed`, `failed`, `blocked`, `running`, `rejected`, `inconsistent`,
`ready`, or `waiting on …`. A `judgement` step counts as done only when accepted, and a
`mechanical` one when it has passed. A report claiming `passed` over a failing gate is
`inconsistent`. A plan not yet released shows no executable step.

**4. A card is the executor's context budget.** `Read:` lists the design sections and files the
step needs, and the executor reads that, not the package. `Do not:` and `Stop if:` bound it: stop
and report rather than improvise. Runtime instructions are cited from `DATA_ENVIRONMENT.md` or
`playbooks/local/`, never copied.

**5. Gates carry expected values, and executors re-run what they build on.** The expected value is
what a weaker executor cannot invent. An incoming executor re-runs the gates of each dependency
before building, and a reviewer re-runs the gates of the attempt under review. That is the
adopter's own step that caught false passes, and the strongest rung of the independence ladder at
no model cost.

**5a. Review is a re-run in a clean checkout of exactly the report's commit**, never in the
executor's working tree. A gate that passed on uncommitted work under a `Commit:` lacking it would
pass again there and prove nothing. The reviewer runs every gate before reading the reported
values. It then reads the diff against `Produces:` and `Do not:`, asks whether each gate could
have failed, and checks the report's notes against the re-run. A package review maps every design
section to what delivered it, and directly checks each section no gate covered. This is the
procedure the dogfood reviews followed, written down because each part caught something or would
have.

**6. Plans change by new files, never by edit.** Executors end an attempt as `blocked` with the
reason, and the capable model revises from those reports. Unchanged steps keep their IDs and their
reports stay valid. A changed step gets a new ID, and an ID is never reused.

**7. A branch is a new package that blocks the step it unblocks.** Its `DESIGN.md` names
`Unblocks: IMP-…/S-<nn>`. The parent's revision adds the child to that step's `Depends on:`, which
may name a whole package, satisfied once that package is accepted.

**8. Links point backwards, written once, by the later record.** A design names its sessions, a
plan its design and session, an attempt its plan and session, a review its attempt and session, a
branch the step it unblocks. The forward direction is found by search, which works because a step
is always cited as `IMP-<YYYY-MM-DD>-<slug>/S-<nn>`. Mutable files (the checkpoint's `Plan:`, INDEX)
hold current pointers forwards.

**9. Packages are indexed by an append-only event log**, `implementations/LOG.md`, with one row
per `opened`, `revised`, `branched`, `accepted` and `abandoned`. Tags go on the `opened` row only,
from the vocabulary the session and experiment logs share. Each row's note names what the event
decided. The log is searched, never read whole, and it is checked before a new package is opened.

**10. Checks, not rules.** No rule enters `RULES.md` (`ADR-013`). What is detectable is checked:
log against directories, plan structure, a fixed file edited, an attempt report contradicting
itself, a link to nothing, and dependency state. It is checked while uncommitted, the one moment a
mistake is free to fix. A committed record is immutable, so a warning on it could never clear
(`ADR-013` §4). The procedures are `playbooks/plan-implementation.md` and
`playbooks/execute-step.md`, with review a section of the second.

**11. On acceptance the package stays**, as an immutable record of what was agreed, attempted and
accepted. A decision that outlives it is promoted, an ADR or `docs/` with `IMP-…` as basis. The
thread's checkpoint closes as usual.

## Alternatives considered

| Option | Why not |
|--------|---------|
| One plan file with status inline (the adopter's shape) | It mixes four write modes. Status drifts, a retry overwrites a failed attempt, parallel executors conflict on one file, and an edited gate is indistinguishable from an edited status. It produced every failure in *Context* |
| Plan fixed, plus a mutable `STATUS.md` | It separates the contract, but status is still one shared, edited file: parallel writes conflict, attempts are overwritten, and contradictions stay possible |
| Plan frozen, status only from per-item gate records, every revision a new plan (option C of the first round) | Close to the decision. Rejected as the *only* mechanism because it made a person-readable plan expensive to change. The decision keeps its immutability and adds revisions with stable step IDs |
| Issues, pull requests and CI as the tracker | Strong for teams, but it moves the record out of the repository, needs a platform and network, and a tool-agnostic template cannot assume it. A team-scale variant, not the default |
| A gate-runner script | `docs/constraints.md` allows two executables. Derivation and checks live in `check.sh` |
| Links in both directions | Impossible without editing closed records: the failure the frozen parallel session showed (issue #3). Search provides the forward direction |
| A `Thread:` or `Implements:` field on session records | A schema addition carried for what search already finds, once step IDs are cited in one form |
| Directory names `plans/`, `implementation_plans/`, `execution-plans/`, `work-packages/` | `plans` is narrower than a directory holding a design, attempts and reviews. `execution` leaves out design and review. Underscores break the directory style. `work-packages` rhymes with nothing here. `implementations/` pairs with `experiments/`: one answers a question, the other delivers a change |
| A `partial` gate verdict | An adjective that degrades. A gate passes or does not, and the fulfilment block says how far it got |
| One row per package in the log | It would need editing as state changes, which an append-only log forbids |

## Consequences

**More files per change**, in exchange for a record that survives retries, parallelism and
revision. Small changes skip packages entirely.

**`check.sh` grows a derivation of state.** If it is wrong, every executor picks the wrong step, so
`bootstrap-test.sh` exercises it on fixtures: an unaccepted judgement dependency, a whole-package
dependency, a self-contradicting report, a dangling link, and acceptance releasing dependants.

**Parallel executors in one working tree are not solved here.** Disjoint files avoid content
conflicts, but concurrent git operations in one clone still collide. Separate clones or worktrees
are assumed, and the plan's `Base:` names where each starts.

**What the dogfood showed** (`sessions/2026-10-26-dogfood-install-label.md`, thirteen findings).
Four steps ran on a cheaper model. Two of them ran in parallel worktrees, without conflict. All four
were accepted on first attempt after independent re-runs.

- Every defect found before release was in the plan's gates: one wider than its step, one that
  could not fail after commit. The template's guidance on gates grew from them.
- The playbooks were missing a base ref, the session-record duty of a subagent executor, the commit
  order behind `Commit:`, and the shape of a package review. All were added.
- One executor's report was right in every gate line and false in a note. Only the reviewer's
  re-run caught it, which is why review now checks a report's notes against the re-run as well.

**The principle in handbook §3 becomes concrete**, and the paragraph was rewritten. The adopter's
local playbook and plan shape informed it. Nothing of its content is copied.

**Untested at scale.** This record states the design as decided. Whether it holds under real use is
for packages, sessions and the adopter-review thread to show, and a correction goes into a later
ADR.

## Evidence and sources

- `[S-adopter-snapshot-2026-10-25]`, read structurally (`sessions/2026-10-25-adopter-example-review.md`).
- Issue #2 (*AI Handoff mechanism for implementation work*) and issue #3 (parallel sessions), both
  by the author.
- `sessions/2026-10-26-planned-threads-options.md`: options, evaluation, the author's intent,
  naming, and the build.
- `sessions/2026-10-26-dogfood-install-label.md`: log conventions, links, and the dogfood.
