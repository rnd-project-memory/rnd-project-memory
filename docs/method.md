# rnd-project-memory — Method

**Updated:** 2026-08-23

> Current best understanding of how the template is built, versioned and delivered. **No history
> here** — no "we used to think". Rationale for contested choices lives in `decisions/`; evidence
> lives in `ai-sandbox/experiments/`.
>
> This describes how the *project* works. What the *product* teaches is
> `RND_PROJECT_MEMORY.md`, and it is not restated here.

## Overview

The template is a documentation system that adopters are expected to edit. That single fact drives
everything below: divergence from upstream is the intended end state, so the usual "merge the new
version in" model cannot work.

Instead, every file is owned by exactly one layer, and an upgrade replaces only the layers upstream
owns. A consumer takes a **vendored copy** — files, not a git relationship — and records which
release it took.

## Steps

**Authoring.** Changes land in `skeleton/` and `RND_PROJECT_MEMORY.md`. The handbook is the
authority; where the two disagree, the skeleton is wrong.

**Releasing.** Cut by PR and tag. The bump follows what the change costs a consumer, and the
release notes are the same text as the `MIGRATIONS.md` section — one source, not two. Any release
touching `ai-sandbox/RULES.md` names each changed rule in its notes, because a rule delivered by
file replacement arrives silently.

**Adopting and upgrading.** Copy what `MANIFEST` lists, record the version in `.template-version`,
and on upgrade replace the mechanism layer and run any migration. Migrations are prose an
assistant executes, not scripts — the material being migrated is prose, and the steps that matter
most are exceptions a script would get wrong while reporting success.

**Validating.** This repository runs the system on itself, with the artefact under `skeleton/` and
its own memory at the root, vendored from a released tag.

## Inputs and outputs

| | |
|---|---|
| Input | Design sessions; reading the artefact; what breaks when the system is used |
| Output | A tagged release: handbook, skeleton, `MANIFEST`, `MIGRATIONS.md` entry |
| Consumer | An adopting project with a `.template-version` and no git link upstream |

## Claims

| Claim | Basis |
|-------|-------|
| Every file is owned by exactly one of four layers | `ADR-002` |
| Content is a defect only when it instructs falsely, not when it merely names a stack | `ADR-002`, `EXP-2026-08-17-pattern-list-extraction` |
| `DATA_ENVIRONMENT.md` is the only true profile file; the rest generalise with examples | `ADR-002`, `EXP-2026-08-17-profile-indirection` |
| The register files need no fencing — a stale rule is not a wrong rule | `ADR-002`, `EXP-2026-08-17-misdirection-recheck` |
| The profile appends to the secret-scan list and never replaces it | `EXP-2026-08-17-pattern-list-extraction` |
| Consumers vendor a pinned copy; upstream never merges | `ADR-003` |
| A rule change is MAJOR only if existing entries stop conforming | `ADR-004` |
| Handbook and skeleton share one tag | `ADR-004` |
| A thread's checkpoint belongs to whoever it names `Held by:`, not to a filename | `ADR-007` |
| Negative knowledge (distrust, scope limits, legitimate absence) needs its own field, not prose | `ADR-007` |

## Known limitations

- **No project has upgraded yet.** The whole delivery half is designed and unexercised.
- **Half the system is untouched by dogfooding** — data environment, source ingestion, the secret
  scan firing on a real secret. See `A-dogfood-coverage`.
- The misdirection criterion has reduced scope twice and was formulated on cases it exonerated;
  acting on it is justified by reversibility rather than by confidence.

## Open questions

- [ ] `Q-unexercised-components`
