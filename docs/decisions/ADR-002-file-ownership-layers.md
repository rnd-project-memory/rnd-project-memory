# ADR-002 · Files are owned by exactly one layer

**Date:** 2026-08-17 · **Status:** accepted
**Revised:** twice on the same day. First after auditing all 32 skeleton files
(`sessions/2026-08-17-ownership-audit-2.md`), which broke the original three-layer form. Then
after three experiments (`sessions/2026-08-17-profile-experiments-3.md`), which overturned two of
that audit's three conclusions. The layers survived; the remedies did not.

## Context

Unlike a code library, this template is *meant* to be edited by whoever adopts it: a project fills
in `docs/problem.md`, writes its checkpoint, keeps its own `SOURCES.md`. Divergence from upstream
is the intended end state, not a defect.

That breaks the usual upgrade model. A merge or `git subtree pull` from upstream would conflict in
nearly every file, because nearly every file has legitimately changed downstream. An upgrade that
requires conflict resolution across a whole tree does not get performed.

An audit of all 32 files established how the tree divides, and three experiments then tested what
that division actually requires. The audit's ownership finding held — seven files are
upstream-authored but must never be upgraded, which needed a fourth layer. Its two remedies did
not: the eleven "leaking" files and the nine "mixed" files were both counted by the wrong measure,
and the work they implied largely dissolves under the criterion stated below.

## Decision

Every file belongs to exactly one layer:

| Layer | Owner | Upgrade behaviour |
|-------|-------|-------------------|
| **Mechanism** | upstream | replaced wholesale |
| **Profile** | upstream or the adopting organisation | substituted, never merged |
| **Scaffold** | upstream authors it, the project owns it from first edit | copied at bootstrap only; upstream revisions never propagate |
| **Content** | the project | upstream never reads or writes it |

Plus a `norcopy` marker for files belonging to the template repository itself and never copied
into an adopting project.

`MANIFEST` at the repository root records the assignment — the table above in machine-readable
form, which is what ADR-003 acts on.

### Content is a defect only when it misdirects

The audit counted files containing stack terms and treated every occurrence as a leak. That
measure was wrong, and the correction generalises beyond the stack.

`DATA_ENVIRONMENT.md` telling a non-Python project to run `uv sync` **instructs, and the
instruction is false**. `dapi[a-f0-9]{32}` in a secret-scanning list on a non-Databricks project
matches nothing, costs nothing, and misleads nobody. Same class of term, opposite consequence.

> **The test:** what specifically goes wrong if this content is wrong for the project, or one
> version out of date? Content that instructs falsely is a defect. Content that merely sits there
> is not.

Applied to the twelve candidates, the test yields four dispositions:

| Disposition | When it applies | Files |
|-------------|-----------------|------:|
| **Substitute** — the file *is* the profile | Stack instruction end to end | 1 |
| **Edit locally** | A clause or a table row instructs falsely; the rest of the file does not | 5 |
| **Leave alone** | Vendor enumeration is the correct form for this content | 1 |
| **Nothing structural** | Ownership is mixed, but stale content does not misdirect | 9 |

### `DATA_ENVIRONMENT.md` is the profile, and it is the only one

Stripping the stack out of it was tried first, as the hardest case, and fails: remove Databricks
and `uv` and nothing concrete remains, because "known data traps" cannot be written abstractly. So
the file stays concrete and ships in variants.

Everything else that named the stack turned out to be a concrete instance of a generic principle —
"upstream Databricks tables are mutable" instances "a source that can change underneath you is not
identified by its name alone". Those need the principle stated with the instance kept as a named
example, not a profile. Only enumerated field lists genuinely defer, and there are two of them
(`EXP-2026-08-17-profile-indirection`).

### The register files are scaffold, not fenced

An earlier revision of this ADR fenced the upstream preamble in nine files with markers. That is
withdrawn (`EXP-2026-08-17-misdirection-recheck`), for three reasons:

1. **A stale rule is not a wrong rule.** It is the previous version of a rule that was acceptable
   when it shipped. The failure mode is missing a newly added rule, not following a false one.
2. **What does change in these files changes at MAJOR anyway** — vocabulary, schema, filenames are
   all migrated already, and a rule revised because the old one caused damage needs the existing
   entries repaired too, which is a migration by definition.
3. **The fence was internally inconsistent.** It declared that no tool would auto-replace the
   region, then added markers whose only consumer is such a tool. An assistant finds a preamble by
   reading; a prose migration can address it by description.

The nine files are `scaffold`. Preamble updates ride on migrations, described in text.

### The profile extends the secret-scan list; it does not replace it

Substitution is the profile layer's general semantics and it is **wrong for
`.githooks/pre-commit`**. If the pattern list came from a profile-supplied file, a missing or
unsubstituted file leaves the variable empty — and an empty extended regex matches every line, so
every commit blocks on clean content. The predictable response is habitual `--no-verify`, after
which the system's only blocking check is dead while appearing installed
(`EXP-2026-08-17-pattern-list-extraction`).

A profile therefore **appends** entries to that list. The inline core cannot go missing, and that
property is worth more than tidiness in the one file whose failure a later edit cannot repair.

## Alternatives considered

| Option | Why not |
|--------|---------|
| One layer, merge on upgrade | Conflicts in nearly every file; the upgrade stops being performed, which is the same as having no upgrade path |
| Three layers, no `scaffold` | Forces `problem.md` and its kind into either mechanism (upstream overwrites the project's own document) or content (upstream cannot seed it at all) |
| Two layers, stack folded into mechanism | Every adopter inherits one author's stack and strips it by hand — the manual step this decision exists to remove |
| Preambles relocated to `RATIONALE.md` | Removes the rule from the point of use; the system's own failure-mode table predicts the result |
| Preambles fenced with markers | Tried and withdrawn: markers serve a tool, and this design deliberately builds no tool |
| Secret-scan patterns supplied by the profile | An absent pattern file blocks every commit on clean content, and the response is habitual `--no-verify`. Trades an inert unused pattern for a silently disarmed hook |

## Consequences

- **The work this ADR implies is far smaller than the audit suggested**: one profile file, five
  local edits, and no structural change to the nine register files. The audit's "eleven leaking
  plus nine mixed" counted term occurrences and layer mixing rather than consequences.
- **`AGENTS.md` was split**, with the working rules moving to `ai-sandbox/RULES.md`. Fencing no
  longer requires it; it survives because rules living in a mechanism file are delivered by
  replacement rather than by migration, which takes rule delivery off `A-prose-migrations` — see
  ADR-004.
- `MANIFEST` needs no region scope. A path and a layer are sufficient.
- The `check.sh` false positives lost the fix that fencing would have supplied and were fixed
  directly: the citation and register checks now skip blockquote lines, `<placeholder>` lines, and
  `playbooks/`. There were three, not two.
- **The misdirection test is young and was formulated on the cases it first exonerated.** It has
  now reduced scope twice. What makes acting on it safe is asymmetry rather than confidence: not
  fencing is reversible against real evidence at v3, while fencing now costs edits in nine files
  against none. Tracked as `A-misdirection-criterion`.
