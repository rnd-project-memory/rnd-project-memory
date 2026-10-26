# 2026-10-26 · Design options for planned threads and model handoff

- **Status:** closed
- **Configuration:** Solo
- **Participants:** author — claude-opus-5-5
- **Signed off:** no
- **Tags:** `#adoption` `#template`

---

## Objective

`adopter-review` Gap 6 and issue #2: lay out design options for plan files, validation gates and
handing implementation to a cheaper model, with a recommendation. The decision is the author's.

## Reasoning

**What the template already says.** Handbook §3 (*A thread with its own plan file stays thin a
different way*) and `RATIONALE.md` (*Delivery state resolves from artefacts*) give a planned thread
three homes: the plan as contract, run artefacts as fact, and the checkpoint header for distrust.
Status is read from artefacts, never from the plan's table. The skeleton carries a `Plan:` line in
the checkpoint template. **What it lacks:** a plan file name or template, any entry in the routing
or artefact tables, a gate format, an artefact convention, a handoff procedure, and any rule for
what happens to a plan when its thread closes.

**What the adopter built** (`[S-adopter-snapshot-2026-10-25]`, structure only):

- **Plan file:** a header (thread, holder, status, resume point, parent plan, evidence session),
  findings and fixed boundaries, Part A design, Part B an ordered gated checklist, and
  *Non-claims*.
- **Each item:** `Status`, `Handoff: mechanical | judgement`, dependencies, *Produces*, the
  implementation, `Gate` (a command plus an expected value), `Stop` (a condition that halts work),
  `Gate ✓` (the observed value) and `Done by`.
- **Handoff playbook:**
  1. Find the first item not `done`.
  2. Search project memory before declaring an unknown.
  3. **Re-run the last done item's gates before building on it.** A failing gate resets the item
     whatever its mark says.
  4. Honour the tag: a cheaper model may not mark a `judgement` item done.
  5. Record the switch as a configuration change.
  6. Annotate observed values and never collapse gates.

  It also states that a handoff licenses neither promotion nor sign-off.

**What went wrong there.** Status was typed into the plan, and it drifted. One item read both
*done* and *not done*, while INDEX and the checkpoint disagreed with the plan. An execution review
then found *passed* gates with no artefacts on disk. Step 3, re-running gates, is what caught it.
Other observations: three nested plans and a separate temporary design file under one thread, plans
up to about 1,100 lines, and none of them in INDEX's thread table. Issue #2 proposes the same
shape: a design, then `PLAN-<thread-slug>.md` with validation gates. It is the same author as the
adopter, so not an independent source.

**Constraint.** `docs/constraints.md` allows two executables. A gate runner is ruled out, and an
extension to `check.sh` is not.

### Options

| | A — name it | B — contract, evidence, handoff | C — immutable plan |
|---|---|---|---|
| Plan file | template for `PLAN-<thread>.md`, entries in the routing and INDEX tables | same as A | same, but frozen once released, like an experiment record |
| Where status lives | in the plan | in the plan, but a `done` mark must name an evidence path that exists | only in gate records, one per item, immutable. Status is derived |
| Drift | as the adopter had it | a mark without evidence is detectable by `check.sh` | impossible by construction |
| Handoff playbook | stays local | ships as `playbooks/handoff.md`, generalised from the adopter's | ships, same as B |
| Changing the plan | edit | edit, with dated amendments by the holder | a new plan file per revision |
| Cost to use | lowest | moderate | highest: many small files, and a revision means a new file |
| Bump | MINOR | MINOR | MINOR |

**Recommendation: B.** It keeps one plan file that a person can read and edit, which C does not.
It closes the failure the adopter actually hit, a `done` with nothing behind it, with a check
rather than a rule (`ADR-013`). And it ships the one procedure with direct evidence of value: the
re-run of the last gates caught false passes in practice. The handbook's line *status is read from
artefacts* survives as *the artefact is the authority, and the mark only indexes it*.

**Decisions B still needs from the author:**

1. One plan per thread, so that a nested plan opens its own thread and thread-table row, or
   several plans per thread? The adopter's one thread carrying three plans is the case against the
   second.
