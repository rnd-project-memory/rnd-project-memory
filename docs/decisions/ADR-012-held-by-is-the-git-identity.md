# ADR-012 · `Held by:` is the clone's git identity, not a declared token

- **Date:** 2026-08-26 · **Status:** accepted
- **Configuration:** Author + reviewer + sign-off
- **Participants:** author — claude-opus-5 · high effort; reviewer — esdevop (human)
- **Signed off:** esdevop — the decision and this text, reviewed 2026-08-26 alongside a
  plain-language walkthrough by the author

## Context

`ADR-007` moved the checkpoint axis from the person to the thread and made ownership a field,
`Held by:`. It did not say where the *value* of that field comes from. `AGENTS.md` answered that
with an **owner token** — initials, declared once, in a file that is committed and shared.

That answer holds for one person and fails for two. `AGENTS.md` has one slot; a project has N
contributors. The failure was found by asking the plain question — with `es` and `se` on one
project, whose token appears on a thread `se` opened? — and following it:

- The rules already answer it: `se`'s. `RULES.md` says only the holder writes; `RATIONALE.md` says
  the field names a temporary state, not a possession.
- But `AGENTS.md`'s section is written in the second-person singular — *"Pick your initials and
  declare them here"* — so it reads as *the project's owner*, and a second contributor has nowhere
  to declare anything.
- `skeleton/README.md` already contradicts it (*"a second contributor picks their own owner
  token"*) with no place to put one, and §15's claim that adding a person is "close to a no-op" is
  true of every file except this one.
- The tempting repair — `se` edits the declared value — is worse than a merge conflict. A one-line
  change to a shared file merges *cleanly* the wrong way: last writer wins and the other person's
  identity disappears with no conflict marker. That is the silently-diverging-copies failure
  `ADR-002` and `ADR-007` both exist to prevent, reappearing one level up.

A second failure sits underneath it, and it is the one that forced this decision rather than a
smaller fix. The token is a value an assistant must *supply*, and an assistant that cannot resolve
it has three plausible wrong answers within reach: the only declared token, the only `Held by:`
value already present, and the commit log. All three point at `es`. A first-time contributor whose
identity is not yet in the project is therefore the case most likely to be silently misattributed —
and misattribution here is not a wrong byline but a false authority claim, since `RULES.md` grants
the write right to whoever the field names. The next session reads it as fact.

## Decision

**`Held by:` is the exact output of `git config user.email` in the clone where the work happens.**
The owner token is retired; `AGENTS.md` loses its declaration section entirely.

Three properties are being bought, in order of weight:

1. **The shared per-person field is deleted, not managed.** Nothing about a person remains in a
   tracked file, so there is no line for a second contributor to edit and nothing to conflict on.
   A roster mapping tokens to identities was the alternative; it manages the problem instead.
2. **The correct value becomes the cheapest value.** One command, unambiguous output. Inference
   does not become impossible, but it stops being the path of least effort — which is what drove
   the misattribution, not malice or ignorance.
3. **The memory record and the git log become the same string**, and therefore mechanically
   comparable across all history.

Two rules ship with it:

- **Never inferred.** Not from commit history, not from another checkpoint, not from a roster
  having only one row. `git config user.email` returning empty is a **stop**, not a default. The
  command is named exactly: it returns empty when unset, whereas git's `username@hostname`
  fabrication happens later, at commit time. Naming the command is what makes the unconfigured
  case fail safe.
- **`Owner:` on register entries is a human name**, and is not this value. `RATIONALE.md` already
  distinguishes them — `Held by:` names a temporary state, `Owner:` a possession — and retiring the
  token would otherwise leave `ASSUMPTIONS.md` and `OPEN_QUESTIONS.md` with no vocabulary at all.
  One token becomes two conventions. That is a real cost, accepted here explicitly rather than
  discovered mid-release.

Enforcement is advisory and lives in `check.sh`, beside the clone-settings section `v2.4.0` added.
It is deliberately **not** in `.githooks/pre-commit`: that hook does not reach a second contributor
at all (`core.hooksPath` is per-clone and never cloned), and any false positive there is answered
with `--no-verify`, which also disables the secret scan sharing that hook.

## Alternatives considered

| Option | Why not |
|--------|---------|
| Keep the single declared token | The failure above: one slot, N people, and the repair is an edit that merges cleanly the wrong way |
| A roster in `AGENTS.md` mapping tokens to git identities | Works, and was the first draft. But it keeps a per-person field in a shared file, keeps a lookup the assistant can get wrong, and forces `check.sh` to parse a `scaffold` file whose format the project owns — the coupling that pushed the credential patterns out to `.githooks/patterns.profile` in `v2.2.0` |
| Bind it, and enforce equality in `pre-commit` | The hook is absent in every clone but the adopter's, so it enforces nothing for the population this decision is about; and it shares an override with the one irreversible check |
| An uncommitted per-clone identity file | Per-clone is the correct scope, but it adds a second source of truth beside `user.email`, which every contributor already has to configure to commit at all |
| Do nothing until a second contributor actually appears | The cost of the retrofit is a rename referenced from the index and every playbook, and it is normally triggered by discovering the problem through a merge conflict that has already destroyed a session's work — §15's own argument for why the axis was designed for n > 1 from the start |

## Consequences

- **MAJOR.** Every live `Held by:` value becomes invalid. The migration rewrites active
  checkpoints and the `INDEX.md` thread table. Session records, experiment records, ADRs and
  `MIGRATIONS.md` keep the old token: immutable records showing the retired shape are the archive
  working correctly, not a miss.
- **One person with several clone identities becomes several holders** — work laptop, personal
  machine, GitHub noreply address. `RULES.md` then locks them out of their own thread, and the
  workaround is indistinguishable from a take-over. Mitigated, not eliminated, by the per-clone
  `user.email` instruction `v2.4.0` shipped: the binding is to *the identity that signs this
  repository's commits*, which is set once per clone.
- **The enforcement is weaker than it first appears.** A check comparing `Held by:` to the
  committer passes for anyone who edits that line to their own address — which is exactly an
  unlogged take-over. It catches the honest mistake and cannot catch the careless one. Stated here
  so the check is not later mistaken for a guarantee.
- **Residual risk, accepted:** `se` committing from a machine configured with `es`'s identity
  resolves cleanly to the wrong person, and no layer in this design can see it. Signed commits with
  per-person keys would close it and are disproportionate here. Recorded in `ASSUMPTIONS.md` as a
  stated boundary rather than an open question.
- Email addresses appear in `ai-sandbox/` files. Exposure inside the repository is nil — git
  history already carries every address on every commit — and bounded outside it, since checkpoints
  are deleted at thread close and never published.
- `docs/glossary.md`'s **owner token** entry is retired by this decision. It was corrected on
  2026-08-26 to its post-`ADR-007` meaning; that correction stands until this lands.
- Extends `ADR-007` rather than superseding it. The thread axis, the holder-writes rule and the
  take-over-as-event rule are all unchanged; only the provenance of the field's value changes.
  `ADR-007`'s `Status:` line takes `extended by ADR-012` when this is accepted — a pointer edit,
  body untouched.
