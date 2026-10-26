# 2026-10-26 · Dogfooding implementation packages on the install-label fix

- **Status:** closed
- **Configuration:** Solo
- **Participants:** author — claude-opus-5-5
- **Signed off:** no
- **Tags:** `#adoption` `#template` `#distribution`

---

## Objective

Run the unreleased implementation-package flow on a real change before `v3.7.0` ships:
`install-path` finding 7, where `install.sh` records the last tag as the version of a skeleton that
has changed since that tag.

## Reasoning

**Where the package lives.** The root runs `v3.6.0`, which has no `implementations/`. The package is
opened in the root's `ai-sandbox/implementations/` anyway, since a package is content and its
directory is the project's. It uses the templates and playbooks in `skeleton/` directly, and
`bash skeleton/check.sh` for status. The root's mechanism files are not raised ahead of the release.
That stays the release's job.

**Package opened** as `IMP-2026-10-26-install-unreleased-label`, with an `opened` row in the root's
new `implementations/LOG.md`. `DESIGN.md` was drafted from `install-path` finding 7. It records
honestly rather than refusing, `T+<sha>` and `T+<sha>-dirty`, and adds a gate that installs from a
throwaway clone in three states.

**Dogfood finding 1: a draft plan read as executable.** Before `PLAN.md` was copied in, `check.sh`
reported *no PLAN.md* while the package was at the design stage. The playbook says to copy both
templates at opening, and this session had skipped it. Once copied, the template's placeholder
steps would have been listed as `ready`. A plan that is not released must offer nothing to
execute. Fixed in `skeleton/check.sh`: an unreleased plan gets structure findings only, plus the
line *not released — no step is executable*.

**The log's conventions, at the author's request.** The author asked for the implementation log to
carry the session log's search instructions, and whether tags apply. Each convention of the session
and experiment logs was weighed:

| Convention | Applies | How |
|---|---|---|
| append only | yes | already |
| search, don't read whole | yes | `rg` by topic, by tag, and by ID for one package's history |
| a hit points at the record, not the log | yes | the ID is the directory |
| the row names what was resolved | yes, per event | `revised` (steps and the report behind them), `branched` (child and step), `accepted` (what was delivered, the review, any question answered), `abandoned` (why) |
| tags, reused, singletons checked | yes, on `opened` only | a package's topic does not change, and tags on every event would inflate the counts |
| check before acting (from the experiment log) | yes | before opening a package; an `abandoned` row is complete knowledge |
| a link column | no | the ID is the path |
| backfilled rows, counters | no | nothing predates the log |

One vocabulary across the three logs, so a single `rg '#<tag>' ai-sandbox/*/LOG.md` covers a topic.
Applied: the skeleton log preamble and a `Tags` column, `check.sh`'s tag frequencies reading the
third log, `session-start.md`'s search line covering every `LOG.md`, and `plan-implementation.md`'s
search-first step plus `accepted`-row contents. The root's log was regenerated, with the package's
`opened` row tagged. The bootstrap fixture row gained the column, and the gate passes.

**Links, the author's question.** Which records point at which was evaluated (see the dogfood
reply). Within packages, and from checkpoint to package, the links already existed. Missing were
the links from design, plan, attempt and review to sessions, a template field for `Unblocks:`, and
any way for a parent's step to wait on a branch: `check.sh` would have shown it `ready`. The rule
adopted is that links point backwards, are written once, by the later record, and are found
forwards by search. Two-way links would require editing closed records, the issue #3 failure. Built
and committed (`3517b1f`):

- `Sessions:` and `Unblocks:` on the design, `Session:` on plan, attempt and review;
- `Depends on:` may name a whole package, satisfied by its `accepted` row;
- `check.sh` checks that every link in an uncommitted record names something that exists;
- two bootstrap gates;
- the rule written into handbook §3 and both playbooks.

No session-record field was added: canonical step IDs make the forward links searchable.

**The design documented.** `docs/decisions/ADR-014-implementation-packages.md` was written with the
full decision, its alternatives and its consequences, and status `proposed`. It is uncommitted until
the author signs it off, since `docs/` changes are reviewed before they land.

**Design approved** by esdevop, 2026-10-26, as specified. `Approved by:` was filled, and `Sessions:`
and `Unblocks:` were added to the draft before approval.

**Dogfood finding 2: a gate wider than its step.** S-02's draft gate demanded *no FAIL anywhere* in
`bootstrap-test.sh`. S-03 edits a mechanism file, which makes the hash gate fail until S-04
regenerates the list. So S-02's gate would have passed or failed depending on whether the parallel
S-03 had run. It was corrected before release, to count only S-02's own `version label` failures.
`plan-implementation.md` step 3 gains the general form: a gate tests its own step, and whole-suite
gates belong on a final step that depends on all the others.

**Execution, round 1: S-01 and S-03 in parallel.** Two Haiku executors, each in its own git
worktree, were given only the playbook's path, the step, and four environment facts. Each claimed,
worked, reported `passed`, and committed three commits on its own branch. Each listed its
difficulties, as asked.

- **`IMP-2026-10-26-install-unreleased-label/S-01`** was accepted after an independent re-run at
  `8592660`, in a detached worktree. The re-run gave 1 `ok` and 2 `FAIL`, matching the report.
  Fast-forwarded into `next`. Review `reviews/S-01__20261026T2200Z.md`.
- **`IMP-2026-10-26-install-unreleased-label/S-03`** was accepted after a re-run at `615a7eb` and a
  reading against design §2.4. Merged into `next`. Review `reviews/S-03__20261026T2210Z.md`.
- The parallel work produced no conflicts: disjoint files, separate worktrees. S-02 was then
  dispatched the same way.

