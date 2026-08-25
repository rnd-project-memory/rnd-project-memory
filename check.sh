#!/usr/bin/env bash
# Advisory checks for the project memory system.
# ALWAYS exits 0. Output is for a human to judge — never a gate.
# The blocking check (secrets) lives in .githooks/pre-commit, deliberately separate:
# a noisy check sharing an exit code with an irreversible one gets disabled.

cd "$(git rev-parse --show-toplevel 2>/dev/null || echo .)" || exit 0
SB=ai-sandbox
n() { printf '\n\033[1m%s\033[0m\n' "$1"; }

n "Mechanism files against their released hashes"
# .template-hashes ships with each release and lists every file upstream owns. Comparing
# against it needs no network and no copy of the template — which is the whole point of
# vendoring. A difference is not an error: it means an upgrade is about to discard someone's
# edit, and that is worth a person's attention *before* the upgrade rather than after.
if [ -f .template-hashes ]; then
  # stderr carries only a summary line that repeats what the FAILED lines already say, and
  # noise is what gets a check ignored. stdout alone reports both a changed file and a missing one.
  drift=$(sha256sum -c --quiet .template-hashes 2>/dev/null)
  if [ -z "$drift" ]; then
    echo "  ok    all match $(awk '{print $1}' .template-version 2>/dev/null)"
  else
    echo "$drift" | sed 's/^/  /'
    echo "  ↑ upstream owns these. An upgrade replaces them wholesale and the edit is lost."
    echo "    Move it to AGENTS.md, propose it upstream, or revert it."
  fi
else
  echo "  none  no .template-hashes — adopted before this check existed, or not from a release"
fi

n "Retired vocabulary"
# Each MAJOR retires a small vocabulary — already named in that release's MIGRATIONS.md Reason
# section (see its "Cutting a release" step on updating this list). A rename this size lands in
# the mechanism files by construction; it strays into playbook prose and scaffold tables by hand,
# and the hash check above cannot see that — a project that dogfoods itself (skeleton/ and
# ai-sandbox/ both) can drift both copies the same wrong way, and they still hash-match each
# other. Exclusions are exactly MIGRATIONS.md's own Exceptions: session and experiment records
# are immutable, ADRs are historical, and MIGRATIONS.md documents the old name on purpose.
RETIRED=(
  'CHECKPOINT-<owner>'
  'one per person'
  'per-owner'
)
RE=$(IFS='|'; echo "${RETIRED[*]}")
hits=$(grep -rlIE \
         --exclude-dir=.git --exclude-dir=sessions --exclude-dir=experiments \
         --exclude-dir=decisions --exclude=MIGRATIONS.md --exclude=check.sh \
         -- "$RE" . 2>/dev/null)
if [ -n "$hits" ]; then echo "$hits" | sed 's/^/  /'; else echo "  clean"; fi

# Only meaningful where this repository carries both its own skeleton/ artefact and a
# .template-version for itself — the self-hosting case from ADR-006. An ordinary consumer never
# has a local skeleton/ directory (README.md's step 1 copies the directory's *contents* out, not
# the directory), so the whole section is skipped there rather than printing an empty heading.
if [ -d skeleton ] && [ -f .template-version ]; then
  n "skeleton/ vs .template-version"
  recorded=$(grep -oE 'skeleton @ [0-9a-f]+' .template-version | awk '{print $NF}')
  actual=$(git log -1 --format=%h -- skeleton/ 2>/dev/null)
  if [ -n "$recorded" ] && [ -n "$actual" ]; then
    recorded_full=$(git rev-parse "$recorded" 2>/dev/null)
    actual_full=$(git rev-parse "$actual" 2>/dev/null)
    if [ -n "$recorded_full" ] && [ "$recorded_full" = "$actual_full" ]; then
      echo "  ok    .template-version matches skeleton/'s last commit ($recorded)"
    else
      echo "  DRIFT .template-version says skeleton @ $recorded, but skeleton/ last changed at"
      echo "        $actual ($(git log -1 --format=%s -- skeleton/ 2>/dev/null))"
      echo "        expected mid-session while skeleton/ is being edited; if this is settled"
      echo "        work, .template-version needs bumping to match"
    fi
  fi
fi

n ".gitignore upstream block"
# The project's own patterns live above the UPSTREAM BLOCK marker and survive an upgrade;
# everything from the marker down is upstream's and is replaced wholesale. Without the marker the
# two are indistinguishable, so an upgrade cannot preserve the project's half — and what those
# lines were protecting quietly stops being ignored. Advisory, not required: a project that
# adopted before the marker existed still works exactly as it did.
MARK='^# ─── UPSTREAM BLOCK'
if [ ! -f .gitignore ]; then
  echo "  none  no .gitignore"
elif grep -qE "$MARK" .gitignore; then
  at=$(grep -nE "$MARK" .gitignore | head -1 | cut -d: -f1)
  mine=$(head -n "$((at - 1))" .gitignore | grep -cvE '^[[:space:]]*(#|$)')
  echo "  ok    marker at line $at; $mine of your own patterns above it survive an upgrade"
