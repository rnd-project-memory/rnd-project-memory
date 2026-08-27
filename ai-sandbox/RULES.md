# Working rules

> **This file is upstream's.** It is replaced wholesale when the template is upgraded, so a local
> edit here is lost at the next version — and lost silently. Anything specific to this project
> belongs in `AGENTS.md`, which is yours. `RATIONALE.md` explains why each rule below exists;
> read it on demand and do not import it.

- **Never write a fact nobody supplied.** Where an entry, a section or a field calls for
  something you were not told and cannot derive from this repository, **stop and ask**. Leaving it
  unanswered is a legitimate outcome; recording the gap — an install marker left in place, an
  `OPEN_QUESTIONS.md` entry, a sentence saying what is not yet decided — is a better one. (The
  marker is not spelled out here on purpose: this file ships into projects, and a literal one
  would read as an unanswered blank to every tool that counts them — the fourth time that has
  caught something.) Writing
  a plausible answer is not, and it is the failure this whole system is built to prevent: a
  document that reads as settled, is not, and cannot be told apart from one that is. This binds
  hardest at the moment a project is set up, when the person and the repository both have least
  to say and the pressure to produce something complete is highest.
- **A field that must not be blank and has no correct value available is a stop, not a guess.**
  Two rules on one slot with no third exit is a defect in the rules; say so and ask, rather than
  reaching for the nearest value that is merely available. `Owner:` is the known case — it takes a
  human name, is never the git address, and stays empty until someone gives you one.
- **A thread's checkpoint is `ai-sandbox/CHECKPOINT-<thread-slug>.md`**, named for what is being
  worked on, not who is working on it. Only whoever it names as `Held by:` writes it — everyone
  else reads. Taking over a thread is an event: write it into your session file and add a
  `sessions/LOG.md` row, not a silent edit of the field.
- **`Held by:` is the exact output of `git config user.email` in this clone.** Never chosen, never
  abbreviated, never copied from another entry, and never inferred — not from commit history, not
  from a checkpoint already present, not from an address being the only one in the project. Empty
  output is a **stop**: ask for it. `Owner:` on a register entry is a different field and takes a
  human name.
- **A thread's checkpoint exists only while something produced is not yet promoted and not yet
  closed.** If everything a session left behind already has a home in `docs/`, `CAVEATS.yaml`, or
  a playbook, there is no checkpoint to open for it.
- `docs/` is the permanent knowledge base: settled conclusions only. **Changes to `docs/` are
  reviewed before they land** — propose the change, then apply it once approved. Working alone
  that means a deliberate diff pass; with colleagues it means a pull request.
- `ai-sandbox/` is working memory. It is *not* a second copy of `docs/`. A matured conclusion
  moves and is deleted from the sandbox, never copied.
- The checkpoint is rewritten, never appended, and capped at 150 lines. Over the cap means
  something needs promoting to `docs/` — not that the prose needs shortening.
- Write every entry for a reader who missed the session. In three months that reader is you.
- The session file is created at the **start** of a session (`Status: open`) and appended to as it
  runs; `checkpoint.md` closes it. Immutable once closed. An `open` file from any earlier session
  was interrupted — freeze it as `abandoned`, do not backfill.
- Experiment records are immutable once written. Corrections go into the next one.
- **A conclusion resting on an experiment marked `not verified` does not move to `docs/`.**
- **If an experiment record cites a file, that file is in the repository** — or the record says
  why not and names what stands in as evidence instead.
- Register entries are **deleted**, never marked resolved — whether answered or gone obsolete.
  The `LOG.md` row names the outcome, which is what keeps the deletion discoverable.
  `ai-sandbox/CAVEATS.yaml` is the one register exempt from this: a trap does not stop being true
  when addressed, so it is corrected or marked gone, never deleted. Where a register inherited
  numbered IDs from before adoption, that row also names the entry's **subject**: a deleted slug
  still reads in an old citation, a deleted number does not.
- **Where a file inherited at adoption cannot follow a rule here, say so in an adoption note** — a
  blockquote under that file's preamble opening `> **Adoption note.**`, stating the rule, what the
  file does instead, and what must happen for the divergence to close. A declared inability to
  close is a valid third part; an omitted one is not, and turns the note into an excuse. Delete the
  note when the divergence closes, with a `LOG.md` row like any other removal.
  **A note covers only records the rule cannot reach because they are older than it** — whether it
  arrived at adoption or in an upgrade. One test: could this file have conformed when it was
  written? If it could, no note is owed and the divergence is fixed rather than documented.
  Otherwise the device stops being how the system is adopted and becomes how its rules are avoided,
  one reasonable exception at a time.
- Data and tool traps go in `ai-sandbox/CAVEATS.yaml`, found by subject — not read start to end.
- Every claim promoted into `docs/` gets a row in `docs/CLAIMS.md` with its basis (`EXP-…`,
  `S-…`, `sessions/…`, or `ADR-…`), written in the same change.
- **A record that describes a check is never rewritten to satisfy it.** These files are prose
  *about* this system, so they quote the strings the checks look for while explaining them, and an
  advisory check will sometimes report the explanation as the thing explained. Editing the record
  to silence it makes the record less true — the worse of the two trades. Aim the check better, or
  leave the line and say why.
- Search before concluding something is unknown: `rg -i "<topic>" ai-sandbox/*/LOG.md docs/`.
- Every number that enters `docs/` carries a date and a source.
- Never commit credentials, tokens, PII, or raw extracted data. See `ai-sandbox/SOURCES.md`.

## Procedures

Ask to follow one of these by path:

| Playbook | When |
|----------|------|
| `ai-sandbox/playbooks/session-start.md` | Opening a session |
| `ai-sandbox/playbooks/checkpoint.md` | Closing a session, or any save point |
| `ai-sandbox/playbooks/promote.md` | Moving a conclusion into `docs/` |
| `ai-sandbox/playbooks/ingest-source.md` | Adding a PDF, wiki page, or transcript |
| `ai-sandbox/playbooks/run-experiment.md` | Running and recording an analysis |
| `ai-sandbox/playbooks/upgrade-template.md` | Raising the project to a later template release |
