# rnd-project-memory — Method

- **Updated:** 2026-08-23

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
| The hash list holds only files installed verbatim; a transformed file cannot be hashed at either path | `ADR-008` |
| Self-check sees the settled state and is blind to the transition — for any self-installing system | `ADR-008` |
| `.gitignore` is owned by region — project above the marker, upstream below, upstream last so a negation cannot re-admit | `ADR-009` |
| Region splitting is an exception, permitted only where an include mechanism is unavailable | `ADR-009` |
| A deviation is invisible to the checks unless its description has one sanctioned form | `ADR-010` |
| A note is owed only where conforming was impossible; the test is whether the record could have conformed when written | `ADR-010` |
| The bump level depends on the rule's wording, because the wording is the consumer's obligation | `ADR-011` |
| An exception that keeps a release MINOR must be inert or expiring; otherwise it is a deferred MAJOR | `ADR-011` |

## Known limitations

- **No project has upgraded yet.** The whole delivery half is designed and unexercised.
- **Half the system is untouched by dogfooding** — data environment, source ingestion, the secret
  scan firing on a real secret. See `A-dogfood-coverage`.
- **Self-check sees the settled state and is blind to the transition.** Three defects shipped
  through four releases because they live in the *installation*, and this repository never installs
  anything: it vendors the files in place, so nothing is renamed, no placeholder is filled and the
  copy set is never chosen. The lesson is not about this template — it holds for any system that
  installs itself, and the blind region is always the transition rather than the resting state.
  `bootstrap-test.sh` performs the transition at release time (`ADR-008`); the components named
  above remain uncovered.
- The misdirection criterion has reduced scope twice and was formulated on cases it exonerated;
  acting on it is justified by reversibility rather than by confidence.

## Open questions

- [ ] `Q-unexercised-components`
