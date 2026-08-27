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

`v3.3.0`. Fourteen releases. The memory half — sections 1–14 of the handbook — has been run
against a real single-author project; the delivery half (§15) has been exercised across two real
structural migrations.

**Three independent green starts have now been run against `v3.1.1`**, the first evidence about
this template that does not come from the repository that ships it:

| Arm | Result |
|---|---|
| A person, unassisted, from the online documentation | installed in **12 minutes**, four documentation defects on the way |
| An assistant, same model family as this documentation's author | recorded what it was not told, opened three questions, invented nothing |
| An assistant, **a different provider** | filled every underdetermined section confidently and raised no questions |

The third outranks the second — the project's own independence ladder rates a same-family model
*weak* evidence. So the honest reading of the pair is not one pass and one fail: **an instruction
telling an assistant not to invent is not load-bearing across providers**, and one run agreeing
with a rule is not evidence that the rule binds.

Two causes, both ours, and `v3.2.0` is what came out of them. The rule itself — *fill only from
what you were told* — existed in exactly one file, the install guide, which is never copied into a
project and so bound nobody after the install; it now lives in `ai-sandbox/RULES.md`, which every
session loads. And `ai-sandbox/DATA_ENVIRONMENT.md` shipped asserting a Python/`uv` stack as fact
while `AGENTS.md` instructed that the stack named must match it — so the assistant that "invented"
a stack was obeying us. The handbook had forbidden exactly this for four releases: *shipping one
full of instructions for a stack the project does not have is worse than shipping nothing*. The
artefact was wrong and the authority was right, which is the direction that rule exists for.

**What is still not solved, and is now measured rather than assumed:** `check.sh` reports clean on
a repository of honest absences and on a repository of confident fiction. It can see that a blank
was answered and not whether the answer is true. The design's answer has always been that a person
reviews `docs/` before it lands — and on day one there is no such review, because the project has
no history and nobody has read anything yet.

**`v3.3.0` withdrew one of `v3.2.0`'s own rules, one release later.** It told an assistant to ask
when a field it must fill has no correct value available. The next run read it, judged that asking
would block the task, and avoided the whole register rather than raise an entry it could not
complete — trading one wrong value in one field for an unused open-questions register. Two things
came out of that: the defect was structural, in a register preamble that said a field is *always*
filled and that blank carries meaning; and a rule was the wrong instrument for something a
one-line check detects. `ADR-013` now decides that choice in general — **the instrument follows
detectability, and a rule is the last resort, for failures nothing can see.**

What is still narrow: one adopting project besides these three starts, multi-user behaviour
reasoned from the design rather than observed, and upgrades still performed by whoever writes the
migrations. This repository runs the system on itself and upgrades itself first, deliberately, so
that the first thing to break belongs to whoever wrote it.

## Licence

MIT — see [LICENSE](LICENSE). It is a documentation system, not a library: adopt it by copying
the parts you want.
