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

**Do not touch:**

| Layer | Why |
|-------|-----|
| `scaffold` | The project owns these from its first edit. An upstream revision to `problem.md` is not an improvement, it is an unwanted rewrite |
| `content` | Sessions, experiments, ADRs, checkpoints. Upstream never wrote these and must never rewrite them |
| `profile` | `DATA_ENVIRONMENT.md` is yours or your organisation's. Substituted only when you choose to |

## 5. Diff `RULES.md` and report every changed rule

**This step is required, and it is the reason this playbook exists.**

```bash
diff <(git show HEAD:ai-sandbox/RULES.md) ai-sandbox/RULES.md
```

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
- [ ] **Every changed rule reported**
- [ ] Migrations executed, exceptions honoured
- [ ] `check.sh` no noisier than before
- [ ] Session recorded, `.template-version` updated last, commit proposed
