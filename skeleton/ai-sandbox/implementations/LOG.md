# <PROJECT_NAME> — Implementation Log

Append only. **One row per event in a package's life**, not one per package: `opened`, `revised`,
`branched`, `accepted`, `abandoned`. A package changes state, and an append-only log may not edit a
row, so its history is its rows.

**Do not read this file in full — search it.** That is what it is for:

```bash
rg -i "<topic>" ai-sandbox/implementations/LOG.md
rg '#<tag>'     ai-sandbox/implementations/LOG.md
rg 'IMP-<YYYY-MM-DD>-<slug>' ai-sandbox/implementations/LOG.md   # one package's whole history
```

A hit gives you a package ID, which is also its directory, `implementations/IMP-…/`. Open that,
not this log. Which steps are ready, running or done is never written here: `check.sh` derives it
from the package's `runs/` and `reviews/`.

**Check here before opening a package.** The change may already be designed, or have been given up
for a reason. An `abandoned` row is as complete a record as an `accepted` one, and cheaper to read
than to rediscover.

**The note names what the event decided**, not just that it happened:

- `revised`: which steps changed, and the report that showed why;
- `branched`: the child package, and the step it unblocks;
- `accepted`: what was delivered, the review that accepted it, and any `OPEN_QUESTIONS.md` entry it
  answered, since deleting that entry leaves this row as the only cue it had an answer;
- `abandoned`: why.

**Tags go on the `opened` row only.** A package's topic does not change between events, and tags
repeated on every row would inflate the frequencies `check.sh` prints. Reuse a tag from the session
or experiment log where one fits, since one vocabulary across the three logs is what lets
`rg '#<tag>' ai-sandbox/*/LOG.md` find everything on a topic.

| ID | Date | Event | Thread | Tags | Note |
|----|------|-------|--------|------|------|
