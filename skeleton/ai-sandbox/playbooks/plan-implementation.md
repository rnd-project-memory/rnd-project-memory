# Playbook — Design a change and release its execution plan

For a change whose execution will leave the session that designed it: handed to a cheaper model,
split across parallel executors, or picked up later. **A change one session can finish needs no
package.** Design it and do it in that session, and record it there.

The division of labour is the point. A capable model and a person spend their tokens on the design
and the plan, where judgement is needed. Cheaper executors spend theirs on steps whose gates tell
them, and anyone checking afterwards, whether they are done. Follow the steps **in order**.

## 1. Open the package

- ID `IMP-<YYYY-MM-DD>-<slug>`, the slug named for the change. It is also the directory name:
  `ai-sandbox/implementations/IMP-<YYYY-MM-DD>-<slug>/`. A numeric suffix only breaks a genuine
  collision, the same rule as session files.
- Copy `implementations/_TEMPLATE/DESIGN.md` and `PLAN.md` into it.
- Add an `opened` row to `implementations/LOG.md`.
- The package belongs to a thread. Point its checkpoint's `Plan:` at the package directory, or open
  a thread for it (`checkpoint.md`).

## 2. Design, then approval

Discuss the design in session and write it into `DESIGN.md`, with numbered sections. The
reasoning, including paths rejected, belongs in the session record. The design holds conclusions.

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
- **`Stop if:`** names where the executor must stop and report rather than improvise: an input
  that does not match, a decision the card does not settle.
- **`Handoff: judgement`** marks a step no gate fully decides. It counts as done only once
  reviewed, and a cheaper executor may run it but never accept it.
- **Order and dependencies.** Steps are listed in an order they can run in. `Depends on:` names
  earlier steps only, which keeps the graph free of cycles by construction. Independent steps run
  in parallel.
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

- **Revise** when the plan is wrong: a gate that tests the wrong thing, a missing or mis-ordered
  step, a card too vague to follow. Write `PLAN.r<n>.md` as a full copy. Give it `Supersedes:`, the
  reason citing the report that showed it, and `Changed steps:`. A changed step gets a new ID, and
  unchanged steps keep theirs, so their reports stay valid. Release it as in step 4, and add a
  `revised` row to the log.
- **Branch** when execution uncovers work the design did not foresee, which must be done before a
  step can proceed. Open a new package, with its own design and plan, whose header names the step
  it unblocks: `Unblocks: IMP-…/S-<nn>`. The blocked step's next attempt depends on the child's
  acceptance. Add a `branched` row naming the child, and give the child its own thread if it
  resumes independently.

## 6. Accept and close

- When every step is accepted, write `reviews/package__<YYYYMMDD>T<HHMM>Z.md`: the package against
  its design. Then add an `accepted` row. A package given up gets an `abandoned` row with the reason.
- Promote what the design settled and the gates proved (`promote.md`): a decision that outlives the
  package becomes an ADR, and a method claim goes to `docs/` with `IMP-…` as its basis.
- Close or rewrite the thread checkpoint (`checkpoint.md`).
- **The package stays.** Design, plan revisions, runs and reviews are an immutable record of what
  was agreed, attempted and accepted, which is what lets a reviewer validate it and a later reader
  reconstruct it.
