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
| `install.sh` | Performs the install. Every step of it that has one correct answer |

The handbook is the authority. Where the two disagree, fix the skeleton.

## Using it

Read the handbook's sections 1–3 first — they are the whole idea, and the rest is mechanism.

```bash
git clone https://github.com/rnd-project-memory/rnd-project-memory.git
cd rnd-project-memory
./install.sh ../my-project my-project you@example.org
```

**Not GitHub's *Use this template*** — it copies the whole repository, this project's own live
memory included, and you would start with a project whose history is somebody else's.

`install.sh` does what has one correct answer and prints what it deliberately left: seven blanks
only a person can answer, your first thread, and a check no script can perform. `skeleton/README.md`
explains each and why. On a project that already has history, read the handbook's §11 first — it
re-orders all of this.

## Status

`v3.1.1`. The memory half — sections 1–14 of the handbook — has been run against a real
single-author project. The delivery half (§15: ownership layers, versioning, migrations) has been
exercised too: twelve releases, `v1.0.0` through `v3.1.1`, including two real structural migrations
(`v1.2.0` → `v2.0.0`, a checkpoint-axis rename; `v2.4.0` → `v3.0.0`, retiring the declared
per-person token in favour of the clone's git identity).

**The system has been adopted once by someone other than its author**, into a project already
three months old with its own working memory, following only the public documentation. That trial
produced a friction log rather than a tidy adoption, which was the point, and `v2.2.0` is what came
out of it.

The sharpest thing it found was not in the log. Three defects had shipped through four releases
because they live in the **installation** — a rename, a placeholder fill, a choice of what to
copy — and a repository that hosts the system on itself never installs anything. Its own checks
reported `ok` while every adopter would have seen a failure on the first line of output. The
general form is worth stating plainly: **a system that checks itself sees the settled state and is
blind to the transition.** `bootstrap-test.sh` now performs that transition at release time.

`v3.1.0` came from an attempt to start a *new* project from the template, which failed on the
install guide rather than on the system. Its instruction to *"replace every `<PROJECT_NAME>` and
`<PLACEHOLDER>`"* named a token that does not exist — one syntax was carrying three things with
three lifetimes: 20 mechanical tokens, 7 blanks only a person can answer, and around 170
occurrences of example field syntax that must never be touched. An install following it destroys
`ai-sandbox/INDEX.md`'s routing table, which every session loads. The blanks are now marked
`<<FILL: …>>` and counted; the mechanical steps have moved out of prose entirely into `install.sh`,
which the guide points at rather than describes; and `bootstrap-test.sh` runs that installer rather
than reproducing it, having previously reproduced it and thereby tested its own copy.

**What that release does not claim.** Extracting the installer was measured, and the measurement
came out against the reasoning behind it: replaying a queued change afterwards touched more files,
not fewer (`EXP-2026-08-26-install-extraction-cost`, `contradicts`). The extraction stands on a
different argument — a gate that reimplements what it gates cannot detect the two disagreeing —
and the metric that failed is retired in the record rather than replaced with one chosen after the
result.

What is still narrow: one adopter, one project, and multi-user behaviour reasoned from the design
rather than observed. Upgrades are still performed by the person who writes the migrations, which
is the setup least likely to catch a subtle mistake. And **no new project has yet been started
from this template by anyone**, which is the next thing to find out rather than something the
release notes can settle.

This repository runs the system on itself and upgrades itself first, deliberately, so that the
first thing to break belongs to whoever wrote it.

## Licence

MIT — see [LICENSE](LICENSE). It is a documentation system, not a library: adopt it by copying
the parts you want.
