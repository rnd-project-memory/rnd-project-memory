# 2026-11-03 · Closing the remaining install findings

- **Status:** closed
- **Configuration:** Solo
- **Participants:** author — claude-opus-5-5
- **Signed off:** no
- **Tags:** `#template` `#adoption`

---

## Objective

`install-path` Gap 1, findings 1–6: fix what the template can fix, and say plainly what it cannot.

## Reasoning

Each finding was re-read and given an instrument under `ADR-013`:

| # | Finding | Instrument | Done |
|---|---|---|---|
| 1 | a register's shipped example cannot be told from an entry | by construction: the example moves into a blockquote titled *Shape of an entry*, in all four registers that had one (`OPEN_QUESTIONS`, `ASSUMPTIONS`, `SOURCES` (row and section), `PUBLICATIONS`), as `CAVEATS.yaml` already does | yes, plus a bootstrap gate |
| 2 | destination and title read as one string | prose and output: usage says `<destination-dir> "<Project Title>"`, the guide's and the README's examples are `../churn-signals "Churn Signals"`, the install prints the title, and when the title equals the folder name it says so with the `grep` to find the headings | yes |
| 3 | no README is created, and nothing says so | output: the install lists *no README.md* among what it leaves, with the reason that what the project is, is the adopter's to say. Writing one would be the invention `RULES.md` forbids | yes |
| 4 | install guidance in three places, one deleted | prose. The three have distinct roles: the README is the entry, `skeleton/README.md` is the guide, §11 covers existing projects. The guide is not deleted from anything the adopter needs, since it is read in the template clone. The defect was the README restating installer behaviour, which now points at the guide | yes |
| 5 | a half-removed `<<FILL:` marker is invisible to the anchored check | check: in the three marker-carrying files, `check.sh` tracks whether a marker is open, and reports a `>>` outside one or a `<<FILL` mid-line. It is silent on whole markers, on filled files, on this repository, and on the adopter copy | yes, plus two bootstrap gates |
| 6 | provider, interface and prompt phrasing confounded across the arms | an experiment, not a template change: *adopt this template* against *create a project*, same provider | no: it needs runs the author makes |

**A mistake of my own, caught by trying it.** The first wording of finding 2's hint said *rerun
with the proper title*. A rerun into a destination already filled stops on collisions, so the
advice would have failed. It now gives the `grep` that lists the headings instead. That command was
run, and it finds 18 files.

`bootstrap-test.sh` passes, with three new gates. Hashes were regenerated. The scaffold changes
(registers) reach new installs only.

## Decisions

- Findings 1–5 closed. Finding 6 is left as an experiment.
- The thread can now close. Its remaining items each have a home elsewhere: finding 6 as one open
  question, Gap 2 already recorded as a boundary in `ADR-013` §6, Gap 3 already in
  `Q-who-keeps-the-history`. Its *Do not do* prohibitions need a home in `docs/` before the
  checkpoint is deleted. That is a `docs/` change, so it is proposed to the author first.

## Next

The author approves or adjusts the thread's closure. Then `adopter-review`.
