# IMP-2026-10-26-install-unreleased-label · Design

- **Status:** approved
- **Approved by:** esdevop · 2026-10-26
- **Thread:** `install-path`
- **Sessions:** `sessions/2026-10-26-next-branch.md`, `sessions/2026-10-26-dogfood-install-label.md`
- **Unblocks:** —
- **Supersedes:** —

> **The contract the plan is written against.** Drafted with the capable model, in sessions whose
> records hold the reasoning. It is approved by a named human, always: a design approved by nobody
> but its author has checked nothing. Then `Status:` becomes `approved`, and the file is never
> edited again. A change after approval is `DESIGN.r<n>.md`, with `Supersedes:` and a reason.

---

## 1. Goal

`install.sh` records in `.template-version` a version that is true for the skeleton it installed.
Today it takes the files from the working tree and the version from the last tag
(`git describe --tags --abbrev=0`). A skeleton changed since that tag is therefore recorded under
the tag's name, and `upgrade-template.md` later upgrades from a release the project does not have
(`install-path` finding 7, `sessions/2026-10-26-next-branch.md`).

## 2. Contract

### 2.1 Detecting a released skeleton

Let `T` be the last tag, found as now. The installed skeleton **is release `T`** exactly when both
hold in the source clone:

- `git diff --quiet T HEAD -- skeleton/`: no committed change under `skeleton/` since `T`;
- `git status --porcelain -- skeleton/` prints nothing: no uncommitted or untracked change.

### 2.2 The recorded version

The first field of `.template-version`:

| Source state | Recorded |
|---|---|
| released (2.1 holds) | `T`, unchanged from today |
| committed changes past `T` | `T+<sha>`, where `<sha>` is the short commit `skeleton/` last changed at, already computed as `sha` |
| uncommitted changes | `T+<sha>-dirty` |

The rest of the line (`skeleton @ <sha>  applied <date>`) is unchanged.

### 2.3 What the install says

When the skeleton is not release `T`, the install still completes (exit 0). It prints, among what
it did, one line naming the state:
`unreleased: skeleton/ differs from <T>; recorded as <label>`.

### 2.4 Readers of the version

- `check.sh` takes the first field verbatim (*Mechanism files* line), the `skeleton @` sha, and the
  `applied` date. All are unaffected by a `+…` suffix, so no change is needed.
- `upgrade-template.md` step 1 gains one sentence. A version carrying `+<sha>` sits between releases:
  upgrade as from `T`, and expect mechanism files to differ from `T`'s hashes where the unreleased
  skeleton changed them, comparing by hand before replacing.

### 2.5 The gate that proves it

`bootstrap-test.sh` gains a section. It makes a throwaway local clone of the source repository,
checked out at its latest tag, and installs from it three times:

1. as tagged, expecting the label `T`;
2. after committing a change under `skeleton/`, expecting `T+<that commit's short sha>`;
3. after an uncommitted change, expecting `T+<sha>-dirty`.

It exercises the installer itself and does not re-derive the label. The expected values are built
from the clone's own `git` output.

## 3. Out of scope

- Refusing to install unreleased content. See §4.
- The README's install instructions, the branch rule (`AGENTS.md`, *Branches*), and shallow-clone
  handling, which the installer already refuses.

## 4. Decisions and alternatives

- **Label, not refuse.** Refusing would break `bootstrap-test.sh`, which installs from an unreleased
  tree by design, and anyone who installs from a branch on purpose. The honest answer exists, so it
  is written down: *unreleased, past `T`, at this commit*. That is this template's own rule against
  a plausible answer where the true one is available.
- **`+<sha>` and `-dirty`.** They follow semantic-versioning build metadata and `git describe --dirty`,
  which a reader may already know.
- **Detection scoped to `skeleton/`.** Changes elsewhere in the repository, such as the handbook or
  this repository's own memory, do not change what an adopter installs.

## 5. Open questions

None at drafting.

## Does not license

That installing from an unreleased tree is supported, or that a `+<sha>` project can be upgraded
mechanically without comparing its mechanism files by hand.
