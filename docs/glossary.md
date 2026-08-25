# rnd-project-memory — Glossary

- **Updated:** 2026-08-17

> Terms used with a specific meaning in this project, especially ones whose everyday
> meaning differs, and ones where stakeholders disagree.

| Term | Meaning here | Notes |
|------|--------------|-------|
| **the artefact** | `skeleton/` and `RND_PROJECT_MEMORY.md` — what gets shipped | Distinct from this repository's own memory at the root, which is real content |
| **mechanism** | A file upstream owns and replaces wholesale on upgrade | One of four ownership layers, `ADR-002` |
| **scaffold** | A file upstream authors once as a starting shape; the project owns it from first edit | Upstream revisions never propagate to it |
| **profile** | Stack-specific content, substituted per adopting project | `DATA_ENVIRONMENT.md` is the only one |
| **vendoring** | Taking a copy of the mechanism layer at a pinned version, with no git relationship | Not a fork, not a submodule, not a subtree |
| **misdirects** | Content that instructs, where the instruction is false for this project | The test for whether stack content is a defect. Content that merely sits there does not misdirect |
| **the routing rule** | Every piece of information has exactly one home | The core of the system; handbook §2 |
| **owner token** | The initials naming one person's checkpoint file | The one value the rules cannot supply themselves; declared in `AGENTS.md` |
| **drift** | Two copies of the same content diverging until neither is trustworthy | The failure the whole system exists to prevent, including in its own delivery |
