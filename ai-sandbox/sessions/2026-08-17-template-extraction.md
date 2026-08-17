# 2026-08-17 · Extracting the template into its own repository

**Status:** closed

> Recorded retroactively. This session ran in the CGS repository, before this repository and its
> memory layer existed; it is the bootstrap record. Later sessions are opened at the start, as
> `RULES.md` requires.

---

## Objective

Decide whether `templates/` should leave the CGS repository, and if so, design how the template is
versioned, distributed, and shared — with colleagues, with a work project, and with personal
projects — without creating two originals.

## Reasoning

Started from a narrow question: does `templates/` belong in CGS? The measurements settled it
quickly — 1840 lines against 1452 in the host's own `docs/`, unrelated change cadence, and the
skeleton's own README already asserting the existence of a template repository that did not exist.

The question then widened, and each answer exposed the next problem:

**Upgrades.** A template meant to be edited cannot be upgraded by merging. This produced the
ownership split (ADR-002). Applying that split immediately exposed `AGENTS.md` as mixing mechanism
with content — the most instruction-dense file in the system, and the one an upgrade would have
had to hand-merge every time.

**Delivery.** The upstream-owned files turned out not to be contiguous, which ruled out subtree and
pushed toward a manifest-driven copy (ADR-003). The unexpected payoff was that a vendored copy is
self-contained, which later removed the continuity objection to public hosting entirely.

**Migrations.** Version pinning creates a need to state what an upgrade costs. Writing an example
migration exposed why a script cannot do the work: the step that says "session files are immutable,
do not fix them" is precisely the step an automated tool would get wrong while reporting success
(ADR-004).

**Hosting.** The instinct that a work-adjacent template should live under the company GitHub was
examined concern by concern. Secrecy turned out not to be one of them; continuity and usage rights
were the real content. Neither requires enterprise hosting — they require a self-contained,
licensed copy, which ADR-003 already produced. The licence gap emerged as the most consequential
finding of the discussion and the cheapest to close.

**Where the work happens.** Raised at the end: design the template in a repository that already
runs the template. The objection considered and rejected was the bootstrap paradox — editing a
playbook while following it. Pinning the root memory to a released tag of the repository's own
skeleton resolves it cleanly and, as a side effect, makes this repository the only place the
migration machinery is exercised early (ADR-006).

Paths tried and abandoned: forking into the enterprise (wrong direction of flow, likely blocked
anyway); a `git submodule` for the mechanism layer (reads as a missing directory to an assistant);
maintaining parallel originals (forbidden by the system's own routing rule); deferring adoption
until v1.0 is "finished" (no definition of finished, and the machinery would ship unexercised).

## Decisions

Six ADRs, all accepted, all in `docs/decisions/`: separate repository (001), file ownership layers
(002), vendored distribution by manifest (003), version semantics and prose migrations (004),
public licensed upstream with consumers vendoring it (005), and the repository running its own
system (006).

## Found along the way

- **The "generic" template already carries the author's work stack.** `AGENTS.md` named Azure
  Databricks and `uv`; `DATA_ENVIRONMENT.md` assumed Unity Catalog table naming; the pre-commit
  hook matches `dapi[a-f0-9]{32}`, a Databricks PAT. Nothing confidential, but it demonstrates
  that the boundary was being held by attention rather than structure — which is what motivated
  the profile layer. This was the single most useful discovery of the session and it came from
  reading the files rather than from the discussion.
- **The system answers one of the questions put to it.** The worry about maintaining parallel
  copies is already refuted by `RND_PROJECT_MEMORY.md` §2, "two copies drift". The design was
  being asked to permit something it exists to forbid.
- **A public repository without a licence grants no rights.** The instinct that sharing from a
  personal account was "not best practice" was most likely detecting this, not a hosting problem.
- **The `AGENTS.md` split moved from important to blocking** once ADR-006 was adopted — a
  dependency that surfaced from applying the system to itself rather than from planning.
- Being behind on a vendored version is not breakage. Restating that dissolved most of the anxiety
  about keeping copies synchronised.

## Next

Sequence, with dependencies:

| # | Step | Depends on |
|---|------|-----------|
| 1 | `git subtree split --prefix=templates` from CGS into the new repository | — |
| 2 | Organisation name and `LICENSE` | Q-upstream-identity |
| 3 | Restructure: handbook / `skeleton/` / root memory | 1 |
| 4 | Split `AGENTS.md` into project file plus imported `RULES.md` | 3 |
| 5 | Bootstrap the root memory from `skeleton/`, tag `v1.0.0` | 3, 4 |
| 6 | Seed the memory with this session's output | 5 |
| 7 | `MANIFEST`, `MIGRATIONS.md`, `playbooks/upgrade-template.md` | 5 |
| 8 | Enterprise copy | 7, and a real colleague |

In CGS: remove `templates/`, update the README, and record the move as a fact. The design
reasoning does not go there — that would create the second copy this session ruled out.
