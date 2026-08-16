# R&D Project Memory — Handbook

A system for keeping knowledge alive across AI-assisted sessions on a research and development
project, where the method is discovered rather than specified, and the knowledge arrives as PDFs,
Confluence pages, call transcripts, brainstorming, and data analysis.

**Audience:** an AI assistant (GitHub Copilot CLI) setting this up in a project repository, and
the human working with it.

**Read this in order.** Sections 1–3 are the whole idea; everything after is mechanism.

---

## 1. What this system is

A project accumulates understanding faster than any single session can hold. The default failure
is not forgetting — it is **lossy re-summarising**: each session compresses the last one's notes,
and after five rounds the notes are a retelling of a retelling, confidently worded and detached
from evidence. The other default failure is the opposite — an append-only log that grows until
the assistant reads only its beginning and end, and the middle silently stops existing.

Both failures come from one mistake: **mixing state with history in a single file.**

| Concern | Answers the question | Growth | Correct write mode |
|---------|---------------------|--------|-------------------|
| State | "What is true now?" | bounded | rewrite |
| History | "What happened?" | unbounded | append, then freeze |

Separate them and there is nothing left to compress. State is rewritten and stays small. History
is written straight into an archive and never touched again. A one-line-per-session index is the
only thing that grows linearly.

This system adds a third element that most note-taking setups lack: a **permanent knowledge base**
(`docs/`) that state graduates into. A conclusion that has stopped moving does not belong in
working memory. Moving it out is what keeps working memory small — not discipline, not summarising.

---

## 2. The routing rule

**This is the core of the system.** Every piece of information has exactly one home. Learn this
table before any file format.

| What it is | Where it goes | Write mode |
|------------|---------------|-----------|
| Settled conclusion about the method | `docs/` | edit in place |
| In-flight reasoning, not yet resolved | `ai-sandbox/CHECKPOINT-<owner>.md` | **rewrite**, ≤150 lines |
| What happened in a session | `ai-sandbox/sessions/<date>-<slug>.md` | create once, **immutable** |
| What an analysis run produced | `ai-sandbox/experiments/EXP-<YYYY-MM-DD>-<slug>.md` | create once, **immutable** |
| Where a fact came from | `ai-sandbox/SOURCES.md` | append; edit status only |
| A question with no answer yet | `ai-sandbox/OPEN_QUESTIONS.md` | add; **delete** when answered |
| Something the method bets on | `ai-sandbox/ASSUMPTIONS.md` | add; **delete** when confirmed |
| Executable logic | `src/` | git |

### The one sentence that matters

> **`ai-sandbox/` is not a second copy of `docs/`.**

When a conclusion matures it **moves**: written into `docs/`, deleted from the sandbox. It is
never copied. Two copies drift, and then nobody can tell which is authoritative — which is the
exact failure this whole structure exists to prevent.

### The graduation test

> Will this still be true in a month?

Yes → `docs/`. Still might turn over → `CHECKPOINT-<owner>.md`. It is a record of an event rather than a
claim → `sessions/` or `experiments/`.

---

## 3. Write modes, and the failure each prevents

Every file in this system has a declared write mode. Violating it is how the system rots.

### Rewrite, one file per owner — `CHECKPOINT-<owner>.md`

Replaced wholesale each time, never appended to. Anything no longer true is **deleted**, not
struck through and not annotated "outdated". The previous version is in git and in the session file.

*Prevents:* current and stale statements interleaving with no marker of which governs. Once that
happens the reader — human or model — cannot trust any line without checking all of them.

**The file is per owner, not per project** — `CHECKPOINT-mk.md`, declared in `AGENTS.md`.
Working alone this means exactly one file, and costs nothing.

*Prevents:* the worst possible git merge. Wholesale rewrite changes nearly every line, so two
people rewriting concurrently conflict across the entire file, and the only resolutions on offer
are "take mine" or "take theirs" — both silently discarding a colleague's session. One file per
owner removes the shared write entirely. It also means adding a second person later is a no-op:
they create their own file and nothing else moves. Retrofitting this onto an established
project means renaming a file referenced from the index and every playbook, usually discovered
*via* the conflict that already ate someone's work.

If genuinely shared in-flight state exists, add one short `CHECKPOINT.md` alongside, owned by
whoever coordinates. Most projects never need it.

### Hard cap — each checkpoint ≤ 150 lines

**Exceeding the cap means something needs promoting to `docs/`. It does not mean shorten the prose.**

*Prevents:* the lossy re-summarising described in §1. Compression is a decision about what to
forget, made by whoever is least equipped to know what will matter in six months. If the file is
over 150 lines, find the most settled part and move it out. Rewording to fit is the precise
mistake this system is built to stop.

The cap is **per file**, so each person gets their own budget. One shared budget across two
in-flight threads either overflows constantly — firing spurious promotion pressure when it
merely holds two people's work — or lets one thread crowd out the other.

### Written for someone who was not there

Every checkpoint entry, and every session and experiment record, is written for a reader who did
not attend the session. Test each entry: *could someone who missed it act on this?*

*Prevents:* notes that are a memory aid rather than an explanation. A checkpoint holds only what
is unresolved, which tempts terseness that relies on context the writer still carries. **Time
separates you from your own context as effectively as another person does** — in three months
the stranger is you, and the only way you find out the entries were too terse is a painful
re-entry six months later.

### Immutable — `sessions/`, `experiments/`

Once written, the file is never edited. A correction goes into the *next* session file, referring
back to the earlier one.

*Prevents:* a rewritten history that agrees with present belief. The value of a record is that it
captures what was believed at the time, including what turned out wrong.

### Append-only — `sessions/LOG.md`, `experiments/LOG.md`

One row per entry. Read by searching for a row, never in full.

Rows name **what was resolved**, not only what was worked on. The log is the discoverable index:
it is where a reader looks first and the only file scanned in bulk.

### Delete-on-resolve — `OPEN_QUESTIONS.md`, `ASSUMPTIONS.md`

