# <PROJECT_NAME> — Why the rules are what they are

**Read on demand, not every session.** Nothing imports this file and nothing should: it is
reference material, like `docs/`, not behavioural instruction. `AGENTS.md` carries the rules;
this file carries the reason each one exists and what breaks without it.

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

## The rules in `AGENTS.md`, and why

### `docs/` holds settled conclusions only; changes are reviewed before they land

`docs/` is what the project will still believe in a year. Anything unreviewed that lands there
is indistinguishable from something verified, and later readers cannot tell them apart.

*Working alone this means a deliberate pass over the diff; with colleagues, a pull request.*

### `ai-sandbox/` is not a second copy of `docs/` — conclusions move, never copy

Two copies drift. Once they disagree, nobody can tell which governs, and the effort spent
deciding exceeds what the note ever saved. Moving is the whole discipline: written into `docs/`,
deleted from the sandbox, in the same change.

### `CHECKPOINT-<owner>.md` is rewritten, never appended, and capped at 150 lines

**Rewritten** so that current and stale statements never interleave. In an append-only state
file the reader cannot trust any line without checking all of them.

**Capped** so the file stays readable. But the cap means *promote something*, never *shorten the
prose*: compression is a decision about what to forget, made by whoever is least equipped to know
what will matter in six months. Repeated compression yields a retelling of a retelling.

**One file per owner** because wholesale rewrite is the worst possible shape for a git merge — it
changes nearly every line, so two concurrent rewrites conflict across the whole file and the only
resolutions available silently discard someone's session.

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
trusted forever. Legitimate bases: a source ID (`S-…`), an experiment ID (`EXP-…`), or a session
file for a conclusion reached by reasoning.

### Never commit credentials, tokens, PII, or raw extracted data

The one rule here whose violation a later edit cannot repair. Once committed, the content is in
git history on every clone, and removal means rewriting history everywhere. Default every source
to `reference-only`; committing is the deliberate exception.

---

## Failure modes

What rot looks like, and what it actually means. Worth a pass every few weeks — `check.sh`
automates the mechanical half.

| Symptom | Real cause | Correct response |
|---------|-----------|------------------|
| `CHECKPOINT-<owner>.md` over 150 lines | Something in it has settled | **Promote.** Do not compress. |
| An entry unchanged for 3+ weeks | It is a conclusion, not a process | Promote |
| The assistant reads only head and tail of a file | That file mixes state with history | Split it |
| The same fact in `docs/` and `ai-sandbox/` | A promotion copied instead of moved | Delete the sandbox copy |
| `OPEN_QUESTIONS.md` full of `Resolved` entries | Statuses used instead of deletion | Delete them |
| A register full of stale low-priority questions | No exit for questions that stopped mattering | Delete as obsolete; log the reason |
| A number in `docs/` with no date or source | Provenance discipline lapsed | Re-verify or remove it |
| Sessions re-deriving the same conclusion | It never made it into `docs/`, or nobody searched | Promote it; search before concluding |
| A claim nobody can trace | Source was never registered | Register it retroactively, or drop the claim |
| An experiment that cannot be re-run | Reproducibility fields not captured | Treat its result as unverified |
| A session file left `Status: open` | The session was interrupted | Freeze as `abandoned`; do not backfill |
| A rule in `AGENTS.md` having no effect | Nothing imports the file it lives in | Reachable from `AGENTS.md`, or it does not exist |

### The last one is invisible when it fails

In the project this system came from, a file defining how the assistant should communicate sat in
the repository for five sessions with nothing loading it. It looked correct. It never ran.

**A silent failure of instruction loading cannot be detected from inside a session.** The only
check is to ask, in a fresh session, for a rule that appears *exclusively* in the imported file.

Note the distinction this rule depends on: it applies to **behavioural instruction** — files meant
to shape what the assistant does every session, which must be reachable from `AGENTS.md`. It does
not apply to **on-demand reference** — `docs/`, `LOG.md`, the playbooks, and this file, which are
opened when needed and would only waste context if loaded every time.
