# R&D Project Memory — Handbook

A system for keeping knowledge alive across AI-assisted sessions on a research and development
project, where the method is discovered rather than specified, and the knowledge arrives as PDFs,
Confluence pages, call transcripts, brainstorming, and data analysis.

**Audience:** an AI assistant (GitHub Copilot CLI) setting this up in a project repository, and
the human working with it.

**Read this in order.** Sections 1–3 are the whole idea; everything after is mechanism. §15 is
about upgrading a project that already runs the system — safe to skip until you have one.

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
| Settled conclusion about the method | `docs/` + a row in `docs/CLAIMS.md` | edit in place |
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
AGENTS.md                      ← auto-loaded entry point; @imports the rules and the index
.gitignore                     ← enforces the never-commit list (§9)
.template-version              ← which release of the template this project is running

docs/                          ← permanent knowledge base: settled conclusions only
  problem.md                   ← problem statement, success criteria, stakeholders
  method.md                    ← the method being designed — current best understanding
  constraints.md               ← scope, compute, data, delivery constraints
  glossary.md                  ← domain terms
  techniques/<name>.md         ← evaluated techniques, including rejected ones
  decisions/ADR-NNN-<slug>.md  ← decision records

ai-sandbox/                    ← working memory between sessions
  RULES.md                     ← the behavioural rules; upstream's, replaced on upgrade
  RATIONALE.md                 ← why each rule exists; read on demand, never imported
  INDEX.md                     ← entry point; current focus
  CHECKPOINT-<owner>.md        ← in-flight reasoning; one per person, ≤150 lines
  CHECKPOINT.md                ← optional: shared in-flight state, if any
  OPEN_QUESTIONS.md            ← active questions only
  ASSUMPTIONS.md               ← what the method bets on
  SOURCES.md                   ← source register
  DATA_ENVIRONMENT.md          ← how to obtain data and run analyses; the profile layer (§15)
  playbooks/                   ← procedures: session-start, checkpoint, promote,
                                 ingest-source, run-experiment
  sessions/LOG.md + <date>-<slug>.md
  experiments/LOG.md + EXP-<YYYY-MM-DD>-<slug>.md

src/                           ← analysis code, in whatever the project uses
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

**Two classes of file, and only one must be imported.** *Behavioural instruction* shapes what the
assistant does every session and must be reachable from `AGENTS.md`: that is `ai-sandbox/RULES.md`,
`ai-sandbox/INDEX.md`, and `ASSISTANT_PROFILE.md` if you fill it in. *On-demand reference* —
`docs/`, `LOG.md`, the playbooks, `RATIONALE.md` — is opened when needed and would only waste
context if loaded every time. Do not `@`-import the second class; the rule below applies to the
first.

`RULES.md` is the highest-stakes member of that first class: it holds every behavioural rule, so
a failed import silently removes all of them at once while the repository still looks correct.

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

**The skeleton is normative. This section does not reproduce it.**

Every file listed below exists, filled and commented, in `skeleton/`. Copy from there. Earlier drafts of this handbook embedded copies of each template; within a day the two had
diverged in four files and the skeleton had grown four more that the handbook never mentioned —
a system whose central claim is that two copies drift, reproducing that failure in its own
delivery. The copies are gone.

