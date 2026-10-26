# IMP-2026-10-26-install-unreleased-label · Plan r1

- **Status:** released
- **Released:** 2026-10-26 by claude-opus-5-5, design approved by esdevop
- **Design:** `DESIGN.md`
- **Session:** `sessions/2026-10-26-dogfood-install-label.md`
- **Supersedes:** —
- **Changed steps:** —
- **Runtime:** none beyond a clone of this repository with its tags, `bash` and `git`. All commands
  run from the repository root on branch `next`.

> **Steps and gates. No status.** Fixed once released. What happened lives in `runs/`, what was
> accepted in `reviews/`. Executors follow `skeleton/ai-sandbox/playbooks/execute-step.md`, and the
> templates for reports are in `skeleton/ai-sandbox/implementations/_TEMPLATE/`.
>
> S-01 and S-03 have no dependency between them and can run in parallel.

---

## Steps

### S-01 · Add the version-label gate to `bootstrap-test.sh`, before the fix

- **Depends on:** —
- **Handoff:** mechanical
- **Read:** `DESIGN.md` §2.2 and §2.5; `bootstrap-test.sh`; `install.sh` lines 30–62 and 240–250
- **Produces:** a new section in `bootstrap-test.sh`, titled with `say "Version label gate"`, placed
  immediately before `say "Result"`
- **Do:**
  1. Create a scratch directory with `mktemp -d` for a clone and three destinations, and add every
     path to the existing `trap … EXIT` cleanup.
  2. Clone the repository: `git clone -q --local "$(pwd)" "$lbl_src"`. Find the tag with
     `T=$(git -C "$lbl_src" describe --tags --abbrev=0)`, then
     `git -C "$lbl_src" checkout -q "$T"`. Give the clone a local `user.email` and `user.name`.
  3. Always run **this working tree's** installer with the clone as its source:
     `(cd "$lbl_src" && "$root/install.sh" "$dX" lbl test@example.invalid) >/dev/null 2>&1`, where
     `root` is this repository's top level. `install.sh` takes its source from the current
     directory's repository, so the clone's skeleton is installed by the installer under test.
  4. Case 1, clean: install into destination A, and expect the first field of `A/.template-version`
     to be exactly `$T`.
  5. Case 2, committed: append one line to `"$lbl_src/skeleton/README.md"` and commit it in the
     clone. Let `sha=$(git -C "$lbl_src" log -1 --format=%h -- skeleton/)`. Install into B, and
     expect `$T+$sha`.
  6. Case 3, uncommitted: append another line to the same file without committing. Install into C,
     and expect `$T+$sha-dirty`, with the same `sha` as case 2.
  7. Report each case with the file's own `ok` and `bad` helpers. Every message must contain the
     words `version label`, for example `ok "version label: clean tag records $T"`.
- **Do not:** change `install.sh`; change any other section of `bootstrap-test.sh`; reach the network;
  rebuild the expected label by copying the installer's own logic. Expected values come from
  `git` output in the clone, as above.
- **Stop if:** the clone has no tag; or case 1 fails, since it already passes today and a failure
  means the test is wrong, not the installer.
- **Gate G-01-1:** `bash -n bootstrap-test.sh` → exit 0
- **Gate G-01-2:** `./bootstrap-test.sh 2>&1 | grep -cE '^  ok    version label'` → `1`
- **Gate G-01-3:** `./bootstrap-test.sh 2>&1 | grep -cE '^  FAIL  version label'` → `2`

### S-02 · Make `install.sh` record the label the design specifies

- **Depends on:** S-01
- **Handoff:** mechanical
- **Read:** `DESIGN.md` §2.1, §2.2 and §2.3; `install.sh`
- **Produces:** `install.sh` computing a `label` after `sha` is known, writing it as the first field
  of `.template-version`, and naming it in the summary
- **Do:**
  1. After `sha=` is set, decide whether `skeleton/` is release `$version`. It is when both
     `git -C "$src" diff --quiet "$version" HEAD -- skeleton/` succeeds, and
     `git -C "$src" status --porcelain -- skeleton/` prints nothing.
  2. Set `label="$version"` when it is. Otherwise set `label="$version+$sha"`, with `-dirty`
     appended when the status command printed anything.
  3. Use `label`, not `version`, wherever `.template-version` is written (the `<VERSION>`
     substitution) and in the `did ".template-version records …"` line.
  4. When `label` differs from `version`, also print, through the same `did` helper,
     `unreleased: skeleton/ differs from $version; recorded as $label`.
- **Do not:** refuse the install; change the `Preparing $version …` line; touch the shallow-clone
  and no-tag refusals; change anything outside `install.sh`.
- **Stop if:** `$version` is not a tag name `git diff` accepts.
- **Gate G-02-1:** `bash -n install.sh` → exit 0
- **Gate G-02-2:** `./bootstrap-test.sh 2>&1 | grep -cE '^  ok    version label'` → `3`
- **Gate G-02-3:** `./bootstrap-test.sh 2>&1 | grep -cE '^  FAIL  version label'` → `0`

### S-03 · Tell `upgrade-template.md` what a `+<sha>` version means

- **Depends on:** —
- **Handoff:** judgement
- **Read:** `DESIGN.md` §2.4 and the *Does not license* section; `skeleton/ai-sandbox/playbooks/upgrade-template.md` step 1
- **Produces:** two to four sentences in step 1 of `skeleton/ai-sandbox/playbooks/upgrade-template.md`
- **Do:** after the paragraph that begins *If it disagrees with the structure*, add a paragraph.
  A version of the form `v<x>+<sha>` (or `…-dirty`) was installed between releases, from a
  skeleton past tag `v<x>`. Upgrade as from `v<x>`, and expect mechanism files to differ from
  `v<x>`'s hashes where the unreleased skeleton changed them. Compare those by hand before step 4
  replaces them. Do not treat the suffix as a release.
- **Do not:** edit any other step; edit the root's `ai-sandbox/playbooks/upgrade-template.md`, which
  is vendored and changes only at a release; restate the design.
- **Stop if:** step 1 no longer has the *If it disagrees with the structure* paragraph.
- **Gate G-03-1:** `grep -c '+<sha>' skeleton/ai-sandbox/playbooks/upgrade-template.md` → `1` or more
- **Gate G-03-2:** `git diff --stat -- ai-sandbox/playbooks/upgrade-template.md | wc -l` → `0`

### S-04 · Regenerate the hash list and run every gate

- **Depends on:** S-02, S-03
- **Handoff:** mechanical
- **Read:** `MIGRATIONS.md` *Cutting a release*, step 2 (the hash command only)
- **Produces:** `skeleton/.template-hashes` matching the changed mechanism files
- **Do:** run the step-2 hash command from `MIGRATIONS.md` exactly as written, then the gates.
- **Do not:** tag, push, or edit `.template-version`.
- **Stop if:** the hash command changes any line other than `ai-sandbox/playbooks/upgrade-template.md`'s.
- **Gate G-04-1:** `git diff --numstat -- skeleton/.template-hashes` → `1	1	skeleton/.template-hashes`
- **Gate G-04-2:** `./bootstrap-test.sh 2>&1 | tail -1` → `  pass`
- **Gate G-04-3:** `bash skeleton/check.sh 2>&1 | grep -c 'FAILED'` → `0`
