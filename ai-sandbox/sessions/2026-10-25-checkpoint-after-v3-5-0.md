# 2026-10-25 · Bringing the thread checkpoint up to v3.5.0

- **Status:** closed
- **Configuration:** Solo
- **Participants:** author — claude-opus-5-5
- **Signed off:** no
- **Tags:** `#template` `#adoption` `#secrets`

> This session began as a `git pull` and did not run `session-start.md`. This record was written
> at its close, from the commands it ran, and is a reconstruction rather than a running account.

---

## Objective

Integrate `origin/main` and leave `CHECKPOINT-install-path.md` true for the root as it now stands.

## Reasoning

`git pull` refused: local `main` held one commit (`5a38a43`, the checkpoint's push-status note)
and `origin/main` held six (`08fde8d`–`216a755`, the `v3.5.0` work of 2026-09-26). It was a
divergence, not a content conflict. `git merge-tree` showed none, and the remote commits never
touch the checkpoint. Rebased: the local commit became `6d543d7`, on top of `216a755`.

That left the checkpoint wrong from its first line. It said the root ran `v3.4.0` and that
`origin/main` was up to date as of `d21987e`. The 2026-09-26 sessions left it alone on purpose,
since it is held by this clone's identity, so nobody else could have corrected it. Rewritten whole
against `v3.5.0`:

- The six findings were re-read against the release. None moved. The installer still takes the
  project name as a separate second argument, still drops `skeleton/README.md` from the candidate,
  and still creates no project README, although it now preserves an existing one.
- The `Owner:` row now matches the ask-before-fill wording in both registers.
- `bootstrap-test.sh` was re-run: pass, 29 checks, including the new collision, README-preservation
  and data-ignore gates.
- The push-state row was removed rather than updated. It had gone stale three times, and
  `5a38a43` had already said to read it from `git status`.

## Found along the way

All six `v3.5.0` commits name a work identity as author, and they are already on `origin/main`.
`docs/constraints.md` forbids employer-identifying content in this public repository *including
in history*. This is commit metadata rather than file content, so neither the secret hook nor
the 2026-08-28 review of the evidence files would have seen it. It is recorded as Gap 4 in the
checkpoint, without the identity itself. The fix, a history rewrite and force-push, is left for
the author to decide.

## Decisions

- Rebase, not merge: one local commit, no overlapping files.
- The checkpoint states no ahead/behind count.
- No history rewrite without the author's decision.

## Next

Decide Gap 4. Then the six findings, as before.
