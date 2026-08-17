# <PROJECT_NAME> — Data Environment

**Updated:** <DATE>

> How to obtain data and run analyses. **No credentials here** — describe where they come
> from, never what they are.

## Access

- Workspace: <name or non-sensitive identifier>
- Authentication: <mechanism — e.g. env var name, CLI profile, keyring entry. Never the value.>
- Required permissions: <what to request, and from whom>

## Tables in use

| Table | Contents | Grain | Refresh | Notes |
|-------|----------|-------|---------|-------|
| `catalog.schema.table` | | one row per … | daily 03:00 UTC | |

**Every table here is mutable.** Any recorded result cites the table *and* the snapshot date.

## Known data traps

<Nulls that mean something specific, duplicated keys, a backfill that changed history,
timezone conventions, columns that are not what their names suggest.>

This is the section that cannot be re-derived from the code. A column whose nulls mean
"not applicable" rather than "unknown" produces a plausible, wrong answer silently, every
time, until someone notices. Write each trap down the moment it is found — it has no other
home in the repository.

## Python environment

Managed with `uv`.

```bash
uv sync                                   # create/refresh the environment from uv.lock
uv run python src/experiments/<file>.py   # run inside it
uv add <package>                          # add a dependency, updating uv.lock
```

`uv.lock` is committed. An experiment record cites its state — that is what makes a result
reproducible when library versions have since moved.

## Run recipes

<Verified commands for common tasks: pulling a slice, running a baseline, exporting results.
Each one that works is one less thing to rediscover.>
