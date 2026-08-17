# ADR-004 · Versions are semantic; migrations are prose an assistant executes

**Date:** 2026-08-17 · **Status:** accepted
**Revised:** the same day, to cover behavioural rule changes — a category the original table did
not classify. Surfaced by `EXP-2026-08-17-misdirection-recheck`.

## Context

Once consumers pin a version, they need to know what raising it costs them. Standard SemVer
applies, but its categories describe an API, and what breaks here is the structure of a memory
system rather than a function signature.

Separately, some upgrades require changing material the consumer already wrote. Renaming a file is
mechanical; "every row in `CLAIMS.md` now carries a basis reference" is a rewrite of prose that a
shell script cannot perform.

## Decision

| Bump | What changed | Consumer action |
|------|--------------|-----------------|
| MAJOR | a routing rule changed; a file moved or was renamed; a register's schema changed; **a rule change that leaves existing entries non-conforming** | run the migration |
| MINOR | a new optional playbook, file, or advisory check; **a new or strengthened behavioural rule that leaves existing entries valid** | replace mechanism, read the named rule change |
| PATCH | wording; a rationale expanded without changing what the rule requires | replace, do nothing |

The discriminator for a rule change is **not its size but whether the project's existing entries
still conform**. *"Search `LOG.md` before concluding something is unknown"* binds future behaviour
only — MINOR. *"Checkpoints are per owner"* leaves the existing `CHECKPOINT.md` misnamed — MAJOR,
with a migration that renames it.

Migrations live in `MIGRATIONS.md`, one section per MAJOR, **written as instructions to an AI
assistant rather than as a script**, because the material being migrated is prose. A migration
states its reason, its steps, and — critically — its exceptions:

```markdown
## v1 → v2: checkpoints became per-owner

Reason: two people were overwriting one file (RATIONALE §…).

1. Rename `ai-sandbox/CHECKPOINT.md` → `CHECKPOINT-<token>.md`.
2. Declare `<token>` in `AGENTS.md`.
3. Find references to the old name: `rg -n 'CHECKPOINT\.md'` — including playbooks and
   session files. Session files are immutable: do NOT edit them; the mismatch is expected.
4. Run `./check.sh`; verify the "Checkpoint size" block.
```

Step 3 is the reason for the format. An assistant understands the exception; a script would "fix"
the immutable session files and violate the system's central rule while reporting success.

Releases are cut by PR and tag. The release notes and the `MIGRATIONS.md` section are the same
text — one source, not two.

### Rule changes are named, at every bump level

Under ADR-002 the working rules live in `ai-sandbox/RULES.md`, which is mechanism: an upgrade
replaces it wholesale. That is the right delivery mechanism and it has one failure mode — the rule
arrives **silently**. A consumer copies a file and is bound by a rule nobody read. A version
number cannot fix this; MINOR tells you to "read the notes" only if the notes say something.

Two obligations therefore attach to `RULES.md`, one on each side:

- **The author's.** Any release whose diff touches `RULES.md` names the change in its notes, one
  line per rule, including at PATCH. A release that touches `RULES.md` and says nothing about
  rules is a defect in the release, not in the consumer.
- **The consumer's safety net.** `playbooks/upgrade-template.md` diffs the incoming `RULES.md`
  against the installed one and reports every changed rule to the user, regardless of what the
  release notes claimed. The author's obligation is process and nothing enforces it; this step is
  what makes a forgotten note recoverable.

## Alternatives considered

| Option | Why not |
|--------|---------|
| Migration shell scripts | Cannot rewrite prose, and cannot honour "immutable files are exempt" |
| Date-based versions | Carries no signal about whether an upgrade requires work |
| No versioning; always take latest | Removes the consumer's ability to defer an upgrade, which is the only reason vendoring is tolerable |
| A fourth bump level for rule changes | SemVer has three numbers; a fourth category needs notation nobody recognises, and the existing three separate the cases correctly once the conformance discriminator is stated |
| Every rule change is MAJOR | Makes the common case — a rule binding only future work — as expensive to consume as a structural migration. Consumers respond by deferring upgrades, which is how a version scheme stops being used |

## Consequences

- MAJOR bumps are expensive to author, which is the correct incentive.
- `playbooks/upgrade-template.md` gains a required step it did not previously have: diff
  `RULES.md` and report the rule changes. Without it the release-notes obligation has no backstop.
- **Rule delivery no longer rides on `A-prose-migrations`.** Because rules live in a mechanism
  file, the common case is a file replacement; a migration is needed only when existing entries
  stop conforming. That reduction is the payoff of the ADR-002 split, and it is the reason the
  split survives even though nothing else requires it.
- Preamble updates in the register files are described in prose by the migration rather than
  delimited by markers — ADR-002 as revised carries no fencing syntax.
- A migration is only proven by being executed. ADR-006 supplies the first executor.
- **The handbook carries the same tag as the skeleton, and a MAJOR release must reconcile it in
  the same change.** Settled by reconciling `RND_PROJECT_MEMORY.md` against the finished design:
  one day's revisions invalidated nine of its sections, and independent release would have shipped
  a correct skeleton beside an authoritative document that was wrong — `skeleton/README.md`
  resolves that disagreement in the handbook's favour, so the wrong document would have won. The
  cost is real: every MAJOR must reconcile 682 lines. The alternative demonstrated its failure
  mode within a day.
- The reliability of prose migrations is an unverified bet — `A-prose-migrations`.