else
  echo "  none  no UPSTREAM BLOCK marker — your patterns and upstream's are indistinguishable,"
  echo "        so the next upgrade cannot preserve yours. Add the marker above upstream's block."
fi

n "Credential patterns (profile layer)"
# The hook ships with a core list and reads additions from this file. It is not in the hash list
# by design — see MANIFEST's criterion — so nothing else would notice its absence.
if [ -f .githooks/patterns.profile ]; then
  c=$(grep -cvE '^[[:space:]]*(#|$)' .githooks/patterns.profile 2>/dev/null)
  echo "  ok    .githooks/patterns.profile: $c pattern(s) beyond the core"
else
  echo "  none  .githooks/patterns.profile is missing — it ships with the template, so it was"
  echo "        deleted. The hook runs its core patterns and says nothing about the absence."
fi

n "Checkpoint size (limit 150)"
for f in "$SB"/CHECKPOINT-*.md; do
  [ -e "$f" ] || continue
  l=$(wc -l < "$f")
  # §11's intake step exempts this file and says outright that it may exceed the cap.
  # Reporting it as OVER would tell the adopter to promote — the one thing that step forbids
  # during bootstrap. What is worth watching on this file is its dismantling date instead: an
  # intake still full after that date is the signal that bootstrapping never finished.
  if [ "$(basename "$f")" = "CHECKPOINT-intake.md" ]; then
    d=$(grep -m1 -iE 'dismantl' "$f" | grep -oE '[0-9]{4}-[0-9]{2}-[0-9]{2}')
    if [ -z "$d" ]; then
      echo "  ?     $f: $l lines, exempt from the cap — but carries no dismantling date"
    elif [ "$(date -d "$d" +%s 2>/dev/null || echo 0)" -lt "$(date +%s)" ]; then
      echo "  PAST  $f: dismantling date $d has passed and $l lines remain —"
      echo "        bootstrapping never finished; this is the highest-priority item, not furniture"
    else
      echo "  ok    $f: $l lines, exempt from the cap; dismantle by $d"
    fi
    continue
  fi
  [ "$l" -gt 150 ] && echo "  OVER  $f: $l lines — promote something, do not compress" \
                   || echo "  ok    $f: $l"
done

n "Dangling citations"
# Blockquote preambles, <placeholder> examples and the playbooks all carry sample IDs.
# Those are instruction, not content: scanning them makes the template report itself.
skip_examples() { grep -vE '^[[:space:]]*[<>]'; }

for id in $(grep -rhE --exclude-dir=playbooks '\[S-[a-z0-9-]+' docs/ "$SB" 2>/dev/null \
            | skip_examples | grep -oE '\[S-[a-z0-9-]+' | tr -d '[' | sort -u); do
  grep -q "^## $id " "$SB/SOURCES.md" 2>/dev/null || echo "  $id cited but not in SOURCES.md"
done
for id in $(grep -rhE 'EXP-[0-9]{4}-[0-9]{2}-[0-9]{2}-[a-z0-9-]+' docs/ 2>/dev/null \
            | skip_examples | grep -oE 'EXP-[0-9]{4}-[0-9]{2}-[0-9]{2}-[a-z0-9-]+' | sort -u); do
  ls "$SB"/experiments/"$id".md >/dev/null 2>&1 || echo "  $id cited but no record file"
done

n "Registers: resolved entries should be deleted, not marked"
# Same exclusion: each register's own preamble explains that `Resolved` must never be used — and
# so does a sanctioned adoption note, which is written as a blockquote for exactly this reason.
# Matched lines are truncated: on a greenfield project an entry is a line, on the existing
# projects §11 is written for it is a paragraph, and six findings can bury the output in a screen
# of prose. The line number is what you act on; the rest is there to recognise the entry by.
hits=$(grep -rn 'Resolved\|RESOLVED\|~~' "$SB"/OPEN_QUESTIONS.md "$SB"/ASSUMPTIONS.md 2>/dev/null \
       | grep -vE ':[0-9]+:[[:space:]]*>' | cut -c1-160)
if [ -n "$hits" ]; then echo "$hits" | sed 's/^/  /'; else echo "  clean"; fi

n "Adoption notes"
# A note records a divergence a file inherited at adoption and could not close. It is a bootstrap
# artefact: notes belong to what the project brought with it, not to current work. Neither number
# is a finding on its own — a note whose closure is genuinely unavailable stays for years, and a
# recent adoption with several notes is exactly what §11 predicts. The pairing is the signal: notes
# on an adoption from long ago mean the device is being used to opt out of rules one at a time.
notes=$(grep -rlI --exclude-dir=.git -- '^> \*\*Adoption note\.\*\*' "$SB" docs 2>/dev/null)
ncount=$(printf '%s' "$notes" | grep -c .)
if [ "$ncount" -eq 0 ]; then
  echo "  none"
