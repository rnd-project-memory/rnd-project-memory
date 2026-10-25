# rnd-project-memory — Source Register

- **Updated:** 2026-10-25

> **Nearly empty, and legitimately so.** This project's knowledge is mostly produced by reasoning in
> session and by reading its own artefact. Claims here usually carry `sessions/…`, `EXP-…` or
> `ADR-…` as basis. The exception is evidence from adopting projects. It is outside material, and
> it is registered here as `reference-only`, without anything that identifies the adopter.

> Every fact in `docs/` that came from outside is traceable to an ID here.
> Cite as `[S-latency-spec §3.2]`.
>
> **IDs are slugs, not numbers.** A slug names the **document's identity** — `S-arch-spec-v2`,
> `S-kickoff-call-0412` — not the claim you wanted from it. Once assigned it is **never
> changed**: renaming breaks every citation silently, because a stale citation still looks valid.
>
> **Sensitivity governs storage.** `committable` → the file lives in `sources/`.
> `reference-only` → the artifact is **never** placed in the repository; only the pointer is.
> Default is `reference-only`. Committing is a deliberate exception, and it is the one
> decision here that a later edit cannot undo — once committed, it is in git history.

## Never commit

Credentials · tokens · connection strings · PII · raw extracted data · customer names ·
anything whose sensitivity has not been established.

---

| ID | Type | Title | Sensitivity | Date read | Status |
|----|------|-------|-------------|-----------|--------|
| `S-<slug>` | | | | | |
| `S-adopter-snapshot-2026-10-25` | adopter snapshot | One adopting project's memory, about 8 weeks on `v3.5.0` | reference-only | 2026-10-25 | ingested |

---

## S-<slug> · <title>

- **Type:** PDF | Confluence | transcript | conversation | dataset doc
- **Origin:** <URL, SharePoint path, or `sources/<file>`>
- **Source date:** <when the source itself was written>
- **Date read:** <when it was ingested — matters for mutable sources>
- **Sensitivity:** committable | reference-only
- **Status:** ingested | partial | superseded by S-<slug>
- **Answers:** <which questions this source can settle>
- **Notes:** <caveats, contested claims, sections worth revisiting>

## S-adopter-snapshot-2026-10-25 · One adopter's project memory, as of 2026-10-25

- **Type:** adopter snapshot: a working project's full tree, read in place
- **Origin:** the author's private snapshot repository, commit `a0fae36`. Not in this repository,
  and never to be. The adopter's work is an employer's, so nothing identifying it is recorded
  here (`docs/constraints.md`).
- **Source date:** 2026-10-25 (snapshot); its records span 2026-08-30 to 2026-10-23
- **Date read:** 2026-10-25
- **Sensitivity:** reference-only
- **Status:** ingested
- **Answers:** how the template behaves over weeks of real use: which write modes held, which
  drifted, what the adopter added. See `sessions/2026-10-25-adopter-example-review.md`.
- **Notes:** the snapshot repository's history is snapshots, not the project's own history, so
  rewrite and deletion frequency cannot be read from it. `.githooks/` was removed when the snapshot
  was prepared. The project keeps evolving, so a later reading is a new entry with its own date.
