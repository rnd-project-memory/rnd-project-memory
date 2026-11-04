#!/usr/bin/env bash
# Runs ./install.sh into a scratch repository, then runs the check.sh that landed there.
# Unlike check.sh, this one FAILS — it is a release gate, not advice.
#
# It calls the installer rather than reproducing it. Until 2026-08-26 it reproduced it, and
# EXP-2026-08-26-prose-script-restatement measured what that cost: one install step written twice
# in two different texts, and one step written in neither. A gate that reimplements what it gates
# tests its own copy, and passes while the thing it stands in for is wrong.
#
# It exists because this repository cannot test itself here. Self-hosting vendors the skeleton's
# files in place: nothing is renamed, no placeholder is filled, the copy set is never chosen. Every
# defect that lives in the *transformation* from skeleton to consumer is therefore invisible to the
# root's own check.sh, which reports `ok` while every adopter sees a failure on line one. That is
# how a hash list naming a file the install renames survived four releases.
#
# It also enforces the hash-list criterion mechanically: the list may contain only files installed
# verbatim, subject to no transformation. Any listed file the install touches shows up here as a
# checksum failure, which is the criterion restated as an executable test.

set -u
cd "$(git rev-parse --show-toplevel 2>/dev/null || echo .)" || exit 1

fail=0
say() { printf '\n\033[1m%s\033[0m\n' "$1"; }
bad() { echo "  FAIL  $1"; fail=1; }
ok()  { echo "  ok    $1"; }

dest=$(mktemp -d) || exit 1
collision_dest=$(mktemp -d) || exit 1
preserve_dest=$(mktemp -d) || exit 1
trap 'rm -rf "$dest" "$collision_dest" "$preserve_dest" "$lbl_src" "$lbl_A" "$lbl_B" "$lbl_C"' EXIT

# The install itself, performed by the file an adopter is pointed at. Anything wrong in here is
# wrong for them too, which is the property this gate exists to have.
./install.sh "$dest" bootstrap-test test@example.invalid first-thread >/dev/null 2>&1 \
  || bad "install.sh did not complete"
git -C "$dest" config user.name "bootstrap-test"

# Step 3b — the blanks a human answers, marked <<FILL: ...>>. An adopter writes real sentences
# here; this stands in for that, because what is being tested is that the install leaves nothing
# marked behind, not the quality of the prose. Counted before and after: a step that silently
# finds nothing to do would pass this gate for the wrong reason.
# check.sh is excluded exactly as its own blank check excludes itself: it names the marker in
# order to look for it. Rewriting it here also replaced its mode with the temp file's, which is
# how a check that describes a check stops being executable.
marked() { grep -rlI --exclude-dir=.git --exclude=check.sh -- '<<FILL' "$dest" 2>/dev/null; }
pre_fill=$(marked | wc -l)
while IFS= read -r f; do
  awk 'BEGIN{RS="\0"} {gsub(/<<FILL:[^>]*>>/, "answered by bootstrap-test"); printf "%s", $0}' \
      "$f" > "$f.bt" && cat "$f.bt" > "$f" && rm -f "$f.bt"
done < <(marked)

git -C "$dest" add -A >/dev/null 2>&1
git -C "$dest" commit -qm "adopt the skeleton" >/dev/null 2>&1 \
  || bad "the first commit was rejected — the hook blocks a clean install"

say "What an adopter's first check.sh run reports"
out=$(cd "$dest" && ./check.sh 2>&1)
echo "$out" | sed 's/^/  │ /' | head -40

say "Gates"

# The criterion, executable: every hashed path must survive the install byte-for-byte.
if [ -f "$dest/.template-hashes" ]; then
  drift=$(cd "$dest" && sha256sum -c --quiet .template-hashes 2>/dev/null)
  if [ -n "$drift" ]; then
    echo "$drift" | sed 's/^/        /'
    bad "hashed files did not survive the install — the list names something the install transforms"
  else
    ok "every hashed file installed verbatim"
  fi
else
  bad ".template-hashes did not reach the consumer — check.sh's first check is inert"
fi

case "$out" in
  *"no .template-hashes"*) bad "check.sh cannot find .template-hashes after a by-the-book install";;
esac
case "$out" in
  *FAILED*) bad "check.sh reports a hash failure on a clean, correct adoption";;
        *) ok "no hash failure on a clean adoption";;
