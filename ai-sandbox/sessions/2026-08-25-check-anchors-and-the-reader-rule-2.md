# 2026-08-25 · Anchoring two checks, and the rule about not writing for them

- **Status:** closed
- **Configuration:** Solo
- **Participants:** author — claude-opus-5 · high effort
- **Signed off:** no
- **Tags:** `#template` `#versioning` `#upgrade`

---

## Objective

Ship the two `check.sh` defects found after `v2.2.0` was tagged, plus the rule the third instance
of them made explicit.

- `Q-check-reads-prose-as-state` — the open-session check greps `Status:.*open` anywhere in a file,
  so a record describing that check reports as an interrupted session.
- `Q-marker-absence-reasons` — the `.gitignore` marker check and `upgrade-template.md`'s fallback
  both assert that a missing marker means the file predates the layout. It has a second cause.
- **New rule:** a record that describes a check is not rewritten to satisfy it. Fix the reader.

## Reasoning

**Both fixes are one anchor each, and the first proposal for one of them was wrong.** The reviewer
proposed anchoring the open-session check on `^\*\*Status:\*\*`. Checked before applying: that
matches nothing, because this morning's bullet pass moved every field to `- **Status:**`. Shipping
it would have converted a check that fires wrongly into a check that cannot fire at all — the
failure named earlier today, arriving through the repair for its opposite, and invisible because
the output of a dead check and a clean repository are the same word. The working anchor is
`^[-*] \*\*Status:\*\*`, and the reason it works is the reason it needed correcting: the bullet
is what now distinguishes a field from a mention of one.

**The marker check now separates two causes.** No marker *and* upstream's patterns present means
the file predates the layout. No marker *and* none of them means the file never took the
never-commit list, which may be deliberate — and the check says so instead of asserting the first.
Found by running the upgrade against this repository, where the second case applied.

**Release step 2b, applied to the new rule.** Which artefact enforces "a record that describes a
check is never rewritten to satisfy it"? **None, and deliberately.** No grep can tell a record
edited for truth from one edited for quiet. The enforcement is the pair of fixes shipping beside
it: they demonstrate the sanctioned repair — aim the check at the *form* a field takes rather than
the words it contains — so the rule arrives with a worked example rather than as an exhortation.
Recording the answer "none" because step 2b exists to make the question asked, not to force a
mechanism into every rule.

**Bump level.** MINOR, and the argument that settles it is the consumer's obligation, not internal
consistency: §15's third column says PATCH means *replace, nothing to do*, and this release adds a
behavioural rule. Shipping it as `v2.2.1` would tell a consumer there was nothing to read and then
bind them by a rule they had not read — which is the failure §15 names thirty lines above the table
and which the rule-naming obligation in `ADR-004` exists to prevent.

## Decisions

- `v2.3.0`, not `v2.2.1`. The two check fixes and the rule ship together; splitting them to keep a
  patch number would defer finished, reviewed work to protect a digit.
- The rule lands in `RULES.md` so it reaches consumers, with its reasoning in `RATIONALE.md` and a
  failure-mode row beside the others.
- `docs/method.md`'s dogfooding limitation is restated in general form: **self-check sees the
  settled state and is blind to the transition.** That holds for any system that installs itself;
  "installation" was this instance of it, not the law. `CLAIMS.md` row updated in the same change.
- A deviation note was considered for the version number and rejected: the divergence was avoidable,
  so a note would have been an excuse with no closing condition — the case `ADR-010` excludes.

## Found along the way

**The fix verified itself on this repository.** After the anchor landed, `check.sh` reports only
the genuinely open session; the closed record from the earlier session — which quotes
`Status: open` while describing this very check — is no longer flagged. That record was never
edited, which is the whole point of the rule shipping beside the fix.

**Root raised to `v2.3.0`.** Fifth self-upgrade. Step 3 clean before anything was replaced; three
mechanism files changed (`check.sh`, `RULES.md`, `RATIONALE.md`), the rest identical; no migration.
Step 5 reported the one new rule. The `.gitignore` branch was a no-op this time — the marker went
in during the `v2.2.0` upgrade and the check reports `ok`.

## Next

Nothing queued, and no thread checkpoint: both questions this session opened were answered by the
release that closed them, and everything else shipped.

`Q-oss-intake` and `Q-contribution-flow` remain 🟢 and still need answers from outside this
repository. `Q-unexercised-components` is 🟡 and untouched by this release.

One thing worth watching rather than acting on: the register check (`Resolved|RESOLVED|~~`) has the
same shape as the two fixed here — it matches words, not a form. It does not currently misfire,
because every mention in both registers sits in a blockquote the check already excludes. A
constructed case does misfire: prose inside a field, such as a `Progress:` line saying an earlier
question *was Resolved*. Not fixed, because `Resolved` has no field form to anchor on — it is a
word that can legitimately appear in any value — and a check that has never misfired on real
content may not be worth pre-emptive machinery. Recorded so the next occurrence is recognised as
the second, not the first.
