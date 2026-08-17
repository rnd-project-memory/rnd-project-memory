# ADR-003 · Distribution is a vendored copy driven by a manifest

**Date:** 2026-08-17 · **Status:** accepted

## Context

Given ADR-002, an upgrade means replacing the upstream-owned files. The question is what carries
them from upstream into a project.

The upstream-owned files are not contiguous: `ai-sandbox/playbooks/`, `check.sh` at the root,
`.githooks/`, and `_TEMPLATE.md` files in three separate directories. Any mechanism that requires
them to live under a single path would require deforming the tree to suit the delivery tool.

## Decision

Upstream publishes `MANIFEST`, a machine-readable list of every path with its layer — the ADR-002
table in executable form. Adoption and upgrade both act on exactly those entries. Consumers record
what they received in `.template-version`:

```
v1.0.0  skeleton @ 1c3dde0  applied 2026-08-17
```

No git relationship of any kind is established between upstream and a consumer.

## Alternatives considered

| Option | Why not |
|--------|---------|
| `git subtree` | Only pays off when the upstream-owned files sit under one path; here they do not |
| `git submodule` | An empty directory until initialised, which reads as a missing file to an assistant walking the tree; also breaks the system's own one-file-one-home premise |
| Fork with merge | Establishes a bidirectional relationship where only one direction is wanted — see ADR-005 |

## Consequences

- A consumer's copy is entirely self-contained. It keeps working if upstream is renamed, moved, or
  deleted — which is what makes ADR-005 safe.
- **Being behind is the normal resting state of a vendored dependency, not breakage.** This is the
  property that dissolves the "I will forget to update both copies" objection: there is nothing to
  keep in sync, only a version to raise deliberately.
- No mechanism exists for contributing upstream from a consumer. That is intentional and is the
  subject of `Q-contribution-flow`.
- `check.sh` gains an advisory check that manifest-owned files match their released hashes; a
  mismatch means someone edited a file they do not own.
- This repository is its own first consumer: the root memory layer is vendored from `skeleton/` at
  a released tag, recorded in `.template-version`. See ADR-006.
