# ADR-015 · No work identity in public history: rewritten once, guarded from now on

- **Date:** 2026-11-03 · **Status:** accepted
- **Configuration:** Author + reviewer + sign-off
- **Participants:** author — claude-opus-5-5; reviewer and signatory — esdevop
- **Signed off:** esdevop — the decision and this text, 2026-11-03

> **Does not license:** a claim that the work identities are gone from the internet. The rewrite
> removes them from this repository's history as served from now on. Copies made before the
> force-push keep the old objects: existing clones, and the host's caches of unreferenced
> commits, which only the host's support can purge.

## Context

`docs/constraints.md` binds this public repository against employer-identifying content
*including in history* (`ADR-005`). On 2026-10-25 a work identity was found as author of six
published commits (`install-path` Gap 4). The measurement before the rewrite found more:

- A **work identity** was author and committer of 6 commits (2026-09-26) and tagger of `v3.5.0`.
- A **second work address** was author and committer of 15 early commits, and tagger of
  `v1.0.0`–`v1.2.0`. The author confirms it is employer-identifying. It also appeared in file
  content, in one closed session record (`sessions/2026-08-26-clone-local-settings.md`), quoted as
  the identity a scratch clone inherited from global config. That line was present in 82 file
  revisions.
- No commit message carried either identity. The repository had 0 forks and 0 stars.

The first measurement counted 6 commits, not 21. Its filter excluded addresses containing
`gmail`, `noreply` or `example`, and so missed the second address. The rewrite matched exact
addresses, so it covered them anyway. Recorded because a filter that silently under-counts is the
kind of instrument this repository keeps warning about.

**The cause is structural.** A clone with no local `user.email` inherits the global one, silently.
On a work machine that is the work address. The content scan in `.githooks/pre-commit` never reads
metadata. On 2026-08-26 the same record that quoted the inherited address also decided *not* to
add an identity check to the blocking hook, reasoning that false positives would teach
`--no-verify`, which also disables the secret scan.

## Decision

**1. History was rewritten, once.** Every commit, branch and tag, with `git filter-branch`:

- author and committer: both work addresses → `esdevop <esdevop@gmail.com>`;
- the session record's line: the address → *a work address [redacted 2026-11-03 under
  docs/constraints.md; see ADR-015]*;
- the four affected tags re-created with the same targets, messages and dates, and a personal
  tagger.

Verified afterwards: neither address nor either name occurs in any object, and every author,
committer and tagger is `esdevop@gmail.com`. `main`, `next` and all tags were force-pushed.

**2. One closed record was edited, minimally and visibly.** Records are immutable, but the
constraint is the harder limit. Only the address was replaced, by a marker naming the date and
this ADR, so the record states that it was changed. Nothing else in it moved.

**3. Old hashes are resolved by a map, not by editing records.** All 114 commits changed hash.
`ai-sandbox/results/history-rewrite-commit-map__20261103T163853Z.json` maps old to new, and
`results/README.md` says so. Records citing old hashes stay as written.

**4. An identity guard, opt-in, blocking.** `.githooks/identity.allow` lists who may author,
commit and tag:

- `pre-commit` checks the committing identity;
- a new `pre-push` checks the author, committer and tagger of everything about to be published,
  including rebased commits and tags, which no commit hook sees;
- an empty list checks nothing.

The template ships the list empty, and this repository lists its one author. `check.sh` reports
the guard's state on every run, and `install.sh` names it among what it leaves to the adopter. A
rule in `RULES.md`, in line with `ADR-013` (detectable, unrecoverable once published: hook and
rule): commit, tag and push only as a listed identity, never bypass, and never add an address to
get past it.

**5. The 2026-08-26 reasoning is answered, not overridden.** Its concern was false positives
teaching `--no-verify`. Opt-in removes them where nobody asked, and exact matches remove the
heuristic. What it did not weigh is that published metadata is irreversible, the class the
blocking hook exists for.

## Alternatives considered

| Option | Why not |
|--------|---------|
| Keep the history, amend the constraint to exempt past metadata | Leaves the employer association public permanently, against a constraint written as binding; and with 0 forks the rewrite was at its cheapest |
| Rewrite only the six commits found first | The measurement was incomplete; the second address was in 15 more commits, four tags and file content |
| `git filter-repo` | Not installed; installing would have meant a download. `filter-branch` covers commits; tags were re-created by hand |
| Edit the records to cite new hashes | Records are immutable; a map resolves old citations without rewriting what anyone wrote |
| An always-on identity check with a heuristic (e.g. "not a free-mail domain") | Fires on projects that never asked, and on legitimate addresses: the false-positive path to `--no-verify` the 2026-08-26 record warned about |
| Only a `pre-commit` check | Misses tags, rebased commits and anything committed before the list existed; `pre-push` is where publication actually happens |

## Consequences

- **Every hash cited before 2026-11-03 is stale.** That covers prose in sessions, `Commit:` fields
  in the dogfood package, and reviews. The map resolves them.
- **Clones made before the rewrite diverge.** Each must be re-cloned, or reset to the new
  `origin/main` and `origin/next` with tags fetched with force.
- **The host may still serve old commits by hash** until its caches are purged. That needs a
  request to the host's support, and it is the author's to make.
- **A local backup bundle of the old history exists** in the session's scratchpad. It contains the
  identities and must never be committed or pushed. Deleting it is the author's decision.
- **A third executable ships.** `docs/constraints.md` said *two executables ship: one advisory
  script, one blocking hook*. `pre-push` makes it three, and the row is amended in the same change,
  not worked around. It stays inside the constraint's purpose: plain shell over `git`, no tool, no
  dependency.
- **The guard travels with the repository.** `.githooks/identity.allow` is tracked, unlike
  `core.hooksPath`, so every clone that runs the hooks enforces it.
