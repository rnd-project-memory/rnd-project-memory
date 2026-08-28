# 2026-08-28 · The third gate costs nothing, and the arc closes

- **Status:** closed
- **Configuration:** Solo
- **Participants:** author — claude-opus-5 · high effort; esdevop (human) — ran the arm
- **Signed off:** no
- **Tags:** `#template` `#adoption`

---

## Objective

Read Run 2 against the outcomes fixed before Run 1, and close the pre-registered design.

## Reasoning

**Neither pre-registered outcome moved.** Entries were raised in both arms and nothing was invented
in either, so by the rule written before any run, the marker restatements do not matter and
`ADR-013`'s third gate has no measured price on its first application.

Run 2 sat on the same CLI build as Runs 1 and 1′, so the harness confound that qualifies cause A
does not reach this comparison. This is the cleanest measurement of the series.

### The finding is what was refused, as much as what was found

Register entries across three runs of near-identical conditions came out **1, 2, 3**, and Run 2
also named four success dimensions where the others named none. A story is available: removing the
flags made the assistant more expansive.

**That story is not readable and is not recorded as a finding.** Run 1′ had already shown the fine
outcome moving from 2 to 1 under a *completely identical* condition. Monotonicity across three
points from a source known to be noisy is a shape, not an effect.

Writing it up would have been the post-hoc metric substitution the pre-registration was built to
prevent — and it would have been persuasive, which is the whole danger. The design's value showed
up precisely here: not in producing a result, but in making an attractive wrong one unavailable.

### One judgement call, and one thing out of scope

`Success criteria` named four dimensions as *not yet defined*. Judged not invention — a statement
about absence, not a claim about the project, and the opposite move from the `v3.1.1` run, which
wrote the same vocabulary as the criteria. Nearer the line than either prior run, and the line is
the project owner's.

Run 2 left the shipped `Q-<slug>` placeholder in the register beside three real entries; Runs 1 and
1′ deleted it. Not attributed to the treatment — the flags sat on `<<FILL:` markers, not on the
register's example, and two of three runs removed it. Recorded as evidence for the standing finding
that an untouched register is indistinguishable from a filled one, now with both in one file.

### The arc

| Version | Invention | Register |
|---|---|---|
| `v3.1.1` | broad | 0 entries |
| `v3.2.0` | none | 0 — the register avoided, because of the `Owner:` rule |
| `v3.3.0` Run 1 | none | 2 |
| `v3.3.0` Run 1′ | none | 1 |
| `v3.4.0` Run 2 | none | 3 |

Invention stopped at `v3.2.0`: the rule moved into a file every session loads, and the shipped
stack stopped being asserted as fact. Register use returned at `v3.3.0`, when a contradiction in
the register's own preamble was removed. `v3.4.0` changed neither.

**Three fixes, three confirmed mechanisms, and one norm shown to cost nothing.** Each was named
before it was tested, and each was tested one at a time.

## Decisions

- **`EXP-2026-08-28-marker-flags` recorded, verdict `supports`.** The third gate stands, now with a
  measurement behind it and not only the drift argument.
- **The pre-registered design is closed.** No further runs under it; anything after this is a new
  design with its own outcomes fixed in advance.
- **The available pattern is recorded as refused**, in the experiment's own text, so that a later
  reader sees the temptation and the reason rather than an absence.

## Found along the way

- **A pre-registration proves itself by what it forbids.** Twice in three days it made an
  attractive reading unavailable — the file-count metric, and now a monotonic trend across three
  noisy cells. Both would have been written up confidently.
- **The instrument's variance is now bounded on both directions of a comparison.** Identical
  conditions gave different fine outcomes; different conditions gave identical coarse ones. That
  pair is what makes the coarse outcomes defensible rather than merely convenient.

## Next

- The six remaining green-start findings, none of which needs an experiment: the register's
  unmarked example entry, `install.sh`'s second argument, the absent project `README.md` — three
  arms out of three — install guidance in three places, the half-removable marker, and the
  provider/interface/phrasing confound that no single run separates.
- `Q-who-keeps-the-history`'s remaining half: the **recurring** cost of keeping the record by hand,
  which the install measurements do not touch.
