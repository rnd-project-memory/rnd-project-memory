# 2026-08-25 · The README's Status section, two releases stale

- **Status:** closed
- **Configuration:** Solo
- **Participants:** author — claude-opus-5 · high effort
- **Signed off:** no
- **Tags:** `#template` `#versioning`

---

## Objective

`README.md` claimed `v2.1.0` after `v2.2.0` and `v2.3.0` had both shipped. Refresh it, and close
the reason it happened.

## Reasoning

The symptom is one number. The cause is that `MIGRATIONS.md`'s "Cutting a release" never names
`README.md` — it covers the hash list, the bootstrap test, retired vocabulary, the bump level, the
tag and its notes, and stops. So the one file a reader meets *before* deciding whether to adopt
anything is the one file the release procedure forgets, and it went stale twice in one day without
anything reporting it.

Same shape as the four instances `v2.2.0` collected, one level out: a step exists, and the artefact
it governs is never told. Here the artefact is the README and the missing enforcement is a line in
the checklist, which is the cheapest of the three forms that question can take.

Rewritten to say what is now true and what is still not. The trial is described by shape only —
"a project already three months old with its own working memory" — since the README is the most
public file here and the trial project is private. Scanned the new text for counts, tooling names
and domain terms before committing; clean.

`MIGRATIONS.md` is `norcopy`, so adding the step changes nothing a consumer receives and needs no
release.

## Decisions

- `README.md`'s Status now leads with the external adoption, because that is the first genuinely
  independent evidence the project has, and follows it with what remains narrow: one adopter, one
  project, multi-user behaviour still reasoned rather than observed.
- The dogfooding lesson is stated in its general form for a reader who will never run this
  template: a system that checks itself sees the settled state and is blind to the transition.
- Release procedure gains step 3b so the next release cannot repeat this.

## Found along the way

The stale line would not have been caught by any check here. `check.sh` reads `.template-version`,
which was correct; nothing compares it to prose. Not proposing a check — a README that lags a
release by a few hours is not worth machinery, and the checklist line is the proportionate fix.

## Next

Nothing queued.
