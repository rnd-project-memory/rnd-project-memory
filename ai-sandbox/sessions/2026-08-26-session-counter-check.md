# 2026-08-26 · Enforcing the session-filename rule that had just been written

- **Status:** closed
- **Configuration:** Solo
- **Participants:** author — claude-opus-5 · high effort
- **Signed off:** no
- **Tags:** `#template` `#adoption`

> A short session, opened deliberately rather than by continuing the previous one. `d974970` had
> already run `checkpoint.md`, which ends a session; the work below arrived after that, so it gets
> its own record. The split was the point — see Objective.

---

## Objective

Give the session-filename rule corrected in `d974970` a mechanical check, in a separate commit, so
that the interval during which the rule existed only as prose is a fact in the history rather than
something folded invisibly into one tidy change.

## Reasoning

The previous session's rule change was correct and unenforced. §12 opens by saying that prose
rules aimed at a probabilistic executor decay, which makes "corrected in prose, not yet checked" a
state the system already classifies as temporary — so recording how long it lasted costs one
commit and answers a question later readers cannot otherwise settle.

The check had one real design problem. The obvious invariant — *a suffixed session file has a
same-date, same-slug sibling* — is violated by eight existing files and always will be, because
records are never renamed. Shipping it that way puts a permanent complaint in the output of every
run, which is precisely the cost `ADR-008` priced when it removed three entries from the hash
list: a check that fails on a correct repository teaches that failing checks are normal.

The resolution is to check **only session files not yet committed**. This is not a weaker version
of the invariant, it is a better-aimed one:

- it catches the mistake at the one moment fixing it is free — before anything cites the name;
- it says nothing about history, which is correct, because history is not a task;
- it works on a file written by hand as well as one written by an assistant, which matters for
  `Q-who-keeps-the-history`: a check survives the assistant being unavailable, a generator does
  not.

`check.sh` already had the precedent — its `docs/`-without-`CLAIMS.md` check looks at staged
changes rather than the whole tree.

Verified against four cases: nothing pending; a suffix with no sibling (reported); a suffix with a
sibling, which is the legitimate reopened-topic case (`ok`); and a plain filename (`ok`). The
second case is exactly the `-5` this repository wrote yesterday and a human caught by reading it.

One accepted false positive, stated in the comment: a slug that genuinely ends in a number.
Advisory output, so the cost is a question rather than a failure.

## Decisions

- **The check examines pending session files only.** History is not a task, and a check that
  complains about it permanently is worth less than no check.
- **§12's table updated in the same edit**, since it had just been corrected for exactly the fault
  of listing checks that no longer matched the script.

## Found along the way

- **The session boundary is awkward twice in one day.** The previous session was closed early and
  then written into; this one had to be opened for four lines of shell. `checkpoint.md` is
  described as runnable "at any point a reliable save is wanted", but closing is also what ends a
  session — so a save point and a session end are the same gesture with different consequences,
  and nothing distinguishes them at the moment of use. Not acted on: one day's evidence, and the
  cheap wrong fix is to license reopening a closed record, which would remove the only guarantee
  the archive has.

## Next

- The bump, now covering two mechanism changes and a rule.
- `install.sh`, which is where the prose-and-script duplication argument becomes testable rather
  than reasoned.
