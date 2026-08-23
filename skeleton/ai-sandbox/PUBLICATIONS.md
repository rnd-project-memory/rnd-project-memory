# <PROJECT_NAME> — Publications Register

**Updated:** <DATE>

> `SOURCES.md` in reverse: that file answers *where a fact came from*, this one answers *where
> it went*. A published page is a copy of knowledge in `docs/`, and it drifts from the original
> silently — and outward, to readers who cannot see `docs/` at all.
>
> Three fields carry the weight. **`Collected:`** — if a script, the page can be rebuilt and
> diffed against what is live; if by hand, drift has to be caught by eye, and that is worth
> knowing in advance. **`Basis:`** — the pointer back into `docs/`; without it, "the source
> changed" and "the publication is stale" cannot be connected. **`Status:`** — see below.
>
> **`stale` is a legitimate, permanent-if-needed status here — not a defect.** Everywhere else
> in this system a resolved entry is deleted (`P-024`). This register is the one exception: a
> page already read by someone outside the project cannot be un-published, so marking it
> `stale` is the only honest thing left to do, and it is information, not clutter.

---

## P-<slug> · <title>

**Where:** <external location the published copy lives — wiki page, URL, distribution list>
**Version:** <published version identifier, and the date it went out>
**Collected:** <script path, and whether it is idempotent — or "by hand">
**Basis:** <what in `docs/` this rests on, plus that claim's own basis — `docs/method.md`,
`EXP-…`>
**Status:** current | stale — <if stale, the specific gap: which sections, what changed
underneath it>
