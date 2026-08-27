# 2026-08-27 · Fixing the two causes, and releasing v3.2.0

- **Status:** closed
- **Configuration:** Solo
- **Participants:** author — claude-opus-5 · high effort
- **Signed off:** no
- **Tags:** `#template` `#versioning` `#upgrade` `#adoption`

---

## Objective

Act on the two findings that could have changed the green-start result, and only those, so that a
re-run measures them rather than a bundle. Release and raise the root.

## Reasoning

Eight findings stand. Two are causes and six are consequences or polish, and the test that
separates them is: *would fixing this have changed what the independent arm did?* Only these two
would. Fixing all eight and re-running would produce a different result that nobody could
attribute — the error the extraction experiment already made once, when it changed two things and
its metric stopped meaning anything.

**Cause one was a layer mistake.** *Fill only from what you were told* lived in
`skeleton/README.md`, which `MANIFEST` marks `norcopy`. Not a weak rule — an absent one, after the
install. And "move it to `RULES.md`" is the wrong instruction: three readers need it at three
moments, and `RULES.md` covers only the second.

| When | Loaded? |
|---|---|
| During the install, when the blanks are filled | `RULES.md` is on disk and **not** loaded — the installing session runs from outside the project |
| Every session afterwards | `RULES.md` is `@`-imported ← where the rule was missing entirely |
| At the moment one blank is filled | only the marker text |

So: the rule in `RULES.md` as the authority, the guide reduced to a pointer, a short form at each
marker. The marker form is deliberately not relied on — `docs/problem.md`'s success-criteria
marker already carried its escape clause, and the independent arm read it and declined it.

**Cause two was ours in a way that reframes the result.** `DATA_ENVIRONMENT.md` shipped asserting
*"Managed with `uv`"* as fact, and `AGENTS.md`'s marker instructed that whatever stack is named
must match that file. The assistant that named a Python/uv stack for a project that had never
mentioned one **was obeying**. Not invention.

The fix is two edits in two files, and only doing one leaves the path open: an example that an
instruction orders you to match has stopped being an example. And the house style already existed
one file away — `gitignore.template` marks its Python block *"delete this block if the project is
not Python"* and always has.

The handbook has forbidden this for four releases: *shipping one full of instructions for a stack
the project does not have is worse than shipping nothing: it instructs, and the instruction is
false.* **The artefact was wrong and the authority was right** — the direction
`skeleton/README.md`'s handbook-wins rule exists for, and the first time it has run that way.

`RATIONALE.md` gains the reasoning for both rules and two failure-mode rows. A file that explains
every rule except the newest is half-delivered, and this is also release step 2b: the artefact
that had to know was not a check but the document that says why.

## Decisions

- **`v3.2.0`, MINOR.** Nothing to do downstream: the rules are additive, `DATA_ENVIRONMENT.md` is
  `profile` and is never replaced by an upgrade, and the marker changes are `scaffold` and reach
  new adoptions only.
- **Six findings deliberately left.** Named in the thread; untouched so the re-run has one
  treatment.
- **The boundary is recorded, not fixed.** `check.sh` cannot see whether an answer is true, and
  nothing here changes that. It is in the release notes as *not claimed*.

## Found along the way

- **The marker caught a fourth tool — the rule about it.** The first draft of the `RULES.md` text
  spelled the install marker literally, and `bootstrap-test.sh` reported it as an unanswered blank
  in a file that ships into every project. `check.sh`, `bootstrap-test.sh`, `install.sh`, and now
  the prose. The rule now names the marker without spelling it, and says why in parentheses.
- **The fix is unverified by construction.** Whether these two changes alter the behaviour they
  were written for cannot be known from here. The measurement is a re-run of the same prompt on
  the same provider with these two changes and nothing else, and it belongs to whoever runs it.

## Next

- Re-run the independent arm: same prompt, same provider, `v3.2.0`.
- The six remaining findings, after that measurement, not before.
