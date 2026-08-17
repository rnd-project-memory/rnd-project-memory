# 2026-08-17 · Auditing file ownership across the skeleton

**Status:** closed

> Second session of the day; suffix per `checkpoint.md`. Recorded retroactively for the same
> reason as the first — this ran in CGS, before this repository existed.

---

## Objective

Sort all 32 skeleton files into the ADR-002 ownership layers, produce a draft `MANIFEST`, and
check whether any file besides `AGENTS.md` and `INDEX.md` mixes layers.

## Reasoning

The prior session assumed the layering was sound and only its application remained. Reading every
file rather than reasoning from filenames overturned that in three places.

**The mixed-file problem is the tree's dominant shape, not an exception.** Nine files carry an
upstream normative preamble above project entries, and the preamble share runs from 30% to 88%.
These are worse cases than `AGENTS.md`: they are edited every session, so an upgrade can neither
replace them nor skip them. The obvious fix — move the preambles into `RATIONALE.md` — is refuted
by `RATIONALE.md` itself, whose failure-mode table names "a rule in a file nothing imports" as a
known way for the system to fail silently. Fencing keeps the rule at the point of use while making
the region addressable, and it needs no tooling beyond what ADR-004 already commits to.

**The stack leaks into eleven files, in two independent groups.** A project could use Databricks
without Confluence or the reverse, so a single profile layer would force adopters to take both.

**Extraction fails on the hardest case, and inverting it succeeds.** `A-profile-separable` asked
whether the stack could be removed from `DATA_ENVIRONMENT.md`. Attempting it showed that stripping
Databricks and `uv` leaves nothing concrete, because "known data traps" cannot be stated
abstractly. Inverting the frame — that file *is* the profile, and everything else defers to it —
resolves the whole leakage at the cost of one line per affected file. The Confluence group needs no
extraction at all, only generic phrasing with named examples.

A fourth layer became necessary once seven files fit none of the three: upstream authors
`problem.md` and its kind as a starting shape, but after the project writes its own, an upstream
revision is an unwanted rewrite rather than an improvement.

## Decisions

- ADR-002 rewritten: four layers (mechanism · profile · scaffold · content) plus a `norcopy`
  marker, two profile groups rather than one, and fenced preamble regions.
- `A-profile-separable` settled and replaced by the narrower `A-profile-indirection`.
- `MANIFEST` drafted with a scope column — whole file or fenced region.
- Step 4 of the sequence restated: fencing nine files, not splitting one.

## Found along the way

- **`skeleton/README.md` overwrites the adopting project's README.** Step 1 says "copy the
  contents of this directory into the project repository root", and `README.md` is one of those
  contents. Step 5 anticipates collisions for `sources/` and `src/` but not this one. Any project
  with an existing README — that is, any real project — loses it to the template's install
  instructions. `README.md` belongs to the template repository and is now marked `norcopy`. The
  same class of problem, smaller, applies to an existing `AGENTS.md`: the instruction should say
  merge, not copy.
- **Two `check.sh` checks will misfire** against the new repository's own memory: the
  resolved-entry check greps for the word `Resolved`, which appears in the preambles explaining
  that it must never be used, and the dangling-citation check assumes a populated `SOURCES.md`,
  which a reasoned-rather-than-sourced project legitimately lacks.
- **Only 7 of 32 files are cleanly replaceable today.** The honest measure of the distance between
  ADR-002 and a working upgrade, and a number worth repeating whenever the design feels finished.
- Reading beat reasoning, again. Every one of these came from opening files, not from thinking
  about them — including the two defects, which had survived three commits of review.

## Next

Supersedes the sequence in `2026-08-17-template-extraction.md`; that file is closed and was left
as written.

| # | Step | Depends on | Change |
|---|------|-----------|--------|
| 1 | `git subtree split --prefix=templates` from CGS | — | — |
| 2 | Organisation name and `LICENSE` | Q-upstream-identity | — |
| 3 | Restructure: handbook / `skeleton/` / root memory | 1 | — |
| 4 | **Fence the mechanism preamble in nine files**, `AGENTS.md` → `RULES.md` being the largest | 3 | **grown** |
| 4a | Fix the two skeleton defects: `README.md` `norcopy`, `AGENTS.md` merge-not-copy | 1 | **new** |
| 5 | Bootstrap the root memory from `skeleton/`, tag `v1.0.0` | 3, 4 | — |
| 6 | Seed the memory with both sessions' output | 5 | — |
| 7 | `MANIFEST` (drafted), `MIGRATIONS.md`, `playbooks/upgrade-template.md` | 5 | manifest drafted |
| 7a | Profile indirection: rewrite the eleven leaking files | 7 | **new** |
| 8 | Enterprise copy | 7, and a real colleague | — |

Step 4a is independent of everything else and fixes a defect that breaks installation for any real
project today — worth doing whether or not the rest proceeds.
