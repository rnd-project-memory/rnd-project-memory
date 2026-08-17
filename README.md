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

`v1.0.0`. The memory half — sections 1–14 of the handbook — has been run against a real
single-author project. The delivery half (§15: ownership layers, versioning, migrations) is
designed and **unexercised**: no project has yet lived through an upgrade, so every claim about
what one costs is reasoning rather than observation.

This repository runs the system on itself and upgrades itself first, deliberately, so that the
first thing to break belongs to whoever wrote it. Multi-user behaviour is likewise reasoned from
the design rather than observed.

## Licence

MIT — see [LICENSE](LICENSE). It is a documentation system, not a library: adopt it by copying
the parts you want.
