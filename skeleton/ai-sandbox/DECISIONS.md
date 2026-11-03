# <PROJECT_NAME> — Working Decisions

- **Updated:** <DATE>

> **Choices taken, too young for an ADR.** R&D runs on trials and repeats, so most decisions are
> not mature when they are made. A decision proves itself by holding, unchanged, while the work
> goes on. By the time it has held, the memory of why it was taken has faded, so it is written
> here **when it is taken**: what was decided, why then, what was rejected, and what would reopen
> it. An ADR written months later from memory records a conclusion without its reasons.
>
> **Not an assumption.** `ASSUMPTIONS.md` holds bets about the world, which evidence settles. This
> file holds choices, which people make. One adopter, with no home for choices, filed every one as
> an assumption with *user decision* as its basis.
>
> **Write modes.**
> - **Add** at the moment of deciding.
> - **Revise** in place when the decision changes. Reset `Decided:`, since maturity counts from the
>   last change, and say in the session record what it replaced.
> - **Move** a decision that has held into an ADR (`promote.md`). The ADR carries the reasons
>   written here, and the entry is deleted.
> - **Drop** a decision that was abandoned: delete it.
>
> Moving and dropping both delete, and the `sessions/LOG.md` row names the outcome. `check.sh`
> lists entries that have held unchanged for 60 days as ripe for an ADR. R&D decisions prove
> themselves over months, and a shorter wait would list choices still being tried.
>
> **IDs are slugs**, `D-<slug>`, named for what was chosen. `Decided … by:` takes a human name. When
> none was given, ask the user who decided. The assistant is never the one who decided.

---

> **Shape of an entry.** Copy it below this line without the `> `, one per entry. It sits in a
> blockquote so that an untouched register reads as empty, and no check counts the example as an
> entry.
>
> ## D-<slug> · <the choice, in a line>
>
> - **Decided:** <DATE> · **by:** <human name>
> - **Why now:** <what forced the choice at this point>
> - **Decision:** <what was chosen>
> - **Rejected:** <each alternative, and why not>
> - **Reopen if:** <the observation that would put it back in question>
> - **Basis:** <`sessions/…`, `EXP-…`, `S-…`, or `—`>
