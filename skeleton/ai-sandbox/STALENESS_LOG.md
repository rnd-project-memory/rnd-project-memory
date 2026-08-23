# <PROJECT_NAME> — Staleness Log

**Updated:** <DATE>

> **Temporary, by design.** This file exists only until the 3-week staleness threshold
> `session-start.md` uses is validated against real data. Once a project has enough closures to
> say whether three weeks was the right number, record the answer in `RATIONALE.md` and delete
> this file — a tool that outlives its question becomes exactly the kind of permanent fixture
> this system exists to prevent.
>
> Append-only. `session-start.md`'s staleness check writes one row **every time it fires**,
> including — especially — when the decision is to defer again. A notice that repeats unchanged
> stops being read after two weeks; the count of how many times a thread was deferred is what
> makes the fourth "still working on something else" line read differently from the first.

| Date | Thread | Age (days) | Decision | Who |
|------|--------|-----------|----------|-----|
| | | | deferred \| closed | |
