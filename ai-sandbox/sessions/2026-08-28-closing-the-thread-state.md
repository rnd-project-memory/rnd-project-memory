# 2026-08-28 · Rewriting the checkpoint that had been patched instead

- **Status:** closed
- **Configuration:** Solo
- **Participants:** author — claude-opus-5 · high effort
- **Signed off:** no
- **Tags:** `#template` `#adoption`

---

## Objective

Leave the thread readable by a session that has none of this context, since the next one will
start cold.

## Reasoning

`CHECKPOINT-install-path.md` had been **amended in place across nine sessions instead of
rewritten**, which is precisely what the rule forbids: *rewrite the whole file, delete everything
no longer true, do not strike through*. Patching kept each new fact correct and let the old ones
rot around them.

What a cold reader would have been told, in the file's own *Current state* table:

- `check.sh` "not yet at the root, which runs `v3.0.1`" — the root has run `v3.4.0` since.
- "Release | none cut; bump undecided" — five have been cut.
- "Placeholder classes … named in `skeleton/README.md` **step 3**" — the guide has had no numbered
  steps since `v3.1.0`.
- And under *Do not do*: "do not remove the marker flags before Run 1" — Run 1 is done and the
  flags are gone, so the one section meant to stop a reader making a mistake was itself instructing
  a stale one.

Every individual edit was correct when made. The failure is that a rewrite-mode file was never
rewritten, and it is invisible while you are the one holding the context — the stale rows read as
familiar rather than as wrong.

**This is the shape the whole system exists to prevent**, found in the file whose write mode was
designed against it, in the thread that spent three days measuring how documents mislead readers
who were not there. `check.sh` reported it as `ok` throughout: it counts lines, and the file was
under the cap.

Rewritten whole. Eighty-five lines, only what is unresolved, and the publication state named in
`Resume from:` because two commits sit unpushed and that is the state of the break.

## Decisions

- **The checkpoint is rewritten, not patched again.** Where a fact still holds it is restated from
  the current tree rather than carried across.
- **No new check proposed.** `ADR-013`'s second gate would ask whether one could catch this, and a
  check for *prose that has stopped being true* is the same thing the retired-vocabulary check
  already fails at — twice on the record. It stays a rule that a person applies, and the failure
  mode is written into this record instead.

## Found along the way

- **The 150-line cap measures the wrong thing for this failure.** A patched file stays short while
  going stale; the cap catches accumulation, not decay. Not a defect in the cap — a limit worth
  knowing, since it is easy to read a green `Checkpoint size` line as the file being in order.

## Next

- Push. Then the six findings in Gap 1, which need no experiment.
