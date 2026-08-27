# <PROJECT_NAME> — Open Questions

- **Updated:** <DATE>

> **Open questions only.** A question leaves this file in one of two ways, and both are
> deletions — status `Resolved` is never used, because a register of resolved entries is one
> nobody reads.
>
> **Answered** — the answer goes into the session record and, if durable, into `docs/`.
>
> **Obsolete** — it stopped mattering: the scope moved, the branch died, or the question was
> wrongly posed. Delete it with a `LOG.md` row reading *"dropped: no longer blocks anything"*
> and one clause of why. Projects abandon questions more often than they answer them, and
> without this exit the register fills with zombie 🟢 entries — the same landfill, built from
> dead questions instead of resolved ones.
>
> Either way the `LOG.md` row is what keeps the deletion discoverable.

**IDs are slugs, not numbers** — `Q-latency-budget`, not `Q3`. Deleting resolved entries
would pit and reuse a numbered sequence, so `Q3` cited in an old session file would later
resolve to a different question. A slug, once assigned, is never changed.

If this register arrived from before adoption and already numbers its entries, they are **not**
renumbered — the counter is frozen, new entries take slugs, and the two schemes coexist
permanently. The handbook's §11 says why, and an adoption note in this file should say it too.

- **Priority:** 🔴 high · 🟡 medium · 🟢 low

> **`Owner:` takes a human name, not a git address.** It names who is accountable for the
> entry — a possession that outlives any clone — and is deliberately not the `Held by:`
> value, which names a temporary write claim and is bound to `git config user.email`
> (`ADR-012`).
>
> **Blank means nobody has claimed this**, and that is the signal the field exists to carry. So
> **raise the entry anyway when you have no name to put here** — an unowned question in the
> register is worth far more than a question that was never written down because one field could
> not be filled.
>
> What blank must never mean is *the owner is known and nobody typed it*. Fill it as soon as
> someone takes the entry; if solo-era entries that do have an owner are left blank out of
> habit, the signal is destroyed the day a second person joins.

---

## Q-<slug> · <short title> 🔴

- **Raised:** <DATE> · **Owner:** <human name>
- **Source:** <where the gap surfaced — a document, a source ID, a session>
- **Question:** <what is unknown>
- **Why it matters:** <what decision it blocks>
- **Progress:** <what has been established so far, or "none">