An answered question is **deleted**, not marked `Resolved`. A confirmed assumption is promoted to
`docs/` and **deleted**. The answer lives in the session file and, if durable, in `docs/`.

*Prevents:* registers becoming landfill. A file that is 80% resolved entries is one nobody reads,
and an unread register is worse than none — it looks like coverage while providing none.

**Deletion is only safe if the resolution is discoverable**, which is why the `LOG.md` row names
it. Otherwise a reader finds the question simply gone, with no cue that an answer exists in a
session file they have no reason to open — and again, that reader is usually you, later.

Entries carry a **`Raised:` date**. What rots a register worked alone is not unowned items but
*undisclosed age*: nothing otherwise shows that a question has been open for four months.

### Shared singletons — the registers

`OPEN_QUESTIONS.md`, `ASSUMPTIONS.md`, `SOURCES.md`, and `DATA_ENVIRONMENT.md` stay single shared
files even with several contributors. Their edits are localised — a new entry at the tail, a
status change on one line — so concurrent changes merge cleanly or conflict on one resolvable
line. Only the rewritten file needed splitting.

---

## 4. Directory structure

```
AGENTS.md                      ← auto-loaded entry point; @imports the index
.gitignore                     ← enforces the never-commit list (§9)

docs/                          ← permanent knowledge base: settled conclusions only
  problem.md                   ← problem statement, success criteria, stakeholders
  method.md                    ← the method being designed — current best understanding
  constraints.md               ← scope, compute, data, delivery constraints
  glossary.md                  ← domain terms
  techniques/<name>.md         ← evaluated techniques, including rejected ones
  decisions/ADR-NNN-<slug>.md  ← decision records

ai-sandbox/                    ← working memory between sessions
  INDEX.md                     ← entry point; current focus
  CHECKPOINT-<owner>.md        ← in-flight reasoning; one per person, ≤150 lines
  CHECKPOINT.md                ← optional: shared in-flight state, if any
  OPEN_QUESTIONS.md            ← active questions only
  ASSUMPTIONS.md               ← what the method bets on
  SOURCES.md                   ← source register
  DATA_ENVIRONMENT.md          ← Databricks access, tables, uv setup, run recipes
  playbooks/                   ← procedures: session-start, checkpoint, promote,
                                 ingest-source, run-experiment
  sessions/LOG.md + <date>-<slug>.md
  experiments/LOG.md + EXP-<YYYY-MM-DD>-<slug>.md

src/                           ← Python, managed by uv
sources/                       ← committable source material only (§9)
```

### Why `docs/` is split this way

`method.md` describes the method as it currently stands — no history, no "we used to think".
`decisions/` carries the history of *why*, one file per decision that was genuinely contested.
`techniques/` holds evaluations of candidate approaches, one per technique.

The split exists because these three answer different questions and rot at different rates.
`method.md` is rewritten often. An ADR is written once and never changes. A technique evaluation
changes only if the technique is re-examined.

### Identifiers

Four things get IDs, and they deliberately use three different schemes. Uniformity is not the
goal — each scheme is chosen for how that ID is actually used.

| Thing | ID | Example | Cited as |
|-------|-----|---------|----------|
| Session | the date-slug filename; **no counter** | `2026-08-16-latency-budget.md` | linked from `LOG.md` |
| Source | `S-<slug>` | `S-arch-spec-v2` | `[S-arch-spec-v2 §3.2]` |
| Experiment | `EXP-<YYYY-MM-DD>-<slug>` | `EXP-2026-08-16-ablation-c` | `[EXP-2026-08-16-ablation-c]` |
| ADR | `ADR-<NNN>-<slug>` — **the one counter** | `ADR-007-feature-store` | linked |

**Sources are slugs because they are cited inline, mid-sentence.** A citation should be readable
without a lookup: `[S-latency-spec §3.2]` says what it is, `[S-014]` does not, and in a document
citing thirty sources that difference compounds on every read.

**Experiments are date-prefixed because chronology carries meaning.** They proliferate and form
supersession chains, so a directory that sorts chronologically is worth the extra length — and
they are cited in dedicated Evidence sections rather than mid-prose, where length costs little.

**ADRs keep a counter** because `ADR-007` is a convention colleagues already recognise, they are
rare and deliberate, and a collision between two of them is one file and trivially resolved.
Breaking a known convention needs a better reason than consistency.

**Sessions lose their counter entirely.** It duplicated the date already in the filename, and
`S07` was one character from the source prefix `S-007` — two unrelated namespaces that looked
alike in prose. The filename is the identifier.

Two consequences worth internalising:

- **No ID requires a lookup to allocate.** Counters force you to scan the register for the
  highest number before adding anything. Slugs and dates do not. That is friction removed from
  every ingestion and every experiment, even working alone.
- **A slug, once assigned, is never changed.** It will eventually look inaccurate — name the
  document's identity, not the claim you wanted from it, and live with it. Renaming breaks
  every citation silently, because a stale citation still looks perfectly valid. This is the
  one real cost of dropping counters, and it is paid by discipline rather than by tooling.

These schemes are also what make the archive safe when more than one person contributes:
nothing needs a shared counter, so two people working at once collide only when they created
genuinely the same thing — which is a merge, not a conflict. See §14.

---

## 5. Setup on GitHub Copilot CLI

### Instruction loading

Copilot CLI automatically loads, from the repository root, the current working directory, and
directories between them:

- `AGENTS.md` — **use this as the entry point**
- `.github/copilot-instructions.md` and `.github/instructions/**/*.instructions.md`
- `CLAUDE.md` and `.claude/CLAUDE.md`
- `GEMINI.md`
- user-level: `~/.copilot/copilot-instructions.md`, `~/.copilot/instructions/**/*.instructions.md`

`AGENTS.md`, `CLAUDE.md`, and `.github/copilot-instructions.md` support **`@` imports**: a line
containing `@` followed by a repo-relative path pulls that file's contents in. Imports do **not**
expand in `GEMINI.md` or `*.instructions.md` files, and paths must stay inside the repository —
absolute paths and `~/` are rejected.

