# ADR-005 · Upstream is public and licensed; the enterprise copy is a consumer, not a fork

**Date:** 2026-08-17 · **Status:** accepted

## Context

The template needs to be usable in three settings at once: personal projects, a work project, and
eventually colleagues' projects. The instinct that a work-adjacent artefact should live under the
company's GitHub is sound, but taken literally it removes personal use, and maintaining two living
originals reintroduces exactly the drift the system exists to prevent —
`RND_PROJECT_MEMORY.md` §2 already forbids it:

> Two copies drift, and then nobody can tell which is authoritative.

Examined individually, the concerns behind that instinct are:

| Concern | Real? |
|---------|-------|
| Secrecy — something confidential ends up public | No. Under ADR-002 the core carries neither stack nor employer |
| Continuity — company work depending on one individual's personal account | **Yes**, and the strongest of them |
| Access — EMU accounts often cannot reach public GitHub | Probably; unverified (`Q-enterprise-access`) |
| Usage rights — colleagues copying unlicensed material into company work | **Yes**, and cheap to fix |
| Contribution direction — colleagues improving a personal repository on company time | Yes; process, not hosting |

None of these requires the template to *live* under the enterprise. They require a colleague's
copy to be self-contained, legally clean, and independent of one person's account.

## Decision

- The core is public, in a GitHub **organisation** rather than a personal account, under an
  explicit licence. Both are `rnd-project-memory`; the licence is MIT.
- Any enterprise copy is an ordinary downstream consumer under ADR-003: vendored core plus a
  company profile. It is not a fork and shares no git history with upstream.
- Work repositories keep no public URL in `git remote -v`. Improvements travel upstream by hand,
  retyped as an abstract rule — never as a diff.
- Both repositories are marked as GitHub *template repositories*, so colleagues get "Use this
  template" — a new repository with no fork relationship and no shared history.

## Alternatives considered

| Option | Why not |
|--------|---------|
| Enterprise-only home | Removes personal use, and concedes as work product something whose ownership is genuinely open — see `A-personal-provenance`, which this decision does not settle |
| Two living originals, synced by hand | Forbidden by the system's own routing rule; drift is a matter of time |
| Fork from public into enterprise | May be blocked outright (`Q-enterprise-access`); regardless, it wires the wrong direction as a first-class relationship, one mistyped remote away from pushing work content outward |
| Personal account, no organisation | Leaves the continuity concern — the strongest one — unaddressed, for no saving |

## Consequences

- **A licence file is required before anyone copies anything.** A public repository without one
  grants no usage rights, so a colleague copying it into company work is formally infringing. This
  is most likely what the original instinct was detecting, and it is a one-file fix rather than a
  relocation. MIT was chosen because it appears on effectively every corporate intake allowlist;
  CC BY 4.0 is the better fit for prose but occasionally confuses code-oriented review processes.
- Manual, abstract flow-back forces genericisation to be an explicit step rather than something a
  diff review is trusted to catch.
- Colleague contributions made on company time are company IP and cannot simply be carried
  upstream — `Q-contribution-flow`.
- The company profile has a natural home under ADR-002's profile layer: an internal variant of
  `DATA_ENVIRONMENT.md` plus a pattern extension for the secret scan. Nothing else needs to differ.
- The enterprise copy is not built until it is needed: EMU actually blocks access, a reusable
  company profile exists, or more than one colleague adopts it.
