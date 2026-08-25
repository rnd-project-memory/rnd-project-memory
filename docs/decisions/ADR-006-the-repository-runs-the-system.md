# ADR-006 · The template repository runs the system it defines

**Date:** 2026-08-17 · **Status:** accepted

## Context

The design decisions above were produced in sessions inside the author's private repository on an
unrelated subject. They would have been filed in that repository's session archive, where they are
noise to every future reader of it — the routing violation this system exists to prevent, being
committed by the project that defines the rule.

Beyond that: the versioning and migration machinery of ADR-003 and ADR-004 is the newest and least
proven part of the design, and it is only exercised by a project that lives through a version
change. A work project will not reach one for months; the originating repository never will.

## Decision

This repository adopts the system, with the artefact and the live memory kept in physically
separate directories:

```
RND_PROJECT_MEMORY.md    handbook — the product
skeleton/                the artefact that gets copied out
AGENTS.md                this project's entry point
docs/                    this project's settled conclusions
ai-sandbox/              this project's live memory
MIGRATIONS.md  MANIFEST  LICENSE  .template-version
```

The root memory layer is **vendored from this repository's own skeleton at a released tag**, with
its own `.template-version`. Work proceeds under the released version while the next one is
authored; when it ships, `upgrade-template.md` is run against the root — the first real migration,
performed by its own author, recorded as a session.

## Alternatives considered

| Option | Why not |
|--------|---------|
| Keep designing in the originating repository | Every design decision is filed where nobody will look for it |
| Root memory pointing directly at `skeleton/` | Editing a playbook would change the procedure mid-session, and the upgrade path would never be exercised |
| Root memory as a hand-synced copy of `skeleton/` | Two living originals inside one repository — the forbidden shape, at close range |
| Adopt the system only after v1.0 is finished | The machinery would ship unexercised, and "finished" has no definition here |
| Defer the `AGENTS.md` split so the first release manufactures a migration | Shipping a known-suboptimal v1.0 to create evidence is contriving it. A migration will arrive when a rule actually changes |

## Consequences

- The separation of `skeleton/` from the root memory is load-bearing, not cosmetic: without it,
  neither an assistant nor `rg` can tell a template file with placeholders from a live working
  file. `check.sh` scopes itself to `docs/` and `ai-sandbox/` from the repository root, so
  `skeleton/` falls outside it without modification.
- `check.sh` exists twice by design: in `skeleton/` as an artefact, at the root as a working tool.
- **Three `check.sh` false positives were found and fixed**, not the two first predicted. All had
  one root cause — the checks read instructional text as content: blockquote preambles,
  `<placeholder>` examples, and playbook prose all carry sample IDs. A latent bug was fixed
  alongside: the resolved-entry check piped through `sed`, so its `|| echo "clean"` branch could
  never fire.
- `ai-sandbox/DATA_ENVIRONMENT.md` is deliberately absent from the root memory. This project has
  no data environment, and by ADR-002's own criterion a file full of instructions for a stack it
  does not have would misdirect. The profile layer is optional when there is no stack.
- Dogfooding validates roughly half the system and cannot validate the other half —
  `A-dogfood-coverage`. A clean `check.sh` here is not evidence that the whole works.
