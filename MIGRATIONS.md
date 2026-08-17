# Migrations

One section per MAJOR release, in order. A consumer upgrading from `<from>` to `<to>` executes
**every** section strictly between them — intermediate MAJORs are not skippable, because each
assumes the structure the previous one left.

This file is upstream's and is never copied into an adopting project. It is read at upgrade time,
by `ai-sandbox/playbooks/upgrade-template.md`.

## How a section is written

**As instructions to an assistant, not as a script.** The material being migrated is prose — a
register's entries, a claim's basis, the wording of a rule — and the steps that matter most are
exceptions a script would get wrong while reporting success. The canonical example: session and
experiment records are immutable, so a migration that renames a file must *not* fix the references
to the old name inside them. That mismatch is the historical record working correctly.

Each section states:

1. **Reason** — what failed under the old shape. Without it the migration reads as churn and gets
   deferred.
2. **Steps** — in order, with the exact commands where a command is exact.
3. **Exceptions** — what must *not* be touched, and why. Never omit this heading; write "none" if
   there are none, so its absence is always a defect rather than a judgement.
4. **Verification** — what `check.sh` should say afterwards, and what a correct diff looks like.

Release notes and the section here are the same text. One source, not two.

## Cutting a release

1. Settle the tree first. **Tag when the artefact is finished, not when it looks finished** — the
   `v1.0.0` tag was cut mid-session, two fixes landed after it, and the root memory then claimed a
   version it did not have for a full session.
2. Regenerate the hash list that consumers check against:

   ```bash
   grep '^mechanism' MANIFEST | awk '{print $2}' | while read -r p; do
     [ -f "skeleton/$p" ] && (cd skeleton && sha256sum "$p")
   done > skeleton/.template-hashes
   ```

   Paths are relative to a consumer's repository root, which is what `skeleton/` becomes. The file
   does not list itself.
3. Tag, with notes that **name every changed rule** if the diff touches `ai-sandbox/RULES.md`, one
   line per rule, at any bump level. If it does not, say so explicitly: "no rule changes" is
   information, and its absence is indistinguishable from an oversight.
4. Add the section here if the bump is MAJOR.

## Partial application

A migration interrupted halfway leaves the repository in a state that claims one version and has
the structure of another. `upgrade-template.md` therefore updates `.template-version` **last**, as
its final step — so the recorded version always names a state that was actually reached, and an
interrupted upgrade is visible rather than silent.

If you find a repository whose `.template-version` disagrees with its structure, trust the
structure and re-run the migration from the version the structure implies.

---

## No migrations yet

`v1.0.0` is the first release. `v1.1.0` added a playbook and changed no structure.

This file exists before it is needed on purpose: the format is easier to agree when nothing is at
stake than in the moment a real migration is due.