2. A separate design file, or design only as the plan's Part A? Settled decisions inside a design
   would go to an ADR either way.
3. What happens to a plan when its thread closes: deleted with the checkpoint, kept as an immutable
   record, or moved somewhere?
4. Does the `mechanical | judgement` tag ship as a field, or stay in the playbook's prose?

### The author's intent, given in this session

The author rejected the A/B/C framing as too narrow and stated the purpose. The design is
discussed carefully with a capable model until it is final and confirmed. That model then writes
an execution plan, so that execution can go to a cheaper model and tokens are spent where judgement
is needed. Each step has a description and gates as acceptance criteria. **A gate's definition
never changes.** Next to it, a separate field records how it was fulfilled, because steps do fail
partly, and without that record the work has to be repeated to find out why. Steps declare
dependencies: dependent steps run in sequence, independent ones in parallel on different
executors. The plan and its status are kept afterwards, so a reviewer can validate the work and the
development can be reconstructed later.

Caveats from the adopter, as the author gives them:

1. Step instructions were sometimes unclear, or not followed by a weaker executor.
2. Executors hallucinated and reported contradictions, the *done and not done* item found earlier.
3. Execution revealed the need to revise the plan, or to branch off it to overcome an issue.

The author's own view: this needs more organisation than one document.

### Further structure observed in the adopter's plans

Structure only, from `[S-adopter-snapshot-2026-10-25]`:

- The two large plans each carried their own copy of the runtime and construction instructions.
  Two copies of one procedure is the drift §2 forbids.
- Part A, the design, was more than half of each file, and an executor had to load it to reach its
  step. That loading cost works directly against the token saving the whole workflow exists for.
- A revision was a new plan file naming its *original contract*. A branch was a new plan naming its
  *parent plan* and the step it unblocked. Both shapes arose without template support.
- The last step of one plan was an owner acceptance step, and the release review was recorded in
  the plan, marked as *not worker completion evidence*.

### Evaluation: why one document fails this workflow

A single mutable plan puts four things with different write modes into one file:

| Content | Writer | When | Correct write mode |
|---|---|---|---|
| design | capable model + person | before release | fixed once approved |
| steps and gates | capable model | at release | fixed; a change is a revision |
| fulfilment | each executor | per attempt | create once, immutable |
| review | reviewer | after a step or phase | create once, immutable |

§1's diagnosis applies directly: mixing state with history in one file is the failure, and here
contract, history and verdicts share one file. Each of the three caveats follows from that.

- **A contradictory report** is possible because status is prose an executor edits in the same file
  as the contract. Nothing structural ties a *done* to the gate results beneath it.
- **A failed attempt overwritten** by the next one loses exactly the evidence the author wants kept.
- **Parallel executors** writing one file is the whole-file merge conflict the thread axis was
  built to remove (§3).
- **Revision inside the file** makes "the gate never changes" unenforceable. An edit to a gate and
  an edit to a status line look the same in the diff.
- **A weak executor loading the whole file** spends the tokens the split was meant to save, and the
  design's breadth invites it to improvise beyond its step.

### Organisations considered

1. **One plan file with status inline.** The adopter's shape. Fails on every point above.
2. **An immutable plan plus a mutable `STATUS.md`.** Separates the contract, but status is still one
   shared, edited file. Parallel writes conflict, attempts are overwritten, and contradictions stay
   possible.
3. **A work package directory.** An immutable design and plan, one immutable report per attempt,
   one immutable review per acceptance, and status *derived* from the reports by `check.sh`.
4. **Issues, pull requests and CI** as the execution tracker. Strong for teams, but it moves the
   record out of the repository, needs a platform and network, and is not what a tool-agnostic
   template can assume. Worth naming as the team-scale variant.

### Recommendation: option 3, a work package

```
ai-sandbox/plans/<feature-slug>/
  DESIGN.md                    spec; draft → approved (named human, date); fixed after approval
  PLAN.md                      step cards and gates; released, then fixed; carries no status
  PLAN.r2.md                   a revision: what changed, why, which report revealed it
  runs/<step>__<utc>.md        one per attempt, immutable: executor, plan revision, commits,
                               per gate: command, observed output, pass | fail, and on failure
                               what blocked it and what was tried
  reviews/<step>__<utc>.md     reviewer's acceptance: which gates were re-run, accepted | rejected
```

