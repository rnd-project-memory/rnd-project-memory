# R&D Project Memory

A system for keeping knowledge alive across AI-assisted sessions on a research and development
project — where the method is discovered rather than specified, and knowledge arrives as PDFs,
wiki pages, call transcripts, discussion, and data analysis.

It exists because the usual failure is not forgetting. It is **lossy re-summarising**: each
session compresses the last one's notes, and after five rounds the notes are a retelling of a
retelling, confidently worded and detached from evidence. The opposite failure is an append-only
log that grows until only its beginning and end are ever read.

Both come from mixing state with history in one file. Separate them and there is nothing left to
compress.

## What is here

| Path | What it is |
|------|-----------|
| `RND_PROJECT_MEMORY.md` | The handbook — the whole system, read once by whoever sets it up |
| `skeleton/` | The copyable starting structure, with `skeleton/README.md` as its install guide |

The handbook is the authority. Where the two disagree, fix the skeleton.

## Using it

Read the handbook's sections 1–3 first — they are the whole idea, and the rest is mechanism. Then
follow `skeleton/README.md` to install the structure into a project.

## Status

`v2.1.0`. The memory half — sections 1–14 of the handbook — has been run against a real
single-author project. The delivery half (§15: ownership layers, versioning, migrations) has now
been exercised too: five releases shipped (`v1.0.0` through `v2.1.0`), including one real
structural migration — `v1.2.0` → `v2.0.0`, a checkpoint-axis rename, not just a mechanism-file
swap.

That exercise is still narrow. It is one project, upgraded by the same person who wrote the
migration — the setup least likely to catch a subtle mistake, and one did slip through: three
stray references to the old naming survived `v2.0.0`'s own rollout, caught by inspection the next
day and closed out in `v2.1.0`, which also added mechanical checks so that class of miss is caught
going forward rather than found by hand next time. Multi-user behaviour remains reasoned from the
design rather than observed.

This repository runs the system on itself and upgrades itself first, deliberately, so that the
first thing to break belongs to whoever wrote it.

## Licence

MIT — see [LICENSE](LICENSE). It is a documentation system, not a library: adopt it by copying
the parts you want.