| File | Purpose |
|------|---------|
| `AGENTS.md` | Auto-loaded entry point: project description, owner token, `@` imports. Yours — never overwritten |
| `ai-sandbox/RULES.md` | The behavioural rules and the playbook list. Upstream's — replaced on upgrade |
| `ai-sandbox/INDEX.md` | Session entry point: routing rule, artifact list, current focus |
| `ai-sandbox/CHECKPOINT-<owner>.md` | One per person; in-flight reasoning, rewritten, ≤150 lines |
| `ai-sandbox/OPEN_QUESTIONS.md` | Active questions only; deleted when answered |
| `ai-sandbox/ASSUMPTIONS.md` | What the method bets on |
| `ai-sandbox/SOURCES.md` | Source register: IDs, provenance, sensitivity |
| `ai-sandbox/DATA_ENVIRONMENT.md` | Access, tables, data traps, run recipes. **The profile layer** — the one file that names the stack (§15). Omit it if the project has no data environment |
| `ai-sandbox/RATIONALE.md` | Why each rule exists; failure-mode table |
| `ai-sandbox/ASSISTANT_PROFILE.md` | Optional; how to pitch explanations. `@`-import it or it does nothing |
| `ai-sandbox/playbooks/*.md` | The six procedures — see §7 |
| `MANIFEST` · `.template-version` · `.template-hashes` | Which files upstream owns, which release you took, and what those files hashed to when it shipped — see §15 |
| `ai-sandbox/sessions/LOG.md` + `_TEMPLATE.md` | Session index and record |
| `ai-sandbox/experiments/LOG.md` + `_TEMPLATE.md` | Experiment index and record |
| `docs/CLAIMS.md` | Index of every claim in `docs/`: shorthand, file, date, basis |
| `docs/problem.md` | Problem statement, success criteria, stakeholders |
| `docs/method.md` | The method as it currently stands |
| `docs/constraints.md` | Scope, compute, data, delivery limits |
| `docs/glossary.md` | Terms used with a specific meaning here |
| `docs/techniques/_TEMPLATE.md` | Evaluation of a candidate technique, including rejected ones |
| `docs/decisions/_TEMPLATE.md` | ADR: context, decision, alternatives, consequences |
| `gitignore.template` | Rename to `.gitignore` — enforces the never-commit list |
| `check.sh` · `.githooks/pre-commit` | Mechanical checks; secret scan — see §12 |

Three fields are worth explaining rather than just copying, because their shape is not obvious:

**`SOURCES.md` — sensitivity is decided at ingestion, defaulting to `reference-only`.** It is the
only decision in the system a later edit cannot undo. See §9.

**Experiment records — snapshot date, not just the source's name.** A source that can change
underneath you is not identified by its name alone. Where a field does not apply, write `n/a`
rather than leaving it blank: a later reader cannot otherwise tell "not applicable" from "nobody
filled this in". See §8.

**`OPEN_QUESTIONS.md` / `ASSUMPTIONS.md` — `Owner:` is always filled in, even alone.** Blank must
mean *unclaimed*; if solo-era entries are left blank, that meaning is destroyed the day a second
person joins.

## 7. Playbooks

**Also normative in the skeleton, for the same reason as §6.** The six procedures live in
`ai-sandbox/playbooks/`. What follows is what each is *for* and the one decision inside it that
is easy to get wrong — not its text.

Copilot CLI has no user-defined slash commands, so a playbook is invoked by asking for it:

```
Follow ai-sandbox/playbooks/checkpoint.md
```

| Playbook | Purpose | The part that is easy to get wrong |
|----------|---------|-----------------------------------|
| `session-start.md` | Load state, report, propose a focus | It **stops and waits**. An assistant that starts researching unprompted has skipped the only step where you steer. |
| `checkpoint.md` | Close a session: freeze the record, promote, rewrite state | Step 3's cap means **promote something**, never shorten the prose. |
| `promote.md` | Move a matured conclusion into `docs/` | Step 2 — find *every* file the conclusion touches. Updating one and missing another leaves `docs/` self-contradictory, which is worse than not recording it. |
| `ingest-source.md` | Take in a PDF, wiki page, or transcript | Sensitivity is decided **before** reading, defaulting to `reference-only`. |
| `run-experiment.md` | Run and record an analysis | The question is written **before** the run. An experiment with no stated question cannot fail, and so teaches nothing. |
| `upgrade-template.md` | Raise the project to a later template release | It diffs `RULES.md` and reports every changed rule. A rule delivered by file replacement arrives silently; this step is the only thing that makes it visible (§15). |

### Why playbooks rather than custom agents

Copilot CLI supports custom agents (`.github/agents/<name>.agent.md`, invoked via `/agent`, in
natural language, or `copilot --agent <name> --prompt "…"`). Deliberately unused for these.

A custom agent is an *isolated* worker with its own context. `checkpoint` and `promote` edit
across the whole repository and must confirm with the user before touching `docs/` — isolation
works against both. Agents suit one job here: ingesting a large PDF, where the reading should not
land in the main session's context.

Playbooks are also tool-agnostic. Under Claude Code the same files can be wrapped as skills — a
three-line `SKILL.md` that says *follow `ai-sandbox/playbooks/<name>.md`* — giving discoverable
one-word invocation with the playbook remaining the single source of truth. The wrapper must
never restate the procedure, or §6's failure returns in a new place.

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
| Environment lock | Library versions change results silently |
| Data source **+ snapshot date** | A source that can change underneath you is not identified by its name alone |
| Runtime / compute | Runtime versions change numerical behaviour |
| Result + uncertainty | A point estimate with no spread cannot be compared |
| Verdict | Forces a conclusion while the context is fresh |
| Threats | What would make it not replicate |

