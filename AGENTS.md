# rnd-project-memory

> **This file is this project's.** The template never overwrites it. The rules the assistant
> follows live in `ai-sandbox/RULES.md`, vendored from `skeleton/` at the version in
> `.template-version` and replaced on upgrade — edit them there and the edit is lost.

## About this project

This repository builds the R&D project memory system: a handbook and a copyable skeleton for
keeping knowledge alive across AI-assisted sessions.

**It also runs that system on itself.** Two things live here and must never be confused:

| Path | What it is |
|------|-----------|
| `skeleton/`, `RND_PROJECT_MEMORY.md` | **the artefact** — what gets copied out and shipped |
| `AGENTS.md`, `ai-sandbox/`, `docs/` | **this project's own live memory** — real entries about real work |

A file under `skeleton/` is a template full of `<placeholders>`. The same filename at the root is
a working file with real content. When searching, check which one you have found: `rg` matches
both, and editing the wrong one either corrupts the shipped artefact or invents a fact.

The root memory is **vendored** from `skeleton/` at a released tag — not symlinked, not synced.
Work proceeds under the released version while the next one is authored; `.template-version`
records which. When a release ships, `upgrade-template.md` is run against the root, and that is
the first real exercise of the upgrade machinery.

Knowledge here arrives from design sessions and from reading the artefact itself. There is no data
environment and no analysis stack, so `ai-sandbox/DATA_ENVIRONMENT.md` is deliberately absent:
under this template's own rule, shipping one full of instructions for a stack the project does not
have would misdirect.

## Session entry point

@ai-sandbox/RULES.md

@ai-sandbox/INDEX.md

## First run in a new clone

`core.hooksPath` and `user.email` live in `.git/config`, which **`git clone` never copies**. The
hook *file* travels with the repository; the setting that runs it does not. A fresh clone has
`.githooks/pre-commit` sitting in the working tree doing nothing, and git gives no warning that
anything is off. Every contributor runs these once, per clone:

```bash
git config core.hooksPath .githooks        # runs the secret scan — nothing else does
git config user.email "you@example.org"    # this clone's identity
```

**Assistant: check both at session start**, before other work. `./check.sh` reports them in its
first section. If the hooks path is unset, say so and stop there — until it is set, the one check
whose failure a later edit cannot repair is not running. If `user.email` is empty, ask for it;
never infer it from commit history or from another file.

If the project has CI, run the same secret scan there as well. It is the only layer that does not
depend on how an individual clone is configured.

## Commits

Conventional Commits. Types used here: `docs`, `feat`, `fix`, `refactor`, `chore`, `exp`.

## Branches

**All work lands on `next`. `main` moves only at a release**: fast-forwarded to `next` once the
release is tagged and the root raised, so that `skeleton/` on `main` is always exactly a tagged
release. Memory commits go to `next` as well, since a session record describing a change belongs
beside the change. On `main`, `check.sh`'s *skeleton/ vs .template-version* section must read `ok`.
`DRIFT` there means the rule was broken.

The reason is `install.sh`. It installs `skeleton/` from the working tree but takes the version
from the last tag. A skeleton change pushed to `main` between releases is therefore installed under
the previous release's name, for example `v3.6.0  skeleton @ <a later commit>`, and every later
upgrade starts from a version the project does not have. Keeping `main` at a release means the
README's `git clone` always installs a real one.

- Push `next` freely. It is the backup and the shared work in progress, and it is not a release.
- A release is cut on `next` (`MIGRATIONS.md`, *Cutting a release*). Then fast-forward `main` to
  it and push both.
- An urgent fix while `next` holds unshippable work: branch from `main`, release from there, then
  merge `main` back into `next`.

**Assistant: check the branch at session start**, alongside the clone settings above. On `main` with
no release in progress, switch to `next` before writing anything.
