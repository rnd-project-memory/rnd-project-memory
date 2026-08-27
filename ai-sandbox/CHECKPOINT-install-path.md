# rnd-project-memory — Checkpoint · install-path

- **Held by:** esdevop@gmail.com · since 2026-08-26
- **Status:** active
- **Resume from:** the probe passed and cause A is supported and replicated
  (`EXP-2026-08-28-probe-and-cause-a`). Run 2 is authorised under the pre-registered rule and has
  not been performed.
  **Do not do until re-verified:** do not claim the template makes an assistant stop where it
  lacks information. Two assisted arms disagree, the one that outranks the other is the one that
  failed, and the one clean run is written up as *worked once*. Do not remove the marker flags
  before Run 1 — that is the baseline they are the treatment against. Do not read `12:11` as the cost of the manual path either — it is the cost of
  *installing*, by someone who had seen the project before, with seven blanks unanswered at the
  endpoint. And do not treat `3.49 AIC` as a saving against it: the cheap run is the one that
  invented.

> This file belongs to one thread, named for what is being worked on. Only whoever it names as
> `Held by:` writes it. Rewritten, never appended; only what is unsettled.

---

## Current state

| Item | Value | Source |
|------|-------|--------|
| Placeholder classes | three, named in `skeleton/README.md` step 3 | this session |
| Install-time blanks | 7 markers, 3 files, `<<FILL: …>>` | `grep -rn '<<FILL' skeleton/` |
| `check.sh` | counts unanswered markers; not yet at the root, which runs `v3.0.1` | `skeleton/check.sh` |
| `bootstrap-test.sh` | passes, 8 gates, 3 of them new | run 2026-08-26 |
| Session filenames | no counter; a suffix breaks a collision only | `checkpoint.md`, §4 |
| Enforcement of that rule | `check.sh`, pending files only | `sessions/2026-08-26-session-counter-check.md` |
| The install | `install.sh`, called by the gate, pointed at by the guide | `3c0da3d` |
| Extraction's measured cost | 3 files vs 2 — `contradicts` | `EXP-2026-08-26-install-extraction-cost` |
| Release | none cut; bump undecided | — |

---

## In progress

### Gap 1 — three runs, pre-registered before any is run (priority: high)

Written down now so that no more convenient outcome can be chosen after a result. Both runs use
the frozen prompt and the same provider and interface as the recorded arms.

**Amended 2026-08-27, before either run.** The original text said to record the model version.
Copilot CLI v1.0.80 does not expose one — only a name (`C-copilot-model-build`), so "GPT-5.6 Luna"
in two runs may be two models with nothing saying so. What is recorded instead: the name as
displayed, the CLI version, and the timestamp. **Run the arms close together in time** — adjacency
is the only control available over a build that cannot be observed. An amendment made before any
data exists is legitimate; the same amendment after a result would not be, and this note is here
so a later reader can tell which this was.

| | State | Measures |
|---|---|---|
| **Run 1** | `v3.3.0` — cause A fixed, marker flags **present** | **A** — done 2026-08-28, supports |
| **Run 1′** | identical to Run 1, nothing changed | **the instrument** — done, **probe passes** |
| **Run 2** | Run 1's state with the marker flags **removed** | **B**, against Run 1 — authorised, not yet run |

In that order. The probe sits between them so that whatever it detects — the model's own variance,
or a build that moved — is measured on the same days as the comparison it qualifies.

**Two binary outcomes, and nothing finer.** At one run per cell anything more detailed is
unreadable against the model's own variance:

1. **Were entries raised in `OPEN_QUESTIONS.md`** — yes/no.
2. **Was anything invented** — yes/no, judged by reading the seven answers against the frozen
   paragraph.

**The probe carries a stopping rule, and it is the point of having it.** *Agree* means both binary
outcomes identical.

- **Run 1 and Run 1′ agree** → the instrument is steady enough at n=1, and a difference at Run 2
  may be read as the flags.
- **Run 1 and Run 1′ disagree** → **stop. Do not perform Run 2.** The design cannot separate a
  treatment from the instrument, and that is settled before any effort is spent interpreting a
  result. The flags question then needs repeats per cell, not a one-run comparison, and that is
  what gets recorded — a finding about the method, arrived at for the price of one run instead of
  a false conclusion.

Not performing Run 2 in that case is deliberate. A result one has pre-committed not to interpret
is a temptation, not data.

**Reading Run 2, if it happens.** Runs 1 and 2 agreeing is decent evidence the flags do not matter
— if they mattered, a difference was expected and none appeared. Runs 1 and 2 differing is *not*
proof that they do, even with a clean probe: one probe bounds the variance loosely, it does not
eliminate it. **Unobservable model drift falls into that same bucket** rather than into an
assumption, so this reading rule survives the instrument's limitation unchanged — it just has more
in it.

**Run 2 is not really about seven lines of marker text.** It is the first test of `ADR-013`'s third
gate. If removing a restatement costs behaviour, the gate has a price, and that is worth knowing
before it is applied again.

**Why A had to ship first.** After A, the tree differs from `v3.2.0` by two things, so removing the
flags now and comparing against the recorded run would measure A and B together — the mistake the
`install.sh` extraction experiment already made.

### Gap 2 — what the mechanical layer cannot see (priority: high)

`check.sh` is clean on a repository of honest absences and on one of confident fiction. `ADR-013`
turns this from an open task into a stated boundary: where neither a rule nor a check applies, the
limit is recorded and left. Nothing in Gap 1 closes it.

### Gap 3 — six findings from the green starts, still untouched (priority: medium)

`OPEN_QUESTIONS.md`'s example entry carries no marker, so an untouched register is
indistinguishable from a filled one. `install.sh`'s second argument and its example. No arm has
produced a project `README.md` — three for three. Install guidance in three places. The `<<FILL:`
marker can be half-removed. And provider, interface and prompt phrasing remain confounded across
the arms.

## Promotion candidates

None. Everything settled this session is either in the artefact itself or in the session record;
nothing here has stopped moving.

---

## Out of scope for this session

- The new-project experiment. It must run in a session with no access to this one, or it measures
  nothing — the same reason §11 step 5 cannot be run from inside the bootstrap session.
- Answering `Q-who-keeps-the-history` by reasoning. What it asks for is a timing, and reasoning
  harder about it is how it would get closed without one.
