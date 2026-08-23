# <PROJECT_NAME> — Why the rules are what they are

**Read on demand, not every session.** Nothing imports this file and nothing should: it is
reference material, like `docs/`, not behavioural instruction. `ai-sandbox/RULES.md` carries the
rules; this file carries the reason each one exists and what breaks without it.

Consult it when a rule feels arbitrary, when you are tempted to make an exception, or when
auditing the system for rot.

---

## Why every rule has a stated failure mode

The rules here are counterintuitive, and an assistant given a rule without its justification
will "helpfully" violate it — summarising instead of promoting, marking resolved instead of
deleting, tidying history instead of freezing it. Each rule below is paired with the specific
failure it prevents, because that pairing is what makes it survive contact with a helpful
assistant.

---

## The rules in `RULES.md`, and why

### `docs/` holds settled conclusions only; changes are reviewed before they land

`docs/` is what the project will still believe in a year. Anything unreviewed that lands there
is indistinguishable from something verified, and later readers cannot tell them apart.

*Working alone this means a deliberate pass over the diff; with colleagues, a pull request.*

### `ai-sandbox/` is not a second copy of `docs/` — conclusions move, never copy

Two copies drift. Once they disagree, nobody can tell which governs, and the effort spent
deciding exceeds what the note ever saved. Moving is the whole discipline: written into `docs/`,
deleted from the sandbox, in the same change.

### `CHECKPOINT-<thread>.md` is rewritten, never appended, and capped at 150 lines

**Rewritten** so that current and stale statements never interleave. In an append-only state
file the reader cannot trust any line without checking all of them.

**Capped** so the file stays readable. But the cap means *promote something*, never *shorten the
prose*: compression is a decision about what to forget, made by whoever is least equipped to know
what will matter in six months. Repeated compression yields a retelling of a retelling. The cap
is not only a readability nicety — reading too much of it is a measured cost, not merely an
unpleasant one; see the reading-budget note near the end of this file.

**One file per thread**, not per owner, because wholesale rewrite is the worst possible shape for
a git merge — it changes nearly every line, so two concurrent rewrites conflict across the whole
file and the only resolutions available silently discard someone's session. Naming the file for
the person rather than the work looked like it avoided this, but a project with one person and
several agents running in parallel has *threads* pausing and resuming independently, not people —
two people (or two agents) on the same thread in two personal files is exactly the pair of
silently diverging copies this design exists to prevent, just moved one level down. Ownership is
instead a field, `Held by:` — deliberately not `Owner:`, because it names a temporary state, not
a possession — with one rule enforcing it: only the holder writes, everyone else reads, and
taking over is a logged event, not a silent edit.

### Files in `sessions/` and `experiments/` are immutable once closed

A record's value is that it captures what was believed *at the time*, including what turned out
wrong. Editing history to agree with present belief destroys exactly the information that makes
the archive worth keeping.

Corrections go into the next record, referring back.

### Answered questions and confirmed assumptions are deleted, not marked resolved

A register that is 80% resolved entries is one nobody reads, and an unread register is worse than
none — it looks like coverage while providing none.

**Deletion is only safe because the resolution is discoverable**: the `LOG.md` row names what was
resolved, not merely what was worked on. Without that, a reader finds the question simply gone,
with no cue that an answer exists — and that reader is usually you, months later.

### Every entry is written for someone who was not there

A checkpoint holds only what is unresolved, which tempts a terseness that leans on context the
writer still carries. Time separates you from your own context as effectively as another person
does. Test each entry: *could someone who missed the session act on this?*

### Every number entering `docs/` carries a date and a source

An undated number cannot be re-verified and cannot be known to be stale. In practice it gets
trusted forever.

Legitimate bases, recorded in `docs/CLAIMS.md`: `EXP-…` (measured), `S-…` (external source),
`sessions/…` (reasoned in a session), `ADR-…` (a decision rather than a discovery). The third
matters most in practice — reasoning in session is the main way knowledge is produced here, and
without a legitimate label for it an assistant will either invent a source or leave the number
bare. Naming a claim as reasoned rather than measured is information, not an admission.

The basis also preserves what promotion otherwise destroys: `ASSUMPTIONS.md` separates `ASSUMED`
from `INFERRED`, but once a claim reaches `docs/` a measured result and a hunch from one call
transcript read identically authoritative.

### Never commit credentials, tokens, PII, or raw extracted data

