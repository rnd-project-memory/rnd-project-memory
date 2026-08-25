# rnd-project-memory — Problem

- **Updated:** 2026-08-17

## What is being solved

Knowledge produced in AI-assisted sessions does not survive them. Two failures account for most of
the loss, and they are opposites:

- **Lossy re-summarising.** Each session compresses the last one's notes. After five rounds the
  notes are a retelling of a retelling — confidently worded, detached from evidence, and no longer
  checkable against anything.
- **The unread archive.** An append-only log grows until only its beginning and end are read, and
  the middle silently stops existing.

Both come from mixing state with history in one file. This project builds and maintains a
structure that separates them, plus the operational layer that keeps the separation from eroding
under a helpful assistant.

## For whom

| Who | What they need |
|-----|----------------|
| A solo practitioner running AI sessions on an R&D project | Something adoptable in an afternoon that does not become a second job |
| That person's colleagues, later | To join without a migration: no renames, no shared counters, no coordination added to the half that already works |
| Whoever sets it up | A textbook that can be read once — the handbook — separate from the files used daily |

The single-author case is the tested one. Multi-user behaviour is reasoned from the design.

## Success criteria

1. **Working memory stays bounded** without anyone compressing prose — the checkpoint cap is met
   by promoting, not by rewording.
2. **A conclusion has exactly one home.** No fact appears in both `docs/` and the sandbox.
3. **A claim in `docs/` is traceable** to an experiment, a source, a session, or a decision.
4. **An adopter can upgrade** to a later version of the template without a merge and without
   losing their own content.
5. **The rules survive contact with a helpful assistant** — each ships with the failure it
   prevents, because a bare imperative gets violated with good intentions.

Criteria 1–3 are met and exercised. Criterion 4 is designed but unproven: no project has yet lived
through an upgrade. Criterion 5 is a standing bet.

## Out of scope

- A tool. The system is prose and directory structure; the only executable parts are one advisory
  script and one blocking git hook.
- Multi-user coordination beyond what falls out of the file layout. Making the archive
  collaborative is explicitly rejected: it charges coordination cost on every session to avoid a
  conflict that occurs rarely.
- Being tool-agnostic in the abstract. It targets an assistant that auto-loads `AGENTS.md` and
  supports `@` imports; portability beyond that is a happy accident, not a requirement.

## Open questions

- [ ] `Q-unexercised-components` — the components neither this repository nor the originating
      one exercises
- [ ] `Q-enterprise-access` — what the employer's GitHub permits
- [ ] `Q-contribution-flow` — how colleague improvements reach upstream