`DATA_ENVIRONMENT.md` states what these mean for the project's own stack — which lockfile, which
identifier form for a data source, what identifies a runtime. The playbook and the record template
name the fields; the profile supplies their shape (§15).

**A field marked `n/a` is as informative as a filled one.** A blank cannot be distinguished from
an oversight, and some of these genuinely do not apply — an experiment that runs no code has no
environment lock, and an immutable source has no snapshot date. Say so rather than leaving a gap.

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

Back this with two artifacts that **ship in the skeleton and are deliberately not reproduced
here** (§6): `gitignore.template`, renamed to `.gitignore`, and `.githooks/pre-commit`, installed
with `git config core.hooksPath .githooks`.

> An earlier draft of this section carried its own copy of the ignore list. It had drifted ten
> lines from the skeleton, seven of them the extracted-data extensions — so the handbook's copy
> failed to stop the very thing this section forbids, while the skeleton's stopped it. That is
> §6's failure occurring inside the section about the one rule a later edit cannot repair, which
> is the strongest argument available for why §6 says what it says.

This is the one rule in the system where a mistake is not repaired by editing a file: once
committed, the content lives in git history, and removing it means rewriting history on every
clone. Treat `reference-only` as the default and `committable` as the deliberate exception.

### Mutable sources

Confluence pages and shared documents change without notice. The register records the **date
read**, not just the source date. A load-bearing claim resting on a page read long ago is
re-verified rather than trusted. `session-start.md` includes this check.

---

## 10. Data environment

`ai-sandbox/DATA_ENVIRONMENT.md` records how to obtain data and run analyses: workspace and auth
*mechanism* (never values), data sources in use with grain and refresh, known data traps,
environment commands, and verified run recipes.

**This is the profile layer, and it is the only file that names the stack.** Everywhere else the
system states the principle and keeps the stack as a named example — the experiment record asks
for "the environment's locked state", not for `uv.lock`. Concentrating the stack in one file is
what lets a project on a different one substitute a single file instead of editing eleven. §15
covers the layer this belongs to.

Stripping the stack out of *this* file was tried and fails: remove the product names and nothing
concrete remains, because a known data trap cannot be stated abstractly. So it stays concrete and
ships in variants.

**A project with no data environment omits the file entirely.** Shipping one full of instructions
for a stack the project does not have is worse than shipping nothing: it instructs, and the
instruction is false.

**No credentials, ever.** Describe where a secret comes from — an environment variable name, a
CLI profile, a keyring entry — never what it is.

### Why the data-traps section matters most

It is the only part that cannot be re-derived from the code. A column whose nulls mean "not
applicable" rather than "unknown" produces a plausible, wrong answer silently, every time, until
somebody notices. The same goes for duplicated keys, a backfill that rewrote history, and
timezone conventions that differ from what a column name implies.

Write each trap down the moment it is found. It has no other home in the repository, and the
second person bitten by it is usually the first person, a year later.

### Why the snapshot date is mandatory

Any source that can change underneath you is mutable in the way that matters. An experiment record
cites the source *and* the date it was read, because the name alone does not identify the data
that produced a result. The environment lockfile is committed for the same reason on the code
side. Where a source genuinely cannot change, record that instead of leaving the field blank.

## 11. Bootstrapping an existing project

For a project already underway with material piled up. Roughly one working session.

**1. Copy the structure.** Take the files `MANIFEST` lists out of `skeleton/` — **not the whole
directory.** `skeleton/README.md` is installation instructions and would replace the project's
own; anything else that already exists is merged, not overwritten. Rename `gitignore.template` to
`.gitignore` and install the hooks *before* any source material is anywhere near the repository,
because that is the one guard a later edit cannot supply retroactively.

Record which release you took in `.template-version`. Without it nothing can tell you whether an
upgrade applies, and §15 has nothing to work from.

**2. Write `AGENTS.md`.** The project description only — **do not write the working rules.** They
ship in `ai-sandbox/RULES.md`, which `AGENTS.md` imports and which an upgrade replaces wholesale;
rules typed into `AGENTS.md` are outside that mechanism and drift silently from the version
everything else assumes. Pick an **owner token** — your initials are fine — and declare it in
`AGENTS.md`; your checkpoint is `CHECKPOINT-<token>.md`. Working alone that is one file, and it
means a second contributor later costs nothing to add.

