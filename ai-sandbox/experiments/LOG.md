# rnd-project-memory — Experiment Log

Append only. One row per experiment. A negative result is a complete result.

**Search, do not read in full:**

```bash
rg -i "<topic>" ai-sandbox/experiments/LOG.md
rg '#<tag>'     ai-sandbox/experiments/LOG.md
```

Check here before running anything: the cheapest experiment is the one already run. A
`contradicts` or `inconclusive` row is exactly as useful as a `supports` one for that purpose.

**Tags:** reuse an existing tag if one fits. `check.sh` prints frequencies.

| ID | Date | Question | Tags | Verdict | Link |
|----|------|----------|------|---------|------|
| EXP-2026-08-17-profile-indirection | 2026-08-17 | Does deferring to `DATA_ENVIRONMENT.md` degrade mechanism files into empty pointers? | `#profile` `#ownership` | supports | [record](EXP-2026-08-17-profile-indirection.md) |
| EXP-2026-08-17-pattern-list-extraction | 2026-08-17 | Do `pre-commit` and `gitignore.template` need their stack content extracted? | `#profile` `#secrets` | contradicts | [record](EXP-2026-08-17-pattern-list-extraction.md) |
| EXP-2026-08-17-misdirection-recheck | 2026-08-17 | Does the misdirection criterion reclassify the nine preamble files and the Group A remainder? | `#ownership` `#versioning` | contradicts | [record](EXP-2026-08-17-misdirection-recheck.md) |
| EXP-2026-08-26-prose-script-restatement | 2026-08-26 | Where a rule is stated in prose and re-implemented in a script, does anything detect the two disagreeing? | `#template` `#adoption` | supports | [record](EXP-2026-08-26-prose-script-restatement.md) |
