# 2026-08-17 · The manifest-hash check, and applying yesterday's lesson

**Status:** closed

> Fifth session of the day.

---

## Objective

Build the check ADR-003 promised and `upgrade-template.md` step 3 already told readers to run,
closing the gap where two documents described something nobody could execute. Then release it and
upgrade this repository to it.

## Reasoning

The design question was where the released hashes come from. Comparing against the upstream
repository would need network access and a copy of the template — which contradicts the property
that makes vendoring worth doing, that a consumer's tree is self-contained and survives upstream
being renamed or deleted.

So the release ships the hashes: `.template-hashes`, generated from `MANIFEST`'s mechanism entries
with paths relative to a consumer's root, verified with `sha256sum -c`. The file cannot list
itself, which is worth stating in `MANIFEST` because its absence otherwise reads as an oversight.

The check is advisory and its output is deliberately terse. That is not style: §12's argument is
that a check which cries wolf is ignored, and this one is meant to be read at the single moment it
is actionable — *before* an upgrade replaces a file someone edited, not after.

## Decisions

None new. This executed ADR-003.

## Found along the way

**The first version was noisy, and the tag was already cut.** `sha256sum` writes a summary line to
stderr repeating what its `FAILED` lines already say. Two redundant lines in a check whose entire
justification is that noise gets checks ignored.

The tag was not pushed, so it was deleted and re-cut at the fixed commit. That is the v1.0.0
lesson — *tag when the artefact is finished, not when it looks finished* — applied on its first
opportunity, and it cost nothing precisely because it was caught before publication. Re-cutting a
pushed tag would have been a different matter.

**The check was tested against a real edit, not just a clean tree.** Appending a line to
`ai-sandbox/RULES.md` produces:

```
  ai-sandbox/RULES.md: FAILED
  ↑ upstream owns these. An upgrade replaces them wholesale and the edit is lost.
    Move it to AGENTS.md, propose it upstream, or revert it.
```

A first attempt at that test was meaningless: run from inside `skeleton/`, `check.sh` still
resolves to the repository root, so it was checking the root memory while the tampering happened
in the skeleton. Worth knowing — `check.sh` always operates on the repository, never on the
directory it was launched from.

**"No rule changes" was verified rather than asserted.** `MIGRATIONS.md` now requires a release to
say so explicitly, because silence is indistinguishable from an oversight. The claim was checked by
diffing `RULES.md` between the tags before writing the notes.

## Next

- `Q-unexercised-components` stands untouched and will stay so here: `DATA_ENVIRONMENT.md`,
  `ingest-source.md` with `SOURCES.md`, and the hook firing on a real secret need a project with
  data and external sources. The first work project is their test.
- Sample IDs inside a `<placeholder>` in `skeleton/docs/method.md` — cosmetic, still open.
- Nothing else outstanding. `MANIFEST`, `MIGRATIONS.md`, `upgrade-template.md` and the hash check
  now all exist, so §15 describes what is there rather than what was intended.
