#!/usr/bin/env bash
# Advisory checks for the project memory system.
# ALWAYS exits 0. Output is for a human to judge — never a gate.
# The blocking check (secrets) lives in .githooks/pre-commit, deliberately separate:
# a noisy check sharing an exit code with an irreversible one gets disabled.

cd "$(git rev-parse --show-toplevel 2>/dev/null || echo .)" || exit 0
SB=ai-sandbox
n() { printf '\n\033[1m%s\033[0m\n' "$1"; }

n "Checkpoint size (limit 150)"
for f in "$SB"/CHECKPOINT-*.md; do
  [ -e "$f" ] || continue
  l=$(wc -l < "$f")
  [ "$l" -gt 150 ] && echo "  OVER  $f: $l lines — promote something, do not compress" \
                   || echo "  ok    $f: $l"
done

n "Dangling citations"
for id in $(grep -rhoE '\[S-[a-z0-9-]+' docs/ "$SB" 2>/dev/null | tr -d '[' | sort -u); do
  grep -q "^## $id " "$SB/SOURCES.md" 2>/dev/null || echo "  $id cited but not in SOURCES.md"
done
for id in $(grep -rhoE 'EXP-[0-9]{4}-[0-9]{2}-[0-9]{2}-[a-z0-9-]+' docs/ 2>/dev/null | sort -u); do
  ls "$SB"/experiments/"$id".md >/dev/null 2>&1 || echo "  $id cited but no record file"
done

n "Registers: resolved entries should be deleted, not marked"
grep -rn 'Resolved\|RESOLVED\|~~' "$SB"/OPEN_QUESTIONS.md "$SB"/ASSUMPTIONS.md 2>/dev/null \
  | sed 's/^/  /' || echo "  clean"

n "Session files without a LOG.md row"
for f in "$SB"/sessions/*.md; do
  b=$(basename "$f"); case "$b" in LOG.md|_TEMPLATE.md) continue;; esac
  grep -q "$b" "$SB/sessions/LOG.md" 2>/dev/null || echo "  $b missing from LOG.md"
done

n "Sessions left open"
grep -ln 'Status:.*open' "$SB"/sessions/*.md 2>/dev/null \
  | sed 's/^/  still open (freeze as abandoned if interrupted): /' || echo "  none"

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
