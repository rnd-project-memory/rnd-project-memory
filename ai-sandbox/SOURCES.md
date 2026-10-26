# rnd-project-memory — Source Register

- **Updated:** 2026-10-26

> **Nearly empty, and legitimately so.** This project's knowledge is mostly produced by reasoning in
> session and by reading its own artefact. Claims here usually carry `sessions/…`, `EXP-…` or
> `ADR-…` as basis. There are two exceptions. Evidence from adopting projects is outside material,
> registered here as `reference-only` without anything that identifies the adopter. Public prior
> art is the other: registered by URL, never copied in.

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
| `S-github-spec-kit-history` | web page | GitHub Spec Kit — project history (official) | reference-only | 2026-10-26 | partial |
| `S-fowler-sdd-tools-2025` | article | Understanding Spec-Driven Development: Kiro, spec-kit, and Tessl (B. Böckeler, martinfowler.com, 2025-10-15) | reference-only | 2026-10-26 | partial |
| `S-openspec-overview` | web page | OpenSpec — overview (agentic-ai docs) and Conduction academy page | reference-only | 2026-10-26 | partial |
| `S-cline-memory-bank` | documentation | Cline — Memory Bank | reference-only | 2026-10-26 | partial |
| `S-claude-code-memory-docs` | documentation | Claude Code — memory (CLAUDE.md and auto memory) | reference-only | 2026-10-26 | partial |
| `S-github-copilot-agentic-memory` | blog post | GitHub — Building an agentic memory system for GitHub Copilot; changelog 2026-01-15 | reference-only | 2026-10-26 | partial |
| `S-beads-agent-tracker` | article | Beads — git-backed issue tracker for coding agents (secondary write-up) | reference-only | 2026-10-26 | partial |
| `S-research-agent-provenance-2026` | papers | XScientist (arXiv 2607.12301); Agora (arXiv 2609.18094) | reference-only | 2026-10-26 | partial |

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

## S-github-spec-kit-history · GitHub Spec Kit — project history (official)

- **Type:** web page
- **Origin:** https://github.github.com/spec-kit/history.html
- **Source date:** as stated on the page; see Notes
- **Date read:** 2026-10-26, through web search summaries and, for the Fowler article, the page itself
- **Sensitivity:** reference-only (public; pointer only)
- **Status:** partial
- **Answers:** `Q-positioning-against-prior-art`
- **Notes:** Spec Kit 1.0.0 on 2026-08-21; 38 agent integrations, 157 extensions, 270+ contributors, as the page states. Spec → plan → tasks → implement.

## S-fowler-sdd-tools-2025 · Understanding Spec-Driven Development: Kiro, spec-kit, and Tessl (B. Böckeler, martinfowler.com, 2025-10-15)

- **Type:** article
- **Origin:** https://www.martinfowler.com/articles/exploring-gen-ai/sdd-3-tools.html
- **Source date:** as stated on the page; see Notes
- **Date read:** 2026-10-26, through web search summaries and, for the Fowler article, the page itself
- **Sensitivity:** reference-only (public; pointer only)
- **Status:** partial
- **Answers:** `Q-positioning-against-prior-art`
- **Notes:** Criticisms: one workflow for all sizes (sledgehammer), verbose markdown to review, false sense of control as agents ignore instructions, unclear spec lifecycle. Dated 2025: tools have moved since.

## S-openspec-overview · OpenSpec — overview (agentic-ai docs) and Conduction academy page

- **Type:** web page
- **Origin:** https://agentic-ai.readthedocs.io/en/latest/Standards/openspec/ ; https://conduction.nl/academy/spec-driven-development
- **Source date:** as stated on the page; see Notes
- **Date read:** 2026-10-26, through web search summaries and, for the Fowler article, the page itself
- **Sensitivity:** reference-only (public; pointer only)
- **Status:** partial
- **Answers:** `Q-positioning-against-prior-art`
- **Notes:** Living spec per capability; proposed changes as delta folders, archived and merged on ship. Secondary sources; version and dates disagree between them, official repository not read.

## S-cline-memory-bank · Cline — Memory Bank

- **Type:** documentation
- **Origin:** https://docs.cline.bot/best-practices/memory-bank
- **Source date:** as stated on the page; see Notes
- **Date read:** 2026-10-26, through web search summaries and, for the Fowler article, the page itself
- **Sensitivity:** reference-only (public; pointer only)
- **Status:** partial
- **Answers:** `Q-positioning-against-prior-art`
- **Notes:** Six markdown files: projectbrief, productContext, activeContext, systemPatterns, techContext, progress. activeContext and progress are summaries rewritten each session.

## S-claude-code-memory-docs · Claude Code — memory (CLAUDE.md and auto memory)

- **Type:** documentation
- **Origin:** https://code.claude.com/docs/en/memory.md
- **Source date:** as stated on the page; see Notes
- **Date read:** 2026-10-26, through web search summaries and, for the Fowler article, the page itself
- **Sensitivity:** reference-only (public; pointer only)
- **Status:** partial
- **Answers:** `Q-positioning-against-prior-art`
- **Notes:** Hand-written CLAUDE.md loaded each session; auto memory (MEMORY.md index plus topic files) captured by the assistant, first 200 lines or 25 KB loaded.

## S-github-copilot-agentic-memory · GitHub — Building an agentic memory system for GitHub Copilot; changelog 2026-01-15

- **Type:** blog post
- **Origin:** https://github.blog/ai-and-ml/github-copilot/building-an-agentic-memory-system-for-github-copilot/ ; https://github.blog/changelog/2026-01-15-agentic-memory-for-github-copilot-is-in-public-preview/
- **Source date:** as stated on the page; see Notes
- **Date read:** 2026-10-26, through web search summaries and, for the Fowler article, the page itself
- **Sensitivity:** reference-only (public; pointer only)
- **Status:** partial
- **Answers:** `Q-positioning-against-prior-art`
- **Notes:** Memories captured automatically, verified against current code before use, shared across Copilot surfaces, expired after 28 days.

## S-beads-agent-tracker · Beads — git-backed issue tracker for coding agents (secondary write-up)

- **Type:** article
- **Origin:** https://www.morphllm.com/beads-agent-memory
- **Source date:** as stated on the page; see Notes
- **Date read:** 2026-10-26, through web search summaries and, for the Fowler article, the page itself
- **Sensitivity:** reference-only (public; pointer only)
- **Status:** partial
- **Answers:** `Q-positioning-against-prior-art`
- **Notes:** JSONL in the repository, dependency graph, ready-work query, compaction of closed tasks. A binary tool. Claims about inspiring Claude Code features are unverified.

## S-research-agent-provenance-2026 · XScientist (arXiv 2607.12301); Agora (arXiv 2609.18094)

- **Type:** papers
- **Origin:** https://arxiv.org/pdf/2607.12301 ; https://arxiv.org/pdf/2609.18094
- **Source date:** as stated on the page; see Notes
- **Date read:** 2026-10-26, through web search summaries and, for the Fowler article, the page itself
- **Sensitivity:** reference-only (public; pointer only)
- **Status:** partial
- **Answers:** `Q-positioning-against-prior-art`
- **Notes:** Research prototypes using git-like protocols as authoritative, provenance-tracked memory for research agents. Read through search summaries only, not in full.
