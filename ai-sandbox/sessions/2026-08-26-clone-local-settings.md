# 2026-08-26 · Clone-local settings, and the contributor they never reach

- **Status:** open
- **Configuration:** Solo
- **Participants:** author — claude-opus-5 · high effort
- **Signed off:** no
- **Tags:** `#template` `#versioning` `#ownership`

---

## Objective

A question about the owner token: with two contributors, which token appears in `Held by:`, and
does the second contributor edit `AGENTS.md` to declare their own? Answer that, then evaluate
whatever it exposes.

## Reasoning

The token question answers itself from the existing rules — `Held by:` is whoever holds the
thread, `RATIONALE.md` says outright it names a temporary state rather than a possession — so
`se` puts `se`, and `es`'s declaration has no reach into it. What does not answer itself is where
a second contributor's token is supposed to live. `skeleton/AGENTS.md`'s section is second-person
singular in a file that is committed and shared: one slot, N people. `skeleton/README.md:65`
already contradicts it ("a second contributor picks their own owner token") with nowhere to put
one, and §15's claim that adding a person is "close to a no-op" is true of every file except this
one.

Two shapes were considered for that: a roster mapping tokens to git identities, and dropping the
token entirely so that `Held by:` **is** `git config user.email`. The second is better and the
reason is worth keeping — it does not manage the shared-file problem, it deletes it. Nothing
per-person remains in a tracked file, so there is no line for a second contributor to edit and
nothing to conflict on. It also makes the correct value the *cheapest* value: one command with
unambiguous output, rather than a lookup with a plausible wrong answer sitting beside it.

Then the evaluation of what that breaks turned up something larger than the thing being fixed.
Every protection proposed for it — `user.useConfigOnly` at bootstrap, an identity check in
`pre-commit` — lives in `.git/config` or is switched on from there. **`git clone` does not copy
`.git/config`.** So none of them exist for the second contributor, who is the entire population
the owner problem is about.

Demonstrated rather than argued, in a scratch repository: two clones of one repo, the same hook
file present in both working trees, `es` blocked on a credential-shaped string and `se`'s
identical commit going straight through. Three things line up to hide it — git issues no warning
when hooks are off, `skeleton/README.md` is `norcopy` so the instruction never reaches a clone,
and the adopter's own hook works, so nothing they can run reports the gap.

That reframes the whole thread. `se` on today's structure has no secret scan, which is a strictly
worse defect than the one the session opened on, and it is present in every project adopted so
far. The identity question rides along with it because both settings live in the same
non-travelling place.

## Decisions

- **Ship the clone-local fix now, at MINOR; defer the `Held by:` binding.** They are separable:
  the binding is MAJOR (it invalidates every live `Held by:` value and needs a migration section),
  and holding the security half hostage to a larger design change is the wrong trade. Raised as
  `Q-held-by-identity-binding` with the evaluation already done.
- **`AGENTS.md` carries the two commands, not `README.md`.** Any tracked file would arrive with
  the clone; `AGENTS.md` is the one that is *read automatically every session*, by the party that
  can act on it without anyone remembering. That is the whole reason for the choice.
- **`check.sh` reports it first, ahead of the hash check.** Every other section here describes a
  document, and a document can be rewritten. This one reports on the check whose failure a later
  edit cannot repair, so it goes first.
- **`user.email` is reported by value, not as `ok`.** Testing surfaced the reason: a scratch clone
  with no local identity inherited `your.email@example.com` from global config. Printing the value
  is what lets a reader notice an address that is not theirs; asserting `ok` would have hidden
  exactly the inherited-identity case that nothing else can catch.
- **Nothing added to `.githooks/pre-commit`.** It does not reach a second contributor, and any
  false positive there is answered with `--no-verify`, which also disables the secret scan sharing
  that hook. Blocking stays reserved for the one irreversible rule.
- **`session-start.md` gains step 0a**, found by "Cutting a release" step 2b. The `AGENTS.md` text
  says "check at session start"; the artefact that governs session start is the playbook, and it
  did not know. The playbook is also `mechanism`, so unlike the `AGENTS.md` section it reaches
  projects already running.

## Found along the way

- **The two halves of this release have different reach, and it favours the check.** `check.sh` is
  `mechanism` and lands in existing projects on upgrade; `AGENTS.md` is `scaffold` and reaches new
  adoptions only. So the artefact that actually protects an existing project's second contributor
  is the check, not the instruction — which is the opposite of how the fix was first conceived.
- **`docs/glossary.md:17` is stale and nothing caught it.** It defines *owner token* as "the
  initials naming one person's checkpoint file" — the pre-`v2.0.0` meaning, retired when the axis
  moved to threads. It survived `v2.1.0`'s retired-vocabulary check because that check matches the
  literal string `CHECKPOINT-<owner>`, which the glossary does not contain. A fourth stray of the
  class `v2.1.0` was created to catch, in the one file whose job is defining terms. Not fixed here:
  it belongs with the binding, which rewrites that entry anyway.
- **A claim worth promoting, not promoted here.** *A hook file travels with the repository; the
  setting that runs it does not, so protection living in `.git/config` is absent for every
  contributor except the adopter.* It is settled and now demonstrated, but `docs/` changes are
  reviewed before they land and this session cannot both propose and approve. Left for a diff pass.

## Next

- `Q-held-by-identity-binding` — the MAJOR, with the breakage analysis already recorded.
- The `docs/method.md` claim above, once reviewed.
- `docs/glossary.md:17`, which the binding rewrites.
