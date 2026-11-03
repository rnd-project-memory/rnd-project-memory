# 2026-11-03 · Closing the install-path thread

- **Status:** closed
- **Configuration:** Solo
- **Participants:** author — claude-opus-5-5
- **Signed off:** no
- **Tags:** `#template` `#adoption`

---

## Objective

Close `install-path` by `checkpoint.md`'s rule: settled parts to `docs/`, what still hangs to one
open question, then delete the checkpoint. The author approved the `docs/` text and owner.

## Reasoning

Closed by `checkpoint.md`'s rule, each remainder to its single home:

- **Prohibitions → `docs/method.md`, *Known limitations*,** with `CLAIMS.md` rows, as the author
  approved:
  - the template does not make an assistant stop where it lacks information;
  - the install cost is a lower bound for installing, not for adopting;
  - no trend in register use across the marker-flag runs.

  The stale *No project has upgraded yet* became *one adopting project has upgraded*. The
  backup-bundle prohibition already lives in `ADR-015`'s consequences.
- **Finding 6 → `Q-prompt-phrasing-confound`** 🟢, Owner esdevop, as the author approved.
- **Gap 2 (`check.sh` cannot judge truth)** was already recorded as a boundary in `ADR-013` §6, and
  needs no entry.
- **Gap 3 (the recurring cost, untimed)** is already the open half of `Q-who-keeps-the-history`.
- **`CHECKPOINT-install-path.md` deleted.** It was removed from INDEX's thread table, and the focus
  and latest-session sections were rewritten.

The cost the checkpoint rule names is accepted: the thread's synthesis, nine weeks of state in one
place, has no other home. Its history remains in the sessions it cites, and in git.

## Decisions

- `install-path` closed.

## Next

`adopter-review`: the design gaps. A home for working decisions, an exit from staleness, a
session-mode axis.
