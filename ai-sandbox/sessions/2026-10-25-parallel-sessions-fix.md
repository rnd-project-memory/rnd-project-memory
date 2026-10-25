# 2026-10-25 · Asking instead of freezing another open session, inside v3.6.0

- **Status:** closed
- **Configuration:** Solo
- **Participants:** author — claude-opus-5-5
- **Signed off:** no
- **Tags:** `#adoption` `#template` `#versioning` `#upgrade`

> Opened after the template edits below were already made in this conversation. The record runs
> from that point and recounts the edits rather than having been written beside them.

---

## Objective

Fix `adopter-review` Gap 7 (issue #3) and ship it inside `v3.6.0`, which is not yet published. Move
the tag, and raise the root again.

## Reasoning

**One rule in five places.** The freeze instruction lived in `RULES.md` as the rule, in
`session-start.md` as the procedure, in `sessions/_TEMPLATE.md`'s preamble as a restatement, in
`RATIONALE.md`'s failure table, and in `check.sh`'s open-session message. Each one changed:

- `RULES.md` (the home): another `open` session file is not yours to change. Ask, freeze only on
  the person's word, never backfill.
- `session-start.md`: the section is renamed *Check for other open sessions*. Each match is
  listed and asked about. There are three outcomes: parallel, so leave it alone, and agree who
  writes a shared thread's checkpoint; interrupted, so freeze as before; no answer, so leave it
  open. The report gains a line for it. The grep is now anchored on the field, the way `check.sh`
  already was. The old pattern also matched `_TEMPLATE.md` and any prose mentioning the status.
- `_TEMPLATE.md`: its restatement became a pointer, per `ADR-013` gate 3.
- `RATIONALE.md`: a new paragraph explains why asking, and why *no answer* defaults to open. The
  failure-table row is corrected.
- `check.sh`: the message asks the question instead of presuming interruption.
- Handbook §7's `session-start.md` row names the behaviour, since the handbook is the authority.

**Under `ADR-013` this is a rule change, and a legitimate one.** Gate 1: the defect is a
contradiction between §3 and the playbook, statable with no model in it. Gate 2: no check can tell
a live session from an interrupted one. Gate 3: the rule has one home and pointers elsewhere. It
replaces a rule rather than adding one, and `RULES.md` does not grow in kind.

Issue #3's criterion, parallel is fine across different checkpoints, enters as the one condition
the playbook names for parallel sessions: a shared thread needs agreement on who writes its
checkpoint. Adding a `Thread:` field to session records, so the sweep could show it, was
considered and left out. It would be a schema addition carried for one report line, and asking
covers it.

**Bump stays MINOR.** Existing records all remain valid. The rule binds future sessions only.

**Checks.** The new grep, run against a fixture, finds a session whose field is `open` and skips
the template and a prose mention. `bootstrap-test.sh` passes. Hashes regenerated: five mechanism
files changed.

**The tag moved.** `v3.6.0` had been cut on `df46662` and was never pushed (`git ls-remote` showed
no such tag). It was deleted and re-cut, annotated, on `9dc48db`, with the notes extended to name
the `RULES.md` change. So the root-raise commit `ed1fbed` recorded a `.template-version` of `df46662`
that never shipped. That commit is left in history, not rewritten. This record and the corrected
`.template-version` say what happened.

**Raising the root again** (`upgrade-template.md`). Step 3: mechanism matched its hashes. Step 4:
five files replaced (`check.sh`, `RULES.md`, `RATIONALE.md`, `playbooks/session-start.md`,
`sessions/_TEMPLATE.md`) and `.template-hashes`. Step 5: the `RULES.md` diff is the one rule above,
and among the playbooks only `session-start.md` changed. Step 7: `check.sh` clean.

## Decisions

- Ask, never guess. With no answer, the file stays `open`.
- No `Thread:` field on session records.
- Re-cut the unpublished tag rather than cut `v3.6.1` on top of an unpublished `v3.6.0`.

## Next

Push `main` with `--follow-tags`, on the author's word. Then Gap 5.

