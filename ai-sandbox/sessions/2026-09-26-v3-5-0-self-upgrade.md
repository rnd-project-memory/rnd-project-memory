# 2026-09-26 · Raise the self-hosting root to v3.5.0

- **Status:** closed
- **Configuration:** Solo
- **Participants:** author — current coding agent; no independent reviewer
- **Signed off:** no

## Objective

Run the self-hosting upgrade after publishing the v3.5.0 template release, moving the root project
from v3.4.0 to v3.5.0 without overwriting project-owned scaffold/content or the colleague-held
`CHECKPOINT-install-path.md`.

## Reasoning

The release contains no MAJOR migration and no mechanism or playbook rule changes. The changed
skeleton register files are scaffold and are not copied over the root project during upgrade. The
changed `gitignore.template` is transformed-on-install and its v3.5 upstream region already matches
the root `.gitignore` region. Mechanism hashes are unchanged. The self-upgrade therefore consists
of verifying these facts, preserving the root's project-owned files, and updating `.template-version`
last to record v3.5.0 and skeleton commit dbdaec6.

## Decisions

- v3.4.0 → v3.5.0 has no `MIGRATIONS.md` section to execute.
- No mechanism files or playbooks require replacement; rules are unchanged.
- The root `.gitignore` upstream region already matches the v3.5.0 template; root-owned lines stay.
- Root register changes remain untouched by the upgrade and retain their explicit Owner workflow.
- The root version record is updated only after the preflight and verification checks.

## Found along the way

The release tag is `v3.5.0`; the skeleton last changed at commit `dbdaec6`. Before the upgrade,
`check.sh` correctly reports a temporary skeleton/version drift because the root still identifies
v3.4.0 while the new artifact is being prepared.

## Next

Self-upgrade completed: `.template-version` now records v3.5.0 at skeleton commit dbdaec6; the
root `.gitignore` upstream region already matched the release; no mechanism or rule replacement
was required; `check.sh`, `bootstrap-test.sh`, shell syntax, and `git diff --check` passed. The
root update is ready for its own explanatory commit. No issue closure is attempted until publishing
succeeds and authentication is available.
