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
  drift=$(sha256sum -c --quiet .template-hashes 2>&1)
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

n "Checkpoint size (limit 150)"
for f in "$SB"/CHECKPOINT-*.md; do
  [ -e "$f" ] || continue
  l=$(wc -l < "$f")
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
# Same exclusion: each register's own preamble explains that `Resolved` must never be used.
hits=$(grep -rn 'Resolved\|RESOLVED\|~~' "$SB"/OPEN_QUESTIONS.md "$SB"/ASSUMPTIONS.md 2>/dev/null \
       | grep -vE ':[0-9]+:[[:space:]]*>')
if [ -n "$hits" ]; then echo "$hits" | sed 's/^/  /'; else echo "  clean"; fi

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
  | grep -vE '[0-9]{4}-[0-9]{2}-[0-9]{2}|S-[a-z]|EXP-' | head -10 | sed 's/^/  /' || echo "  none"

printf '\n\033[2madvisory only — nothing here blocks a commit\033[0m\n'
exit 0