Because Copilot CLI also reads `CLAUDE.md`, a project set up this way works unchanged if you ever
move to Claude Code. Keep the content in `AGENTS.md`.

> **Critical, and invisible when it fails:** an instruction file that nothing imports has no
> effect. It will look correct in the repository and be silently absent from every session. If a
> file is meant to shape the assistant's behaviour, it must be reachable through `AGENTS.md`.
> Verify by asking the assistant, in a fresh session, to state a rule that appears only in the
> imported file.

### Procedures: playbooks, not slash commands

**Copilot CLI does not support user-defined slash commands.** Repeatable procedures are therefore
plain Markdown files in `ai-sandbox/playbooks/`, invoked by asking for them:

```
Follow ai-sandbox/playbooks/checkpoint.md
```

`AGENTS.md` lists them so the assistant knows they exist.

Copilot CLI *does* support **custom agents** — `.github/agents/<name>.agent.md`, project-level, or
`~/.copilot/agents/` for personal ones, invoked with `/agent`, by asking in natural language, or
via `copilot --agent <name> --prompt "…"`. Deliberately **do not** use them for the core
procedures. A custom agent is an isolated worker with its own context; `checkpoint` and `promote`
edit files across the whole repo and must confirm with the user before touching `docs/`. Isolation
works against both.

Custom agents suit one thing here well: ingesting a large PDF, where the bulk of the reading should
not land in the main session's context. Optional, and only once the rest is working.

### Tool permissions

Copilot CLI prompts before running commands. Allow the read-only ones you use constantly —
`git log`, `git status`, `git diff`, `ls`, `find`, `rg`, `wc` — so sessions are not interrupted.
Keep write and network operations prompted.

---

## 6. File templates

Copy these verbatim. `<PLACEHOLDER>` marks what to replace.

### `AGENTS.md`

```markdown
# <PROJECT_NAME>

## About this project

<One paragraph: what is being researched or designed, and for whom.>

R&D project. The method is being discovered, not implemented from a specification.
Knowledge arrives from documentation, Confluence, call transcripts, discussion, and
data analysis against Azure Databricks. Analysis code is Python, managed with `uv`.

## Session entry point

@ai-sandbox/INDEX.md

## Working rules

- **Owner token:** `<owner>` — my checkpoint is `ai-sandbox/CHECKPOINT-<owner>.md`. Write to
  that file only; other `CHECKPOINT-*.md` files belong to other people.
- `docs/` is the permanent knowledge base: settled conclusions only. **Changes to `docs/` are
  reviewed before they land** — propose the change, then apply it once approved. Working alone
  that means a deliberate diff pass; with colleagues it means a pull request.
- `ai-sandbox/` is working memory. It is *not* a second copy of `docs/`. A matured
  conclusion moves and is deleted from the sandbox, never copied.
- `CHECKPOINT-<owner>.md` is rewritten, never appended, and capped at 150 lines. Over the cap
  means something needs promoting to `docs/` — not that the prose needs shortening.
- Write every entry for a reader who missed the session. In three months that reader is me.
- Files in `sessions/` and `experiments/` are immutable once written. Corrections go
  into the next one.
- Answered questions and confirmed assumptions are **deleted** from their registers,
  not marked resolved — and the `LOG.md` row names what was resolved, so the answer
  stays discoverable.
- Every number that enters `docs/` carries a date and a source.
- Never commit credentials, tokens, PII, or raw extracted data. See `ai-sandbox/SOURCES.md`.

## Procedures

Ask to follow one of these by path:

| Playbook | When |
|----------|------|
| `ai-sandbox/playbooks/session-start.md` | Opening a session |
| `ai-sandbox/playbooks/checkpoint.md` | Closing a session, or any save point |
| `ai-sandbox/playbooks/promote.md` | Moving a conclusion into `docs/` |
| `ai-sandbox/playbooks/ingest-source.md` | Adding a PDF, Confluence page, or transcript |
| `ai-sandbox/playbooks/run-experiment.md` | Running and recording an analysis |

## Commits

Conventional Commits. Types used here: `docs`, `feat`, `fix`, `chore`, `exp`.
```

### `ai-sandbox/INDEX.md`

```markdown
# <PROJECT_NAME> — Session Index

**Updated:** <DATE>

Entry point for every session. Loaded automatically through `AGENTS.md`.

---

## Routing rule

| What | Where |
|------|-------|
| Settled conclusion | `docs/` |
| In-flight reasoning | `CHECKPOINT-<owner>.md` (one per person) |
| What happened in a session | `sessions/<date>-<slug>.md` |
| What an analysis produced | `experiments/EXP-<YYYY-MM-DD>-<slug>.md` |
| Where a fact came from | `SOURCES.md` |

`ai-sandbox/` is **not a second copy** of `docs/`. Matured conclusions move out.

---

## Artifacts

| File | Contents | Write mode |
|------|----------|-----------|
| `CHECKPOINT-<owner>.md` | Current unresolved state | rewrite, ≤150 lines |
| `OPEN_QUESTIONS.md` | Active questions (resolved are deleted) | edit |
| `ASSUMPTIONS.md` | What the method bets on | edit |
| `SOURCES.md` | Source register with IDs | append |
| `DATA_ENVIRONMENT.md` | Databricks, uv, run recipes | edit |
| `sessions/LOG.md` | One row per session | append only |
| `experiments/LOG.md` | One row per experiment | append only |

---

## Current focus

<2–4 lines: the live question, and what is blocking it.>

---

## What a new session does

1. Read this file, then your `CHECKPOINT-<owner>.md`, then `OPEN_QUESTIONS.md`.
2. Do not read `docs/` wholesale — open a document when it is actually needed.
3. Ask for the session focus if it was not given.
4. Close with `playbooks/checkpoint.md`.
```

### `ai-sandbox/CHECKPOINT-<owner>.md`

