# rnd-project-memory — Working Decisions

- **Updated:** 2026-11-03

> **Choices taken, too young for an ADR.** R&D runs on trials and repeats, so most decisions are
> not mature when they are made. A decision proves itself by holding, unchanged, while the work
> goes on. By the time it has held, the memory of why it was taken has faded, so it is written
> here **when it is taken**: what was decided, why then, what was rejected, and what would reopen
> it. An ADR written months later from memory records a conclusion without its reasons.
>
> **Not an assumption.** `ASSUMPTIONS.md` holds bets about the world, which evidence settles. This
> file holds choices, which people make. One adopter, with no home for choices, filed every one as
> an assumption with *user decision* as its basis.
>
> **Write modes.**
> - **Add** at the moment of deciding.
> - **Revise** in place when the decision changes. Reset `Decided:`, since maturity counts from the
>   last change, and say in the session record what it replaced.
> - **Move** a decision that has held into an ADR (`promote.md`). The ADR carries the reasons
>   written here, and the entry is deleted.
> - **Drop** a decision that was abandoned: delete it.
>
> Moving and dropping both delete, and the `sessions/LOG.md` row names the outcome. `check.sh`
> lists entries that have held unchanged for 28 days as ripe for an ADR. That number is a starting
> guess, not a measurement.
>
> **IDs are slugs**, `D-<slug>`, named for what was chosen. `Decided … by:` takes a human name. When
> none was given, ask the user who decided. The assistant is never the one who decided.

---

> **Shape of an entry.** Copy it below this line without the `> `, one per entry. It sits in a
> blockquote so that an untouched register reads as empty, and no check counts the example as an
> entry.
>
> ## D-<slug> · <the choice, in a line>
>
> - **Decided:** 2026-11-03 · **by:** <human name>
> - **Why now:** <what forced the choice at this point>
> - **Decision:** <what was chosen>
> - **Rejected:** <each alternative, and why not>
> - **Reopen if:** <the observation that would put it back in question>
> - **Basis:** <`sessions/…`, `EXP-…`, `S-…`, or `—`>

## D-current-focus-bound-15-lines · INDEX's Current focus is reported past 15 non-blank lines

- **Decided:** 2026-10-25 · **by:** esdevop
- **Why now:** an adopter's *Current focus* reached about 300 lines in a file loaded every session,
  and the shipped guidance of 2–4 lines lived only in a marker that answering deletes.
- **Decision:** `check.sh` warns past 15 non-blank lines, with blockquote guidance excluded.
- **Rejected:** no threshold, which is what let the adopter's grow. A threshold at the guidance's
  own 4 lines, which would warn on most honest rewrites.
- **Reopen if:** projects rewriting honestly keep landing between 10 and 15, or the warning is
  answered by trimming wording rather than by rewriting.
- **Basis:** `sessions/2026-10-25-v3-6-0-index-focus.md`

## D-batch-template-releases · Releases accumulate, except fixes for a cost already paid

- **Decided:** 2026-10-26 · **by:** esdevop
- **Why now:** two MINOR releases were cut in one day, and `v3.6.0` had to be re-cut when another
  fix arrived after it.
- **Decision:** improvements and diagnostics accumulate on `next`. A fix for a defect whose cost
  has been paid ships at once, as `v3.6.0`'s parallel-session fix and `v3.8.0`'s identity guard
  did.
- **Rejected:** a release per change, since each costs this repository a hash pass, notes, README
  status and a root raise. A fixed cadence, which would hold back urgent fixes.
- **Reopen if:** an adopter is harmed by a fix that waited, or a batch grows past what one review
  can read.
- **Basis:** `sessions/2026-10-26-next-branch.md`

## D-all-work-on-next · All work lands on `next`; `main` moves at a release

- **Decided:** 2026-10-26 · **by:** esdevop
- **Why now:** `install.sh` labels its install with the last tag. Unreleased skeleton work pushed to
  `main` would have been installed under the previous release's name.
- **Decision:** one working branch, `next`, for template and memory alike. `main` is
  fast-forwarded only at a release (`AGENTS.md`, *Branches*).
- **Rejected:** template work on `next` with memory on `main`, which would split every mixed
  commit, and leave session records describing changes absent from their own branch.
- **Reopen if:** a second contributor needs to work on `main`-based branches, or `install.sh`'s own
  `+<sha>` label makes the rule redundant. Since `v3.7.0` it records unreleased installs honestly.
- **Basis:** `sessions/2026-10-26-next-branch.md`
