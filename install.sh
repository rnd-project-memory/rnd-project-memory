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

say "Preparing $version for $dest"

# Build the transformed candidate outside the destination. Existing projects are not safe to
# update by copying over them: cp -r silently replaces files and the old installer even removed
# an adopter's README.md. The candidate lets us compare first and keep the destination untouched
# when a human merge is needed.
tmp=$(mktemp -d "${TMPDIR:-/tmp}/rnd-project-memory-install.XXXXXX") || die "cannot create a temporary install tree"
trap 'rm -rf "$tmp"' EXIT
candidate="$tmp/tree"
mkdir -p "$candidate" || die "cannot create the temporary install tree"
cp -a "$src/skeleton/." "$candidate/" || die "copy failed"
rm -f "$candidate/README.md"

# The candidate is now the install's complete copy set. Apply the mechanical transformations to it,
# never to the adopter's files.
[ -f "$candidate/gitignore.template" ] && mv "$candidate/gitignore.template" "$candidate/.gitignore"

name_sed=$(printf '%s' "$name" | sed 's/[&|]/\\&/g')
date_sed=$(printf '%s' "$today" | sed 's/[&|]/\\&/g')
version_sed=$(printf '%s' "$version" | sed 's/[&|]/\\&/g')
sha_sed=$(printf '%s' "$sha" | sed 's/[&|]/\\&/g')

# _TEMPLATE.md files are copied per entry rather than filled in place, so they keep theirs.
n=0
while IFS= read -r f; do
  case "$(basename "$f")" in _TEMPLATE.md) continue;; esac
  sed -i "s|<PROJECT_NAME>|$name_sed|g; s|<DATE>|$date_sed|g" "$f"
  n=$((n+1))
done < <(grep -rlI --exclude-dir=.git -e '<PROJECT_NAME>' -e '<DATE>' "$candidate" 2>/dev/null)

if [ -f "$candidate/.template-version" ]; then
  sed -i "s|<VERSION>|$version_sed|; s|<SHA>|$sha_sed|; s|<DATE>|$date_sed|" "$candidate/.template-version"
fi

# Resolve the identity without changing the destination. A supplied value wins; otherwise an
# existing repository identity is retained. An empty value remains an explicit human follow-up.
existing_mail=$(git -C "$dest" config user.email 2>/dev/null || true)
effective_mail=$mail
[ -n "$effective_mail" ] || effective_mail=$existing_mail

# ─── Step 4 — the first thread, only when one is named ───────────────────────
# The slug is a judgement — it names what the work is about — so the install performs this step
# only when told the answer, and leaves it undone otherwise. Held by: comes from the clone's
# identity and from nowhere else; without one the rename is refused rather than done with a
# placeholder holder, because a checkpoint naming nobody reads as unattended and an unattended
# thread is one anyone may take over.
cp="$candidate/ai-sandbox/CHECKPOINT-thread.md"
if [ -n "$slug" ] && [ -f "$cp" ]; then
  if [ -z "$effective_mail" ]; then
    printf '  todo  thread "%s" not opened: no user.email in this clone, and Held by: is never\n' "$slug"
    printf '        inferred. Set it, then rename ai-sandbox/CHECKPOINT-thread.md by hand.\n'
  else
    slug_sed=$(printf '%s' "$slug" | sed 's/[&|]/\\&/g')
    mail_sed=$(printf '%s' "$effective_mail" | sed 's/[&|]/\\&/g')
    sed -i "s|<thread>|$slug_sed|g; s|<your \`git config user.email\`>|$mail_sed|" "$cp"
    mv "$cp" "$candidate/ai-sandbox/CHECKPOINT-$slug.md"
  fi
fi

# ─── Step 5 — preflight existing paths and show safe diffs ───────────────────
# git diff --no-index compares files even though the template and destination are separate Git
# repositories. It returns 1 for a real difference, so only exit codes >1 are errors here.
dest_repo=0
git -C "$dest" rev-parse --is-inside-work-tree >/dev/null 2>&1 && dest_repo=1
collisions=0
unchanged=0
new_files=0

tracked_state() {
  if [ "$dest_repo" -eq 1 ] && git -C "$dest" ls-files --error-unmatch -- "$1" >/dev/null 2>&1; then
    printf 'tracked'
  else
    printf 'untracked'
  fi
}

