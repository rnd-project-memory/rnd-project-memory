# 2026-08-26 · Do the instructing documents say what the system now does?

- **Status:** closed
- **Configuration:** Solo
- **Participants:** author — claude-opus-5 · high effort
- **Signed off:** no
- **Tags:** `#template` `#versioning` `#upgrade`

---

## Objective

Audit every document that *instructs* — both `README.md` files, the handbook, the playbooks, the
templates — against what `v2.4.0` and `v3.0.0` actually implemented, and close any gap where a
guide tells a reader one thing while the mechanism does another.

## Reasoning

Two releases in two days changed a rule, deleted a section from a loaded instruction file, and
added a check. The mechanism files were replaced wholesale, which is what that layer is for. The
risk is entirely in the layers replacement does not reach: prose in the handbook, the install
guide, and the one playbook whose subject is upgrading itself.

The sweep was mechanical first — every occurrence of `token`, `initials`, `declare`, `Held by`,
`hooksPath`, `user.email` outside the archives — then read in context. `check.sh`'s retired
vocabulary was already `clean`, which is exactly why the mechanical pass was not enough: the check
matches retired *strings*, and every gap found here was a correct-sounding sentence that had simply
stopped being true.

Four real gaps, one of them a genuine contradiction:

**`upgrade-template.md` step 4 said not to touch `scaffold` or `content`, full stop.** The
`v3.0.0` migration requires deleting a section from `AGENTS.md` (scaffold) and rewriting `Held by:`
in every live checkpoint (content). A consumer executing the upgrade in order would hit step 4
telling them those files are off limits and step 6 telling them to edit exactly those files. This
is the first migration to require scaffold edits, so the ambiguity was latent until now. Step 4 now
scopes itself: it governs the wholesale *replacement*, and a migration section may still direct
hand edits to any layer — what never happens is copying an upstream file over one of the project's.

**`skeleton/README.md` step 2 still described hook installation as a one-time adoption step.** That
is the precise misconception `v2.4.0` exists to correct, sitting in the install guide. Step 2 now
groups both clone-local settings, says they are run once per clone by every contributor, and points
at the `AGENTS.md` section — noting that this file itself never reaches a second contributor, since
it is `norcopy`. Step 4 loses the identity command it had briefly acquired and keeps only the
checkpoint rename, so the two settings have one home rather than two.

**The handbook was behind the skeleton on both releases**, which matters more than it would in
another repository: `skeleton/README.md` states that where the two disagree the handbook wins. §11
step 4 did not mention that `AGENTS.md` now carries a per-clone setup section, so an adopter
writing that file from the handbook could drop the only route by which a colleague is told to
install the hook. §12 said "hooks do not survive a clone" and then treated it as a setup-ordering
detail rather than the reason the instruction has to live in a tracked file. §15's "adding a person
is close to a no-op" table was true of every file and silent on the two commands a second person
must run before they have either a secret scan or a value for `Held by:`.

## Decisions

- **`v3.0.1`, PATCH.** Only one mechanism file changed (`upgrade-template.md`); a consumer takes
  the replacement and does nothing else. The handbook and `skeleton/README.md` are `norcopy` and
  reach nobody through a release at all.
- **Not folded into `v3.0.0` by moving the tag.** `v3.0.0` is a complete, coherent release; this
  audit is separate work that followed it. Rewriting the tag to hide that sequence would make the
  history less true, and `MIGRATIONS.md`'s own warning about tagging early is an argument for not
  tagging prematurely, not for retconning what a tag contained.
- **The two clone-local settings get one home in the install guide**, not one each in steps 2 and
  4. The split is what made them read as unrelated concerns in the first place.

## Found along the way

**The retired-vocabulary check cannot see this class at all, and that is now twice.** It reported
`clean` throughout, correctly — no gap here involved a retired string. `docs/glossary.md` carried a
stale *definition* earlier today for the same reason. The pattern is that a check on vocabulary
catches renames and is blind to a sentence that was true under the old design and is false under
the new one. Still not proposing machinery: the honest answer is that this is what a release audit
is for, and the release procedure already has a step for the artefacts a rule governs
("Cutting a release" 2b). What it does not have is a step for the *prose that describes* the rule.

That is worth considering for the next release rather than now — the observation is one session
old, and adding a checklist line on a single instance is how checklists become unread.

## Next

Consider a "Cutting a release" step covering instructing prose, if a third instance appears.
