#!/usr/bin/env bash
# Installs skeleton/ into a scratch repository exactly as skeleton/README.md says, then runs the
# check.sh that landed there. Unlike check.sh, this one FAILS — it is a release gate, not advice.
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
trap 'rm -rf "$dest"' EXIT

say "Installing skeleton/ per skeleton/README.md into $dest"

# Step 1 — copy the contents, except this README.md.
cp -r skeleton/. "$dest"/ || exit 1
rm -f "$dest/README.md"

# Step 2 — rename, then install the hooks.
mv "$dest/gitignore.template" "$dest/.gitignore" 2>/dev/null
git -C "$dest" init -q .
git -C "$dest" config core.hooksPath .githooks
git -C "$dest" config user.email test@example.invalid
git -C "$dest" config user.name "bootstrap-test"

# Step 3 — replace the placeholders. _TEMPLATE.md files are copied per entry, not filled in
# place, so they keep theirs.
while IFS= read -r f; do
  case "$(basename "$f")" in _TEMPLATE.md) continue;; esac
  sed -i "s/<PROJECT_NAME>/bootstrap-test/g; s/<DATE>/$(date +%F)/g" "$f"
done < <(grep -rlI --exclude-dir=.git -e '<PROJECT_NAME>' -e '<DATE>' "$dest" 2>/dev/null)

# The version file the adopter writes. Its format is the skeleton's own, with the placeholders
# filled the way step 3 fills every other file.
if [ -f "$dest/.template-version" ]; then
  sed -i "s/<VERSION>/$(git describe --tags --abbrev=0 2>/dev/null || echo v0.0.0)/; \
          s/<SHA>/$(git log -1 --format=%h -- skeleton/)/; s/<DATE>/$(date +%F)/" \
      "$dest/.template-version"
fi

# Step 3b — the blanks a human answers, marked <<FILL: ...>>. An adopter writes real sentences
# here; this stands in for that, because what is being tested is that step 3 leaves nothing
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
  && ok "step 3b had $pre_fill files to answer" \
  || bad "no <<FILL>> markers shipped — step 3b tests nothing and check.sh's blank check is inert"

post_fill=$(marked | wc -l)
[ "$post_fill" -eq 0 ] \
  && ok "no install blank left unanswered" \
  || bad "$post_fill files still carry <<FILL>> — a marker step 3's grep does not reach"

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

left=$(grep -rlI --exclude-dir=.git '<PROJECT_NAME>' "$dest" 2>/dev/null \
       | grep -v '_TEMPLATE\.md$' | wc -l)
[ "$left" -eq 0 ] \
  && ok "no <PROJECT_NAME> left outside the _TEMPLATE.md files" \
  || bad "$left installed files still say <PROJECT_NAME> after step 3"

say "Result"
[ "$fail" -eq 0 ] && echo "  pass" || echo "  FAIL — an adopter following the instructions gets the above"
exit "$fail"