```markdown
# <PROJECT_NAME> — Checkpoint · <owner>

**Updated:** <DATE> · **Limit: 150 lines**

> **This file belongs to one person.** Rename it `CHECKPOINT-<your-token>.md` and declare the
> token in `AGENTS.md`. Other `CHECKPOINT-*.md` files are read-only to you.
>
> Only what is **in progress and not yet settled** in `docs/`.
> This file is **rewritten**, not appended. Delete what is no longer true — do not strike it out.
> An entry unchanged for 3+ weeks is a conclusion, not a process: promote it.
> Write each entry so someone who missed the session could act on it — in three months,
> that someone is you.

---

## Current state

| Item | Value | Source |
|------|-------|--------|
| | | |

---

## In progress

### Gap 1 — <name> (priority: high | medium | low)

<What is unresolved, and what closing it depends on.>

---

## Promotion candidates

<Entries that look ready to move into `docs/`. Empty is a healthy state.>

---

## Out of scope for this session

<Things a session should not drift into.>
```

### `ai-sandbox/OPEN_QUESTIONS.md`

```markdown
# <PROJECT_NAME> — Open Questions

**Updated:** <DATE>

> **Open questions only.** An answered question is **deleted** from this file — the answer
> goes into the session record and, if durable, into `docs/`. Status `Resolved` is not used
> here; keeping resolved entries turns the register into a landfill nobody reads.

**Priority:** 🔴 high · 🟡 medium · 🟢 low

> **`Owner:` is always filled in, even working alone.** Blank must mean *nobody has
> claimed this* — the signal the field exists to carry. If solo-era entries are left
> blank, that meaning is destroyed the day a second person joins.

---

## Q<N> · <short title> 🔴

**Raised:** <DATE> · **Owner:** <owner>
**Source:** <where the gap surfaced — a document, a source ID, a session>
**Question:** <what is unknown>
**Why it matters:** <what decision it blocks>
**Progress:** <what has been established so far, or "none">
```

### `ai-sandbox/ASSUMPTIONS.md`

```markdown
# <PROJECT_NAME> — Assumption Register

**Updated:** <DATE>

> What the method **bets on, and where it could be wrong**. Not "what I understood about the
> project" — that belongs in `docs/`. The test: *if this turned out false, what breaks?*
>
> Type: `CONFIRMED` (verified) · `INFERRED` (derived logically) · `ASSUMED` (plausible, unverified)
>
> **`CONFIRMED` is no longer an assumption.** It moves to `docs/` and is deleted from here,
> which is what keeps this register bounded.

> **`Owner:` is always filled in, even working alone.** Blank must mean *nobody has
> claimed this* — the signal the field exists to carry. If solo-era entries are left
> blank, that meaning is destroyed the day a second person joins.

---

## A<N> · <statement> — `ASSUMED`

**Raised:** <DATE> · **Owner:** <owner>
**Basis:** <what it rests on — source ID, reasoning, or convention>
**If false:** <what breaks, and how badly>
**What would settle it:** <the check that would confirm or kill it>
```

### `ai-sandbox/SOURCES.md`

See §9 for the discipline. Template:

```markdown
# <PROJECT_NAME> — Source Register

**Updated:** <DATE>

> Every fact in `docs/` that came from outside is traceable to an ID here.
> Cite as `[S-latency-spec §3.2]`.
>
> **IDs are slugs, not numbers.** A slug names the **document's identity** — `S-arch-spec-v2`,
> `S-kickoff-call-0412` — not the claim you wanted from it. Once assigned it is **never
> changed**: renaming breaks every citation silently, because a stale citation still looks valid.
>
> **Sensitivity governs storage.** `committable` → the file lives in `sources/`.
> `reference-only` → the artifact is **never** placed in the repository; only the pointer is.
> Default is `reference-only`. Committing is a deliberate exception.

## Never commit

Credentials · tokens · connection strings · PII · raw extracted data · customer names ·
anything whose sensitivity has not been established.

---

| ID | Type | Title | Sensitivity | Date read | Status |
|----|------|-------|-------------|-----------|--------|
| `S-<slug>` | | | | | |

---

## S-<slug> · <title>

**Type:** PDF | Confluence | transcript | conversation | dataset doc
**Origin:** <URL, SharePoint path, or `sources/<file>`>
**Source date:** <when the source itself was written>
**Date read:** <when it was ingested — matters for mutable sources>
**Sensitivity:** committable | reference-only
**Status:** ingested | partial | superseded by S-<slug>
**Answers:** <which questions this source can settle>
**Notes:** <caveats, contested claims, sections worth revisiting>
```

### `ai-sandbox/sessions/LOG.md`

```markdown
# <PROJECT_NAME> — Session Log

Append only. One row per session. **Do not read in full** — find the row by topic or date,
then open the session file.

| Date | Topic | Outcome | Link |
|------|-------|---------|------|
```

### `ai-sandbox/sessions/<date>-<slug>.md`

```markdown
# <DATE> · <topic>

**Status:** closed

---

## Objective

<What this session set out to do.>

## Reasoning

<How the thinking went, including paths tried and abandoned. This file is the only
place holding full detail — everything else is a summary of it.>

## Decisions

<What was settled, and what moved into `docs/`.>

## Found along the way

<Discoveries incidental to the objective. Often the most valuable part.>

## Next

<What the following session should pick up.>
```

### `ai-sandbox/experiments/LOG.md`

```markdown
# <PROJECT_NAME> — Experiment Log

Append only. One row per experiment. A negative result is a complete result.

| ID | Date | Question | Verdict | Link |
|----|------|----------|---------|------|
```

### `ai-sandbox/experiments/EXP-<YYYY-MM-DD>-<slug>.md`

```markdown
# EXP-<YYYY-MM-DD>-<slug>

**Date:** <DATE> · **Status:** complete | aborted
**Question:** <the single question this run answers>

---

## Reproducibility

| Field | Value |
|-------|-------|
| Git SHA | `<sha>` |
| `uv.lock` | `<hash>` or "unchanged since EXP-<YYYY-MM-DD>-<slug>" |
| Entry point | `src/experiments/<file>.py` |
| Data source | `<catalog.schema.table>` |
| Snapshot date | <date the data was read — upstream tables mutate> |
| Filters / slice | <row and column selection> |
| Cluster / runtime | <DBR version, node type, count> |
| Run duration | <time> |

## Setup

<What was varied, what was held fixed, and the baseline compared against.>

## Result

<The numbers, with uncertainty. State the metric and its definition.>

## Verdict

**supports | contradicts | inconclusive** — <one line>

## What this changes

<Which open question it touches, which assumption it moves, what it proposes for `docs/`.>

## Threats to this result

<Leakage, sample size, confounds, anything that would make it not replicate.>
```