**Dogfood findings 3–11, from the executors' reports and the reviews:**

3. **A vacuous gate.** S-03's G-03-2 checked the working tree for changes to a file. That is clean
   at any commit, so the gate could not fail once the work was committed. A gate must still mean
   something when a reviewer re-runs it at the report's commit. State it against a commit range or
   against content, not against working-tree cleanliness. The fault was in the card.
4. **No base ref.** Both executors' worktrees started from the default branch, where neither the
   playbook nor the package exists. Both fast-forwarded to `next` themselves. The plan header's
   `Runtime:` said *on branch `next`*, but `execute-step.md` never tells the executor to check out
   the plan's base. That needs a field, or a step zero.
5. **Who writes the session record.** `execute-step.md` step 2 tells the executor to name the step
   in its session record. An executor running inside another session, as a subagent, has no
   session record of its own, and was told not to edit the coordinator's. The playbook must say
   that such an executor reports to the hosting session, which records the step.
6. **The order behind `Commit:`.** Neither the playbook nor the template says to commit the work
   before running the gates, or that claim, work and close are separate commits. Both executors
   inferred the same order: claim, then work, gates run against the work commit, then close.
   That order should be written down.
7. **`Evidence:` for gates that produce only output.** Both wrote `—`. The template should say that
   `—` is right when the observed values in *Gates* are the whole evidence.
8. **Attribution.** The coordinator gave the first two executors a trailer naming the wrong model.
   This was the coordinator's error, not the template's, and it was corrected for S-02. The report's
   `Executor:` field carried the true model in both cases.
9. **`./check.sh` in an unreleased repository.** It is only true of the template repository while
   dogfooding, where the root's copy lags `skeleton/`. Not a template defect.
10. **Design imprecision found by a judgement review.** §2.4 places the risk of a `+<sha>` install in
    the hash comparison. The project's own hashes match it, and the risk is in migrations that
    assume `v<x>`'s files. The paragraph was accepted as cautious rather than wrong, and the point is
    recorded in the review for the next edit of `upgrade-template.md`.
11. **Card authoring.** S-01's gates grep for an exact message format, which the card stated only
    by example. One executor also found the *Stop if* for case 1 ambiguous: does a `bad` line count
    as stopping? `plan-implementation.md` should say that when a gate greps output, the card states
    the exact format the step must produce, and that *Stop if* names an observable condition.

The template edits for 3–7 and 11 wait until the package is accepted. S-04's gate expects the
hash list to change by exactly one line, and editing mechanism files mid-package would break it for
a reason outside the step: finding 2's coupling, met again.

**Execution, round 2.**

- **`IMP-2026-10-26-install-unreleased-label/S-02`** was accepted after a re-run at `df89093`. The
  same run showed two hash failures caused by S-03's edit, and S-02's narrowed gate passed
  correctly through them. Finding 2's fix, observed working.
- **`IMP-2026-10-26-install-unreleased-label/S-04`** was accepted after a re-run at `67ee69b`.
- The package was accepted against its design. Review `reviews/package__20261026T2255Z.md`, and an
  `accepted` row in the log.
- §2.4, which no gate covered, was checked directly. An install from `next` recorded
  `v3.6.0+67ee69b` and printed the `unreleased:` line, and that project's `check.sh` reported
  `ok all match v3.6.0+67ee69b`.
- All four executor worktrees were removed after merging. Each was checked to be clean and merged
  first.

**Dogfood findings 12–13:**

12. **A report true in its gates and false in its notes.** S-04's executor wrote that the bootstrap
    run *had FAIL lines that the gate does not look at*. The reviewer's re-run counted zero, and
    `pass` already implies zero. Every gate line was correct. A hallucination in prose, where no
    check reaches, caught only by re-running. This is the author's caveat 2, observed once.
13. **A package review has no single attempt.** Its `Run reviewed:` was written as prose, and the
    link check reported each word as a missing file. The record was corrected before commit, to
    `Run reviewed: —` plus a `Reviews:` field listing the step reviews, which the check now also
    resolves.

**Folded back into the template**, after acceptance so that no step's gate was disturbed:

| Finding | Change |
|---|---|
| 3 | gates must hold when re-run at the report's commit: test content or a commit range |
| 4 | `Base:` in the plan header; step 0 of `execute-step.md`, start from it |
| 5 | an executor inside another session names it in `Session:` and reports back, without editing it |
| 6 | three commits (claim, work, close); the work is committed before the gates run, and `Commit:` is that commit; the claim file is closed in place |
| 7 | `Evidence: —` when the observed values are the whole evidence |
| 11 | a gate that reads output gets the exact output stated; `Stop if:` names an observable condition |
| 12 | review checks a report's notes against the re-run |
| 13 | the package-review shape in the review template and playbook |

Field guidance was put in each template's blockquote, not in field values. A placeholder left in a
link field would otherwise be split into words by the link check: finding 13's mechanism,
anticipated. `bootstrap-test.sh` passes. `ADR-014`'s consequences and *Does not license* were
updated with what the dogfood showed. It stays `proposed` and uncommitted until the author signs it.

**Not changed:** finding 8 (attribution, the coordinator's error), finding 9 (only true of this
repository while dogfooding), and finding 10 (recorded in S-03's review for the next edit).

## Decisions

- Design approved by esdevop. Executors on a cheaper model, in parallel worktrees. The coordinator
  reviews each attempt by re-running its gates.
- Findings folded into the template only after the package was accepted.
- `ADR-014` stays uncommitted until signed off.

## Next

The author reads and signs `ADR-014`. Then `v3.7.0`: the root raised, `main` fast-forwarded, issue
#2 closed.