else
  echo "$notes" | sed 's/^/  /'
  adopted=$(grep -oE 'applied [0-9]{4}-[0-9]{2}-[0-9]{2}' .template-version 2>/dev/null | awk '{print $2}')
  if [ -n "$adopted" ]; then
    days=$(( ( $(date +%s) - $(date -d "$adopted" +%s 2>/dev/null || date +%s) ) / 86400 ))
    echo "  ↑ $ncount note(s); this version applied $adopted (${days}d ago). Notes are written at"
    echo "    adoption, never for current work — a new one long after is the finding."
  else
    echo "  ↑ $ncount note(s); no applied date in .template-version to weigh them against"
  fi
fi

n "Session files without a LOG.md row"
for f in "$SB"/sessions/*.md; do
  b=$(basename "$f"); case "$b" in LOG.md|_TEMPLATE.md) continue;; esac
  grep -q "$b" "$SB/sessions/LOG.md" 2>/dev/null || echo "  $b missing from LOG.md"
done

n "Sessions left open"
# _TEMPLATE.md ships with Status: open — it is the shape a new session is created from,
# not a session that was interrupted.
open=$(grep -ln 'Status:.*open' "$SB"/sessions/*.md 2>/dev/null | grep -v '_TEMPLATE\.md$')
if [ -n "$open" ]; then
  echo "$open" | sed 's/^/  still open (freeze as abandoned if interrupted): /'
else echo "  none"; fi

n "docs/ changed without CLAIMS.md"
if git diff --cached --name-only 2>/dev/null | grep -q '^docs/'; then
  git diff --cached --name-only | grep -q 'docs/CLAIMS.md' \
    || echo "  staged docs/ changes but CLAIMS.md untouched — is the index still true?"
else echo "  no staged docs/ changes"; fi

n "Tag frequencies (singletons are usually a second spelling)"
grep -ho '`#[a-z0-9-]*`' "$SB"/sessions/LOG.md "$SB"/experiments/LOG.md 2>/dev/null \
  | sort | uniq -c | sort -rn | sed 's/^/  /' || echo "  no tags yet"

n "Heuristic: numbers in docs/ with no nearby date (expect false positives)"
grep -rnE '[0-9]+(\.[0-9]+)?\s*(%|ms|GB|k)\b' docs/ 2>/dev/null \
  | grep -vE '[0-9]{4}-[0-9]{2}-[0-9]{2}|S-[a-z]|EXP-' | head -10 | cut -c1-160 \
  | sed 's/^/  /' || echo "  none"

n "Unverified experiments"
# P-112: a conclusion resting on one of these does not promote to docs/ until this changes.
found=0
for f in "$SB"/experiments/EXP-*.md; do
  [ -e "$f" ] || continue
  grep -q 'Verified by:.*not verified' "$f" || continue
  found=1
  d=$(grep -m1 -oE '\*\*Date:\*\* [0-9]{4}-[0-9]{2}-[0-9]{2}' "$f" | grep -oE '[0-9]{4}-[0-9]{2}-[0-9]{2}')
  if [ -n "$d" ] && age=$(( ( $(date +%s) - $(date -d "$d" +%s 2>/dev/null || echo 0) ) / 86400 )) 2>/dev/null; then
    echo "  $f: not verified, ${age}d"
  else
    echo "  $f: not verified"
  fi
done
[ "$found" -eq 0 ] && echo "  none"

n "Stale publications"
# Exclude the template's own field-vocabulary line ("current | stale — <if stale, ...>"): a
# placeholder enumerating the legal values is not a filled-in entry. Same failure family as the
# other checks' skip_examples — a check that scans the file finds the file's own instructions.
stale=""
[ -f "$SB/PUBLICATIONS.md" ] && stale=$(grep 'Status:.*stale' "$SB/PUBLICATIONS.md" | grep -v '<')
if [ -n "$stale" ]; then
  grep -B3 'Status:.*stale' "$SB/PUBLICATIONS.md" | grep -v '<' | grep -E '^## |Status:' | sed 's/^/  /'
else
  echo "  none"
fi

n "Field value distribution (P-130 — diagnostic only, no threshold)"
# A dictionary field that stays healthy shows a spread across its declared values. Values
# appended by hand beyond the dictionary mean the field is being asked two questions at once;
# one value dominating almost everything means it is asking the wrong one. Either way this is
# a prompt to look, not a failure.
if [ -f "$SB/CAVEATS.yaml" ]; then
  echo "  CAVEATS.yaml severity:"
  grep -oE '^\s*severity:\s*\S+' "$SB/CAVEATS.yaml" 2>/dev/null | awk '{print $2}' \
    | sort | uniq -c | sort -rn | sed 's/^/    /'
fi

printf '\n\033[2madvisory only — nothing here blocks a commit\033[0m\n'
exit 0