Each of the author's requirements has a home:

- **Fixed gate definitions.** They live in `PLAN.md` and are never edited. A wrong gate becomes a
  new gate ID in a new revision, citing the report that exposed it. `check.sh` can see a `PLAN.md`
  edited after its release commit: detectable, so a check, not a rule (`ADR-013`).
- **The fulfilment field** is the per-gate block of a run report, in a file separate from the
  definition. A failed attempt keeps its report, so the investigation starts from what was
  observed, without a re-run.
- **Dependencies.** Each card has `Depends on:`. Steps with no unmet dependency are free for any
  executor. Claiming is creating the run file with `Status: running`, the session-file lifecycle
  applied to steps, and the parallel-session rule carries over: another executor's `running` file
  is not yours to touch. Parallel executors write disjoint files, so they never conflict.
- **Review and reconstruction.** Reviews are records. When the thread closes, the checkpoint is
  deleted as usual, durable design decisions are promoted (ADR, `method.md`, `techniques/`), and the
  package stays as an immutable record, like `experiments/`. One `plans/LOG.md` row per package
  keeps it findable.

How each caveat is met:

1. **Unclear or unfollowed instructions.** A card is a context budget. It names `Read:` (design
   sections, files), `Produces:`, `Do not:` and `Stop if:`, and the executor reads that, not the
   package. Shared runtime recipes live once in `DATA_ENVIRONMENT.md` or `playbooks/local/` and are
   cited, never copied into plans. Each card is tagged `mechanical` or `judgement`, and a cheaper
   executor may not complete a judgement card. Before release, a structural check confirms every
   gate has an expected value, every `Depends on:` names a real step, and the graph has no cycle.
   The capable model is used for authorship, and the check catches the gaps it leaves.
2. **Hallucinated or contradictory reports.** `check.sh` checks a report against itself:
   - the outcome equals the conjunction of its gate verdicts;
   - each cited commit exists in git;
   - each cited evidence file exists.

   The incoming executor and the reviewer re-run the gates they build on, which is the adopter's
   own step that caught the false passes. A deterministic re-run is also the strongest rung of the
   independence ladder at zero model cost (`CONFIGURATIONS.md`).
3. **Revision and branching.** Executors never edit the plan. They end an attempt as `blocked`, with
   the reason. A **revision** is `PLAN.r<n>.md`: the capable model issues it, it names its reason
   and the changed or added step IDs, and unchanged steps keep theirs, so reports stay valid. A
   **branch**, work the plan did not foresee, is a new package naming the parent package and step it
   unblocks. That step is then blocked on the child's acceptance. A branch with its own resume
   point gets its own thread row, which is the adopter's untracked-plans gap closed.

**Identifiers.** Step IDs are allocated once, by one author, inside an immutable file, and never
reused by a revision. That is the case `ADR`s already justify, not the shared counter
`docs/constraints.md` forbids. Run and review files are named by step and UTC timestamp, with no
counter.

**When not to use it.** A change one session can finish needs no package. The package exists to
let execution leave the session that designed it, for another model, another executor, or later.

**Costs, stated.** There are more files per feature. The shape needs three templates and probably
two playbooks: authoring and releasing a plan, and executing a step, with review a section of one
of them. `check.sh` gains a status view and the structural checks. Handbook §3's planned-thread
paragraph must be rewritten, since the artefact directory it describes becomes concrete. This is
MINOR: new optional files, playbooks and checks, with existing records untouched.

**Open for the author:** the directory name, whether review needs a playbook of its own, whether a
`partial` verdict is wanted (recommended against: a gate passes or not, and the detail lives in the
fulfilment block), and whether the `DESIGN.md` approval requires a named human always or only for
judgement-heavy packages.

### Naming and indexing, from the author

The author asked for packages to be indexed like sessions, because their number will grow. They
found `plans/` too broad and proposed `implementation_plans/` or `execution_plans/`, to say these
are for implementing, not for future intentions.

