# Playbook — Raise the project to a later template release

Run when you want something a later release has. **Being behind is not a problem to fix** — a
vendored copy works exactly as well as the day it was taken. Upgrade deliberately, not on a
schedule.

Follow the steps **in order**.

## 1. Establish where you are

```bash
cat .template-version
```

If that file is missing, the project was adopted without recording a version. Do not guess: compare
the mechanism files against the template's releases and find the one they match, then write the
file before going further.

If it disagrees with the structure — it names a version whose files are not what you have — an
earlier upgrade was interrupted. **Trust the structure**, not the file, and re-run from the version
the structure implies.

## 2. Read every migration between the two versions

Fetch the target release and read `MIGRATIONS.md`. Execute **every** section strictly between your
version and the target, in order. Intermediate MAJORs are not skippable: each assumes the structure
the previous one left.

If there are no MAJORs between them, there is no migration — only the file replacement in step 4.

## 3. Check for edits to files you do not own

```bash
./check.sh          # "Mechanism files against their released hashes" is the block to read
```

It compares against `.template-hashes`, which shipped with the release you are on — no network and
no copy of the template required.

A mechanism file that differs means someone edited a file upstream owns, and step 4 is about to
discard that edit. **Stop and show the user the diff.** The change either belongs in `AGENTS.md`,
or it is worth proposing upstream, or it was a mistake — all three need a person, and none of them
survive being silently overwritten.

If the block reports *no* `.template-hashes`, the project predates this check. Compare by hand
against the release it claims before going further; that comparison is what caught the first real
discrepancy this system ever had.

## 4. Replace the mechanism layer

Copy the paths `MANIFEST` marks `mechanism`. Replace them wholesale; do not merge.

**Copy `.template-hashes` as well.** It is deliberately not in the manifest — a file cannot carry
its own hash — so "copy what `MANIFEST` marks" leaves it behind, still describing the release you
are leaving. Every file you just replaced then fails step 7's comparison against the old list, on a
correct upgrade, which is the standing false alarm `ADR-008` exists to prevent.

**`.gitignore` is the one exception, and it is not a merge.** The file has two regions: everything
from the `# ─── UPSTREAM BLOCK` marker down is upstream's, everything above it is the project's.
Replace the region from the marker down with the release's `gitignore.template`, and **leave every
line above the marker exactly as it is.** Order is not cosmetic — upstream's patterns sit at the
bottom so that a `!negation` in the project's region cannot re-admit a file the never-commit list
excludes.

If the file has no marker, the project adopted before this layout existed and the two halves are
indistinguishable. Do not guess. Show the user the release's block beside their file and let them
place the marker; from then on it is mechanical.

**Do not touch:**

| Layer | Why |
|-------|-----|
| `scaffold` | The project owns these from its first edit. An upstream revision to `problem.md` is not an improvement, it is an unwanted rewrite |
| `content` | Sessions, experiments, ADRs, checkpoints. Upstream never wrote these and must never rewrite them |
| `profile` | `DATA_ENVIRONMENT.md` is yours or your organisation's. Substituted only when you choose to |

**"Do not touch" governs this step, not the whole upgrade.** A migration section in step 6 may
direct edits to `scaffold` or `content` files, and `v2.4.0 → v3.0.0` does both — it deletes a
section from `AGENTS.md` and rewrites `Held by:` in every live checkpoint. Those are hand edits
the section names one at a time, made by you against your own files. What never happens, at any
step, is the thing *this* step does: copying an upstream file over one of yours.

## 5. Diff `RULES.md` and report every changed rule

**This step is required, and it is the reason this playbook exists.**

```bash
diff <(git show HEAD:ai-sandbox/RULES.md) ai-sandbox/RULES.md
for f in ai-sandbox/playbooks/*.md; do diff <(git show "HEAD:$f") "$f"; done
```

**Both, not just the first.** `RULES.md` is where a rule is *supposed* to live, and the playbooks
are where one arrives when it governs a single procedure — `v3.1.0` delivered two that way, and
this step, run on `RULES.md` alone, would have reported "no rule changes" and been wrong. A rule is
whatever binds the next session, not whatever sits in the file named for rules.

Rules arrive by file replacement, which means they arrive **silently**: the file is copied and the
project is now bound by a rule nobody read. Report each change to the user in plain language, one
line per rule, whatever the release notes did or did not say.

The release notes are supposed to name these. This step exists because that obligation is process,
and nothing enforces it.

## 6. Execute the migrations

Work through the sections from step 2 in order. Honour each section's **Exceptions** heading
literally — the usual one is that session and experiment records are immutable, so references to a
renamed file are left as they are. That mismatch is the archive working correctly.

If a migration touches `docs/`, the normal review rule applies: propose the change and wait for
agreement before applying it.

## 7. Verify

```bash
./check.sh
```

Compare against what you saw in step 3. New findings are the migration's fault until shown
otherwise. A migration that leaves `check.sh` noisier than it found it is not finished.

## 8. Record it, then update the version — in that order

Write a session record: which version to which, which rules changed, which migrations ran, what
`check.sh` said. An upgrade is a change to how every future session behaves, and it deserves the
same record as any other.

**Update `.template-version` last.** It is the final step so that the recorded version always names
a state that was actually reached; an upgrade interrupted anywhere before this point stays visible
rather than becoming a lie.

```
v<new>  skeleton @ <sha>  applied <date>
```

Then propose a commit. Do not commit unprompted.

## Checklist

- [ ] Starting version established, or reconstructed from the structure
- [ ] Every migration between the versions read, in order
- [ ] Edits to mechanism files surfaced to the user before anything was replaced
- [ ] Mechanism replaced; scaffold, content and profile untouched
- [ ] `.gitignore` replaced from its marker down, the project's own lines above it untouched
- [ ] **Every changed rule reported**
- [ ] Migrations executed, exceptions honoured
- [ ] `check.sh` no noisier than before
- [ ] Session recorded, `.template-version` updated last, commit proposed
