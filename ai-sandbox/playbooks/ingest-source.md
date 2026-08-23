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
| Internal dated note | A source only if written **at the moment of assertion**, not reconstructed later. Register as an ordinary `S-…` with author and date. As strong as evidence that something was said — it licenses nothing about the data itself (see `Does not license:` in `ASSUMPTIONS.md`). The boundary with `sessions/…`: a note carries knowledge brought *into* the project; a session file carries knowledge *produced* in it — the test is whether the claim existed before the session, not who wrote it down. |
| Conversation with an AI | Not a source. Reasoning to be verified, and it is recorded in `sessions/`, not `SOURCES.md`. |
