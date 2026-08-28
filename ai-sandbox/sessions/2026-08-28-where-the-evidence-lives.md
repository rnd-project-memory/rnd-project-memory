# 2026-08-28 · Where the green-start evidence lives, and what was in it

- **Status:** closed
- **Configuration:** Solo
- **Participants:** author — claude-opus-5 · high effort
- **Signed off:** no
- **Tags:** `#template` `#adoption` `#secrets`

---

## Objective

Meet the rule that a cited file is in the repository, for five experiment records that cite a
working directory outside it.

## Reasoning

The question was housekeeping — copy the artefacts in? — and the answer turned out to be no, on a
constraint rather than on taste.

**The raw evidence carries employer-identifying strings.** A work email domain appears three times
in one log and as `user.email` in one working tree's `.git/config`; a work account name appears
thirty-seven times across four logs. `docs/constraints.md` binds this public repository against
that, *including in history* (`ADR-005`), and a public history is not undone by deleting a file.

**The guard that exists is the wrong shape for it.** `.githooks/pre-commit` matches credential
*values* — AWS keys, private keys, provider tokens — and `patterns.profile` says in as many words
that a pattern must match a value and not the name of one, because a check firing on documentation
about passwords is answered with `--no-verify` and is then dead while still looking installed.
An address on a corporate domain is an identifier, not a credential. It would have gone straight
through.

So the constraint was met by someone looking, and that is worth stating plainly rather than
recording a near miss as a success. Whether it should be mechanised is a separate question and not
obviously yes: a pattern for one employer's domain protects one project, and a general one for
email addresses would fire on every register entry that names a person.

**What is in the repository instead** is the summary §8 already anticipates for this case —
*"reproducible without the raw, possibly gitignored, data behind it."* Each arm's version, model,
interface, cost and both pre-registered outcomes, plus the sha256 of every raw file, so a reader
holding the raw evidence can confirm it is what the records cite and a reader without it still has
the outcomes. The records themselves are immutable, so the reason they point outward is stated
once beside the evidence, as `CONFIGURATIONS.md` does for `ADR-007`'s basis.

The seven installed trees are not summarised beyond that: each is about 400 KB of near-unmodified
skeleton, reconstructible from its own `.template-version`, and the five files that actually differ
are already quoted in the records.

## Decisions

- **`green-start-arms__20260828T003043Z.json` written** to `ai-sandbox/results/`, seven arms.
- **The reason lives in `results/README.md`**, not in the immutable records.
- **`Q-oss-intake` raised 🟢 → 🟡.** Run 2 was performed on a work machine under a work git
  identity against this public repository. Nothing employer-identifying entered the repository, and
  the question is unchanged in substance — but it now describes something that has happened rather
  than something that might, and it is still not answerable from inside here.

## Found along the way

- **A summary is not a consolation prize here.** Writing one forced every arm onto a single table
  with the same fields, which is how the retrospective classification of the three earlier arms
  became visible as weaker than the three pre-registered ones. That distinction is now marked per
  row rather than living in whoever remembers it.

## Next

- The six green-start findings.
