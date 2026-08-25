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

`v2.3.0`. The memory half — sections 1–14 of the handbook — has been run against a real
single-author project. The delivery half (§15: ownership layers, versioning, migrations) has been
exercised too: seven releases, `v1.0.0` through `v2.3.0`, including one real structural migration
(`v1.2.0` → `v2.0.0`, a checkpoint-axis rename rather than a mechanism-file swap).

**The system has now been adopted once by someone other than its author**, into a project already
three months old with its own working memory, following only the public documentation. That trial
produced a friction log rather than a tidy adoption, which was the point, and `v2.2.0` is what came
out of it. Roughly half its findings were acted on; the rest were judged specific to that project's
shape rather than to the template, and re-opening them needs a second adopter rather than more
reasoning about the first.

The sharpest thing it found was not in the log. Three defects had shipped through four releases
because they live in the **installation** — a rename, a placeholder fill, a choice of what to
copy — and a repository that hosts the system on itself never installs anything. Its own checks
reported `ok` while every adopter would have seen a failure on the first line of output. The
general form is worth stating plainly, because it is not specific to this project: **a system that
checks itself sees the settled state and is blind to the transition.** `bootstrap-test.sh` now
performs that transition at release time.

What is still narrow: one adopter, one project, and multi-user behaviour reasoned from the design
rather than observed. Upgrades are still performed by the person who writes the migrations, which
is the setup least likely to catch a subtle mistake — one slipped through `v2.0.0`'s own rollout
and was closed out in `v2.1.0`, which added mechanical checks so that class of miss is caught
rather than found by hand.

This repository runs the system on itself and upgrades itself first, deliberately, so that the
first thing to break belongs to whoever wrote it. `v2.3.0` came from exactly that: two defects
the previous release exposed in its own rollout, one found by running the upgrade and one by
closing the session that recorded it.

## Licence

MIT — see [LICENSE](LICENSE). It is a documentation system, not a library: adopt it by copying
the parts you want.
