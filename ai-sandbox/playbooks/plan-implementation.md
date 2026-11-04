# Playbook — Design a change and release its execution plan

For a change whose execution will leave the session that designed it: handed to a cheaper model,
split across parallel executors, or picked up later. **A change one session can finish needs no
package.** Design it and do it in that session, and record it there.

The division of labour is the point. A capable model and a person spend their tokens on the design
and the plan, where judgement is needed. Cheaper executors spend theirs on steps whose gates tell
them, and anyone checking afterwards, whether they are done. Follow the steps **in order**.

## 1. Open the package

Search `implementations/LOG.md` first (`rg -i "<topic>"`). The change may already have a package,
or an `abandoned` row saying why it was given up.

- ID `IMP-<YYYY-MM-DD>-<slug>`. **The slug names the objective, not the solution**: what will be
  true once the package is accepted, such as `honest-version-for-unreleased-installs`, not
  `add-sha-suffix` or `fix-install`. A slug never changes, and a revision may replace the approach
  while the objective stands, so a slug naming the approach turns false at the first revision.
  A ticket number goes in the design's text, not the slug. The ID is also the directory name:
  `ai-sandbox/implementations/IMP-<YYYY-MM-DD>-<slug>/`. A numeric suffix only breaks a genuine
  collision, the same rule as session files.
- Copy `implementations/_TEMPLATE/DESIGN.md` and `PLAN.md` into it.
- Add an `opened` row to `implementations/LOG.md`, with its tags. Tags go on this row only.
- The package belongs to a thread. Point its checkpoint's `Plan:` at the package directory, or open
  a thread for it (`checkpoint.md`).

## 2. Design, then approval

Discuss the design in session and write it into `DESIGN.md`, with numbered sections. The
reasoning, including paths rejected, belongs in the session record. The design holds conclusions,
and its `Sessions:` names every record where it was discussed, so *why* stays one hop away.

**Links point backwards, and are written once.** Each record names the earlier records it rests on
when it is written: a design its sessions, a plan its design and session, an attempt its plan and
session, a review its attempt and session, a branch the step it unblocks. A closed record is never
edited to point forwards, so the forward direction is found by search. That only works if IDs are
written the same way everywhere. A step is cited as `IMP-<YYYY-MM-DD>-<slug>/S-<nn>`, in session
records too.

**A named human approves it.** Set `Status: approved` and `Approved by:` with a name and date. From
then on `DESIGN.md` is fixed. A change is `DESIGN.r<n>.md`: a full copy with `Supersedes:` and the
reason, approved the same way.

## 3. Write the plan

From the approved design only. If writing a step needs a decision the design does not contain,
that is a gap in the design, not a choice to make in the plan. Return to step 2.

- **One card per step, small enough to have one outcome.** The card is the executor's whole
  context. `Read:` lists the design sections and files the step needs, and nothing else.
- **Every gate is a command or an artefact assertion, plus an expected value.** Without the
  expected value a weaker executor will supply one. A gate tests the result, not the process.
- **A gate must still mean something when re-run at the report's commit.** A reviewer re-runs it
  later, at that commit. Test content, or a commit range (`git diff A B`), never working-tree
  cleanliness, which is clean at every commit and so proves nothing after the fact.
- **When a gate reads output, the card states the exact output the step must produce**, not an
  example of it. A `Stop if:` names a condition the executor can observe, not a judgement.
- **A gate tests its own step only.** A gate on a whole-suite result, such as *no failures
  anywhere*, couples the step to every other step: it fails or passes depending on whether a
  parallel step has finished. Whole-suite gates belong on a final step that depends on all the
  others.
- **`Stop if:`** names where the executor must stop and report rather than improvise: an input
  that does not match, a decision the card does not settle.
- **`Handoff: judgement`** marks a step no gate fully decides. It counts as done only once
  reviewed, and a cheaper executor may run it but never accept it.
- **Order and dependencies.** Steps are listed in an order they can run in. `Depends on:` names
  earlier steps only, which keeps the graph free of cycles by construction. Independent steps run
  in parallel.