esac
case "$out" in
  *"still the shipped template"*) bad "check.sh reports template residue after an install that named its thread";;
                               *) ok "no template residue reported when the first thread was named";;
esac
# The Current focus bound must hold on day one, and its guidance must outlive the answered blank:
# that guidance used to live only in the marker, which is exactly what the step above deletes.
case "$out" in
  *"lines — rewrite it"*) bad "check.sh reports an over-long Current focus on a fresh install";;
                       *) ok "Current focus within its bound on a fresh install";;
esac
grep -q 'never appended' "$dest/ai-sandbox/INDEX.md" \
  && ok "Current focus guidance survives answering the blank" \
  || bad "INDEX.md lost its Current focus guidance once the blank was answered"

say "Implementation package gate"
# Status in a package is derived, never typed. If the derivation is wrong, every executor picks the
# wrong step, so it is tested on a package with a judgement dependency, an independent step and a
# report that contradicts itself.
case "$out" in
  *"Implementation packages"*"  none"*) ok "no package findings on a fresh install";;
  *) bad "check.sh reports implementation packages on a fresh install";;
esac
pk="$dest/ai-sandbox/implementations/IMP-2000-01-01-fixture"
mkdir -p "$pk/runs" "$pk/reviews"
cat > "$pk/PLAN.md" <<'PLAN'
- **Status:** released
### S-01 · a
- **Depends on:** —
- **Handoff:** judgement
- **Gate G-01-1:** `true` → exit 0
### S-02 · b
- **Depends on:** S-01
- **Handoff:** mechanical
- **Gate G-02-1:** `true` → exit 0
### S-03 · c
- **Depends on:** —
- **Handoff:** mechanical
- **Gate G-03-1:** `true` → exit 0
### S-04 · d
- **Depends on:** IMP-2000-01-02-branch
- **Handoff:** mechanical
- **Gate G-04-1:** `true` → exit 0
PLAN
mkdir -p "$dest/ai-sandbox/implementations/IMP-2000-01-02-branch"
printf '| IMP-2000-01-01-fixture | 2000-01-01 | opened | first-thread | `#fixture` | fixture |\n' \
  >> "$dest/ai-sandbox/implementations/LOG.md"
printf -- '- **Status:** passed\n- **Commit:** %s\n- **Gate G-01-1:** pass — exit 0\n' \
  "$(git -C "$dest" rev-parse --short HEAD)" > "$pk/runs/S-01__20000101T0000Z.md"
printf -- '- **Status:** passed\n- **Session:** `sessions/no-such-session.md`\n- **Commit:** %s\n- **Gate G-03-1:** fail — exit 1\n' \
  "$(git -C "$dest" rev-parse --short HEAD)" > "$pk/runs/S-03__20000101T0000Z.md"
pout=$(cd "$dest" && ./check.sh 2>&1)
printf '%s\n' "$pout" | grep -qE 'S-02 +waiting +on S-01' \
  && ok "a judgement step that passed but is not accepted holds its dependants" \
  || bad "S-02 is not waiting on an unaccepted judgement step"
printf '%s\n' "$pout" | grep -qE 'S-03 +inconsistent' \
  && ok "a passed report over a failing gate shows as inconsistent" \
  || bad "a self-contradicting report is not shown as inconsistent"
printf '%s\n' "$pout" | grep -q 'S-03__20000101T0000Z.md: passed, but 1 of 1' \
  && ok "the uncommitted contradicting report is reported" \
  || bad "the uncommitted contradicting report is not reported"
printf '%s\n' "$pout" | grep -qE 'S-04 +waiting +on IMP-2000-01-02-branch' \
  && ok "a step depending on a whole package waits until that package is accepted" \
  || bad "S-04 does not wait on the package it depends on"
printf '%s\n' "$pout" | grep -q 'Session: sessions/no-such-session.md does not exist' \
  && ok "a backward link to a record that does not exist is reported" \
  || bad "a dangling Session: link is not reported"
printf -- '- **Verdict:** accepted\n' > "$pk/reviews/S-01__20000101T0100Z.md"
(cd "$dest" && ./check.sh 2>&1) | grep -qE 'S-02 +ready' \
  && ok "accepting the judgement step makes its dependant ready" \
  || bad "S-02 is not ready after S-01 was accepted"
