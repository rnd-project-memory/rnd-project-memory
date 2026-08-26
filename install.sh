#!/usr/bin/env bash
# Installs skeleton/ into a project repository, performing the mechanical steps of
# skeleton/README.md and only those.
#
# The boundary is deliberate and is the whole point of the file: everything here is a
# transformation with one correct answer, derivable from the arguments and the tree. Everything
# requiring a person — what the project is, who it is for, what a thread should be called — is
# reported at the end and left undone. A script that guessed at those would produce a repository
# that reads as finished and describes a project nobody has.
#
# It is also what the install guide points at rather than restates. Before this existed, step 3
# was written twice — as a pipeline in skeleton/README.md and as a loop in bootstrap-test.sh —
# and changing the step meant editing both by hand.
#
# Usage:  ./install.sh <destination> <project-name> [user-email] [first-thread-slug]
#
# norcopy: belongs to the template repository. Never copied into an adopting project.

set -u

die() { printf '\033[1minstall.sh:\033[0m %s\n' "$1" >&2; exit 1; }
say() { printf '\n\033[1m%s\033[0m\n' "$1"; }
did() { printf '  ok    %s\n' "$1"; }
left(){ printf '  todo  %s\n' "$1"; }

dest=${1:-}
name=${2:-}
mail=${3:-}
slug=${4:-}

[ -n "$dest" ] && [ -n "$name" ] || die "usage: ./install.sh <destination> <project-name> [user-email] [first-thread-slug]"

src=$(git rev-parse --show-toplevel 2>/dev/null) || die "run this from a clone of the template repository"
[ -d "$src/skeleton" ] || die "no skeleton/ in $src — this is not the template repository"

mkdir -p "$dest" || die "cannot create $dest"
dest=$(cd "$dest" && pwd)
[ "$dest" != "$src" ] || die "destination is the template repository itself"

# The release being installed. Recorded in .template-version, which is the only thing that lets an
# upgrade later know what it is upgrading from — so a wrong value here is not a cosmetic defect,
# it is a project that can never be upgraded correctly.
#
# Both facts come from the clone's history, and a shallow clone has neither. `git clone --depth 1`
# fetches no tags at all, so `git describe` finds nothing, and the path-limited log returns the one
# commit it has rather than the commit skeleton/ last changed. Neither failure announces itself:
# the first draft fell back to "v0.0.0-untagged" and reported it as ok, which is the shape this
# whole system exists to refuse — a plausible answer where the honest one is "I cannot tell".
# Refused before anything is copied, so the destination is left untouched.
if [ "$(cd "$src" && git rev-parse --is-shallow-repository 2>/dev/null)" = "true" ]; then
  die "this is a shallow clone, so its history cannot say which release it holds.
       Fix:  git -C $src fetch --unshallow --tags"
fi
version=$(cd "$src" && git describe --tags --abbrev=0 2>/dev/null) || version=""
[ -n "$version" ] || die "this clone has no tags, so nothing can say which release it holds, and
       .template-version would record a version that does not exist.
       Fix:  git -C $src fetch --tags"
sha=$(cd "$src" && git log -1 --format=%h -- skeleton/ 2>/dev/null)
[ -n "$sha" ] || die "cannot find the commit skeleton/ was last changed at in this clone"
today=$(date +%F)

say "Installing $version into $dest"

# ─── Step 1 — the copy set: the directory's contents, except its own README ───
cp -r "$src/skeleton/." "$dest"/ || die "copy failed"
rm -f "$dest/README.md"
did "copied skeleton/ contents (README.md is the install guide, not part of the system)"

# ─── Step 2 — the rename, then this clone's settings ──────────────────────────
[ -f "$dest/gitignore.template" ] && mv "$dest/gitignore.template" "$dest/.gitignore"
did "gitignore.template renamed to .gitignore"

if [ ! -d "$dest/.git" ]; then
  git -C "$dest" init -q . || die "git init failed"
  did "git init (the destination was not a repository)"
fi

git -C "$dest" config core.hooksPath .githooks
did "core.hooksPath=.githooks — the secret scan runs in this clone"

# Never inferred. RULES.md makes an empty user.email a stop, not a value to guess: an address
# taken from commit history or from another file names the wrong person in every Held by: written
# afterwards, and nothing later distinguishes that from a correct one.
if [ -n "$mail" ]; then
  git -C "$dest" config user.email "$mail"
  did "user.email=$mail"
