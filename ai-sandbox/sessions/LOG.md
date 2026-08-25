# rnd-project-memory — Session Log

Append only. One row per session.

**Do not read this file in full — search it.** That is what it is for:

```bash
rg -i "<topic>" ai-sandbox/sessions/LOG.md
rg '#<tag>'     ai-sandbox/sessions/LOG.md
```

A hit gives you a session file; open that, not this log.

**Outcome names what was resolved**, not just what was worked on. Answered questions are
deleted from `OPEN_QUESTIONS.md`, so this row is the only cue a later reader gets that the
question ever had an answer.

**Tags:** reuse an existing tag if one fits — a topic spelled three ways over six months is
what makes search fail. `check.sh` prints tag frequencies; a singleton usually means a second
spelling of something already here.

| Date | Topic | Tags | Outcome | Link |
|------|-------|------|---------|------|
| 2026-08-17 | Extracting the template into its own repository | `#template` `#versioning` `#distribution` `#licensing` | Six ADRs accepted: separate repo, ownership layers, vendored distribution, prose migrations, public licensed upstream, self-hosting. Found the core carrying the author's work stack; found the missing licence. | [2026-08-17-template-extraction.md](2026-08-17-template-extraction.md) |
| 2026-08-17 | Auditing file ownership across the skeleton | `#template` `#ownership` `#manifest` | ADR-002 rewritten to four layers with fenced preambles; `A-profile-separable` settled by inverting extraction into concentration, replaced by `A-profile-indirection`; `MANIFEST` drafted. Found two skeleton defects: the README overwrites the adopting project's, and two `check.sh` checks misfire. | [2026-08-17-ownership-audit-2.md](2026-08-17-ownership-audit-2.md) |
| 2026-08-17 | Testing the profile remedies, and what they cost | `#template` `#ownership` `#versioning` | Three experiments. Fencing withdrawn and the preamble files reclassified as scaffold; the secret-scan list must not be profile-supplied; `A-profile-indirection` confirmed and retired, `A-misdirection-criterion` raised. Step 4 kept but reduced; ADR-004's rule-change gap closed; `Q-upstream-identity` and `Q-handbook-version` answered. Scope fell from twenty files to six. | [2026-08-17-profile-experiments-3.md](2026-08-17-profile-experiments-3.md) |
| 2026-08-17 | Step 7, and the first real upgrade | `#versioning` `#upgrade` | `MIGRATIONS.md` and `upgrade-template.md` written, so §15 describes what exists rather than what was promised. `v1.1.0` released, its notes naming the `RULES.md` change as ADR-004 requires. The root memory upgraded from `v1.0.0` — and step 3 caught that it had never actually been at `v1.0.0`: the tag was cut mid-session and two fixes landed after it. Delete-and-copy across 15 mechanism entries produced no conflicts. | [2026-08-17-first-self-upgrade-4.md](2026-08-17-first-self-upgrade-4.md) |
| 2026-08-17 | The manifest-hash check, and applying yesterday's lesson | `#versioning` `#upgrade` | `check.sh` gains the check ADR-003 promised; `.template-hashes` ships with each release so a consumer verifies offline. `v1.2.0` released and the root upgraded to it. The first cut was noisy and the tag was re-cut before publication — the v1.0.0 tagging lesson applied on its first opportunity. Tested against a real edit, not only a clean tree. | [2026-08-17-manifest-hash-check-5.md](2026-08-17-manifest-hash-check-5.md) |
| 2026-08-19 | Enterprise access confirmed | `#distribution` | Cloning from inside the work network verified. `Q-enterprise-access` retired: access answered, forking moot under ADR-005, intake carried forward as `Q-oss-intake` 🟢. Removes the manual carry-in path and the first of ADR-005's three conditions for building an enterprise copy. | [2026-08-19-enterprise-access-confirmed.md](2026-08-19-enterprise-access-confirmed.md) |
| 2026-08-23 | Skeleton v2.0.0 — thread checkpoints and negative knowledge | `#template` `#ownership` `#versioning` `#upgrade` | All 30 techniques from the design review implemented as one MAJOR release. ADR-007 accepted: checkpoint axis is now thread, not owner; negative knowledge (distrust, scope limits, legitimate absence) named as a first-class category with fields. `MIGRATIONS.md` carries its first real structural section. Root memory raised to `v2.0.0`; `CHECKPOINT-esdevop.md` closed, not renamed — nothing was left in progress once its one live item was fixed. | [2026-08-23-skeleton-v2-thread-checkpoints.md](2026-08-23-skeleton-v2-thread-checkpoints.md) |
| 2026-08-24 | v2.1.0 — closing gaps found in v2.0.0's own rollout | `#template` `#versioning` `#upgrade` | Three stray `CHECKPOINT-<owner>.md` references fixed; `check.sh` gains "Retired vocabulary" and "skeleton/ vs `.template-version`" checks so both classes of miss are caught mechanically going forward. `MIGRATIONS.md`'s release procedure updated to feed future retired terms into the check. `v1.0.0`–`v1.2.0` found already tagged on the artefact commit; `v2.0.0` and `v2.1.0` tagged the same way, retroactively for the former. Root memory raised to `v2.1.0`. | [2026-08-24-v2-1-0-drift-tags.md](2026-08-24-v2-1-0-drift-tags.md) |
| 2026-08-25 | Findings from an external adoption trial, and v2.2.0 | `#template` `#versioning` `#upgrade` `#adoption` | First evidence from an adopter outside this repository. `ADR-008`–`ADR-011` accepted, all four signed off by a named human — the first use of that configuration here. The hash list may now list only files installed verbatim; three entries broke that and reported FAILED on every correct adoption, none visible to self-hosting, which performs no installation. `.gitignore` gains a two-region owner split; the adoption note is sanctioned with a fixed form and a boundary; the bump discriminator is bounded by inert-or-expiring. §11 rewritten to eleven steps and now says bootstrapping *begins* there. `bootstrap-test.sh` added as a release gate. Root memory raised to `v2.2.0`, which exercised the new `.gitignore` branch and found its fallback assumes the wrong cause (`Q-marker-absence-reasons`). | [2026-08-25-adoption-trial-intake.md](2026-08-25-adoption-trial-intake.md) |