Verify the imports work: in a fresh session, ask the assistant to state a rule that appears only
in `RULES.md`, then one that appears only in `INDEX.md`. If either fails, that import is not
loading and every rule in the file is inert.

**3. Register sources before reading them.** List all existing material — PDFs, Confluence
pages, transcripts — into `SOURCES.md` with IDs and sensitivity. Registering is fast;
ingesting is not. Do the registration in one pass so the inventory is complete, then ingest in
priority order.

**4. Write `docs/problem.md` first.** What is being solved, for whom, and what "done" means. If
this cannot be stated crisply, that is the most valuable finding of the day — record the
ambiguity in `OPEN_QUESTIONS.md`.

**5. Capture current understanding into an intake file.** Everything currently believed but not
written down. Do not attempt to distil it into `docs/` yet — it has not been tested by a session,
and premature promotion puts unstable claims in the permanent base.

**This will exceed 150 lines, and that is expected.** Write it to
`ai-sandbox/CHECKPOINT-<owner>-intake.md`, which is **exempt from the cap** and carries a
dismantling date in its header — four to six weeks out.

The exemption exists because the three rules otherwise deadlock: this step says capture
everything, §3 caps the checkpoint at 150 lines, and this step also forbids promoting yet, which
is the cap's only prescribed remedy. On a real project the intake is 300+ lines on day one.

The intake file is drained, not archived: each session moves what has proven durable into `docs/`
and what is still live into the real checkpoint. When it empties, delete it. If the dismantling
date passes and it is still full, that is the signal that bootstrapping never finished — treat it
as the highest-priority item, not as furniture.

**6. Backfill the session log.** If the project has git history, reconstruct one row per
significant past episode from the commits. Approximate rows are worth more than an empty log.

**7. Seed `DATA_ENVIRONMENT.md`** with the tables already in use and every data trap already
known. This will be incomplete. Incomplete and growing is the working state.

Do **not** try to fill everything at once. `OPEN_QUESTIONS.md` and `ASSUMPTIONS.md` populate
naturally as sessions run; forcing entries produces filler that trains everyone to skim.

---

## 12. Failure modes and mechanical checks

**The failure-mode table lives in `ai-sandbox/RATIONALE.md`, inside the project** — not here.

That placement is deliberate. This handbook is a textbook: read once, by the person setting the
system up, in whatever repository it was copied from. The failure-mode table is operational — it
is consulted while working, by whoever notices something rotting, and it must therefore exist in
the live project rather than in the template it came from. `RATIONALE.md` also carries one
paragraph per rule in `RULES.md` explaining what that rule prevents, for the same reason: rules
that ship as bare imperatives get "helpfully" violated.

### What is checked mechanically

Prose rules aimed at a probabilistic executor decay. Two scripts ship in the skeleton, with
deliberately different severity:

| Artifact | Checks | Mode |
|----------|--------|------|
| `check.sh` | Mechanism files against their released hashes · checkpoint line limits · dangling `[S-…]` / `[EXP-…]` citations · `Resolved` in registers · session files missing a `LOG.md` row · `docs/` edited without `CLAIMS.md` · tag frequencies · numbers without dates | **Always exits 0.** Advisory output only |
| `.githooks/pre-commit` | Secret patterns, `gitleaks` if installed | **Blocking** |

They are separate on purpose. `check.sh` includes heuristics that will produce false positives —
version strings read as undated numbers, for instance — and a noisy check sharing an exit code
with the secret scan is a check that gets disabled after its first irritating run. The one rule
whose violation cannot be repaired by editing a file must not be hostage to that.

### The failure mode both scripts share

**A check that scans the repository will find the repository's own instructions.** The registers
explain in their preambles that `Resolved` must never be used; the playbooks cite `[S-latency-spec
§3.2]` as an example; `sessions/_TEMPLATE.md` ships with `Status: open` because that is the shape
a new session is created from; and the secret scan's own pattern list is, necessarily, a list of
credential shapes.

Every one of those was reported as a finding before being fixed. They share one cause — a check
reading instruction as content — and the fixes are all exclusions: skip blockquote lines, skip
`<placeholder>` lines, skip `playbooks/`, skip `_TEMPLATE.md`, and require a credential *value*
rather than a credential's *name*.