elif [ -n "$(git -C "$dest" config user.email 2>/dev/null)" ]; then
  did "user.email=$(git -C "$dest" config user.email) — already set, left alone"
else
  mail=""
fi

# ─── Step 3a — the mechanical tokens ─────────────────────────────────────────
# _TEMPLATE.md files are copied per entry rather than filled in place, so they keep theirs.
n=0
while IFS= read -r f; do
  case "$(basename "$f")" in _TEMPLATE.md) continue;; esac
  sed -i "s/<PROJECT_NAME>/$name/g; s/<DATE>/$today/g" "$f"
  n=$((n+1))
done < <(grep -rlI --exclude-dir=.git -e '<PROJECT_NAME>' -e '<DATE>' "$dest" 2>/dev/null)
did "$n files had <PROJECT_NAME> and <DATE> substituted"

if [ -f "$dest/.template-version" ]; then
  sed -i "s/<VERSION>/$version/; s/<SHA>/$sha/; s/<DATE>/$today/" "$dest/.template-version"
  did ".template-version records $version, skeleton @ $sha, applied $today"
fi

# ─── Step 4 — the first thread, only when one is named ───────────────────────
# The slug is a judgement — it names what the work is about — so the install performs this step
# only when told the answer, and leaves it otherwise. Held by: comes from the clone's identity and
# from nowhere else; without one the rename is refused rather than done with a placeholder holder,
# because a checkpoint naming nobody reads as unattended and is a thread anyone may take over.
cp="$dest/ai-sandbox/CHECKPOINT-thread.md"
if [ -n "$slug" ] && [ -f "$cp" ]; then
  held=$(git -C "$dest" config user.email 2>/dev/null)
  if [ -z "$held" ]; then
    printf '  todo  thread "%s" not opened: no user.email in this clone, and Held by: is never\n' "$slug"
    printf '        inferred. Set it, then rename ai-sandbox/CHECKPOINT-thread.md by hand.\n'
  else
    sed -i "s/<thread>/$slug/g; s|<your \`git config user.email\`>|$held|" "$cp"
    mv "$cp" "$dest/ai-sandbox/CHECKPOINT-$slug.md"
    did "thread opened: ai-sandbox/CHECKPOINT-$slug.md, held by $held"
  fi
fi

say "Left for you — this script does none of it on purpose"

# ─── Step 3b — the blanks only a person can answer ───────────────────────────
# check.sh is excluded because it names the marker in order to count it, and _TEMPLATE.md files
# because they are copied per entry rather than filled in place. Both exclusions are the same ones
# check.sh applies to itself; a marker that names itself catches every tool that looks for it.
fill=$(grep -rlI --exclude-dir=.git --exclude=check.sh -- '<<FILL' "$dest" 2>/dev/null \
       | grep -v '_TEMPLATE\.md$')
if [ -n "$fill" ]; then
  c=$(echo "$fill" | while IFS= read -r f; do grep -c '<<FILL' "$f"; done \
      | awk '{t+=$1} END {print t+0}')
  left "$c blanks marked <<FILL: …>>. Answer each and delete the marker:"
  echo "$fill" | sed "s|^$dest/|          |"
  echo "        AGENTS.md and ai-sandbox/INDEX.md load into every session, so a marker left in"
  echo "        either is read as instruction. check.sh counts what is left."
fi

[ -z "$mail" ] && left "git -C $dest config user.email \"you@example.org\" — never inferred; it is what Held by: takes"

[ -f "$dest/ai-sandbox/CHECKPOINT-thread.md" ] \
  && left "name your first thread: rerun with a fourth argument, or rename ai-sandbox/CHECKPOINT-thread.md by hand and set Held by:"
left "delete sources/ and src/ if the project already keeps those somewhere, under any name"
left "verify instruction loading in a fresh assistant session — it cannot be checked from"
echo "        inside the session that wrote AGENTS.md, which is why no script does it"
left "on a project already underway, read RND_PROJECT_MEMORY.md §11 before going further"
echo
echo "        Each of these is skeleton/README.md, \"What it leaves for you\", with the reason."

say "Then"
echo "  cd $dest && ./check.sh        # advisory, always exits 0"
echo
