# <PROJECT_NAME> — Data Environment

**Updated:** <DATE>

> How to obtain data and run analyses. **No credentials here** — describe where they come
> from, never what they are.

## Access

One block per source — most projects have more than one, and each has its own way of failing.

### <source name>

- Workspace: <name or non-sensitive identifier>
- Authentication: <mechanism — e.g. env var name, CLI profile, keyring entry. Never the value.>
- Required permissions: <what to request, and from whom>
- Status: alive | being phased out | phased out, no replacement

**Status matters most for on-prem sources.** A cloud source fails loud — a token expires and
the next call errors. An on-prem source can fail silent: the server is decommissioned, nobody
tells the project, and it is discovered months later when someone needs it and it is gone. This
field exists to say so while the source is still alive, not after.

If one source's description outgrows this file, give it `ai-sandbox/env/<source>.md` and leave
one line plus a pointer here — the same thin-file-with-a-pointer shape as
`CHECKPOINT-<thread>.md`.

## Tables in use

**A hand-written table list is not knowledge — it is derivable, and derived things get
generated, not typed.** Where the schema is generated, this section is four lines, not a table:

- Catalog: <path to the generated file, e.g. `ai-sandbox/env/<source>/structure.yaml`>
- Regenerate: `<command>`
- Last generated: <timestamp — anything depending on this catalog cites it>
- Curated notes: `ai-sandbox/CAVEATS.yaml` — traps and join semantics live there and are never
  regenerated, because they cannot be derived from the source at all

If a working set is still worth listing by hand, the criterion for a row is **a decision
depends on it** — not "was queried at some point":

| Table | Contents | Grain | Refresh | Notes |
|-------|----------|-------|---------|-------|
| `catalog.schema.table` | | one row per … | daily 03:00 UTC | |

**Every table here is mutable.** Any recorded result cites the table *and* the snapshot date —
the same discipline `run-experiment.md` asks of a data snapshot, and for the same reason: a
generated catalog is only as useful as the freshness of what depends on it is honest about.

Data and tool traps live in `ai-sandbox/CAVEATS.yaml` now, not here — search it by subject
before touching a table, column, or tool this project relies on.

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
