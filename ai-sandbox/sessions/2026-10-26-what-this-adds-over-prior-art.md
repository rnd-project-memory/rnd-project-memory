# 2026-10-26 · What this system adds over prior art

- **Status:** closed
- **Configuration:** Solo
- **Participants:** author — claude-opus-5-5
- **Signed off:** no
- **Tags:** `#template` `#adoption` `#distribution`

> Written at the session's end, after the evaluation was given in conversation. A reconstruction of
> a short, single-topic session, not a running account.

---

## Objective

The author asked whether this project reinvents something that already ships ready-made in AI
models, tools or harnesses.

## Reasoning

A web landscape read, through search summaries plus one article read in full
(`[S-fowler-sdd-tools-2025]`). Sources are registered in `SOURCES.md` with status `partial`, since
most were read only through summaries. One page that looked closest to this project, an essay on
a research notebook for coding agents, returned 404 and is not registered.

**Already shipped.**

| This project | Prior art | Overlap |
|---|---|---|
| memory across sessions | `[S-claude-code-memory-docs]`, `[S-github-copilot-agentic-memory]`, `[S-cline-memory-bank]` | high: commodity |
| implementation packages | `[S-github-spec-kit-history]`, `[S-openspec-overview]`, Kiro and Tessl via `[S-fowler-sdd-tools-2025]` | high: OpenSpec's living spec plus archived changes mirrors `docs/` plus `implementations/` |
| derived step states | `[S-beads-agent-tracker]` | medium: same idea, as a tool |
| evidence-backed R&D memory | `[S-research-agent-provenance-2026]` | low: research prototypes, no product |

**Apparently missing from prior art**, as far as the summaries show:

- write modes separating settled, in-flight and history (Cline rewrites summaries, and Copilot
  expires memories after 28 days);
- claims indexed with their basis;
- fields for distrust and scope;
- the rule against writing facts nobody supplied;
- verdict kept apart from verification;
- verification of execution by immutable attempt reports and clean-checkout re-runs, the gap
  `[S-fowler-sdd-tools-2025]` names in spec-driven tools;
- tool neutrality, tested across providers;
- source sensitivity for employer work.

**Not checked:** whether current Spec Kit or OpenSpec versions verify execution beyond tasks.

**Risks stated.** The system's weight is a real cost. The adopter promoted nothing to `docs/` in
eight weeks, its INDEX bloated, and its staleness check became ritual.
`[S-fowler-sdd-tools-2025]` reports the same of spec-driven tools: a sledgehammer, and markdown
heavier to review than code. Implementation packages compete in the most crowded part of the field.
No value is yet shown beyond one author.

**Recommendation given.**

- Name the niche narrowly: an evidence layer for AI-assisted R&D, recording what is known, what it
  rests on, and what was actually verified. Leave auto-memory and spec pipelines to the tools.
- Consider making implementation packages a thin verification layer over Spec Kit or OpenSpec
  output.
- Settle the question by a pre-registered comparison, not by argument.

## Decisions

- Recorded as `Q-positioning-against-prior-art` 🔴, Owner esdevop, as the author asked, with the
  comparison as *what would answer it*.
- Eight sources registered as `reference-only`, by URL.

## Next

Design the comparison's pre-registration, or decide the positioning, whichever the author chooses.