printf '| IMP-2000-01-02-branch | 2000-01-02 | accepted | first-thread | | fixture |\n' \
  >> "$dest/ai-sandbox/implementations/LOG.md"
(cd "$dest" && ./check.sh 2>&1) | grep -qE 'S-04 +ready' \
  && ok "accepting the package releases the step that depends on it" \
  || bad "S-04 is not ready after the package it depends on was accepted"
rm -rf "$pk" "$dest/ai-sandbox/implementations/IMP-2000-01-02-branch"
git -C "$dest" checkout -q -- ai-sandbox/implementations/LOG.md

[ -f "$dest/.template-version" ] \
  && ok ".template-version reached the consumer" \
  || bad "no .template-version — §11 names it and the skeleton does not ship it"

# ADR-009: splitting a file into owned regions is a conditional exception, permitted only where an
# include mechanism is unavailable. Exactly one file qualifies. This gate is what keeps that true
# without anyone having to remember it.
# Anchored: a file that *mentions* the marker in prose or matches on it in code is documenting
# the exception, not taking it. Only a real marker line counts.
marked=$(grep -rlI --exclude-dir=.git -- '^# ─── UPSTREAM BLOCK' "$dest" 2>/dev/null)
count=$(printf '%s' "$marked" | grep -c . )
if [ "$count" -le 1 ]; then
  ok "region markers: $count (the exception is bounded to one file)"
else
  echo "$marked" | sed 's/^/        /'
  bad "$count files carry a region marker — ADR-009 permits one, and only where no include exists"
fi

[ "$pre_fill" -gt 0 ] \
  && ok "the install left $pre_fill files carrying blanks to answer" \
  || bad "no <<FILL>> markers shipped — this gate tests nothing and check.sh's blank check is inert"

post_fill=$(marked | wc -l)
[ "$post_fill" -eq 0 ] \
  && ok "no install blank left unanswered" \
  || bad "$post_fill files still carry <<FILL>> — a marker the install's grep does not reach"

# README step 4 — the rename — went unexercised until 2026-08-26 because the gate reimplemented
# the install and simply omitted it. Nothing reported that: check.sh's line-limit check counts
# lines without asking what the file is, and its Held by: check skips placeholder values so that a
# clean adoption does not open on a mismatch. Two correct checks whose exemptions overlap.
if [ -f "$dest/ai-sandbox/CHECKPOINT-first-thread.md" ]; then
  hb=$(grep -m1 'Held by:' "$dest/ai-sandbox/CHECKPOINT-first-thread.md")
  case "$hb" in
    *test@example.invalid*) ok "the named thread was opened and Held by: filled from the clone";;
    *) bad "CHECKPOINT-first-thread.md exists but Held by: is $hb";;
  esac
elif [ -f "$dest/ai-sandbox/CHECKPOINT-thread.md" ]; then
  bad "the install was given a thread slug and left CHECKPOINT-thread.md unrenamed"
else
  bad "neither CHECKPOINT-thread.md nor CHECKPOINT-first-thread.md exists after the install"
fi

# The failure the three classes exist to prevent, and the only one that is silent: an install told
# to "replace every placeholder" replaces the example syntax too, and takes the routing table in
# ai-sandbox/INDEX.md with it. That file is loaded into every session, so the damage is read as
# instruction from then on. Nothing above would notice: it hashes to nothing, holds no marker, and
# reads as prose.
if grep -q 'CHECKPOINT-<thread>\.md' "$dest/ai-sandbox/INDEX.md" 2>/dev/null; then
  ok "example syntax survived the install (INDEX.md still documents CHECKPOINT-<thread>.md)"
else
  bad "ai-sandbox/INDEX.md no longer documents CHECKPOINT-<thread>.md — the install consumed the"
  echo "        example syntax along with the placeholders, and every session now loads the result"
fi

for owner_file in "$dest/ai-sandbox/OPEN_QUESTIONS.md" "$dest/ai-sandbox/ASSUMPTIONS.md"; do
  if grep -q 'ask the user who should own' "$owner_file" \
     && ! grep -q 'Owner:` is always filled' "$owner_file"; then
    ok "$(basename "$owner_file") asks before filling an unknown Owner"
  else
    bad "$(basename "$owner_file") does not carry the ask-before-filling Owner workflow"
  fi
done