### `docs/decisions/ADR-NNN-<slug>.md`

```markdown
# ADR-<NNN> · <title>

**Date:** <DATE> · **Status:** accepted | superseded by ADR-<NNN>

## Context

<The situation forcing a choice. What made this contested.>

## Decision

<What was chosen.>

## Alternatives considered

| Option | Why not |
|--------|---------|
| | |

## Consequences

<What this commits the project to, including the costs accepted.>
```

### `docs/techniques/<name>.md`

```markdown
# <Technique>

*Status: under evaluation | evaluated — adopted | evaluated — rejected*
*Role: <what job it would do in the method>*

## What it is

<Intuitive picture first, then the technical definition.>

## What needed checking

<Checklist agreed **before** evaluation started.>
- [ ] <criterion>

## Mechanics

## Requirements

<Data, compute, latency, licensing.>

## Evidence

<Experiment IDs and source IDs supporting the assessment.>

## Risks and failure modes

## Conclusion

**Adopted | Adopted with caveats | Rejected** — <why, in one paragraph>
```

---

## 7. Playbooks

Each is a file in `ai-sandbox/playbooks/`. Copy the content below into the corresponding file.

### `session-start.md`

```markdown
# Playbook — Open a session

## Read, in this order

1. `ai-sandbox/INDEX.md` — current focus
2. `ai-sandbox/CHECKPOINT-<owner>.md` — what is in progress. If other `CHECKPOINT-*.md`
   files exist, skim them too: they are colleagues' in-flight work, read-only to you
3. `ai-sandbox/OPEN_QUESTIONS.md` — active questions

**Do not** read `docs/` in full, and do not read `sessions/LOG.md` in full. Open a
specific document when the discussion actually needs it. The point of the index is to
avoid loading the whole knowledge base into every session.

## Report back, ~10 lines maximum

- where the last session stopped
- what is currently in progress
- the 2–3 highest-priority open questions
- a proposed focus for this session

Then **stop and wait** for confirmation or redirection. Do not start work unprompted.

## Staleness checks

- **Stalled entry.** If a `CHECKPOINT-<owner>.md` entry has not changed in 3+ weeks (check
  `sessions/LOG.md`), flag it as a promotion candidate: it is a conclusion, not a process.
- **Aging numbers.** If the checkpoint holds figures marked unverified and the session
  touches them, offer to re-check against the data before reasoning on top of them.
- **Mutable sources.** If a claim in play cites a Confluence page read more than a few
  months ago, flag that the page may have changed.
```

### `checkpoint.md`

```markdown
# Playbook — Close a session

Run at the end of a session, or at any point a reliable save is wanted.
Follow the steps **in order**.

## 1. Write the session file

`ai-sandbox/sessions/YYYY-MM-DD-<slug>.md`, slug in lowercase with hyphens.

Contents: objective, how the reasoning went, decisions, incidental findings, what is next.
Full detail belongs here — this file is its only home. Several sessions in one day get a
numeric suffix (`-2`).

**Once written, this file is immutable.** Errors in it are corrected in the *next* session,
not edited retroactively.

## 2. Decide what graduates to `docs/`

Review the session's output for conclusions that have stopped moving. **List the candidates
for the user and wait for agreement** — `docs/` is never modified without it. On agreement,
follow `promote.md`.

Test: still true in a month → `docs/`. Might still turn over → checkpoint.

## 3. Rewrite `CHECKPOINT-<owner>.md`

**Rewrite the whole file. Do not append.** Write only `CHECKPOINT-<owner>.md` — the file
named by the owner token in `AGENTS.md`. Other people's checkpoints are never edited.

- Delete everything no longer true. Do not strike through or mark "outdated" — delete.
  Previous versions are in git and in the session file.
- Delete everything promoted in step 2.
- Keep only what is unresolved.
- Check the limit: `wc -l ai-sandbox/CHECKPOINT-<owner>.md` ≤ 150.

**If it exceeds 150 lines**, something needs promoting — that is not a signal to shorten
the wording. Find the most settled part and move it to `docs/`. Compressing prose to fit
the cap is the exact failure this system exists to prevent.

## 4. Update the registers

`OPEN_QUESTIONS.md` — **delete** answered questions (do not mark them resolved); add
questions raised this session.

`ASSUMPTIONS.md` — an assumption that became `CONFIRMED` is promoted to `docs/` and
**deleted** here; one proven false is deleted, with its consequence recorded in the
checkpoint as a gap; add new assumptions surfaced this session.

`SOURCES.md` — add any source consulted this session that is not yet registered.

## 5. Update the log and index

- `sessions/LOG.md` — one row: date, topic, outcome, link to the session file. The outcome
  names **what was resolved**, not just what was worked on: this row is the only cue a later
  reader gets that a deleted question ever had an answer.
- `experiments/LOG.md` — a row for each experiment run this session.
- `INDEX.md` — update the date and "Current focus". Leave the rest alone
  unless the structure genuinely changed: this file loads into every session and must
  stay small and stable.

## 6. Propose a commit

Conventional Commits. Show the message and **wait for confirmation — do not commit
unprompted.**

## Checklist

- [ ] Session file written
- [ ] Promotions agreed and applied
- [ ] `CHECKPOINT-<owner>.md` rewritten, ≤150 lines
- [ ] Registers updated, resolved entries deleted
- [ ] `LOG.md` and `INDEX.md` updated
- [ ] Commit proposed
```

### `promote.md`

