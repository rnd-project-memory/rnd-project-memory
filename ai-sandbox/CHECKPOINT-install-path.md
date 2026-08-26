# rnd-project-memory — Checkpoint · install-path

- **Held by:** esdevop@gmail.com · since 2026-08-26
- **Status:** active
- **Resume from:** the placeholder class is fixed and `bootstrap-test.sh` passes; nothing is
  released, and the other three install defects are named but untouched.
  **Do not do until re-verified:** do not claim the new-project path works. It has been tested by
  `bootstrap-test.sh`, which is this repository installing its own skeleton — the same blind spot
  `ADR-008` exists for, one level up. No person has followed the rewritten step 3 from a clean
  start, and the one attempt that produced this thread was made against the *old* text.

> This file belongs to one thread, named for what is being worked on. Only whoever it names as
> `Held by:` writes it. Rewritten, never appended; only what is unsettled.

---

## Current state

| Item | Value | Source |
|------|-------|--------|
| Placeholder classes | three, named in `skeleton/README.md` step 3 | this session |
| Install-time blanks | 7 markers, 3 files, `<<FILL: …>>` | `grep -rn '<<FILL' skeleton/` |
| `check.sh` | counts unanswered markers; not yet at the root, which runs `v3.0.1` | `skeleton/check.sh` |
| `bootstrap-test.sh` | passes, 8 gates, 3 of them new | run 2026-08-26 |
| Session filenames | no counter; a suffix breaks a collision only | `checkpoint.md`, §4 |
| Release | none cut; bump undecided | — |

---

## In progress

### Gap 1 — the bump is undecided (priority: high)

The change splits across layers and the layers disagree about who it reaches. `AGENTS.md`,
`ai-sandbox/INDEX.md` and `docs/problem.md` are `scaffold`: new adoptions only, and an existing
project's copies are already filled, so there is genuinely nothing for it to do. `check.sh` is
`mechanism` and arrives at the next upgrade carrying a new advisory section, which is behaviour a
consumer did not have.

`v2.3.0` settled a near-identical case as MINOR on the consumer's obligation — *PATCH says
"nothing to do", and this ships a behavioural rule*. That precedent now bites directly:
`playbooks/checkpoint.md` changed how a session file is **named**, which is a behavioural rule
arriving by wholesale file replacement, and `ADR-004` requires a release touching the rules to
name each changed one in its notes. The remaining doubt is narrower than it was — whether the
`check.sh` blank check, which prints `ok` on every already-filled project, adds anything to that.
`ADR-011` bounds the discriminator to inert-or-expiring and has not been applied yet.

### Gap 2 — three install defects remain, and it is unclear whether they are one change (priority: medium)

Found by the same failed attempt that produced the placeholder fix:

1. GitHub's *Use this template* copies the whole repository, this project's own live memory
   included. `ADR-003` already says distribution is a vendored copy, so the button is the wrong
   mechanism and nothing says so.
2. `skeleton/README.md` step 1 instructs the reader to delete the file they are reading.
3. There is no path for a project with **no** history. §11 is written for one already underway;
   the new-project case has only the numbered steps in the install guide.

They may be one change — *how a project starts* — or three unrelated ones. Deciding that is the
work, not implementing them.

### Gap 3 — `bootstrap-test.sh` is an installer named as a test (priority: medium)

It performs the whole mechanical install and now the blanks too. Extracting `install.sh` from it
would take the assistant out of the step where it is least useful and most likely to invent. Held
here rather than done because it is the first concrete piece of `Q-who-keeps-the-history`, and
doing it before that question has a shape would answer it by accident.

---

## Promotion candidates

None. Everything settled this session is either in the artefact itself or in the session record;
nothing here has stopped moving.

---

## Out of scope for this session

- The new-project experiment. It must run in a session with no access to this one, or it measures
  nothing — the same reason §11 step 5 cannot be run from inside the bootstrap session.
- Answering `Q-who-keeps-the-history` by reasoning. What it asks for is a timing, and reasoning
  harder about it is how it would get closed without one.
