# 2026-08-26 · Raising the root memory to v3.1.0

- **Status:** closed
- **Configuration:** Solo
- **Participants:** author — claude-opus-5 · high effort
- **Signed off:** no
- **Tags:** `#template` `#versioning` `#upgrade`

---

## Objective

Cut `v3.1.0` and run `upgrade-template.md` against this repository's own memory — the first real
exercise of the release, and by `ADR-006` the reason the artefact is hosted here at all.

## Reasoning

**`v3.0.1` → `v3.1.0`. No MAJOR between them, so no migration section — file replacement only.**

Step 3 found the mechanism files at the root all matching `v3.0.1`: nobody had edited a file
upstream owns, so nothing was at risk of being discarded.

**Rules that changed.** `ai-sandbox/RULES.md` is untouched, which under step 5 as written meant
reporting "no rule changes". That is false, and finding out how is the substance of this session:
two behavioural rules shipped through `playbooks/checkpoint.md`, which step 5 never looked at.

- A session filename carries no counter; a numeric suffix breaks a same-date same-slug collision
  and nothing else.
- A blank the install cannot fill is marked `<<FILL:` at the start of a line and answered before
  the first commit.

**Three defects, all found by running the procedure rather than reading it.** This is what the
self-hosting rule is for, and it is the first time the upgrade machinery has produced this many at
once.

1. **The blank check fired on the repository that ships the marker.** Nine files — every one that
   *discusses* `<<FILL>>` — including `ai-sandbox/INDEX.md` under the heading reserved for files
   loaded into every session. The check was correct for every adopter, who has prose about none of
   this, and wrong only for the author. That is this project's own blind spot pointed the other
   way: usually the author sees a clean repository and the adopter sees the failure. Here it is
   reversed, and the reversal is more dangerous, because the person who can fix it is the one being
   trained to ignore it. Anchored to the line start, exactly as the `.gitignore` block check is,
   and for the reason its comment already gave: a file that mentions a marker in prose is
   documenting it, not carrying one.
2. **Step 4 never said to copy `.template-hashes`.** It says to copy what `MANIFEST` marks
   `mechanism`, and the hash list is deliberately not in the manifest — a file cannot carry its own
   hash. So the list stayed behind describing the release being left, and every file just replaced
   failed step 7's comparison. It has been done by hand at every previous upgrade and written down
   at none: a rule known to the person who performs upgrades and to no document.
3. **Step 5 diffed `RULES.md` alone.** Fixed to diff the playbooks too, with the reason stated: a
   rule is whatever binds the next session, not whatever sits in the file named for rules.

**The tag was re-cut.** Nothing had been published — six local commits, no remote tag — and the
alternative was shipping a release whose own check is noisy for its author. `v1.2.0` set this
precedent for the same reason.

## Decisions

- **`v3.1.0` released**, MINOR on the consumer's obligation. Both exceptions checked against
  `ADR-011` and inert: an existing project's session filenames are never re-examined and its
  placeholders were filled at install, so nothing downstream costs anything and no second shape is
  maintained.
- **Root memory raised to `v3.1.0`**, `.template-version` written last per the playbook's own rule
  about partial application.
- **The three defects ship in the release** rather than as a follow-up patch, because the tag had
  not been published and a defect found before publication is not yet history.

## Found along the way

- **The release procedure and the upgrade playbook found different things.** `bootstrap-test.sh`
  passed throughout — it installs into a scratch repository, where no prose about the marker
  exists, so defect 1 was invisible to it by construction. It took running the upgrade *here*,
  where the prose lives. Two instruments, two blind spots, neither redundant.
- `check.sh` after the upgrade is quieter than before it, which is step 7's standard for a
  finished migration.

## Next

- The alignment audit: every instructing, documenting and template file against what `v3.1.0`
  actually does, before any new project is started from it.
- Then the new-project experiment, on the released tag, from a session with no access to this one.
