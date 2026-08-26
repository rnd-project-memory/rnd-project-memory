# 2026-08-26 · Removing the hazard changes what the warning should say

- **Status:** closed
- **Configuration:** Solo
- **Participants:** author — claude-opus-5 · high effort; esdevop (human) — performed and verified the setting change
- **Signed off:** no
- **Tags:** `#template` `#distribution`

---

## Objective

Act on two answers from the repository's GitHub settings, one of which invalidated a paragraph
written earlier the same day.

## Reasoning

**The *Use this template* button existed, and has been switched off.** Confirmed visually on the
repository's main page after unticking *Template repository* in settings. `v3.1.0` had added a
paragraph warning readers not to press it. That paragraph now described a control that is not
there, and a reader who finds no button and reads a warning about one concludes the documentation
is stale — which discounts everything else in it. **Removing a hazard is not neutral toward the
sign that warned about it.**

Re-aimed rather than deleted, and the reason for keeping it is the finding: **the switch is a
repository setting.** It is not in this repository, no check can read it, and turning it back on
restores the button silently. `gh api … --jq .is_template` would read it, but `check.sh` is
offline by design and adding a network call to it would trade a much larger property for this.

That puts the setting in the same family as `core.hooksPath`, which `v2.4.0` was built around —
behaviour that lives outside the tracked tree and travels with nothing — but one step further out
and worse: `core.hooksPath` is at least reportable by a local command, and this is not reportable
at all from inside a clone. It is the first surface this project depends on that **nothing here
can watch**, and the paragraph is the whole of the mitigation.

**The rendered-README question was badly posed and could not have been answered.** It was asked as
if it belonged with the button question, but the remote is at `v3.0.1` and `install.sh` first
appears in `v3.1.0`, so neither README there can mention an installer. Reading the landing page
belongs after the push, not before it.

## Decisions

- **The paragraph stays, re-aimed**: leads with the repository not being a template, states that
  the switch is invisible to every check here, and says that is why it outlives the button.
- **No release.** `skeleton/README.md` is `norcopy`.

## Found along the way

- **A warning and the hazard it names have independent lifetimes**, and the sign is the one that
  rots quietly. Nothing in this system checks whether a warning still has a referent; the retired
  vocabulary check matches strings, and "Use this template" is still a real string about a real
  GitHub feature.

## Next

- Push. Then read the rendered landing page — the check that could not run before it.