This matters more for the hook than for `check.sh`, and the reason is behavioural rather than
technical. An advisory check that cries wolf is ignored. A **blocking** check that cries wolf is
answered with `git commit --no-verify`, and once that becomes reflex the only irreversible guard
in the system is dead while still appearing installed. Precision in the pattern list is therefore
not tidiness; it is what keeps the check alive.

A corollary for anyone extending it: **a profile may add patterns to the hook's list but must
never supply the list.** An absent or unsubstituted pattern file leaves an empty expression, an
empty expression matches every line, and every commit blocks on clean content — which produces
exactly the `--no-verify` reflex above.

Hooks do not survive a clone. Installation is one line, and it belongs in the setup steps where
it will actually be run:

```bash
git config core.hooksPath .githooks
```

If the project has CI, run the secret scan there too — it is the only layer nobody can forget to
install.

## 13. Assistant profile (optional)

If explanations land consistently too shallow or too deep, fill in
`ai-sandbox/ASSISTANT_PROFILE.md` and **`@`-import it from `AGENTS.md`**.

Unlike `RATIONALE.md`, this one *is* behavioural instruction — it shapes every session, so it
belongs in the imported class (§5). An un-imported profile is the exact silent failure §12
describes: it sits in the repository looking correct and never runs.

The template covers who you are and where your expertise stops, how to pitch explanations,
whether to flag something as worth understanding properly or safe to treat as a black box, and
the request to be explicit about uncertainty. Be specific about the boundary of your knowledge —
generic seniority labels calibrate nothing.

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

## 15. Versions and upgrading

Everything above describes adopting the system once. This section is about what happens when the
template moves on and your project has not.

### Why this is not the usual upgrade problem

A library is upgraded by taking the new version. This template is **meant to be edited**: you fill
in `problem.md`, write your checkpoint, keep your own `SOURCES.md`. Divergence from upstream is the
intended end state, not a defect.

So merging a new version in would conflict in nearly every file, because nearly every file has
legitimately changed. And an upgrade that requires resolving conflicts across a whole tree does not
get performed — which is the same, in practice, as having no upgrade path at all.

The way out is to stop asking "what changed upstream?" and ask **"who owns this file?"**

### Four layers

| Layer | Owner | On upgrade |
|-------|-------|-----------|
| **Mechanism** | upstream | replaced wholesale |
| **Profile** | upstream, or your organisation | substituted, never merged |
| **Scaffold** | upstream wrote the starting shape; you own it from your first edit | never touched again |
| **Content** | you | upstream never reads or writes it |

Mechanism is the playbooks, `RULES.md`, `RATIONALE.md`, the `_TEMPLATE.md` files, `check.sh`, the
hook. Profile is `DATA_ENVIRONMENT.md` (§10). Scaffold is `AGENTS.md`, `problem.md`, the registers
and the logs. Content is your sessions, experiments, ADRs and checkpoints.

`MANIFEST`, in the template repository, records which file is which. It is the table above in a
form a script can read.

**A scaffold file is never upgraded, and that is deliberate.** Once you have written your
`problem.md`, a revised heading structure from upstream is not an improvement — it is an unwanted
rewrite of your document. The same goes for the register preambles: a preamble one version old is
the *previous* version of a rule that was acceptable when it shipped. It does not misdirect. Where
a rule genuinely must reach you, it arrives through `RULES.md`, which is mechanism.

### Taking a version, and knowing which you took

Adoption and upgrade are both a copy of the paths `MANIFEST` lists. No fork, no submodule, no
subtree — **no git relationship of any kind** between your project and the template.

That is what makes your copy self-contained: it keeps working if the upstream repository is
renamed, moved, or deleted. It also means there is no mechanism for pushing changes back, which is
intentional.

Two files come out of that. You write the first; the release supplies the second:

```
.template-version    v1.1.0  skeleton @ 8aee1f4  applied 2026-08-17
.template-hashes     the sha256 of every mechanism file as it shipped
```

`.template-hashes` is what lets `check.sh` tell you, before an upgrade, that someone has edited a
file upstream owns — offline, with no copy of the template anywhere. That warning is worth more
before the replacement than after it, and it is the only moment the information is actionable.

**Being behind is the normal resting state of a vendored dependency, not breakage.** A project on
v1.0.0 works exactly as well as it did the day it adopted it. There is nothing to keep in sync —
only a version to raise deliberately, when you want something a later release has.

