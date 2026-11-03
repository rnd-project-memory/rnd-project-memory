# rnd-project-memory — Staleness Log

- **Updated:** 2026-11-03

> **Temporary, by design.** This file exists only until the 3-week staleness threshold
> `session-start.md` uses is validated against real data. Once a project has enough closures to
> say whether three weeks was the right number, record the answer in `RATIONALE.md` and delete
> this file — a tool that outlives its question becomes exactly the kind of permanent fixture
> this system exists to prevent.
>
> Append-only. **A row is a human decision, made by the thread's holder**: `closed`, or
> `deferred`, with a revisit date. An assistant notices a stalled thread and reports it. It never
> writes a deferral, because a deferral nobody chose is not a decision, and one adopter's log
> filled with assistant deferrals, several each session, that ended nothing.
>
> **A deferral names its end.** `check.sh` stays quiet about the thread until the revisit date,
> then reports it again. Re-deferring is a new row with a new date, so the count of rows still
> shows how often a thread was put off, the way the fourth *still working on something else* line
> reads differently from the first. Rows from before the *Revisit* column have no date, and count
> as no deferral.

| Date | Thread | Age (days) | Decision | Who | Revisit |
|------|--------|-----------|----------|-----|---------|
| | | | deferred \| closed | | |
