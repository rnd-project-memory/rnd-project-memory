# 2026-08-26 · Do the instructing documents say what v3.1.0 does?

- **Status:** closed
- **Configuration:** Solo
- **Participants:** author — claude-opus-5 · high effort
- **Signed off:** no
- **Tags:** `#template` `#versioning` `#upgrade`

---

## Objective

Audit every document that instructs, documents, specifies or templates against what `v3.1.0`
actually does — before any new project is started from it, so that the first adoption is not a
session spent fixing the guide.

## Reasoning

Two passes, because the previous audit established that one is not enough: a mechanical sweep for
stale strings, then reading for sentences that are grammatical, plausible, and false. Fourteen
findings; the sweep produced eight of them and the reading produced the six that mattered most.

### What the sweep found

- **§11 step 1** told the reader to write `.template-version` by hand and showed its placeholder
  format. `install.sh` writes it — release, skeleton commit, date, none of them a judgement.
- **§11 step 11** listed the mechanical tokens as work still to do. Step 1 substituted them.
- **§15** said *"you write the first"* of the two version files. No longer true.
- **§15** said an upgrade copies the paths `MANIFEST` marks `mechanism` — the exact omission
  repaired in `upgrade-template.md` this morning, still standing in the document that playbook
  defers to. The handbook is the authority; it was wrong and the playbook was right.
- **`MIGRATIONS.md` 2a** described `bootstrap-test.sh` as installing "exactly as
  `skeleton/README.md` says". It runs `install.sh` now — the installer itself, not a copy.
- **`check.sh`** cited "README.md's step 1"; the guide no longer has numbered steps.
- **`MANIFEST`** cited "step 3" for the token substitution.
- **`README.md`** — the root one, the only page a reader meets before deciding to adopt — did not
  mention that an installer exists.

### What only reading found

**The sharpest is a defect I created and could not see.** `MIGRATIONS.md` step 4 says to name
every changed rule *if the diff touches `ai-sandbox/RULES.md`*. `v3.1.0` changed no rule there and
two in `playbooks/checkpoint.md`. This is **the same blind spot as `upgrade-template.md` step 5**,
which I fixed hours earlier on the receiving end without once looking at the sending end. A rule
nobody names on the way out is a rule nobody diffs on the way in, and the two halves failed
identically and independently. Both now say to look in the playbooks.

**Three defects were in the install guide, hours old, mine.** A duplicated line — *"Run
`./check.sh` any time"* twice, three lines apart. Two paragraphs merged into one run-on by an
edit. And a usage line reading
`./install.sh ../my-project my-project you@example.org [first-thread-slug]`, offering square
brackets to be typed or not — in the guide whose subject is that a reader cannot tell which
brackets are literal. No check could have caught any of them, and none is subtle. They were
invisible because I wrote them.

**Two counts disagreed.** The guide said `grep -rn '<<FILL' .` while `check.sh` counts
`^<<FILL:`. In a consumer's repository the two agree; in any repository whose prose mentions the
marker they do not, and the guide teaches the shape a reader carries elsewhere. Anchored to match.

**§11 counted the seven blanks twice.** Step 7 writes `docs/problem.md`, which is four of them,
and step 11 then presents all seven as outstanding. Both steps were right about their own half and
neither knew about the other.

## Decisions

- **`v3.1.1` released**, PATCH, exactly as `v3.0.1` was: alignment of the instructing documents
  with a release that had already shipped. Nothing to do downstream; `check.sh` changes only in a
  comment.
- **The handbook was corrected against the playbook, not the reverse.** `§15` was wrong about
  `.template-hashes` and `upgrade-template.md` was right. The rule that the handbook wins governs
  the *skeleton*, not a repair the skeleton reached first.

## Found along the way

- **A symmetric defect is invisible from one side.** Fixing `upgrade-template.md` step 5 this
  morning made the release procedure's identical fault *less* likely to be noticed, not more: the
  receiving end now worked, so nothing failed. It took an audit that read both.
- **Every defect the reading found was in text written today.** The audit's value was not
  archaeology; it was looking at fresh work with the intent to disbelieve it.
- `check.sh` reported `clean` throughout, as it did during the previous alignment audit, and for
  the same reason: it matches strings, and none of these was a string that had been retired.

## Next

- The new-project experiment, on `v3.1.1`, from a session with no access to this one.
