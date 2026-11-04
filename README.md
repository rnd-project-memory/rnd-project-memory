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
./install.sh ../churn-signals "Churn Signals" you@example.org
```

**Not GitHub's *Use this template*** — it copies the whole repository, this project's own live
memory included, and you would start with a project whose history is somebody else's.

The first argument is the folder, the second the project's title as every heading will show it.
`install.sh` does what has one correct answer and prints what it deliberately left.
**`skeleton/README.md` is the install guide**: each step, what is left to you, and why. On a
project that already has history, read the handbook's §11 first. It re-orders all of this.

The template does not globally ignore generic data-file extensions or a `data/` directory. Add
project-specific patterns above the `.gitignore` upstream marker if this project wants them ignored.
The pre-commit hook is a separate safety control and still blocks known data-file extensions from
commits by default.

## Status

`v3.11.0`. Twenty-two releases. The memory half — sections 1–14 of the handbook — has been run
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

**`v3.4.0` applies `ADR-013`'s third gate to the release before it**, removing a short form of one
rule that `v3.2.0` had added at each of the seven install markers. One rule stated in one place,
pointed at elsewhere, never restated. Removing the restatement changed neither pre-registered
outcome, so on its first application the third gate had no measured price.

**`v3.6.0` is the first release driven by long use rather than by a green start.** One adopting
project was read after about eight weeks under the template. Three things it showed were
detectable and nothing detected them. *Current focus* in `INDEX.md` grew to about 300 lines in a
file loaded every session, because the bound lived only in the blank that answering deletes. A
log written with bare tags made the tag check print nothing. The shipped checkpoint template
survived as a "thread" for weeks. Each is now a `check.sh` report that clears when acted on. One
failure was ours and needed no check: the session-start sweep froze any other open session as
interrupted. That contradicts §3, where parallel agents are the normal case, and live sessions
were frozen. The sweep now asks. What
the same reading found and did not fix — nothing promoted to `docs/` after install day, staleness
notices deferred every time, single-valued fields — is a design question, not a check.

**`v3.7.0` adds implementation packages** (`ADR-014`), for changes designed in one place and
executed in another: by a cheaper model, by parallel executors, or later. A capable model and a
person fix the design and a gated plan. Executors leave one immutable report per attempt.
`check.sh` derives each step's state from those reports, never from typed status, and a reviewer
re-runs the gates in a clean checkout of the reported commit. It was dogfooded once here, on the
fix that makes `install.sh` label an unreleased skeleton honestly (`v3.6.0+<sha>`): four steps on
a cheaper model, two in parallel, all accepted. Along the way, one executor's report proved right
in every gate and false in a note, and only the reviewer's re-run caught it. Exercised so far on
one small change, with no revision or branch.

**`v3.8.0` guards identity like a secret** (`ADR-015`). This repository's published history carried
two work identities, in commit and tag metadata and in one record's text. The content scan never
reads metadata, and a clone with no local `user.email` inherits the global one without a word.
History was rewritten once, with a hash map left for every old citation. From now on
`.githooks/identity.allow` lists who may commit. `pre-commit` and a new `pre-push` block anyone
else: author, committer and tagger, including tags and rebased commits. The list ships empty, and
empty checks nothing, so a project that never opted in sees no false positive.

**`v3.9.0` closes the design gaps the adopter's memory showed.** A choice too young for an ADR now
has a home, `DECISIONS.md`. It is written when the choice is taken, while its reasons are fresh,
and moved into an ADR once it has held: R&D decisions prove themselves by surviving, and by then
nobody remembers why they were made. A stalled thread is deferred only by its holder, and only
with a revisit date, where the adopter's assistant deferred everything every session. Sessions
carry a `Mode:`. `CAVEATS.yaml` `severity:` measures what a miss costs. Register examples no longer
pose as entries, and `check.sh` sees a half-removed install blank.

**`v3.10.0`: only the user ends a session.** Saving and closing were one gesture, so an
assistant that saved carefully also closed the session, at its own reading of *done*, while the
user still meant to go on. They are two now: save at any time, with the record left open; close
only on the user's word. Working decisions ripen for an ADR at 60 days.

**`v3.11.0`: a plan revision follows its design revision.** Met at work. A design was revised
properly into `DESIGN.r1.md`, but its plan was edited in place, and the reports of finished steps
stopped matching the plan they cite. Revisions now share one number, so `DESIGN.rN.md` pairs with
`PLAN.rN.md`. `check.sh` halts a package while its design is ahead of its plan, or while a
released file differs from its release, and names the way back. A revision must account for every
step it supersedes.

What is still narrow: one adopting project besides these three starts and one more read after
weeks of use, multi-user behaviour reasoned from the design rather than observed, and upgrades
still performed by whoever writes the migrations. This repository runs the system on itself and
upgrades itself first, deliberately, so that the first thing to break belongs to whoever wrote it.

## Licence

MIT — see [LICENSE](LICENSE). It is a documentation system, not a library: adopt it by copying
the parts you want.
