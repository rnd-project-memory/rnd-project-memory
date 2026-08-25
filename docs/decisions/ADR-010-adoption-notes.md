# ADR-010 · The adoption note, and the boundary that keeps it from becoming an excuse

- **Date:** 2026-08-25 · **Status:** accepted
- **Configuration:** Author + reviewer + sign-off
- **Participants:** author — claude-opus-5 · high effort; reviewer — esdevop (human)
- **Signed off:** esdevop — the decision; this text was written afterwards and unreviewed

## Context

A project adopting this system mid-life brings files that some of these rules contradict: a
register that numbers its entries where the rules require slugs, one that has been a journal for a
year, material that has no slot at all. The rules cannot be followed and the files cannot be
rewritten, so something has to record which is in force.

An external adoption trial hit this and invented a device under pressure — a short note under each
affected file's preamble, saying where the file below does not follow the preamble above and why
nothing was changed. It is a reasonable thing to invent. The problem is that it was invented, and
the next adopter will invent something else: differently shaped, differently placed, and — this is
the part that matters — **unrecognisable to the mechanical checks.**

The trial demonstrated that directly. Its note was written as a numbered list, so `check.sh`'s
register check read the note's own explanation of the rule as a violation of it and reported the
documentation of the deviation alongside the deviations. An adopter doing exactly what an existing
project needs them to do made the tooling noisier by doing it.

A check can be taught to skip a note. It cannot be taught to skip five shapes it has never seen.

## Decision

**The adoption note is sanctioned, with a fixed form.** A blockquote directly under the affected
file's preamble, opening `> **Adoption note.**`, carrying three parts:

1. what the rule says;
2. what this file does instead;
3. **what must happen for the divergence to close — or a statement that it cannot close, and why.**

The third part is what separates a record from an excuse. Without it, "we wrote down that we
diverge" becomes the answer to every friction the system produces and reconciliation never
arrives. A declared *inability* to close is a legitimate value — the design already treats a
declared absence as knowledge rather than a gap, the way `Basis:` accepts `—`. The test is whether
closure is unavailable or merely unscheduled: "the citations live in files this system declares
immutable" is the first; "we have not got to it" is the second, and that is a deadline with no
date. When a divergence does close, the note is deleted with a `LOG.md` row, like any other
removal here.

**The blockquote is not a style choice.** It is how the checks already tell commentary about a
rule apart from a violation of it — the same exclusion the register preambles rely on — so the
sanctioned form closes the trial's F-028 without a line of new checking code. A device each
adopter shapes for themselves is invisible to tooling by construction.

**And the boundary, which is what makes this safe:**

> An adoption note covers records the rule cannot reach **because they are older than it** —
> whether the rule arrived when the template was adopted or when it was upgraded. It does not
> cover a record created after the rule existed, when conforming was possible.
>
> One test: **could this file have conformed when it was written?** If it could, no note is owed.

The boundary is stated by its reason rather than by listing the doors a rule can come through.
"Files inherited at adoption" was the first formulation and it is too narrow: a project's own
records can fall out of conformance without being inherited from anywhere, the first time an
upgrade introduces a rule they predate. Enumerating cases would mean adding a case each time one
appears, and a boundary maintained by enumeration is one that gets worked around while still
looking intact.

What the reason preserves is the thing the boundary was for. A note is available where conforming
was impossible, and nowhere else — so it can never become a way to opt out of a rule one
reasonable exception at a time. `check.sh` reports the count of notes alongside the adoption date
from `.template-version`, so notes accumulating long after the fact are visible rather than
inferred.

**This project failed the test on its own history the day the rule was written.** `ADR-007` was
produced in the same session that introduced `CONFIGURATIONS.md`, under `Configuration: Solo` and
`Signed off: no` — a configuration that does not license an `ADR-` number. Conforming was possible;
the rule existed in the same commit. So it is owed no note. It is owed an honest basis line
naming what it actually rests on, recorded beside the register that carries the rule rather than
by editing an immutable record. The narrower "everything older than the rule" formulation would
have swept exactly this case up and quietly excused it.

The boundary is about **when a note is written, not how long it lives.** A note whose third part
declares that closure is unavailable — the inherited identifier scheme is the standing example —
stays for as long as the divergence does, which may be forever. That is the device working, not
an expiry being missed.

## Alternatives considered

| Option | Why not |
|--------|---------|
| Leave it unsanctioned; each adopter improvises | The trial shows what improvisation costs: a reasonable shape that the checks read as the violation it documents. Multiply by adopters and no check can be written at all. |
| Forbid the device; require the file to conform | Some divergences cannot be closed — renumbering an inherited register would mean editing files this system declares immutable. Forbidding the note does not remove the divergence, it removes the record of it. |
| Sanction the note with no closing condition | It becomes the standing answer to every friction. This is the failure the boundary and the third part exist to prevent, and it is the more likely one, because writing the note feels like doing the work. |
| Sanction it for ongoing use, not just bootstrap | Then it is a rule-exemption mechanism with no expiry and no author — the opposite of what the system is for. |
| Bound it by enumerating the doors — "files inherited at adoption" | Too narrow, and narrow in a way that hides things: a project's own records fall out of conformance whenever an upgrade brings a rule they predate. Each new door would have to be added by hand, and the version that says "anything older than the rule" would have excused `ADR-007`, which could have conformed and did not. |
| Put the note in a separate register instead of in the file | The reader who needs it is the one reading the file, mid-task. A register they must know to consult is a register they will not consult. |

## Consequences

- `RULES.md` gains the rule, so it reaches consumers — the handbook stays in the template
  repository, and a project two years in has no copy of §11 to read.
- `RATIONALE.md` carries why, including the boundary and the impossibility-versus-unscheduled test.
- `check.sh` reports how many adoption notes a project has and how long ago it adopted. It does not
  judge; that pairing is the whole signal, and the answer to "notes on a five-year-old adoption" is
  a conversation, not an exit code.
- The device is now a third member of a family the system already had: `STALENESS_LOG.md` exists
  until its threshold is measured, the intake file carries a dismantling date, and an adoption note
  names what would close it. Anything created to hold a known imperfection names its own removal,
  or it becomes furniture.
- Evidence is one trial on one project. What generalises is that any project older than its
  template will have files that cannot follow the rules on day one; the particular divergences that
  project had were not acted on.
