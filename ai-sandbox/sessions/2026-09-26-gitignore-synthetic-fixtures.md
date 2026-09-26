# 2026-09-26 · Narrow synthetic CSV fixture convention

- **Status:** closed
- **Configuration:** Solo
- **Participants:** author — current coding agent; no independent reviewer
- **Signed off:** no

## Objective

Address upstream issue #1 before the next template release without removing the global raw-CSV
safety backstop. Define a narrow, reviewable convention for synthetic CSV test fixtures and make
Git ignore, the pre-commit hook, and advisory checks agree.

## Reasoning

The issue identifies a real usability problem: global `*.csv` protection also hides legitimate
synthetic fixtures, encouraging `git add -f`. Removing the global rule would weaken raw-data
protection. The safer design is to keep the global ignore and allow only files named
`*.synthetic.csv` under `tests/fixtures/`, with an adjacent `*.synthetic.md` declaration that
contains `synthetic: true`. The blocking hook allows only that form and rejects every other staged
CSV. `check.sh` reports tracked violations without pretending it can prove that data is synthetic.

## Decisions

- Keep `*.csv` globally ignored.
- Re-include only `tests/fixtures/**/*.synthetic.csv`.
- Require an adjacent staged/committed `*.synthetic.md` declaration containing `synthetic: true`.
- Keep raw CSV, extracted CSV, and arbitrary forced-added CSV blocked by the hook.
- Document that the declaration is a review/provenance assertion, not an automated privacy proof.

## Found along the way

The change belongs in the upstream mechanism surfaces: `gitignore.template`, `.githooks/pre-commit`,
and `check.sh`, with matching self-hosted root copies and bootstrap coverage. It is a release
behavior change and will be included in the planned MINOR release rather than changing the version
mid-worktree.

## Next

Implemented the convention, regenerated mechanism hashes, and validated it with the bootstrap gate:
normal declared synthetic fixtures commit, while force-added unapproved CSV is blocked. The global
CSV safety rule remains in place. `check.sh`, shell syntax, and `git diff --check` passed; its
output retains only pre-existing advisory notices. No commit was made; issue closure and release
notes remain for user review.