- **`Base:` names the branch every step starts from.** An executor's clone or worktree may start
  elsewhere, from the default branch, where neither the plan nor the playbook exists.
- **Runtime instructions are cited, never copied.** How to reach the data, run a job, or use a
  cluster lives once, in `DATA_ENVIRONMENT.md` or `playbooks/local/`. A plan that carries its own
  copy drifts from the next plan's.

## 4. Release

1. Run `./check.sh`. Its *Implementation packages* section reports a gate without an expected
   value, or a dependency that names no earlier step.
2. Read the cards as the executor will: one card, its `Read:` list, nothing else. Could a weaker
   model do the step from that alone? Where it could not, the card is not finished.
3. Set `Status: released` and `Released:`, then commit. The plan is now fixed.

## 5. During execution: revise, or branch

Executors never edit the design or the plan. They end an attempt as `blocked` and say why. Those
reports are what this step reads.

Revisions share one number per package, N, and `DESIGN.md` and `PLAN.md` are revision 0.

- **Revise the design** when it is wrong. Write `DESIGN.rN.md` as a full copy, approved by a named
  human like the first. **The moment it exists, execution stops.** `check.sh` shows no step
  `ready` until `PLAN.rN.md` (same N) is released with `Design:` naming it. Then write that plan.
- **Revise the plan alone** when the plan is wrong but the design stands: a gate that tests the
  wrong thing, a missing or mis-ordered step, a card too vague to follow. Write `PLAN.rN.md` under
  the next N, with `Design:` naming the design it still implements.
- **Either way, account for every step of the plan you supersede.**
  - `Carried steps:`, unchanged, keep their IDs. Their reports stay valid only if their meaning did
    not move. A carried step whose `Read:` cites a design section the revision rewrote has changed,
    whatever its card says, so list it under `Changed steps:` instead.
  - `Changed steps:` get new IDs.
  - `Dropped steps:` are gone, with the reason in the revision's text.

  `check.sh` reports any step of the superseded plan that is in none of the three.
- **Re-run the carried steps' gates** at the revision's base. Record them as
  `reviews/revision-rN__<YYYYMMDD>T<HHMM>Z.md`, with `Run reviewed:` set to `—`. A step accepted
  under the old plan is then accepted under the new one on evidence, not on habit.
- Release the plan as in step 4, and add one `revised` row to the log naming N and what changed.

**If a released file was edited in place**, which is exactly what this step exists to prevent,
`check.sh` reports it on the package's line. Recover:

1. restore the file from its release commit: `git show <release-commit>:<path> > <path>`;
2. put the change into the next revision instead;
3. commit both.

The reports citing the file are valid again, since they cite what it says once more. Nothing was
lost: the history kept the released text.
- **Branch** when execution uncovers work the design did not foresee, which must be done before a
  step can proceed. Open a new package, with its own design and plan, whose `DESIGN.md` names the
  step it unblocks: `Unblocks: IMP-…/S-<nn>`. Then revise the parent. The step's replacement in
  `PLAN.r<n>.md` adds the child to `Depends on:`, so `check.sh` holds it until the child is
  accepted. Add a `branched` row naming the child, and give the child its own thread if it resumes
  independently.

## 6. Accept and close

- When every step is accepted, write `reviews/package__<YYYYMMDD>T<HHMM>Z.md`: the package against
  its design. Then add an `accepted` row naming what was delivered, the review, and any
  `OPEN_QUESTIONS.md` entry it answered. A package given up gets an `abandoned` row with the
  reason.
- Promote what the design settled and the gates proved (`promote.md`): a decision that outlives the
  package becomes an ADR, and a method claim goes to `docs/` with `IMP-…` as its basis.
- Close or rewrite the thread checkpoint (`checkpoint.md`).
- **The package stays.** Design, plan revisions, runs and reviews are an immutable record of what
  was agreed, attempted and accepted, which is what lets a reviewer validate it and a later reader
  reconstruct it.
