# 2026-08-26 · The glossary's owner-token entry, four releases stale

- **Status:** closed
- **Configuration:** Solo
- **Participants:** author — claude-opus-5 · high effort
- **Signed off:** no
- **Tags:** `#template` `#ownership`

---

## Objective

`docs/glossary.md:17` still defined *owner token* as "the initials naming one person's checkpoint
file" — the pre-`v2.0.0` meaning, retired when the checkpoint axis moved from the person to the
thread. Found while evaluating the binding question in the previous session and deferred there;
fixed here.

## Reasoning

The entry was not merely dated, it was misdirecting in the sense `ADR-002` gives the word: it
instructs, and what it instructs is false. A reader looking up the term is told the token names a
file. `ADR-007` renamed exactly that away, `RULES.md` has said `CHECKPOINT-<thread-slug>.md` since
`v2.0.0`, and `RATIONALE.md` states the token names a temporary state rather than a possession.
The one file whose job is to settle what a word means was the one still using the retired meaning.

Rewritten to lead with what the token *is* — who currently holds a thread — and to carry the
negative explicitly, since the wrong idea is the one a reader arrives with. `ADR-007` cited so the
entry points at the decision rather than restating it.

Why `v2.1.0`'s retired-vocabulary check did not catch it is the part worth keeping. That check
matches literal strings named in a migration's Reason section: `CHECKPOINT-<owner>`,
`one per person`, `per-owner`. This entry contained none of them. It expressed the retired *idea*
in words nobody had listed, which is what a definition does — it paraphrases. So the check covers
restatements of a retired term and not restatements of a retired meaning, and a glossary is where
the second is most likely to live.

Not proposing a widened pattern. Matching on paraphrase means guessing the phrasings in advance,
which is the same problem one level down, and this class has now produced exactly one instance.
Recorded rather than mechanised.

## Decisions

- Entry rewritten; `ADR-007` cited; `Updated:` moved to 2026-08-26.
- **No release.** `docs/glossary.md` is `scaffold`, and the copy under `skeleton/` is an empty
  table with no owner-token row — so nothing a consumer receives changes. Same shape as the
  `README.md` refresh on 2026-08-25.
- **No `CLAIMS.md` row.** It indexes claims in `docs/method.md`; the glossary holds definitions and
  has never been indexed there. `check.sh` asks the question on any staged `docs/` change, and the
  answer here is that the index is still true.
- Term left in place rather than deleted, even though `Q-held-by-identity-binding` may retire the
  token entirely. A definition that is correct today is worth having today, and the register entry
  already records that the binding rewrites it.

## Found along the way

Nothing further. The `Held by:` field itself has no glossary row, which is defensible — the term
appears in `RULES.md`, the checkpoint template's own preamble, and `RATIONALE.md`, and adding a
fourth statement of it would be the duplication the routing rule forbids.

## Next

`Q-held-by-identity-binding` remains queued, and rewrites this entry if it lands.