### What a version number tells you

The bump says what raising it will cost you.

| Bump | What changed | What you do |
|------|--------------|-------------|
| MAJOR | a routing rule changed; a file moved or was renamed; a register's schema changed; a rule change that leaves your existing entries non-conforming | run the migration |
| MINOR | a new optional playbook, file, or check; a new or strengthened rule that leaves existing entries valid | replace mechanism, read the named rule changes |
| PATCH | wording; a rationale expanded without changing what the rule requires | replace, do nothing |

For a rule change the discriminator is **not how big the rule is but whether your existing entries
still conform.** *"Search the logs before concluding something is unknown"* binds future behaviour
only — MINOR. *"Checkpoints are per owner"* leaves your `CHECKPOINT.md` misnamed — MAJOR, and the
migration renames it.

### Migrations are prose, not scripts

A MAJOR release carries a section in `MIGRATIONS.md`, written as instructions **to an assistant**.
The reason is that the material being migrated is prose, and the steps that matter most are
exceptions:

```markdown
## v1 → v2: checkpoints became per-owner

3. Find references to the old name: `rg -n 'CHECKPOINT\.md'` — including playbooks and
   session files. Session files are immutable: do NOT edit them; the mismatch is expected.
```

A script would "fix" the immutable session files, violate the system's central rule, and report
success. An assistant understands the exception. That is the whole argument for the format, and it
is also its risk: a half-applied migration is worse than none, because the repository then claims a
version it does not structurally have.

The release notes and the `MIGRATIONS.md` section are the same text. One source, not two.

### The one thing that arrives silently

Because the rules live in `RULES.md` and `RULES.md` is mechanism, a rule change reaches you as a
**file replacement**. You copy a file and are now bound by a rule nobody read. A version number
cannot fix that: MINOR tells you to read the notes only if the notes say something.

Two obligations therefore attach to that file:

- **Upstream's:** any release whose diff touches `RULES.md` names each changed rule in its notes,
  one line per rule, including at PATCH. A release that touches `RULES.md` and says nothing about
  rules is a defect in the release.
- **Yours:** `upgrade-template.md` diffs the incoming `RULES.md` against the installed one and
  reports every changed rule, whatever the notes claimed. Upstream's obligation is process and
  nothing enforces it; this step is what makes a forgotten note recoverable.

### If you are running this inside an organisation

The template is public and MIT-licensed, and that is not incidental: **a public repository without
a licence grants no rights**, so copying it into company work would be infringement rather than
adoption. If your employer has an intake process for external open-source material, run it once
against the licence and everything after is routine.

An internal copy — if you want one, for a company-specific profile or because your environment
cannot reach the public repository — is an ordinary consumer under this section: vendored
mechanism plus your own `DATA_ENVIRONMENT.md`. **Not a fork.** A fork wires a relationship in the
direction you do not want, one mistyped remote away from pushing internal content outward, whereas
a copy has nowhere to push. Improvements travel back by hand, retyped as an abstract rule, which
forces the genericisation to be a deliberate step rather than something a diff review is trusted
to catch.

---

## Origin

This system was derived from a working single-author project that ran it across a series of
sessions, then adapted for R&D work: multi-source knowledge intake, reproducible analysis, and
GitHub Copilot CLI in place of Claude Code. The rules that look pedantic — delete rather than
mark resolved, promote rather than compress, freeze rather than edit — are the ones that were
learned from watching the alternatives fail.

That project was CGS, a personal repository, and the history is preserved in this one. It shows a
discontinuity rather than a straight line: the first commit carries generic templates brought
*from* a work project, and the next deletes all of them and builds the current system in their
place. Everything from that second commit is new work. The commits before the split resolve in
CGS, not here — the extraction rewrote every tree, so they arrived with their dates and messages
and new hashes.

**The single-author case is the tested one.** The structure is built for concurrent contributors
because that costs the solo case nothing and removes a later migration — but the multi-user
behaviour is reasoned from the design, not observed. The merge properties are certain; the claim
that terse notes degrade for a reader who was not there is a prediction, well supported by how
badly it degrades for the same author six months on.

**The delivery half is younger and less tested than the memory half.** Sections 1–14 have been
run; §15 has not. No project has yet lived through an upgrade, so every claim about what a
migration costs is reasoning rather than observation. The template repository upgrades itself
first, deliberately, so that the first thing to break belongs to whoever wrote it.
