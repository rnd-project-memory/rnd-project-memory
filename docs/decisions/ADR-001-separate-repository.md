# ADR-001 · The template lives in its own repository

**Date:** 2026-08-17 · **Status:** accepted

## Context

The template was developed inside CGS, a personal crypto-strategy repository, where it had arrived
as working material from an unrelated job. By 2026-08-17 it had grown to 1840 lines against 1452
in that repository's own `docs/` — the largest component of a repository it has nothing to do
with, sharing one commit history and one `git log`.

The two also change on unrelated rhythms: CGS changes when the portfolio or the market changes;
the template changes when the memory system is refined against a real project.

The skeleton's own `README.md` already stated the resolution as fact:

> The handbook (`RND_PROJECT_MEMORY.md`) stays in the template repository — it is a textbook for
> whoever sets the system up, not an operational file.

That sentence referred to a repository that did not exist. Extraction does not change the
document; it makes the document true.

## Decision

Extract into a dedicated repository named `rnd-project-memory`, using
`git subtree split --prefix=templates` so that the four commits which shaped the design travel
with it, in order: `767b1d9` (2026-08-15) → `105d28e` → `cd1579f` → `9d547dc` (2026-08-16).

Those SHAs are **coordinates in CGS, not in this repository.** The split rewrites every tree to
strip the `templates/` prefix, so the commits arrive with their author, date and message intact
and with new hashes. Anyone tracing provenance later resolves these four in CGS.

## Alternatives considered

| Option | Why not |
|--------|---------|
| Leave it in CGS | The skeleton README's claim stays false; reuse in other projects means hand-copying out of a repository of personal financial notes, with a fresh chance each time of taking the wrong thing |
| Copy without history | Discards the provenance record — see the consequences below, which turn out to matter beyond tidiness |

## Consequences

- **What the preserved history actually shows** — corrected on the day of extraction, after
  reading the first commit rather than assuming its contents. `767b1d9` added six generic
  templates *brought from the work project*: `INITIAL_AI_INSTRUCTIONS.md`,
  `TOOLS_AND_ENVIRONMENT.md` and four flat registers. `105d28e` — "replace work templates with R&D
  project memory handbook and skeleton" — deleted all six and created the current system in their
  place.

  So the history does not show a system that predates its use at work. It shows a clean
  discontinuity: what was brought in, the commit where it was discarded, and that everything from
  `105d28e` onward is new work done in a personal repository. That is a weaker claim than the one
  first recorded here and it is the one the evidence supports. It is not reconstructible after a
  squash, which is why the split preserved all four commits rather than starting at `105d28e`.
- The six superseded files were scanned for employer-identifying content — company or system
  names, internal URLs, ticket keys — and carry none; they are `<PROJECT_NAME>` scaffolding. That
  is what makes publishing the full history safe under ADR-005. It bears on confidentiality only,
  not on IP: see `A-personal-provenance`.
- CGS `README.md` described `templates/` and now carries a pointer here instead.
- CGS keeps its own simpler memory layer (single `CHECKPOINT.md`, no owner token). That is a
  deliberate divergence, not drift: CGS is not a consumer of this template.