report_collision() {
  rel=$1
  target=$2
  incoming=$3
  reason=$4
  collisions=$((collisions + 1))
  printf '\n  COLLISION [%s] %s (%s)\n' "$(tracked_state "$rel")" "$rel" "$reason"
  if [ -f "$target" ] && [ -f "$incoming" ]; then
    diff_rc=0
    git --no-pager diff --no-index --unified=3 -- "$target" "$incoming" || diff_rc=$?
    [ "$diff_rc" -le 1 ] || die "git diff failed while comparing $rel"
  else
    printf '        existing: %s\n        incoming:  %s\n' "$target" "$incoming"
  fi
}

# A pre-existing gitignore.template would be left beside the newly installed .gitignore. Treat
# that rename ambiguity as a collision instead of silently creating two competing ignore files.
if [ -e "$dest/gitignore.template" ] || [ -L "$dest/gitignore.template" ]; then
  if [ ! -e "$dest/.gitignore" ] && [ ! -L "$dest/.gitignore" ]; then
    report_collision "gitignore.template" "$dest/gitignore.template" "$candidate/.gitignore" \
      "the install rename would leave two ignore-file conventions"
  fi
fi

has_symlink_parent() {
  rel=$1
  current=$dest
  IFS='/' read -r -a parts <<< "$rel"
  last=$((${#parts[@]} - 1))
  for ((i=0; i<last; i++)); do
    current="$current/${parts[i]}"
    [ -L "$current" ] && return 0
  done
  return 1
}

while IFS= read -r -d '' incoming; do
  rel=${incoming#"$candidate/"}
  target="$dest/$rel"
  if has_symlink_parent "$rel"; then
    report_collision "$rel" "$target" "$incoming" "an existing parent is a symlink"
  elif [ -e "$target" ] || [ -L "$target" ]; then
    if [ -f "$target" ] && [ -f "$incoming" ]; then
      diff_rc=0
      git --no-pager diff --no-index --quiet -- "$target" "$incoming" >/dev/null 2>&1 || diff_rc=$?
      if [ "$diff_rc" -eq 0 ]; then
        unchanged=$((unchanged + 1))
      elif [ "$diff_rc" -eq 1 ]; then
        report_collision "$rel" "$target" "$incoming" "different file content"
      else
        die "git diff failed while checking $rel"
      fi
    else
      report_collision "$rel" "$target" "$incoming" "different file type"
    fi
  else
    new_files=$((new_files + 1))
  fi
done < <(find "$candidate" -type f -print0)

if [ "$collisions" -gt 0 ]; then
  printf '\ninstall.sh: %s collision(s); no project files or Git settings were changed.\n' "$collisions" >&2
  printf 'Resolve or merge the displayed files, then rerun the installer.\n' >&2
  exit 2
fi

# Install only paths proven absent. Matching files are deliberately not copied again.
while IFS= read -r -d '' dir; do
  rel=${dir#"$candidate/"}
  [ "$rel" = "$dir" ] && continue
  mkdir -p "$dest/$rel" || die "cannot create $dest/$rel"
done < <(find "$candidate" -type d -print0)
while IFS= read -r -d '' incoming; do
  rel=${incoming#"$candidate/"}
  target="$dest/$rel"
  if [ ! -e "$target" ] && [ ! -L "$target" ]; then
    cp -a "$incoming" "$target" || die "copy failed for $rel"
  fi
done < <(find "$candidate" -type f -print0)
did "installed $new_files new files; preserved $unchanged identical existing files"

if [ -f "$dest/.gitignore" ]; then
  did "gitignore.template renamed to .gitignore"
fi

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

# ─── Step 3a — report the mechanical substitutions ───────────────────────────
did "$n files had <PROJECT_NAME> and <DATE> substituted"
if [ -f "$dest/.template-version" ]; then
  did ".template-version records $version, skeleton @ $sha, applied $today"
fi
if [ -n "$slug" ] && [ -f "$dest/ai-sandbox/CHECKPOINT-$slug.md" ]; then
  did "thread opened: ai-sandbox/CHECKPOINT-$slug.md, held by ${effective_mail:-unassigned}"
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
