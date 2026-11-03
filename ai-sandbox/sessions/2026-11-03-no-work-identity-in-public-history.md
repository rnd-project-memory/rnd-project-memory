# 2026-11-03 · No work identity in public history, now or later

- **Status:** closed
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

**The guard, built and tested.**

- `skeleton/.githooks/identity.allow` is profile layer and ships empty, which checks nothing.
- `pre-commit` gains an identity check that runs before anything else, since a commit with nothing
  staged still records who made it.
- A new `pre-push` checks author, committer and tagger of every commit and tag about to be
  published.
- `check.sh` reports the guard's state, `install.sh` names it as left to the adopter, and `MANIFEST`
  lists both files.
- The rule is in `RULES.md`, with rationale in `RATIONALE.md`, setup text in the skeleton's
  `AGENTS.md`, and the handbook's §9 and §12.
- Tested on a scratch install: the empty list passes; an unlisted author is blocked; a glob passes,
  case-insensitively; at push, an unlisted tagger and an unlisted author are each blocked.
- `bootstrap-test.sh` gains five gates, and passes. Committed as `a744486`, a hash from before the
  rewrite.

**The rewrite.**

- A full backup bundle of the old history was written to the scratchpad. It contains the
  identities and is not to be committed.
- The rewrite ran on a separate clone, with `git filter-branch`, since `filter-repo` is not
  installed and nothing was downloaded. An env filter replaced both work addresses for author and
  committer, a tree filter replaced the address in the one record with a redaction marker, and
  tags were carried with `--tag-name-filter cat`. The four tags with a work tagger were re-created
  with the same target, message and date.
- The clone's remote was removed, refs and reflogs dropped, and objects pruned.

**Verified:**

- neither address and neither name occurs in any object;
- every author, committer and tagger is `esdevop@gmail.com`;
- the record carries the marker;
- all 114 commits changed hash.

**The first measurement was incomplete.** It counted 6 affected commits. Pairing old and new
commits showed the second address as author and committer of 15 more early commits, and every
commit changed. My filter had excluded addresses containing `gmail`, `noreply` or `example`, and
the second address evidently matched one of them. The rewrite matched exact addresses, so it was
not affected. The total is 21 commits and 4 tags. An under-counting filter is the instrument
failure this repository keeps warning about, met in my own check.

**The map.** Old to new hashes, keyed by author date, committer date and subject (unique across all
114), is in `ai-sandbox/results/history-rewrite-commit-map__20261103T163853Z.json`.
`results/README.md` explains it.

**A constraint met head-on.** `docs/constraints.md` said *two executables ship*. `pre-push` makes
it three, so the row is amended openly, along with the handbook's §12 count, rather than worked
around.

**This repository's own list:** `.githooks/identity.allow` names `esdevop@gmail.com`. The root's
hooks are vendored, so they enforce it from the next release, `v3.8.0`. Because this is a safety
fix for a cost already paid, it ships at once under the branch rule.

**Waiting on the author:** the sign-off of `ADR-015` and the `constraints.md` amendment, and the
go-ahead for the force-push.

**Sign-off and release.**

- The author signed `ADR-015` in the file itself. My edit script expected the unsigned line,
  failed on it, and a commit went ahead without the status change, because the commands were not
  chained. That commit was unpublished, and it was amended: status `accepted`, plus two
  `method.md` claims with `CLAIMS.md` rows.
- `v3.8.0`, MINOR, on `93b6264`. The tag notes name the new `RULES.md` rule and the
  `AGENTS.md` setup text.
- Root raised. `check.sh`, `RULES.md`, `RATIONALE.md` and `pre-commit` were replaced, and
  `pre-push` added and executable. The root's `AGENTS.md` now says the guard is on here, and
  `check.sh` reports *identity guard on (1 listed); user.email is listed*.

**Published.**

- `main` was fast-forwarded to `next`, and both were force-pushed with all 19 tags. The new
  `pre-push` checked every commit and tag going out, and passed them. That was its first real use.
- Verified from a fresh mirror clone of the remote: 118 commits and 21 refs; no occurrence of
  either address or either name in any object; every author, committer and tagger
  `esdevop@gmail.com`; the old `main` tip not reachable.

**Left for the author**, outside this repository:

- ask GitHub Support to purge cached views of the unreferenced old commits;
- check whether any issue or comment links an old commit, since such links keep it reachable;
- re-clone, or reset, any other clone made before 2026-11-03;
- delete the backup bundle in the session scratchpad when no longer wanted. It contains the
  identities.

## Decisions

- Option A, the rewrite, and the opt-in guard, as the author decided. `ADR-015` accepted.
- One closed record edited, minimally and visibly, under the binding constraint.
- `v3.8.0` released at once, as a fix for a cost already paid.

## Next

`install-path` findings 1–6, then the `adopter-review` design gaps.
