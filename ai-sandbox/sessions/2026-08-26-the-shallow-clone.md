# 2026-08-26 · The clone that cannot say which release it is

- **Status:** closed
- **Configuration:** Solo
- **Participants:** author — claude-opus-5 · high effort
- **Signed off:** no
- **Tags:** `#template` `#versioning` `#adoption`

---

## Objective

Before publishing, rehearse the one part of the adoption path nothing had exercised: running
`install.sh` from a **clone** rather than from the working tree.

## Reasoning

The question on the table was whether to stage the experiment against a local bare repository or
against the real remote. Answering it needed one fact — whether a clone carries what `install.sh`
reads — so the rehearsal was run for that, and it returned a defect instead of an answer.

`install.sh` takes two facts from the clone's history: the release, via `git describe --tags`, and
the commit `skeleton/` was last changed at, via a path-limited `git log`. **A shallow clone has
neither.** `git clone --depth 1` fetches no tags at all, and the path-limited log returns the one
commit it holds rather than the commit that touched `skeleton/`.

Both failures were silent. The first draft fell back to `v0.0.0-untagged` and printed it as an
`ok` line:

```
ok    .template-version records v0.0.0-untagged, skeleton @ 0195fa9, applied 2026-08-26
```

Neither field is true. And `.template-version` is not decoration — field one is what `check.sh`
reports and what §15 measures every future upgrade from, so a project installed this way can never
be upgraded correctly, and nothing about it looks wrong.

**`--depth 1` is not an exotic case.** It is what anyone in a hurry types, and what a great many
automated environments do by default. The rehearsal used it not because it was suspected but
because it is the obvious way to clone something you only want to read.

The repair is the rule this project already applies to `user.email`: **a fact that cannot be
derived is a stop, not a fallback.** Both conditions are now refused before anything is copied, so
the destination is left untouched — 0 files, verified — and the message names the one command that
fixes each (`fetch --unshallow --tags`, `fetch --tags`).

**No release.** `install.sh` is `norcopy`: it belongs to the template repository and is never
copied into a project, so nothing an adopter holds changes and there is no version for them to
move to. Same treatment `MIGRATIONS.md` got on 2026-08-25 for the same reason.

## Decisions

- **A shallow clone and a tagless clone are both refusals**, checked before the copy set is
  touched.
- **The local-stage option is closed as an experiment setting**, and the reason is now evidenced
  rather than argued: the rehearsal's whole value was finding this, and it took ten minutes; but
  three of the defects closed today — the *Use this template* button, the rendered landing page,
  and access itself — do not exist locally at all. A stage also requires an out-of-band
  instruction ("clone from this path"), and anything the operator has to say that the
  documentation does not is a measurement of the operator.

## Found along the way

- **`bootstrap-test.sh` could not have caught this and still cannot.** It runs `install.sh` inside
  the template repository's own working tree, which is never shallow and always has tags. The
  install path it exercises begins one step later than the adopter's does. A third instrument
  would be a clone-and-install gate; not built, because it needs a bare clone per run and the
  defect it would have caught is now refused at the door.
- The fallback value `v0.0.0-untagged` was written by the same hand that wrote the rule forbidding
  exactly that shape for `user.email`, in the same file, forty lines apart.

## Next

- Push, then the new-project experiment against the remote.
