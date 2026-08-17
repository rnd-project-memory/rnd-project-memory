# rnd-project-memory — Source Register

**Updated:** 2026-08-17

> **Empty, and legitimately so.** This project's knowledge is produced by reasoning in session and
> by reading its own artefact, not by ingesting external material. Claims here carry
> `sessions/…`, `EXP-…` or `ADR-…` as basis. The register exists for the day that changes; an
> empty one is not a gap.

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
