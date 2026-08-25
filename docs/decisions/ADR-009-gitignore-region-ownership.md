# ADR-009 · `.gitignore` is owned by region, and region splitting is an exception

- **Date:** 2026-08-25 · **Status:** accepted
- **Configuration:** Author + reviewer + sign-off
- **Participants:** author — claude-opus-5 · high effort; reviewer — esdevop (human)
- **Signed off:** esdevop — the decision; this text was written afterwards and unreviewed

## Context

`.gitignore` has to hold two things at once: upstream's never-commit list, which is a security
control, and the adopting project's own paths, which upstream cannot know. Until now it was
classed `mechanism` and the bootstrap step said "anything else that already exists is merged, not
overwritten". Those two instructions are incompatible. A merged project line lives in a file
upstream replaces wholesale, so it is deleted at the next upgrade — silently, and what it was
protecting stops being ignored. For this file that is not untidiness; it is a disclosure path.

The obvious repair is the one the system already uses for `AGENTS.md`: make the file the
project's, and keep upstream's content in a separate file the project imports. **That device is
unavailable here.** It works because a small project file can `@`-import a large upstream one, and
`.gitignore` has no include directive. Git's nearest equivalents — `.git/info/exclude` and
`core.excludesFile` — are per-clone and uncommitted, so neither can carry upstream's list to
anyone else. Reclassifying the file as `scaffold` would therefore not relocate ownership; it would
revoke it, and upstream could never again push a strengthened never-commit pattern to a project
already running. That is a security regression wearing a layer change's clothes.

So the file needs an ownership shape the model does not have. Until now there were two:
`mechanism` — upstream owns the whole file; `scaffold` — the project owns it after seeding. This
introduces a third: **one file, two owners, boundary at a marker.**

## Decision

**`.gitignore` is split into two regions by a marker line.** Everything above it is the project's
and is never touched by an upgrade; everything from `# ─── UPSTREAM BLOCK` down is upstream's and
is replaced wholesale.

**The order is load-bearing, not layout.** `.gitignore` resolves last-match-wins, so upstream's
patterns sit at the *bottom*: a `!negation` written in the project's region cannot re-admit a file
the never-commit list excludes. Verified both ways — with the project region last, a negation wins
and the file is tracked; with it first, upstream's pattern holds.

**The marker is warned, not required.** `check.sh` reports its absence and `upgrade-template.md`
falls back to today's manual merge when it is missing, so a project that adopted before this
layout existed stays conforming and the release stays MINOR.

**Region splitting is an exception, not a technique available on request:**

> A file is split into owned regions only where an include mechanism is unavailable. If the file
> can import another file, the `AGENTS.md`/`RULES.md` device is used instead.

Without that condition, "put a marker in it" becomes the comfortable answer every time the choice
between `mechanism` and `scaffold` is unpleasant, and the ownership model — whose whole value is
that `MANIFEST` answers "who owns this file?" with one word — dissolves into per-file negotiation.
Exactly one file in the template meets the condition today, and it should stay that way.
`bootstrap-test.sh` fails the release if a second installed file carries a region marker, so the
exception is bounded mechanically rather than by memory.

## Alternatives considered

| Option | Why not |
|--------|---------|
| Leave it `mechanism` with no region | The instruction to merge and the promise to replace wholesale cannot both hold. Project lines die at the next upgrade, silently, and the paths they covered become committable again. |
| Reclassify as `scaffold`, like `AGENTS.md` | The device that makes `AGENTS.md` work is the `@` import, which `.gitignore` does not have. Without it, "the project owns the file" means upstream can never again strengthen a security control on an existing adopter. |
| Keep upstream's list in a second file and include it | Git has no include directive for ignore files. `.git/info/exclude` and `core.excludesFile` are per-clone and uncommitted, so upstream's list would reach one machine and no others — absent everywhere else, and looking exactly like having none. |
| Allow negations in the project region to re-admit specific paths | Tested: with the project region last, a negation defeats the never-commit list. This is precisely the change an adopter reaches for on day one when their existing artefacts stop being tracked. The ordering forecloses it, and the answer to that need is an `ai-sandbox/results/*.json` summary, which is committable by design. |
| Require the marker outright | Every existing adopter's file lacks it, which under `ADR-004`'s discriminator makes them non-conforming and forces a MAJOR. A one-line migration is cheap, but not cheap enough to impose for a benefit each adopter can take when they next upgrade. |

## Consequences

- The ownership model has a third shape, and it is fenced: by a stated condition, by a
  release-time gate, and by there being exactly one instance to point at.
- `upgrade-template.md` step 4 gains an exception branch — replace from the marker down, leave
  everything above untouched — plus an explicit "do not guess" path when no marker is present.
- `check.sh` reports whether the marker exists and how many of the project's own patterns sit
  above it, so a file that has lost its boundary says so before an upgrade rather than after.
- The Python block moves into the project's region. Its instruction — "delete this block if the
  project is not Python" — was previously an invitation to edit a file `MANIFEST` said would be
  replaced wholesale and `check.sh` would report as drift. It is now simply true.
- Because the region below the marker is verbatim upstream by construction, integrity checking on
  it remains available later as a region hash, which does not violate `ADR-008`'s criterion. Not
  part of this release.
- The evidence is one adoption trial on one project. What generalises is the collision itself —
  any project older than its template has ignore patterns of its own — and not that project's
  particular paths, which were not acted on.
