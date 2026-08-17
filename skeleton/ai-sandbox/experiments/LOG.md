# <PROJECT_NAME> — Experiment Log

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