```markdown
# Playbook — Promote a conclusion into `docs/`

Moves a matured conclusion from working memory into the permanent knowledge base.
Governing rule: **`docs/` reflects current understanding.** Outdated sections are
rewritten, never left standing beside newer ones.

## 1. Pick the destination

| What is moving | Where |
|----------------|-------|
| Problem framing, success criteria | `docs/problem.md` |
| How the method works | `docs/method.md` |
| A contested choice and its rationale | `docs/decisions/ADR-NNN-<slug>.md` |
| Assessment of a candidate technique | `docs/techniques/<name>.md` |
| Scope, compute, data, delivery limit | `docs/constraints.md` |
| A term used with a specific meaning | `docs/glossary.md` |

If it fits nowhere, it is probably not ready. Leave it in the checkpoint.

## 2. Find what it replaces

**Mandatory.** Search `docs/` for existing statements on the topic before writing anything.
A new conclusion almost always refines or overturns something already recorded.

One conclusion often touches several files. Update all of them in a single commit —
leaving one behind puts the knowledge base into a self-contradictory state, which is worse
than not having recorded the conclusion at all.

## 3. Rewrite in place

- Rewrite the outdated section. **Do not add a new section beside it.**
- No "previously X, now Y" phrasing. `docs/` describes the present; history lives in git,
  `sessions/`, and `decisions/`.
- Match the surrounding style.
- Every number carries a date and a source ID.
- Claims from external material cite their source: `[S-latency-spec §3.2]`.

## 4. Sync the open questions

If this closes a question, delete it from `OPEN_QUESTIONS.md` and clear any corresponding
checkbox in the `docs/` file it came from.

## 5. Delete the working copy

Remove what moved from `CHECKPOINT-<owner>.md` / `ASSUMPTIONS.md`. Duplication between `docs/` and
`ai-sandbox/` is precisely what this system is built to prevent: two copies drift, and then
neither is trustworthy.

## 6. Report

List the files changed and what changed in each, then propose a commit. Do not commit
without confirmation.

`docs/` changes are **reviewed before they land**. Working alone that is a deliberate pass over
the diff; with colleagues it is a pull request. The check that matters is step 2 — that every
file the conclusion touches was updated, not just the obvious one.

## When **not** to promote

- The conclusion rests on unverified numbers — verify first.
- It was floated for consideration, without the user's agreement.
- It could still turn over next session. Leave it in the checkpoint.
```

### `ingest-source.md`

```markdown
# Playbook — Ingest a source

For a PDF, Confluence page, call transcript, or any external material entering the project.

## 1. Register before reading

Choose a slug and add the entry to `SOURCES.md`. Record type, origin, source date,
**date read**, sensitivity, and status.

The slug names the **document's identity**, not the claim you wanted from it:
`S-arch-spec-v2`, `S-kickoff-call-0412`, `S-latency-spec`. There is no counter to look up,
and two people ingesting concurrently collide only when it is genuinely the same document —
which is a merge, not a conflict.

**A slug, once assigned, is never changed.** It will eventually look inaccurate. Rename it
and every citation breaks silently, because a stale citation still looks perfectly valid.
Live with the imperfect name.

**Decide sensitivity first.** Default is `reference-only` — the artifact stays out of the
repository and only the pointer is stored. Only mark `committable` when it is established
that the material may live in the repo; then place it in `sources/`. If sensitivity is
unclear, it is `reference-only`. This is the one decision in the system that a later edit
cannot undo: once committed, the content is in git history.

## 2. State what it is expected to answer

Before extracting anything, write down which open questions this source might settle. This
prevents ingestion becoming an end in itself, and makes it obvious when a source turns out
not to contain what was hoped.

## 3. Extract, with citations

Pull out claims relevant to the project. Each carries a locator — page, section, heading,
or transcript timestamp — so `[S-latency-spec §3.2]` resolves to something.

Separate:

- **stated in the source** — quote or close paraphrase
- **inferred from it** — the interpretation, marked as such
- **contradicts existing knowledge** — flag loudly; this is the highest-value outcome

## 4. Route the output

- Settles an open question → follow `promote.md`; delete the question.
- Interesting but unresolved → `CHECKPOINT-<owner>.md`.
- Something the method now relies on → `ASSUMPTIONS.md`.
- Raises new questions → `OPEN_QUESTIONS.md`, citing the source ID.

## Source-type caveats

| Type | Caveat |
|------|--------|
| Confluence | **Mutable.** Record the date read; the page can change or be deleted underneath a claim. Re-verify anything load-bearing. |
| Call transcript | Speech is imprecise and often speculative. Distinguish a decision from thinking aloud. Attribute claims to speakers when it matters. |
| PDF / report | Check its own date and provenance — a report may itself cite something stale. |
| Conversation with an AI | Not a source. Reasoning to be verified, and it is recorded in `sessions/`, not `SOURCES.md`. |
```

### `run-experiment.md`

```markdown
# Playbook — Run and record an experiment

## 1. State the question first

One sentence, written before the run: what would this result change? An experiment without
a stated question cannot fail, and therefore teaches nothing.

State the expected outcome too. A result only surprises if there was a prior.

## 2. Fix the reproducibility triple

Before running, record: git SHA, `uv.lock` state, and the data source **with its snapshot
date**. Upstream Databricks tables are mutable — a table name alone does not identify the
data. See `DATA_ENVIRONMENT.md`.

Commit the analysis code before running it. A result tied to uncommitted code is not
reproducible.

## 3. Run

Keep the entry point a script in `src/experiments/`, not an ad-hoc notebook cell.
Notebooks are for exploration; anything producing a recorded result needs a file that
can be re-run.

## 4. Write the record

`ai-sandbox/experiments/EXP-<YYYY-MM-DD>-<slug>.md`, using the template. Immutable once written.

Fill in **Threats to this result** honestly — leakage, sample size, confounds. This section
is what stops a result from being over-claimed six months later by someone who has forgotten
its caveats, including you.

## 5. Give a verdict

**supports · contradicts · inconclusive.** "Inconclusive" is a legitimate and common outcome;
recording it prevents the experiment being re-run identically later.

**A negative result is a complete result.** Record it with the same care as a positive one
and keep it on file. Negative findings are the ones most reliably lost, and re-running a
known-failed approach is a standard way to lose a week.

## 6. Route it

- Adds a row to `experiments/LOG.md`.
- Changes what the method does → `promote.md` into `docs/method.md` or `docs/techniques/`.
- Settles an assumption → update `ASSUMPTIONS.md` (confirmed ones move to `docs/` and are deleted).
- Raises questions → `OPEN_QUESTIONS.md`.
```

