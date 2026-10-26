# 2026-10-26 · Writing down how an attempt is reviewed

- **Status:** closed
- **Configuration:** Solo
- **Participants:** author — claude-opus-5-5
- **Signed off:** no
- **Tags:** `#adoption` `#template`

---

## Objective

The author observed that the reviewer re-ran the gates at each attempt's commit, and asked whether
that belongs in the reviewer's instructions. Write the review procedure as it was actually
performed in `IMP-2026-10-26-install-unreleased-label`.

## Reasoning

The playbook's review section had a single line, *re-run the gates against its `Commit:`*. The
dogfood reviews did more, and each addition caught something or would have:

| Practice | What it guards against | Before |
|---|---|---|
| a clean, separate checkout of exactly `Commit:` | a gate passing on uncommitted work under a commit that lacks it, which re-passes in the executor's tree | implied at most |
| re-run before reading the claimed values, then compare by shape where values legitimately vary | anchoring; fresh fixture shas misread as divergence (S-01, S-02) | first half only |
| the diff against `Produces:` and `Do not:` | work outside the step, which no gate tests | missing |
| ask whether each gate could fail | vacuous gates (G-03-2) | missing |
| notes checked against the re-run | a false note beside true gates (S-04) | added earlier today |
| package review: design-to-evidence table, plus direct checks of sections no gate covers | all steps accepted, design not delivered (§2.4) | missing |

Written into `execute-step.md` as eight steps plus a package subsection. Handbook §7's row and
`ADR-014` (new point 5a, still `proposed` and uncommitted) state the core. This changes a playbook,
not `RULES.md`. `bootstrap-test.sh` passes. Hashes were regenerated.

## Decisions

- The review procedure as performed becomes the written one.

## Next

`ADR-014` sign-off, then `v3.7.0`.
