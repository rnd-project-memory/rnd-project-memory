# 2026-08-26 · What the green-start experiments returned

- **Status:** closed
- **Configuration:** Solo
- **Participants:** author — claude-opus-5 · high effort; esdevop (human) — ran both arms
- **Signed off:** no
- **Tags:** `#template` `#adoption`

---

## Objective

Read the results of the two green-start experiments — a fresh assistant installing the template
from the public repository, and the same install performed by a person unassisted — against what
was fixed in advance, and record them.

## Reasoning

Two records rather than one, because the arms answer different questions and only the first has a
hypothesis. `EXP-2026-08-26-green-start-assisted` tests whether an assistant stops where it lacks
information; `EXP-2026-08-26-green-start-manual` measures whether the manual path completes and
what it costs.

**The assisted arm held where it was aimed and failed where nobody was looking.** The three
sections the paragraph deliberately underdetermined — data environment, success criteria, scope —
were written as explicit absences with pointers into three new `OPEN_QUESTIONS.md` entries. No
invented facts, no operator input, zero questions asked. The install completed, `check.sh` clean.

Then every one of those three entries was stamped `Owner: esdevop@gmail.com`, thirteen lines below
a bold rule in the same file saying `Owner:` takes a human name and is *deliberately not* the git
address. That is the whole result in one line, and the mechanism is worth more than the miss: the
field carries **two rules and no third exit** — always filled in, and not an address — and nothing
says *ask*. Between "must not be blank" and "this value is wrong", it took the forbidden value.

The design's own failure mode, in miniature, in the one slot where it had no escape. Prose gave it
an escape and it used it — *"Not yet stated crisply. See `Q-success-criteria`"* is exactly the
sentence the template asks for. A structured field gave it none.

**Two markers were answered leaving their closing bracket**, in `AGENTS.md` and `INDEX.md` — the
two files loaded into every session — and `check.sh` said `ok`. That check was anchored to
`^<<FILL:` this morning to clear nine false positives in this repository. **The anchoring traded a
false positive for a false negative and the trade came due the same day.** Both misses are on
multi-line markers, where the delimiters are not on the line the text is.

**The manual arm produced the number `Q-who-keeps-the-history` has been carrying an assertion in
place of all day: 12:11.** Unassisted, from the online documentation, by an operator who had failed
the same task once under `v2.4.0` and had never used `install.sh`. A lower bound, and the endpoint
is *installed*, not *ready to work* — seven blanks remain.

The four costs in that log are all documentation defects, none irreducible work. The sharpest
produced a wrong artefact silently: the guide's example is
`./install.sh ../my-project my-project you@example.org`, where the same string is both the
destination path and the project name, so the two read as one thing. The operator supplied the
folder name and got `# churn-signals` where the assisted arm got `# Churn Signals`. **The
assistant beat the person at precisely the parameter whose documentation is ambiguous** — it read
the title from the description, the person read it from the folder — and nothing checks it either
way.

**Neither arm produced a `README.md`,** and only the person noticed. Locating why took a search
through three documents and an inference from a sentence about a different file.

## Decisions

- **Both records written, both `Verified by: self`**, with the verification noting that the
  assisted session's own closing summary claimed it filled the blanks "strictly from what you gave
  me" — true of the prose, false of `Owner:`, and absent from its summary. Reading the artefact
  rather than the report is what separated them.
- **The `docs/problem.md` opening sentence is recorded as a judgement call, not ruled on.** It is
  derivable from the premise and asserts nothing checkable, so it reads as a near miss; a stricter
  bar fails it. The bar is the project owner's to set and the examiner wrote the rule.
- **Nothing fixed in this session.** Five findings are named in the two records; acting on them is
  the next session's work, so that what the experiment found and what was done about it are
  separable later.

## Found along the way

- **The warning re-aimed the previous evening worked on its first real reader.** The session cloned
  the template directly into the target, then reversed on reading the guide and re-did the install
  through `install.sh`. That paragraph was rewritten hours earlier because the button it described
  had been switched off.
- **A fix that removes a false positive can install a false negative in the same stroke**, and the
  second is the more expensive: the first is loud and annoying, the second is silent and looks
  like success.
- **The same-family caveat applies and should not be waved through.** `CONFIGURATIONS.md` rates a
  model of the same family as the author *weak* evidence. The documentation was written by an
  assistant; the assisted arm was run by one of the same family. A different provider costs
  nothing extra and moves the result a rung up the ladder.

## Next

- The five findings, in one session: `Owner:`'s third exit plus a check on `@`; a marker whose
  closing token cannot be half-removed; `install.sh`'s second argument, its name and its example;
  the missing project `README.md`; and the three-places problem.
- A second assisted arm on a different provider, if one is available.