left=$(grep -rlI --exclude-dir=.git '<PROJECT_NAME>' "$dest" 2>/dev/null \
       | grep -v '_TEMPLATE\.md$' | wc -l)
[ "$left" -eq 0 ] \
  && ok "no <PROJECT_NAME> left outside the _TEMPLATE.md files" \
  || bad "$left installed files still say <PROJECT_NAME> after install.sh ran"

say "User-controlled data ignore gate"
mkdir -p "$dest/tests/fixtures" "$dest/data"
printf 'id,value\nSAMPLE-001,1\n' > "$dest/tests/fixtures/example.csv"
printf 'id,value\nSAMPLE-002,2\n' > "$dest/data/example.csv"
if git -C "$dest" check-ignore -q -- tests/fixtures/example.csv; then
  bad "CSV is still globally ignored; data-file ignore policy should be user-controlled"
else
  ok "CSV is visible for the user to track or ignore"
fi
if git -C "$dest" check-ignore -q -- data/example.csv; then
  bad "data/ is still globally ignored; data-directory ignore policy should be user-controlled"
else
  ok "data/ is visible for the user to track or ignore"
fi
rm -f "$dest/tests/fixtures/example.csv" "$dest/data/example.csv"
rmdir "$dest/tests/fixtures" "$dest/data" 2>/dev/null || true

say "Existing-project collision gate"
git -C "$collision_dest" init -q . || bad "could not initialise collision fixture"
git -C "$collision_dest" config user.email test@example.invalid
git -C "$collision_dest" config user.name bootstrap-test
printf 'keep this README\n' > "$collision_dest/README.md"
printf '# Existing project\n' > "$collision_dest/AGENTS.md"
git -C "$collision_dest" add README.md AGENTS.md
git -C "$collision_dest" commit -qm "seed existing project" \
  || bad "could not commit collision fixture"
if collision_out=$(./install.sh "$collision_dest" collision-project test@example.invalid 2>&1); then
  collision_rc=0
else
  collision_rc=$?
fi
[ "$collision_rc" -eq 2 ] \
  && ok "differing tracked files stop the install with collision status 2" \
  || { bad "collision install returned $collision_rc, expected 2"; echo "$collision_out"; }
printf '%s\n' "$collision_out" | grep -q 'COLLISION.*AGENTS.md' \
  && ok "collision output names the existing file" \
  || { bad "collision output did not name AGENTS.md"; echo "$collision_out"; }
printf '%s\n' "$collision_out" | grep -q '^diff --git' \
  && ok "collision output includes a git diff" \
  || { bad "collision output did not include a git diff"; echo "$collision_out"; }
[ "$(cat "$collision_dest/README.md")" = "keep this README" ] \
  && ok "existing README survives a collision" \
  || bad "existing README was changed or removed"
[ ! -e "$collision_dest/check.sh" ] \
  && ok "collision preflight leaves no partial install" \
  || bad "collision preflight copied files before aborting"
[ -z "$(git -C "$collision_dest" status --porcelain)" ] \
  && ok "collision preflight leaves the tracked project clean" \
  || bad "collision preflight changed the tracked project"

say "Existing README preservation gate"
printf 'keep this README\n' > "$preserve_dest/README.md"
if ./install.sh "$preserve_dest" preserve-project test@example.invalid >/dev/null 2>&1; then
  [ "$(cat "$preserve_dest/README.md")" = "keep this README" ] \
    && ok "an existing README survives a successful install" \
    || bad "a successful install changed or removed the existing README"
  # Given no thread slug, the install leaves the shipped checkpoint template in place and says so
  # once. check.sh is what keeps saying so: without it the template counted as a thread, reported
  # ok, for as long as nobody happened to notice.
  case "$(cd "$preserve_dest" && ./check.sh 2>&1)" in
    *"CHECKPOINT-thread.md: still the shipped template"*)
      ok "an unnamed first thread is reported by check.sh, not counted as a thread";;
    *) bad "check.sh is silent about CHECKPOINT-thread.md left by an install with no thread slug";;
  esac
else
  bad "install with a non-conflicting existing README failed"
fi