The one rule here whose violation a later edit cannot repair. Once committed, the content is in
git history on every clone, and removal means rewriting history everywhere. Default every source
to `reference-only`; committing is the deliberate exception.

### A thread's checkpoint exists only while something is unpromoted and unclosed

The obvious rule is "open a checkpoint when a thread pauses", and it fails on the thread that
never visibly pauses: six sessions of steady work, no interruption, and still not finished —
producing exactly the unclosed state a pause-triggered rule would miss entirely. "Something
produced has nowhere else to live yet" catches that thread; "it paused" does not. Closing gets
the same care in the opposite direction: a checkpoint that closes only when explicitly told to
never closes, and accumulates dead files nobody deletes.

### Negative knowledge needs a home as much as positive knowledge does

Distrust ("don't believe this yet"), scope limits ("this licenses X but not Y"), and legitimate
absence ("no reference exists") are knowledge — but unlike a measured result or a settled
decision, none of them has an obvious file to live in by default. Left homeless, all three leak
into prose: a warning not to trust a task's self-report ends up as one sentence in a 3,000-line
checkpoint instead of a field anyone can find. The cost of losing a positive fact is re-deriving
it; the cost of losing a prohibition is repeating the mistake it existed to prevent, and that
mistake is usually silent — nothing errors, the wrong thing just looks fine. `CAVEATS.yaml`'s
`severity: critical`, `ASSUMPTIONS.md`'s `Does not license:`, and every field that accepts a
legitimate `—` are this principle applied in one place each, not five unrelated ideas.

**Two rules of form worth naming explicitly.** Write negative knowledge as a prohibition or the
name of a check, never as a confidence adjective — adjectives degrade quietly (a `High` written
in June still reads `High` in October, whether or not anything justifies it still), while a named
check or an explicit "don't do X" either holds up or doesn't. And an absence must be a legitimate
value somewhere a pointer is otherwise mandatory — a required field with no legal "empty" gets
filled with the nearest plausible-looking answer, which is worse than admitting nothing is there,
because it reads as trustworthy.

### Traps and unverified work don't get to hide in prose either

`ai-sandbox/CAVEATS.yaml` exists because a trap is found once and needed forever, by whoever next
touches the same table, column, or tool — and prose buried in a checkpoint is not found, it is
stumbled on. It is the one register exempt from delete-on-resolve: a trap being "fixed" usually
means the data moved or the tool changed, not that the trap stopped being true history.

Two rules pair with it: a conclusion built on an experiment marked `not verified` does not reach
`docs/`, and an experiment record that cites a file makes that file real — in the repository, or
named as absent with a stated substitute. Both close the same gap: a self-reported "pass" and an
independently checked one look identical in prose unless the record forces the distinction. In
one closed project that produced this design, independent recount found a real bug in roughly
half the tasks it checked — self-report alone would have missed all of them silently.

### A register that stops being cleaned has become a journal

`ai-sandbox/ASSUMPTIONS.md` and `OPEN_QUESTIONS.md` are built around deletion: an entry that
stops mattering leaves. If a register grows for months with no deletions, it has not failed —
it has quietly turned into a different kind of file, one that keeps history on purpose, and
`docs/CLAIMS.md` is that file done deliberately (its `superseded by` rows are kept, not deleted,
and it says so). The failure is calling the drifted file a registry after it stops behaving like
one: the checkpoint playbook keeps asking for deletions nobody is doing, while a separate
current-state view gets built informally alongside it — which looks like a violation of "one home
per fact" without being one. The fix is a declaration, not a cleanup: either resume deleting, or
name the file a journal and give current state its own place.

### Some files must be readable without an assistant; most need not be

Readability-by-a-human-with-no-AI-help is a requirement for a named, small class of files: a
checkpoint's header, a decision record, gate criteria, open questions. It is explicitly not a
requirement for session bodies, generated catalogs, or raw run output — demanding prose
readability there would only produce padding nobody reads.

Two reasons this class needs to be readable at all. First, credit exhaustion is an expected
state this system has to survive, not an incident: if the only way to read a decision is to
spend the resource that just ran out, the decision is unavailable exactly when it might matter
most. Second, a memory that only its own kind of process reads is a closed loop — the process
that wrote an ambiguity is the one most likely to read it back the same wrong way, consistently
and confidently, and that looks identical to correctness from inside the loop. A human outside
the loop is how the guarantee actually gets checked, not a courtesy extended to one.

### Reading rules are a budget mechanism with a measured price, not just hygiene