---

## 8. Experiment discipline

The reason experiments get their own archive rather than living in session notes:

> Three months on, `docs/method.md` states "approach B beats A by 12%". Nobody can say which
> data snapshot, which code, or which cluster produced it. The claim is now unfalsifiable, and
> unfalsifiable claims quietly become folklore that the project builds on.

A notebook does not solve this. Notebooks are edited in place, run out of order, and hold no
record of the data as it was.

### What makes a result survive

| Field | Why it is mandatory |
|-------|--------------------|
| Question | An experiment without a question cannot fail |
| Git SHA | The code as it was, not as it is now |
| `uv.lock` | Library versions change results silently |
| Table **+ snapshot date** | Upstream tables mutate; the name alone identifies nothing |
| Cluster / runtime | Runtime and Spark versions change numerical behaviour |
| Result + uncertainty | A point estimate with no spread cannot be compared |
| Verdict | Forces a conclusion while the context is fresh |
| Threats | What would make it not replicate |

### Graduating a result into `docs/`

A single experiment rarely changes the method. What belongs in `docs/method.md` is the
**conclusion drawn across experiments**, citing their IDs:

> Feature set C is dropped: it adds 0.3pp at four times the compute `[EXP-2026-05-04-ablation-c, EXP-2026-05-11-cost-c]`.

The experiment records stay where they are. `docs/` holds the claim; `experiments/` holds
the evidence. This is the same separation as `docs/` versus `sessions/` — conclusion in one
place, the trail in another.

---

## 9. Source discipline

### Why IDs

Once a PDF has been distilled into a paragraph in `docs/`, the route back to its origin is
gone. When a stakeholder challenges the claim — or the Confluence page changes underneath it —
there is no way to re-check without re-reading everything. An ID assigned at ingestion costs
seconds and makes the claim auditable:

> Latency budget is 200 ms end-to-end `[S-latency-spec §3.2]`.

### Sensitivity and the never-commit list

Every source is `committable` or `reference-only`, decided **at ingestion**, defaulting to
`reference-only`.

| Class | Storage | Cited as |
|-------|---------|----------|
| `committable` | `sources/` in the repo | file path + page/section |
| `reference-only` | never in the repo | external URL/path + access note |

**Never commit, under any classification:**

credentials · tokens · connection strings · workspace URLs with embedded secrets · PII ·
customer or client names where confidentiality applies · raw extracted data · anything whose
sensitivity has not been established

Back this with `.gitignore`:

```gitignore
# Never commit
.env
*.key
*.pem
secrets/
data/
sources/reference-only/

# Python / uv
.venv/
__pycache__/
.ipynb_checkpoints/
```

This is the one rule in the system where a mistake is not repaired by editing a file: once
committed, the content lives in git history, and removing it means rewriting history on every
clone. Treat `reference-only` as the default and `committable` as the deliberate exception.

### Mutable sources

Confluence pages and shared documents change without notice. The register records the **date
read**, not just the source date. A load-bearing claim resting on a page read long ago is
re-verified rather than trusted. `session-start.md` includes this check.

---

## 10. Data environment

`ai-sandbox/DATA_ENVIRONMENT.md` records what makes a run repeatable — and nothing that must
stay secret.

```markdown
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
timezone conventions, columns that are not what their names suggest. This section pays for
itself the second time someone is bitten.>

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
```

### Why the data traps section matters most

It is the part that cannot be re-derived from the code. A column whose nulls mean "not
applicable" rather than "unknown" will produce a plausible, wrong answer, silently, every time,
until someone notices. Write these down the moment they are found — that is knowledge with no
other home in the repository.

---

## 11. Bootstrapping an existing project

For a project already underway with material piled up. Roughly one working session.

**1. Create the structure.** Directories and files from §4 and §6, all empty. Add `.gitignore`
from §9 first, before any source material is anywhere near the repo.

**2. Write `AGENTS.md`.** Project description and working rules. Pick an **owner token** — your
initials are fine — and declare it there; your checkpoint is `CHECKPOINT-<token>.md`. Working
alone that is one file, and it means a second contributor later costs nothing to add.

Verify the import works: in a fresh session, ask the assistant to state a rule that appears only
in `INDEX.md`. If it cannot, the import is not loading and every rule below it is inert.

**3. Register sources before reading them.** List all existing material — PDFs, Confluence
pages, transcripts — into `SOURCES.md` with IDs and sensitivity. Registering is fast;
ingesting is not. Do the registration in one pass so the inventory is complete, then ingest in
priority order.

**4. Write `docs/problem.md` first.** What is being solved, for whom, and what "done" means. If
this cannot be stated crisply, that is the most valuable finding of the day — record the
ambiguity in `OPEN_QUESTIONS.md`.

**5. Capture current understanding into `CHECKPOINT-<owner>.md`.** Everything currently believed but
not written down. Do not attempt to distil it into `docs/` yet — it has not been tested by a
session, and premature promotion puts unstable claims in the permanent base.

**6. Backfill the session log.** If the project has git history, reconstruct one row per
significant past episode from the commits. Approximate rows are worth more than an empty log.

**7. Seed `DATA_ENVIRONMENT.md`** with the tables already in use and every data trap already
known. This will be incomplete. Incomplete and growing is the working state.

Do **not** try to fill everything at once. `OPEN_QUESTIONS.md` and `ASSUMPTIONS.md` populate
naturally as sessions run; forcing entries produces filler that trains everyone to skim.

---

## 12. Failure modes

What rot looks like, and what it actually means. Check against this every few sessions.