say "Register and marker gate"
# A register's shipped example lives in a blockquote, so an untouched register reads as empty.
live=$(grep -lE '^## [A-Z]-<slug>' "$dest"/ai-sandbox/*.md 2>/dev/null)
[ -z "$live" ] \
  && ok "no register ships a live example entry" \
  || bad "a register ships its example as a live entry: $live"
case "$out" in
  *"a marker half removed"*) bad "check.sh reports a half-removed marker after a complete fill";;
  *) ok "no marker remnant after the blanks are answered";;
esac
cp "$dest/ai-sandbox/INDEX.md" "$dest/ai-sandbox/INDEX.md.orig"
printf 'what is left of a marker.>>\n' >> "$dest/ai-sandbox/INDEX.md"
(cd "$dest" && ./check.sh 2>&1) | grep -q 'INDEX.md:[0-9]*: a marker half removed' \
  && ok "a half-removed marker is reported" \
  || bad "a half-removed marker is not reported"
mv "$dest/ai-sandbox/INDEX.md.orig" "$dest/ai-sandbox/INDEX.md"

say "Revision gate"
# One adopter's agent revised the design into DESIGN.r1.md, then edited the released PLAN.md in place
# and committed it, so the reports of steps already done no longer matched the plan they cite. The
# scenario, step by step.
rp="$dest/ai-sandbox/implementations/IMP-2000-01-03-revision"
mkdir -p "$rp/runs" "$rp/reviews"
printf -- '- **Status:** approved\n' > "$rp/DESIGN.md"
cat > "$rp/PLAN.md" <<'PLAN'
- **Status:** released
- **Design:** `DESIGN.md`
### S-01 · a
- **Depends on:** —
- **Handoff:** mechanical
- **Gate G-01-1:** `true` → exit 0
### S-02 · b
- **Depends on:** S-01
- **Handoff:** mechanical
- **Gate G-02-1:** `true` → exit 0
PLAN
printf -- '- **Verdict:** accepted\n' > "$rp/reviews/S-01__20000103T0000Z.md"
printf '| IMP-2000-01-03-revision | 2000-01-03 | opened | first-thread | | fixture |\n' >> "$dest/ai-sandbox/implementations/LOG.md"
rev_commit() { git -C "$dest" add -A ai-sandbox/implementations >/dev/null; (cd "$dest" && git commit -qm "$1" >/dev/null 2>&1); }
rev_out() { (cd "$dest" && ./check.sh 2>&1) | grep 'IMP-2000-01-03-revision'; }
rev_commit "revision fixture released"
rev_out | grep -qE 'IMP-2000-01-03-revision \(PLAN.md\)$' \
  && ok "a released plan with an approved design executes" \
  || bad "the released fixture plan is not shown as executable"
printf -- '- **Status:** approved\n' > "$rp/DESIGN.r1.md"; rev_commit "design revised"
rev_out | grep -q 'HALTED.*DESIGN.r1.md is ahead of PLAN.md' \
  && ok "a design revision without its plan halts execution" \
  || bad "execution was not halted when the design got ahead of the plan"
printf '### S-03 · edited in place\n- **Depends on:** —\n- **Handoff:** mechanical\n- **Gate G-03-1:** `true` → exit 0\n' >> "$rp/PLAN.md"
rev_commit "the mistake: PLAN.md edited in place"
rev_out | grep -q 'PLAN.md differs from its release at .* (edited in 1 commit(s) since)' \
  && ok "a released plan edited in place, and committed, is reported" \
  || bad "a committed in-place edit of a released plan is not reported"
git -C "$dest" show "HEAD~2:ai-sandbox/implementations/IMP-2000-01-03-revision/PLAN.md" > "$rp/PLAN.md"
sed 's/`DESIGN.md`/`DESIGN.r1.md`/; s/^### S-02 · b/### S-03 · b, revised/; s/G-02-1/G-03-1/' "$rp/PLAN.md" \
  | sed '1a - **Carried steps:** S-01' > "$rp/PLAN.r1.md"
# Checked before the revision is committed, which is when an author can still fix it.
rev_out | grep -q 'S-02 of PLAN.md is in neither PLAN.r1.md nor its Changed/Dropped steps' \
  && ok "a step that vanishes from a revision without being accounted for is reported" \
  || bad "a silently dropped step is not reported"
sed -i '2a - **Changed steps:** S-02 → S-03' "$rp/PLAN.r1.md"
rev_commit "recovered: PLAN.md restored, PLAN.r1.md released"
rout=$( (cd "$dest" && ./check.sh 2>&1) | sed -n '/IMP-2000-01-03-revision (PLAN.r1.md)$/,+2p')
printf '%s\n' "$rout" | grep -qE 'S-01 +accepted' && printf '%s\n' "$rout" | grep -qE 'S-03 +ready' \
  && ok "after recovery the carried step stays accepted and the revised step is ready" \
  || bad "after recovery the package does not show S-01 accepted and S-03 ready"
git -C "$dest" reset -q --hard HEAD~4; rm -rf "$rp"

say "Working decisions gate"
dc="$dest/ai-sandbox/DECISIONS.md"; cp "$dc" "$dc.orig"
printf '\n## D-held-choice · held\n\n- **Decided:** %s · **by:** fixture\n' "$(date -d '70 days ago' +%F)" >> "$dc"
printf '\n## D-young-choice · young\n\n- **Decided:** %s · **by:** fixture\n' "$(date -d '40 days ago' +%F)" >> "$dc"
dout=$(cd "$dest" && ./check.sh 2>&1)
printf '%s\n' "$dout" | grep -q 'ripe  D-held-choice: held 70 days' \
  && ok "a decision held 70 days is listed as ripe for an ADR" \
  || bad "a decision held 70 days is not listed as ripe"
printf '%s\n' "$dout" | grep -q 'D-young-choice' \
  && bad "a 40-day-old decision is listed as ripe, under the 60-day threshold" \
  || ok "a decision younger than 60 days is not listed"
mv "$dc.orig" "$dc"

say "Staleness gate"
# Only a human defers a stalled thread, and a deferral names its end. Tested on a checkpoint whose
# last commit is forty days old, against four states of the log.
sl="$dest/ai-sandbox/STALENESS_LOG.md"; cp "$sl" "$sl.orig"
old=$(date -d '40 days ago' '+%Y-%m-%dT12:00:00')
cp "$dest/ai-sandbox/CHECKPOINT-first-thread.md" "$dest/ai-sandbox/CHECKPOINT-old-thread.md"
git -C "$dest" add ai-sandbox/CHECKPOINT-old-thread.md
(cd "$dest" && GIT_COMMITTER_DATE="$old" GIT_AUTHOR_DATE="$old" git commit -qm "an old thread" >/dev/null 2>&1)
stale() { (cd "$dest" && ./check.sh 2>&1) | grep -q 'Stalled: CHECKPOINT-old-thread.md'; }
ahead=$(date -d '10 days' +%F); behind=$(date -d '1 day ago' +%F)
stale && ok "a thread untouched for 40 days, never deferred, is reported" \
      || bad "a 40-day-old thread with no deferral is not reported"
printf '| %s | old-thread | 40 | deferred | assistant (session-start sweep) | %s |\n' "$(date +%F)" "$ahead" >> "$sl"
stale && ok "a deferral recorded by an assistant does not quiet it" \
      || bad "an assistant's deferral quieted a stalled thread"
printf '| %s | old-thread | 40 | deferred | esdevop | %s |\n' "$(date +%F)" "$ahead" >> "$sl"
stale && bad "the holder's deferral with a revisit date ahead did not quiet the notice" \
      || ok "the holder's deferral quiets it until the revisit date"
printf '| %s | old-thread | 40 | deferred | esdevop | %s |\n' "$(date +%F)" "$behind" >> "$sl"
stale && ok "a deferral past its revisit date reports the thread again" \
      || bad "a lapsed deferral still quiets the thread"
git -C "$dest" reset -q --hard HEAD~1; mv "$sl.orig" "$sl"

say "Identity guard gate"
# Published identity metadata cannot be withdrawn, so the guard blocks. It must stay silent until a
# project lists anyone, since a check firing on a project that never asked teaches --no-verify,
# and must block both at commit and at push once a list exists.
case "$out" in
  *"identity guard off"*) ok "the identity guard ships off, with an empty list";;
  *) bad "check.sh does not report the identity guard as off on a fresh install";;
esac
idr=$(mktemp -d) || exit 1
git init -q --bare "$idr/remote.git"
git -C "$dest" remote add idtest "$idr/remote.git"
cp "$dest/.githooks/identity.allow" "$idr/allow.orig"
printf 'someone@else.invalid\n' >> "$dest/.githooks/identity.allow"
printf 'x\n' > "$dest/identity-fixture.txt"; git -C "$dest" add identity-fixture.txt
if (cd "$dest" && git commit -qm "identity fixture" >/dev/null 2>&1); then
  bad "a commit by an unlisted identity was not blocked"
else
  ok "a commit by an unlisted identity is blocked"
fi
printf '*@EXAMPLE.invalid\n' >> "$dest/.githooks/identity.allow"
(cd "$dest" && git commit -qm "identity fixture" >/dev/null 2>&1) \
  && ok "a commit by a listed identity, matched by glob and case-insensitively, passes" \
  || bad "a commit by a listed identity was blocked"
(cd "$dest" && GIT_COMMITTER_EMAIL=tagger@else.invalid GIT_COMMITTER_NAME=t git tag -a idtag -m t)
if (cd "$dest" && git push -q idtest idtag >/dev/null 2>&1); then
  bad "a tag by an unlisted tagger was pushed"
else
  ok "a tag by an unlisted tagger is blocked at push"
fi
(cd "$dest" && git push -q idtest HEAD:refs/heads/main >/dev/null 2>&1) \
  && ok "commits by a listed identity push" \
  || bad "a push of listed commits was blocked"
git -C "$dest" tag -d idtag >/dev/null; git -C "$dest" remote remove idtest
git -C "$dest" reset -q --hard HEAD~1; cp "$idr/allow.orig" "$dest/.githooks/identity.allow"; rm -rf "$idr"

say "Version label gate"
# The first field of .template-version must say what the install was made from. Expected values
# come from the clone's own git output, not from re-deriving the installer's logic.
lbl_src=$(mktemp -d) || exit 1
lbl_A=$(mktemp -d) || exit 1
lbl_B=$(mktemp -d) || exit 1
lbl_C=$(mktemp -d) || exit 1
root=$(pwd)
git clone -q --local "$root" "$lbl_src" 2>/dev/null || bad "version label: could not clone the repository"
T=$(git -C "$lbl_src" describe --tags --abbrev=0 2>/dev/null)
if [ -z "$T" ]; then
  bad "version label: the clone has no tag, so there is no release to expect"
else
  git -C "$lbl_src" checkout -q "$T"
  git -C "$lbl_src" config user.email test@example.invalid
  git -C "$lbl_src" config user.name bootstrap-test

  # Case 1: as tagged, clean.
  (cd "$lbl_src" && "$root/install.sh" "$lbl_A" lbl test@example.invalid) >/dev/null 2>&1
  got=$(awk '{print $1; exit}' "$lbl_A/.template-version" 2>/dev/null)
  [ "$got" = "$T" ] \
    && ok "version label: clean tag records $T" \
    || bad "version label: clean tag recorded '$got', expected '$T'"

  # Case 2: a committed change under skeleton/ moves the label to T+<sha>.
  printf 'version label fixture, committed\n' >> "$lbl_src/skeleton/README.md"
  git -C "$lbl_src" commit -qam "fixture: committed skeleton change" >/dev/null 2>&1
  sha=$(git -C "$lbl_src" log -1 --format=%h -- skeleton/)
  (cd "$lbl_src" && "$root/install.sh" "$lbl_B" lbl test@example.invalid) >/dev/null 2>&1
  got=$(awk '{print $1; exit}' "$lbl_B/.template-version" 2>/dev/null)
  [ "$got" = "$T+$sha" ] \
    && ok "version label: committed change records $T+$sha" \
    || bad "version label: committed change recorded '$got', expected '$T+$sha'"

  # Case 3: an uncommitted change adds -dirty to the same sha.
  printf 'version label fixture, uncommitted\n' >> "$lbl_src/skeleton/README.md"
  (cd "$lbl_src" && "$root/install.sh" "$lbl_C" lbl test@example.invalid) >/dev/null 2>&1
  got=$(awk '{print $1; exit}' "$lbl_C/.template-version" 2>/dev/null)
  [ "$got" = "$T+$sha-dirty" ] \
    && ok "version label: uncommitted change records $T+$sha-dirty" \
    || bad "version label: uncommitted change recorded '$got', expected '$T+$sha-dirty'"
fi

say "Result"
[ "$fail" -eq 0 ] && echo "  pass" || echo "  FAIL — an adopter following the instructions gets the above"
exit "$fail"