"Don't read `docs/` wholesale", "the index stays small and stable", the 150-line cap — these
were justified as keeping context tidy. They also have a real, billed cost of ignoring them: in
one closed project, a single poorly-scoped orientation pass cost roughly the same credits as 108
average working turns, and re-billing the same oversized input on every subsequent turn compounds
that. The rule survives on quality grounds alone even without a credit constraint — a bloated
context measurably degrades reasoning, independent of price — but a project under real budget
pressure can additionally turn on per-turn cost telemetry (a `profile`-layer addition, not shipped
here by default) to see concretely where credits are actually going, rather than assume.

Worth stating what this system does not attempt: comparing models or configurations by reading
session records is not reliable, because topic, context volume, and repetition are not
controlled between them. Telemetry answers "where did the cost go", not "which configuration is
worth it" — the latter question is out of scope by design, not by oversight.

### Delivery state resolves from artefacts, not from prose

For a thread with a plan, the plan is a contract (tasks, gates), and what actually happened lives
in artefacts on disk (a manifest per task, a decision per gate) — never typed by hand, and their
absence is itself informative (no manifest means not yet certified, not "assume it passed"). The
one-command recipe that reads the artefact directory and reports status belongs in
`playbooks/local/`, named for what it checks, and it has to read the directory, not the plan's
task table: the table states intent and can drift (a task added mid-flight may never make it back
into the table), while the directory only ever states fact.

---

## Failure modes

What rot looks like, and what it actually means. Worth a pass every few weeks — `check.sh`
automates the mechanical half.

| Symptom | Real cause | Correct response |
|---------|-----------|------------------|
| `CHECKPOINT-<thread>.md` over 150 lines | Something in it has settled | **Promote.** Do not compress. |
| An entry unchanged for 3+ weeks | It is a conclusion, not a process | Promote |
| The assistant reads only head and tail of a file | That file mixes state with history | Split it |
| The same fact in `docs/` and `ai-sandbox/` | A promotion copied instead of moved | Delete the sandbox copy |
| `OPEN_QUESTIONS.md` full of `Resolved` entries | Statuses used instead of deletion | Delete them |
| A register full of stale low-priority questions | No exit for questions that stopped mattering | Delete as obsolete; log the reason |
| A register with no deletions for months | It has become a journal, not a registry | Resume deleting, or declare it a journal and split off current state |
| A number in `docs/` with no date or source | Provenance discipline lapsed | Re-verify or remove it |
| Sessions re-deriving the same conclusion | It never made it into `docs/`, or nobody searched | Promote it; search before concluding |
| A claim nobody can trace | Source was never registered | Register it retroactively, or drop the claim |
| An experiment that cannot be re-run | Reproducibility fields not captured | Treat its result as unverified |
| An experiment cited from `docs/` whose evidence file is gitignored | The record didn't say what stands in as evidence | Add a `results/` pointer, or don't promote it |
| A session file left `Status: open` | The session was interrupted | Freeze as `abandoned`; do not backfill |
| `docs/CLAIMS.md` disagrees with `docs/` | The index was updated separately, or not at all | Re-sync; it belongs in the same change as the promotion |
| A claim in `docs/` with no `CLAIMS.md` row | Promotion skipped step 3's substep | Add it, or the claim is unfindable by the next promotion |
| An intake file past its dismantling date | Bootstrapping never finished | Highest-priority item, not furniture |
| A rule having no effect | Nothing imports the file it lives in — `RULES.md` is one `@` line away from silence | Reachable from `AGENTS.md`, or it does not exist |
| A task ID named in a checkpoint header | The plan pointer has stopped holding | Delete it; add a mechanical check if it recurs |
| A dictionary field collecting hand-appended values | It's asking about more than one axis | Split the field along the axis the appended values reveal |
| One value filling almost every row of a field | It's asking the wrong question | Reconsider what the field should distinguish |

### The last one is invisible when it fails

In the project this system came from, a file defining how the assistant should communicate sat in
the repository for five sessions with nothing loading it. It looked correct. It never ran.

**A silent failure of instruction loading cannot be detected from inside a session.** The only
check is to ask, in a fresh session, for a rule that appears *exclusively* in the imported file.

Note the distinction this rule depends on: it applies to **behavioural instruction** — files meant
to shape what the assistant does every session, which must be reachable from `AGENTS.md`. It does
not apply to **on-demand reference** — `docs/`, `LOG.md`, the playbooks, and this file, which are
opened when needed and would only waste context if loaded every time.
