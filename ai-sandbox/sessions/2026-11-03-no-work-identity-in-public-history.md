# 2026-11-03 · No work identity in public history, now or later

- **Status:** open
- **Configuration:** Solo
- **Participants:** author — claude-opus-5-5
- **Signed off:** no
- **Tags:** `#secrets` `#template` `#distribution`

---

## Objective

`install-path` Gap 4. The author chose to rewrite history (option A). Remove the work identities
from published commit, committer and tagger metadata, and from file content, then prevent
recurrence with an identity guard. The guard ships empty in the template and is filled in for this
repository, and it is documented where other assistants will read it.

## Reasoning

**Extent, measured before deciding** (identities compared by hash, never printed):

- The work identity is the author of 6 commits, `08fde8d`–`216a755` (2026-09-26), and the tagger
  of `v3.5.0`.
- A third address is the tagger of `v1.0.0`–`v1.2.0`. The author confirms it is employer-identifying.
- **The third address is also in file content.** It appears in one closed session record,
  `sessions/2026-08-26-clone-local-settings.md`, line 65, which quotes it as the identity a scratch
  clone inherited from global config. The line is present in 82 file revisions, every commit since
  2026-08-26. No commit message carries either identity.
- The repository has 0 forks and 0 stars. 45 commits follow the first affected one on `main`. About
  91 hash-like tokens in immutable records will point at pre-rewrite commits.

**A closed record must be edited.** Two rules collide. Records are immutable once closed, and
`docs/constraints.md` binds *nothing employer-identifying, including in history*. The constraint
is the harder limit, so it wins, and the edit is the minimum it requires. The address is replaced
by a visible redaction marker that names its date and reason. A silent change would make the
record misstate what it said, and the marker keeps it honest about having been changed. The rest of
the line, and of the record, stays as written.

**The same record decided against an identity check**, with *nothing added to `.githooks/pre-commit`
… blocking stays reserved for the one irreversible rule*. Its reason was that a false positive is
answered with `--no-verify`, which also disables the secret scan. That reasoning is answered here,
not overridden:

- published identity metadata is irreversible, the same class the secret scan exists for;
- the guard is opt-in, inactive until a project lists who may commit, so an unconfigured project
  has no false positives;
- a listed identity matches exactly, so there is no heuristic to cry wolf.

