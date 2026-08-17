# EXP-2026-08-17-profile-indirection

**Date:** 2026-08-17 · **Status:** complete
**Question:** Does making mechanism files defer to `DATA_ENVIRONMENT.md` for stack specifics
degrade them into empty pointers?

---

## Reproducibility

| Field | Value |
|-------|-------|
| Git SHA | `9d547dc` |
| Environment lock | `n/a` — no code executed |
| Entry point | `n/a` — the rewrite was the run |
| Data source | `templates/rnd-project/ai-sandbox/playbooks/run-experiment.md` and `.../experiments/_TEMPLATE.md` |
| Snapshot date | 2026-08-17, at `9d547dc` |
| Filters / slice | `n/a` |
| Runtime / compute | `n/a` |
| Run duration | `n/a` |

## Setup

`A-profile-indirection` named these two files as the honest test: they carry the densest Group A
stack leakage in the skeleton (2 and 3 stack terms respectively). Both were rewritten in full
under the indirection rule — no Databricks, no `uv`, no `catalog.schema.table`, no DBR — and the
result judged against the original on whether it still instructs.

Candidates: `run-experiment.candidate.md`, `experiments-template.candidate.md`.

Held fixed: sections 1, 4, 5 and 6 of the playbook were not touched, since they carry no stack
content. Only §2 and §3 changed.

## Result

| Measure | `run-experiment.md` | `_TEMPLATE.md` |
|---------|--------------------:|---------------:|
| Lines, before → after | 48 → 54 | 39 → 42 |
| Stack terms, before → after | 2 → 0 | 3 → 0 |
| Deferrals to `DATA_ENVIRONMENT.md` | 1 → 2 | 0 → 2 |

Both files got **longer**, not shorter, and each gained exactly one deferral. Neither turned into
a pointer.

The mechanism by which this happened is the interesting part. Going line by line, the stack
content divided into two kinds:

**Enumerated field lists** — the only construct that genuinely needs indirection. In the playbook
this is one clause of one sentence; in the template it is the value column of eight rows. Even
here the indirection is partial: the playbook keeps a generic floor ("at minimum the git SHA, the
environment's locked state, and the data source with its snapshot date") and defers only the
project-specific remainder.

**Everything else was a concrete instance of a generic principle.** "Upstream Databricks tables
are mutable" is an instance of "a source that can change underneath you is not identified by its
name alone". "Not an ad-hoc notebook cell" is an instance of "not an ad-hoc interactive session".
`uv.lock` is an instance of "the environment's locked state". These do not need a profile at all —
they need the principle stated with the instance kept as a named example, which is exactly the
remedy the audit assigned to Group B (Confluence/Notion).

The row *names* in the template were already generic in 6 of 8 cases. Only `uv.lock` →
`Environment lock` and `Cluster / runtime (DBR…)` → `Runtime / compute` needed renaming; the stack
lived in the example values, which is where a template's placeholders belong anyway.

Two improvements arrived unbidden, both from being forced to write for an unknown stack:

- **"Write `n/a`, do not leave blank."** A field that does not apply must say so, or a later
  reader cannot tell it from an omission. The originals have no such rule. This is the same
  argument `OPEN_QUESTIONS.md` and `ASSUMPTIONS.md` already make about the `Owner:` field, arrived
  at independently — which is mild evidence it is a real property of the system rather than a
  local preference.
- **"Or 'immutable source'"** for the snapshot date, for the same reason.

## Verdict

**supports** — the indirection does not hollow out the mechanism files, and the two hardest cases
came out marginally better than they went in.

## What this changes

**`A-profile-indirection` is confirmed and should be deleted from `ASSUMPTIONS.md`**, with the
conclusion landing in ADR-002 with this experiment as its basis. That is the register's own rule:
confirmation is a transition, not a state.

**ADR-002's Group A remedy should be narrowed, and the design gets simpler.** The audit assigned
Group A "defer to the profile" and Group B "genericise with examples", as two distinct remedies.
This result collapses most of that distinction: within Group A, only enumerated field lists need
deferral, and everything else takes the Group B remedy. `DATA_ENVIRONMENT.md` remains the profile
file, but far fewer files need to point at it than the audit assumed — two constructs across the
two densest files.

**Q-unexercised-components moves slightly.** This is the first use of `experiments/_TEMPLATE.md`
for anything, and it exposed that the template is fitted to data-analysis runs: 5 of its 8
reproducibility fields are `n/a` for a design experiment. That is not necessarily a defect — an
R&D project's experiments mostly *are* data runs — but it means the `n/a` rule added above is
load-bearing rather than cosmetic, and it is the reason this record reads as deliberate rather
than half-filled.

## Threats to this result

- **n = 2, both chosen as worst cases for prose.** The result generalises downward to easier prose
  files, not upward. It says nothing about `.githooks/pre-commit` and `gitignore.template`, where
  the stack content is a list of patterns rather than an instance of a principle — a regex has no
  generic form to state, so those two may still need real extraction. They are the honest next
  test, and they were not run here.
- **The judgement "still instructs" is mine, unblinded, and I designed the remedy.** A rewrite
  looks adequate to its author more reliably than to a stranger. The line counts and term counts
  are objective; the quality claim is not.
- **`DATA_ENVIRONMENT.md` was not rewritten.** Both candidates assume it can carry the deferred
  field list legibly. That assumption is untested and is now the load-bearing one.
- The two "unbidden improvements" are improvements to the originals that could have been made
  without any of this. They count as evidence that the rewrite was done attentively, not as
  evidence that indirection causes improvement.
