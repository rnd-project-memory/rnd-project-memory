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

## Owner token

`esdevop` — the value that appears in `Held by:` on any thread checkpoint I currently hold.
A thread's checkpoint is named for what is being worked on
(`ai-sandbox/CHECKPOINT-<thread-slug>.md`), not for this token.

## Commits

Conventional Commits. Types used here: `docs`, `feat`, `fix`, `refactor`, `chore`, `exp`.
