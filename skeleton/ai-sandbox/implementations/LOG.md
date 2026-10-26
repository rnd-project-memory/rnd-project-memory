# <PROJECT_NAME> — Implementation Log

Append only. **One row per event in a package's life**, not one per package: `opened`, `revised`,
`branched`, `accepted`, `abandoned`. A package changes state, and an append-only log may not edit a
row. So its history is its rows:

```bash
rg 'IMP-<YYYY-MM-DD>-<slug>' ai-sandbox/implementations/LOG.md
```

A package is `implementations/IMP-<YYYY-MM-DD>-<slug>/`, opened and run by
`playbooks/plan-implementation.md` and `playbooks/execute-step.md`. `check.sh` reports its step
status, derived from `runs/` and `reviews/`, never typed here.

| ID | Date | Event | Thread | Note |
|----|------|-------|--------|------|
