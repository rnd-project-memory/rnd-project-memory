# rnd-project-memory — Staleness Log

**Updated:** 2026-08-23

> **Temporary, by design.** Exists only until the 3-week staleness threshold `session-start.md`
> uses is validated against real data; once a project has enough closures to say whether three
> weeks was right, the answer goes in `RATIONALE.md` and this file is deleted. See
> `docs/decisions/ADR-007-threads-and-negative-knowledge.md`.
>
> Append-only. `session-start.md`'s staleness check writes one row every time it fires,
> including when the decision is to defer again.

| Date | Thread | Age (days) | Decision | Who |
|------|--------|-----------|----------|-----|
| | | | deferred \| closed | |
