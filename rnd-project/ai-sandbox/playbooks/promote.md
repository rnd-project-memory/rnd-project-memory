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