**Recommended name: `implementations/`.** A package holds a design, a plan, attempt reports and
reviews, so a name containing *plans* is narrower than its contents. `implementations/` pairs with
`experiments/`: one answers a question, the other delivers a change, and both are dated, indexed,
immutable records. It also follows the directory style, which uses single plural words
(`sessions/`, `experiments/`, `playbooks/`, `results/`) and keeps hyphens for slugs. Underscores
appear nowhere.

**Indexing, mirroring experiments:**

- **Package ID** `IMP-<YYYY-MM-DD>-<slug>`, which is also the directory name. It sorts by date and
  is citable inline as `[IMP-…]`. `check.sh`'s dangling-citation check extends to `IMP-`.
- **`implementations/LOG.md`** is append-only, with **one row per lifecycle event**, not one per
  package: `opened`, `revised`, `branched`, `accepted`, `abandoned`. A package changes state over
  its life, and an append-only log may not edit a row. A search by ID returns a package's whole
  history.
- **`check.sh`** checks that every package directory has an `opened` row, and that every row names
  a directory that exists.

### The author's decisions, and the build

Decided by the author: the work-package shape; the name `implementations/` with IDs
`IMP-<date>-<slug>` and an event log; review as a section of the execution playbook, not a playbook
of its own; and `DESIGN.md` approval by a named human always.

Built on `next`:

- **Templates**, `implementations/_TEMPLATE/`: `DESIGN.md`, `PLAN.md`, `run.md`, `review.md`.
  They carry no `<DATE>` or `<PROJECT_NAME>` token. The install substitutes those in every file not
  named `_TEMPLATE.md`, so the templates install verbatim and can be hashed as mechanism.
  `implementations/LOG.md` is scaffold, like `experiments/LOG.md`.
- **Playbooks:**
  - `plan-implementation.md`: open, design, approve, write, release, revise or branch, accept.
  - `execute-step.md`: pick, claim, re-run dependencies, do, report, record a model change, and a
    section on reviewing.

  Both are added to `RULES.md`'s procedures table. No rule enters `RULES.md`. Executors never
  editing the plan is enforced by a check where it is detectable (uncommitted edits to a released
  plan), and otherwise lives in the playbook.
- **`check.sh`** gains *Implementation packages*:
  - log rows against directories;
  - plan structure (a gate without `→`, a step without a gate, a dependency that is not an earlier
    step);
  - fixed files edited while uncommitted;
  - uncommitted attempt reports against themselves (`passed` over a non-`pass` gate, a missing or
    non-existent `Commit:`, a missing `Evidence:` path);
  - each open package's step states, derived as `accepted`, `passed`, `failed`, `blocked`,
    `running`, `inconsistent`, `rejected`, `ready` or `waiting on …`.

  A `judgement` dependency is satisfied only by `accepted`. Dangling-citation checks cover `IMP-`
  in `docs/`.
- **The reports-only-while-uncommitted design** follows `ADR-013` §4. A warning on a committed,
  immutable report could never clear, so committed contradictions show as the `inconsistent` state
  instead of as a warning.
- **Where it is documented:** handbook §2 (routing), §3 (rewritten as implementation packages, with
  the write-mode table), §4, §6, §7 and §12; `RATIONALE.md` *Delivery state resolves from
  artefacts*; `INDEX.md`'s routing and artefact tables; `CHECKPOINT-thread.md` and `checkpoint.md`,
  whose `Plan:` now names a package.
- **Gates.** `bootstrap-test.sh` gains four: no findings on a fresh install; an unaccepted
  judgement step holds its dependant; a self-contradicting report shows as `inconsistent` and is
  reported; acceptance releases the dependant. It passes. A scratch fixture also exercised a
  revision (`PLAN.r2.md` picked over `PLAN.md`), a parallel step, a ghost log row, a fixed-file
  edit and acceptance hiding the package. On this repository and on the adopter copy the section
  reads `none`.

**Not done:** nothing released, and the root not raised; this waits for `v3.7.0`. Cycles are
excluded by construction (dependencies name earlier steps), not detected by graph search.

## Decisions

- Recorded above: name, IDs, event log, review section, named-human approval.
- No new rule in `RULES.md`.

## Next

Release `v3.7.0` with Gap 5 when the author wants it, then close issue #2 against it.
