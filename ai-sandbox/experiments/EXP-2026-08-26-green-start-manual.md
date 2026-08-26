# EXP-2026-08-26-green-start-manual

- **Date:** 2026-08-26 · **Status:** complete
- **Question:** Can a person install the template unassisted, following only the public
  documentation — and what does it cost?

---

## Reproducibility

| Field | Value |
|-------|-------|
| Git SHA | template under test at `v3.1.1`, `skeleton @ 3d731cc`; this record written at `a2e046c` |
| Environment lock | n/a |
| Entry point | `log_b.md`, timestamped free prose; `exp_b_user_feedback.md` |
| Data source | `/home/irig0/Projects/exp--project-memory-green-start/exp_b/churn-signals` |
| Snapshot date | 2026-08-26 |
| Filters / slice | wall-clock to a verified install; the produced tree |
| Runtime / compute | one person, no assistant, documentation read online |
| Run duration | **12 minutes 11 seconds** to a verified install; logging time excluded |
| Run ID (remote/async) | n/a |

## Setup

The same title and paragraph as the assisted arm. No assistant, no local copy of the
documentation, no notes. Endpoint: the install verified and the blank-finding command confirmed to
work.

**The operator is not naive and said so.** They had attempted a green start on `v2.4.0` before
`install.sh` existed and failed to complete it, and they had never used `install.sh`. One
contamination is logged in place, at 6:42 — recalling unprompted that `user.email` had to be set.
This is a **lower bound**, not a typical cost.

## Result

**Completed, in 12:11.** The number did not exist before this run; `Q-who-keeps-the-history` had
been carrying an unmeasured assertion in its place all day.

**The endpoint is "installed", not "ready to work".** Seven `<<FILL:` markers remain unanswered
and nothing is committed. The manual path's *full* cost is larger by however long the seven
answers take, which this run did not measure.

Four defects, with their cost in the log:

| Log time | What happened | Cost |
|---|---|---|
| 1:21 → 4:00 | copied `skeleton/` into the project, then re-read the guide and deleted it | **2:39** |
| 9:00 | the second argument to `install.sh` was unclear | took the folder name |
| 11:26 | no `README.md` in the installed project and no document explains why | searched three documents, then wrote one by hand |
| — | install guidance lives in three places, one of which the install deletes | — |

**The second-argument confusion produced a wrong artefact and nothing detected it.** `AGENTS.md`
in the manual arm reads `# churn-signals`; the assisted arm reads `# Churn Signals`. The guide's
example is `./install.sh ../my-project my-project you@example.org`, in which the same string
appears as both the destination path and the project name, so the two read as one thing. Following
that, the operator supplied the folder name. `check.sh` has nothing to say about it.

**The `README.md` gap is shared with the assisted arm**, which also produced none and, unlike the
person, did not notice. The operator located the cause only by reaching into
`RND_PROJECT_MEMORY.md` and inferring it from a sentence about a different file — and recorded
that prior knowledge is what made that fast.

**One positive confirmation.** `grep -rn '^<<FILL' .` was tested and reported clear and usable for
finding what remains.

## Verdict

**supports** — the manual path completes, unassisted, from the public documentation, in a time
that is minutes rather than hours. It supports the weaker claim only: *possible*, and possible for
someone who had seen the project before.

## Verification

- **Verified by:** self
- **How verified:** the produced tree read against the log

## What this changes

- **`Q-who-keeps-the-history` gains its first number**, and with it the shape of the answer: the
  manual path is not the obstacle. Twelve minutes, and the four costs above are all documentation
  defects rather than irreducible work.
- **Three defects to fix**, each cheap: the second argument's name and example; the missing
  `README.md`, which neither arm produced; and the three-places problem, which is the same
  duplication the installer extraction addressed one level down.
- **The operator's feedback names a fifth**, not visible in the artefact: `install.sh` must be run
  from the template's directory, with both trees at the same level, and nothing says so up front.

## Threats to this result

- **The operator wrote the documentation being tested**, and had failed the same task once before
  under an earlier version. Both cut the same way: this is the fastest a person is likely to be.
- **One contamination is logged and at least one is not**, by construction — prior knowledge does
  not announce itself each time it is used.
- **The endpoint excludes the seven answers**, which is where a naive operator's time would
  actually go.
- **n=1, one person.** The unassisted arm cannot be repeated by the same person, and there is no
  second operator.
