# EXP-2026-08-17-pattern-list-extraction

**Date:** 2026-08-17 · **Status:** complete
**Question:** Do `.githooks/pre-commit` and `gitignore.template` need their stack content
extracted into the profile layer, as the ownership audit assumed?

---

## Reproducibility

| Field | Value |
|-------|-------|
| Git SHA | `9d547dc` |
| Environment lock | `n/a` — no project environment involved |
| Entry point | `n/a` — inspection, plus one shell check reproduced below |
| Data source | `templates/rnd-project/.githooks/pre-commit`, `templates/rnd-project/gitignore.template` |
| Snapshot date | 2026-08-17, at `9d547dc` |
| Filters / slice | `n/a` |
| Runtime / compute | GNU grep, bash 5.x, WSL2 |
| Run duration | `n/a` |

## Setup

`EXP-2026-08-17-profile-indirection` closed with these two files named as the honest next test and
with a stated prior: that they would resist the remedy, because their stack content is a list of
patterns and a regex has no generic form to state in its place.

Two things were checked. First, what the stack content in each file actually is. Second, what
happens if it is extracted into a profile-supplied file, since that is the remedy the audit
implied.

## Result

**The prior was right about the mechanism and wrong about the conclusion.** A regex has no generic
form — but neither file needs one, because neither was leaking in the sense that matters.

### The pre-commit pattern list is a corpus, not a profile

The full list names five vendors, not one:

```
aws_secret_access_key          AWS
BEGIN [A-Z ]*PRIVATE KEY       generic
xox[baprs]-                    Slack
gh[pousr]_[A-Za-z0-9]{20,}     GitHub
dapi[a-f0-9]{32}               Databricks
AccountKey=                    Azure Storage
password\s*=\s*[...]           generic
```

`dapi` is one entry among five vendor-specific ones. Nobody reading `xox[baprs]-` concludes the
template assumes Slack, and the same reading applies to `dapi`. Vendor enumeration is what a
secret-scanning list *is*; gitleaks — which this hook already delegates to when present — ships
hundreds of such rules for exactly this reason.

The audit counted this file as leaking because it counted term occurrences. That was the wrong
measure.

### The discriminator is misdirection, not presence

`DATA_ENVIRONMENT.md` telling a non-Python project to run `uv sync` is wrong: it instructs, and
the instruction is false. `dapi[a-f0-9]{32}` in a scan list for a non-Databricks project is inert:
it matches nothing, costs nothing, and misleads nobody.

Same class of term, opposite consequence. **Stack content is a defect when it instructs wrongly,
not when it merely sits there.** Applying that test, the eleven "leaking" files from the audit are
not eleven cases of one problem.

### Extraction actively damages the hook

If the pattern list were supplied by the profile as a separate file, a missing or unsubstituted
file leaves the variable empty — and an empty extended regex matches every line. Reproduced:

```
$ pat_missing=$(cat /nonexistent/secret-patterns 2>/dev/null)
$ grep -cnEi "$pat_missing" sample.txt
2                                    # every line of clean content matched
$ if grep -nEi "$pat_missing" sample.txt >/dev/null 2>&1; then echo BLOCKED; fi
BLOCKED                              # the form the hook actually uses
```

Every commit blocks on clean content. The predictable human response is habitual
`git commit --no-verify`, after which the only blocking check in the system is dead while
appearing installed.

The hook's own header calls this "the one rule a later edit cannot repair". Extraction would trade
an inert unused pattern for a failure mode that silently disarms it. The inline list cannot go
missing; that is a property worth more than tidiness.

### `gitignore.template` is already fenced by its own comment

The Python-specific content is three lines under a heading that names it:

```
# Python / uv
.venv/
__pycache__/
.ipynb_checkpoints/
```

An adopter on a different stack deletes the block in seconds, and the label is what tells them
they may. Ignore rules for directories that never appear are inert. The data extensions above it
(`*.csv`, `*.parquet`, …) are not a stack at all — this is a template for projects that handle
extracted data, and those lines are core to its purpose.

## Verdict

**contradicts** — neither file needs the profile remedy the audit implied. `pre-commit` needs no
change; `gitignore.template` needs at most four words on one comment line.

## What this changes

- **The audit's count of eleven leaking files does not survive.** Seven files were counted for
  Group A; two of them (`pre-commit`, `gitignore.template`) are not defects under the misdirection
  test. The number that matters is smaller than the count reported, and the count should be
  restated in terms of misdirection rather than term occurrence.
- **ADR-002 gains a third disposition**, alongside "defer to the profile" and "genericise with
  examples": *leave alone — vendor enumeration is the correct form for this content.* Without it,
  a later reader applying ADR-002 mechanically would extract the pattern list and disarm the hook.
- **The profile extends the list, it does not replace it.** A company adding Snowflake or internal
  token shapes appends entries. Substitution semantics, which ADR-002 specifies for the profile
  layer generally, are wrong for this one file and the ADR should say so explicitly.
- One-line improvement worth making regardless: `# Python / uv` →
  `# Python / uv — delete if this project is not Python`. It costs nothing and converts an inert
  block into a self-removing one.

## Threats to this result

- **The misdirection test was formulated during this experiment, on these files.** A criterion
  invented while examining the cases it exonerates deserves suspicion. It should be re-applied to
  the nine files already classified before it is trusted — it may reclassify some of those too,
  in either direction.
- The empty-pattern failure was reproduced with GNU grep and bash. Behaviour is POSIX-specified
  for an empty BRE/ERE and should hold elsewhere, but only one implementation was tested.
- A profile-supplied pattern file could be made safe — fail closed if absent, verify a checksum.
  This experiment tested the straightforward implementation, not the careful one. The conclusion
  is that extraction buys nothing here, not that it is impossible to do safely.
- `n = 2`, and both were selected because they were expected to break the remedy. Selection for
  difficulty makes a `contradicts` verdict more informative than a `supports` one would have been,
  but it is still not a sample.