| Symptom | Real cause | Correct response |
|---------|-----------|------------------|
| `CHECKPOINT-<owner>.md` over 150 lines | Something in it has settled | **Promote.** Do not compress. |
| An entry unchanged for 3+ weeks | It is a conclusion, not a process | Promote |
| The assistant reads only head and tail of a file | That file mixes state with history | Split it — this is the failure §1 describes |
| The same fact in `docs/` and `ai-sandbox/` | A promotion copied instead of moved | Delete the sandbox copy |
| `OPEN_QUESTIONS.md` full of `Resolved` entries | Statuses used instead of deletion | Delete them |
| A number in `docs/` with no date or source | Provenance discipline lapsed | Re-verify or remove it |
| Sessions re-deriving the same conclusion | It never made it into `docs/` | Promote it now |
| A claim nobody can trace | Source was never registered | Register it retroactively, or drop the claim |
| An experiment that cannot be re-run | Reproducibility triple not captured | Treat its result as unverified |
| A rule in an instruction file having no effect | Nothing imports the file | Reachable from `AGENTS.md`, or it does not exist |

The last one deserves emphasis: it was found by accident in the project this system came from,
where a file defining how the assistant should communicate sat in the repository for five
sessions with nothing loading it. It looked correct. It never ran. **A silent failure of
instruction loading is invisible from inside the session** — the only way to catch it is to ask
the assistant to state a rule that lives exclusively in the imported file.

---

## 13. Assistant profile (optional)

If explanations land consistently too shallow or too deep, add a profile file and import it
from `AGENTS.md` — otherwise it does nothing (§12).

```markdown
# Assistant profile — <PROJECT_NAME>

## Who I am

<Role and depth in the relevant fields. Be specific about the boundary: which areas
are hands-on experience, and which are new territory. Generic seniority labels do not
calibrate anything.>

## How to work with me

- Build on my reasoning rather than listing alternatives.
- Be explicit about uncertainty — say plainly when something is speculative or contested.
- Use structure where it helps: comparisons, trade-off tables, scenario analysis.
- Flag the most important insight in each batch, and why it matters.
- Skip generic points unless they are a step toward something sharper.

## How to explain

- Concrete picture or analogy first, technical definition second.
- Define terms on first use.
- Always connect to the practical consequence for the decision at hand.
- Mark whether something is **worth understanding properly** or **safe to treat as a
  black box for now**.

## Collaboration

- This is a back-and-forth, not a one-shot answer.
- After each exchange, suggest 2–3 concrete directions to explore next.
- Push-back or confusion is a signal to re-explain or re-angle — not to abandon the idea.
```

---

## 14. Working with colleagues

There is no separate multi-user mode. The structure above is already concurrency-safe, so this
section is short by design — it lists what a second contributor actually adds, which is very
little.

### Why there is nothing to migrate

The design decisions that matter were made for the general case, and the single-author case is
simply n = 1:

| Decision | Where | Solo cost |
|----------|-------|-----------|
| One checkpoint per owner | §3 | one file, named with your token |
| No shared counters in any ID | §4 | none — it removed a register lookup |
| Entries written for someone who was not there | §3 | none — that reader is you, later |
| Resolutions named in `LOG.md` | §3 | none, same reason |
| `docs/` reviewed before it lands | §7 | a deliberate diff pass instead of a PR |
| `Raised:` date on register entries | §6 | none — it surfaces age, which rots solo too |
| `Owner:` on register entries | §6 | ten characters, and every historic entry is already attributed |

Adding a person is therefore a no-op: they pick an owner token, create their own
`CHECKPOINT-<token>.md`, and everything else is already shared-safe. Nothing is renamed, no
playbook changes, and no existing file moves.

That property is the whole point of designing this way. Retrofitting concurrency-safety onto an
established project means renaming a file referenced from the index and every playbook — and it
is normally triggered by discovering the problem the expensive way, through a merge conflict that
has already destroyed a session's work.

### What genuinely changes with a second person

**`docs/` review becomes a pull request** rather than a self-review pass. This is the one place
where more people make the system genuinely better rather than merely surviving: `promote.md`
step 2 requires finding every file a conclusion touches, and a second reader catches the missed
one that a tired author does not.

**Pull before closing a session.** `checkpoint.md` step 5 touches shared `LOG.md` and `INDEX.md`.
Both are append or small-edit, so conflicts are one line and trivially resolved — but two agents
running Copilot CLI simultaneously have nothing coordinating them.

That is the complete list.

### What not to do

Do not make the archive collaborative. Shared session files, review on experiment records, or a
process for agreeing checkpoint contents all add coordination cost to the half that already works,
paid on every session rather than only when a conflict occurs.

### Multi-user failure modes

| Symptom | Cause | Response |
|---------|-------|----------|
| Merge conflict spanning a whole checkpoint | Two people writing one checkpoint file | One file per owner (§3) — check the owner token in `AGENTS.md` |
| A colleague's checkpoint reads as cryptic | Written for someone who was there | §3, "written for someone who was not there" |
| Questions sitting untouched for weeks | `Owner:` left blank, so nobody has claimed it | Fill it in; blank means unclaimed, never "legacy" |
| Two people re-deriving the same conclusion | It never got promoted, or the promotion was not visible | Review at merge |
| A question vanished with no visible answer | `LOG.md` row named the topic, not the resolution | §3, append-only |
| Contradictions inside `docs/` | A promotion updated some of the files it touched, not all | `promote.md` step 2, enforced at review |

---

## Origin

This system was derived from a working single-author project that ran it across a series of
sessions, then adapted for R&D work: multi-source knowledge intake, reproducible analysis, and
GitHub Copilot CLI in place of Claude Code. The rules that look pedantic — delete rather than
mark resolved, promote rather than compress, freeze rather than edit — are the ones that were
learned from watching the alternatives fail.

**The single-author case is the tested one.** The structure is built for concurrent contributors
because that costs the solo case nothing and removes a later migration — but the multi-user
behaviour is reasoned from the design, not observed. The merge properties are certain; the claim
that terse notes degrade for a reader who was not there is a prediction, well supported by how
badly it degrades for the same author six months on.
